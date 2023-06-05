Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADF8721F2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjFEHNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFEHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:13:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9F110
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:12:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 160FE1F8AB;
        Mon,  5 Jun 2023 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685949140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XfVQ9uT9kbRVvxZWdoeBj7hWEgfYxWlxzh+N0mhwC9U=;
        b=ugMYp84OM22Mf+ikwRJJD8nRHRx68Vsgx8PdYaCYtVIi1XWT9545ikvfdR4ip9TZ4KIqOS
        54EpHquab8T1sBXWseq4CMeIka+5ytWkmyaO6OHZor6c4c3rDnDlg0kYOgXtfC2a6kRfG9
        Zk+AqMAVylMSfEfwWuSPgUA1Wns/9dM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE021139C7;
        Mon,  5 Jun 2023 07:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N2kbONOKfWRcZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 05 Jun 2023 07:12:19 +0000
Date:   Mon, 5 Jun 2023 09:12:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 3/4] workqueue: add schedule_on_each_cpumask helper
Message-ID: <ZH2K0wdL3YAOUaTf@dhcp22.suse.cz>
References: <20230530145234.968927611@redhat.com>
 <20230530145335.930262644@redhat.com>
 <ZHnI93EMp+Aq8UAA@dhcp22.suse.cz>
 <ZHohHHvtDjIJHA+a@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHohHHvtDjIJHA+a@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-06-23 14:04:28, Marcelo Tosatti wrote:
> On Fri, Jun 02, 2023 at 12:48:23PM +0200, Michal Hocko wrote:
[...]
> > > +	if (!alloc_cpumask_var(&effmask, GFP_KERNEL)) {
> > > +		free_percpu(works);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	cpumask_and(effmask, cpumask, cpu_online_mask);
> > > +
> > > +	cpus_read_lock();
> > > +
> > > +	for_each_cpu(cpu, effmask) {
> > 
> > Is the cpu_online_mask dance really necessary? 
> 
> > Why cannot you simply do for_each_online_cpu here? 
> 
> Are you suggesting to do: 
> 
> 	for_each_online_cpu(cpu) {
> 		if cpu is not in cpumask
> 			continue;
> 		...
> 	}
> 
> This does not seem efficient.

Are you sure this is less sufficient than a memory allocation?
-- 
Michal Hocko
SUSE Labs
