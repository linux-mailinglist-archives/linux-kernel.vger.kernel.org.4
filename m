Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D227208AA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjFBRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjFBRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDB29F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685728463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyaonDHM5xc2AUqOrNjfHglkwINHnKW+9198mSTvX0Q=;
        b=jGX8pKFGO4QxSWkwZBYn3YrkWfKOy3TnNxHp02olSjQwuyLxPGWAzdy12/0Wono+FQK56R
        jWQynTL5G+NE2nHR0HzSvoaTQxQSwGqm9y8DwbmQ5W4FHO0O1DqilOjnCWbSlbRoP1cdp8
        N9pHgsZjlMh+c31Ub2cXwb100bNIVGM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-_mdejqjjMUaKLnb9nZMRhg-1; Fri, 02 Jun 2023 13:54:13 -0400
X-MC-Unique: _mdejqjjMUaKLnb9nZMRhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFA3785A5A8;
        Fri,  2 Jun 2023 17:54:12 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E078492B00;
        Fri,  2 Jun 2023 17:54:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id F33F140178AFC; Fri,  2 Jun 2023 13:57:18 -0300 (-03)
Date:   Fri, 2 Jun 2023 13:57:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/4] vmstat: skip periodic vmstat update for nohz full
 CPUs
Message-ID: <ZHofbuFGrtuC/zRt@tpad>
References: <20230530145234.968927611@redhat.com>
 <20230530145335.828634764@redhat.com>
 <ZHnGyNd4lHz/pwKr@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHnGyNd4lHz/pwKr@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:39:04PM +0200, Michal Hocko wrote:
> On Tue 30-05-23 11:52:36, Marcelo Tosatti wrote:
> > @@ -2022,6 +2023,16 @@ static void vmstat_shepherd(struct work_
> >  	for_each_online_cpu(cpu) {
> >  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> >  
> > +		/*
> > +		 * Skip periodic updates for nohz full CPUs.
> > +		 * Any callers who need precise values should use
> > +		 * a snapshot of the per-CPU counters, or use the global
> > +		 * counters with measures to handle errors up to
> > +		 * thresholds (see calculate_normal_threshold).
> > +		 */
> > +		if (tick_nohz_full_cpu(cpu))
> > +			continue;
> 
> In other code path we have used cpu_is_isolated, is there any reason to
> diverge from that here? Isn't this effectivelly the same kind of
> problem?

Changed to cpu_is_isolated, thanks.

