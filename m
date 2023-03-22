Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208186C3FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCVBZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427E35AE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679448259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z/QQf3QVrjt4nRAI9fy69GpEwFN8RRRA87OipQJ+EW8=;
        b=eLK4VILUUKT4anhwUlBRgNEGwlhYqprO+5gllESPBHd7Nu7kDYWlV6WsKgFaWGVkT8wyEC
        bofnz/+9QibWRbMRhXJyGfvVaVV6Z/nZMoT00XhYVCJTHpsKToZwJeT+ZomKuzNINBgLHi
        b/MJ6+xFWx/Mkd9TCb6PT8GUK93spAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-HE3xuRZAOSCC6xDr7MBnqw-1; Tue, 21 Mar 2023 21:24:14 -0400
X-MC-Unique: HE3xuRZAOSCC6xDr7MBnqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B71A585C064;
        Wed, 22 Mar 2023 01:24:13 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5375F492C14;
        Wed, 22 Mar 2023 01:24:13 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 521144038A1EC; Tue, 21 Mar 2023 22:20:24 -0300 (-03)
Date:   Tue, 21 Mar 2023 22:20:24 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 13/13] vmstat: add pcp remote node draining via
 cpu_vm_stats_fold
Message-ID: <ZBpX2L8/Nd39CiH9@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230320180745.858515310@redhat.com>
 <93b293341866a4366b2f2a614f8742ca94ff4e3c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b293341866a4366b2f2a614f8742ca94ff4e3c.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:43:09PM -0700, Tim Chen wrote:
> On Mon, 2023-03-20 at 15:03 -0300, Marcelo Tosatti wrote:
> > 
> > +
> > +		if (do_pagesets) {
> > +			cond_resched();
> > +			/*
> > +			 * Deal with draining the remote pageset of a
> > +			 * processor
> > +			 *
> > +			 * Check if there are pages remaining in this pageset
> > +			 * if not then there is nothing to expire.
> > +			 */
> > +			if (!pcp->expire || !pcp->count)
> > +				continue;refresh_cpu_vm_stats
> > +
> > +			/*
> > +			 * We never drain zones local to this processor.
> > +			 */
> > +			if (zone_to_nid(zone) == cpu_to_node(cpu)) {
> > +				pcp->expire = 0;
> > +				continue;
> > +			}
> > +
> > +			WARN_ON(pcp->expire < 0);
> > +			/*
> > +			 * pcp->expire is only accessed from vmstat_shepherd context,
> > +			 * therefore no locking is required.
> > +			 */
> > +			if (--pcp->expire)
> > +				continue;
> > +
> > +			if (pcp->count)
> > +				drain_zone_pages(zone, pcp);
> > +		}
> 
> This logic is the same to that for the do_pagesets portion of code in refresh_cpu_vm_stats().
> Is it possible to consolidate to avoid replicating the logic across two functions?
> 
> Tim 

Tim,

One of the versions is for remote access, the other version is for local
access (thats why merging the two is not so simple).

I suppose the next logical step would be ensure that the current 
!CONFIG_HAVE_CMPXCHG_LOCAL also uses the cmpxchg remotely (then 
refresh_cpu_vm_stats can be removed).

