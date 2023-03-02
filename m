Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580CB6A896B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCBTTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCBTTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AD126C9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677784701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rd86piASxER0GGhUHxbaoGJl42WC61IuJKtqa6+2RWE=;
        b=Z7HDSYHT0leE5/dG0NVCapEON+LH4DfQM/KO5iMaqO6JGYOYOufQi3OtLhNr154sLyJmhy
        ELhIwWnPl7rPo5mbE25/AbHtOfo21dfftimt+BYN98OfrONFnv/GnK3KxKE1JJeyVRZ5+v
        /S9c40cnP85t6HhC5/XQF0eAmCIJN4M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-U_6cJ3QLNzqUZs0Z7TWW1Q-1; Thu, 02 Mar 2023 14:18:20 -0500
X-MC-Unique: U_6cJ3QLNzqUZs0Z7TWW1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6290B3C0F421;
        Thu,  2 Mar 2023 19:18:19 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D37C540C83B6;
        Thu,  2 Mar 2023 19:18:18 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id B751D403F7F28; Thu,  2 Mar 2023 16:17:16 -0300 (-03)
Date:   Thu, 2 Mar 2023 16:17:16 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
Message-ID: <ZAD2PI9Lp8UpquCf@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
 <ZADbC9RnmVtpC6kE@x1n>
 <ZADcb+3sU08MHhy3@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZADcb+3sU08MHhy3@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:27:11PM -0500, Peter Xu wrote:
> On Thu, Mar 02, 2023 at 12:21:15PM -0500, Peter Xu wrote:
> > On Thu, Feb 09, 2023 at 12:01:51PM -0300, Marcelo Tosatti wrote:
> > > Draining of pages from the local pcp for a remote zone was necessary
> > > since:
> > > 
> > > "Note that remote node draining is a somewhat esoteric feature that is
> > > required on large NUMA systems because otherwise significant portions
> > > of system memory can become trapped in pcp queues. The number of pcp is
> > > determined by the number of processors and nodes in a system. A system
> > > with 4 processors and 2 nodes has 8 pcps which is okay. But a system
> > > with 1024 processors and 512 nodes has 512k pcps with a high potential
> > > for large amount of memory being caught in them."
> > 
> > How about mentioning more details on where does this come from?
> > 
> > afaict it's from commit 4037d45 since 2007.
> > 
> > So I digged that out mostly because I want to know why we did flush pcp at
> > all during vmstat update.  It already sounds weird to me but I could have
> > been missing important details.
> > 
> > The rational I had here is refresh_cpu_vm_stats(true) is mostly being
> > called by the shepherd afaict, while:
> > 
> >   (1) The frequency of that interval is defined as sysctl_stat_interval,
> >       which has nothing yet to do with pcp pages but only stat at least in
> >       the name of it, and,
> > 
> >   (2) vmstat_work is only queued if need_update() here:
> > 
> > 	for_each_online_cpu(cpu) {
> > 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> > 
> > 		if (!delayed_work_pending(dw) && need_update(cpu))
> > 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> > 
> > 		cond_resched();
> > 	}
> > 
> >       need_update() tells us "we should flush vmstats", nothing it tells
> >       about "we should flush pcp list"..
> > 
> > I looked into the 2007 commit, besides what Marcelo quoted, I do see
> > there's a major benefit of reusing cache lines, quotting from the commit:
> > 
> >         Move the node draining so that is is done when the vm statistics
> >         are updated.  At that point we are already touching all the
> >         cachelines with the pagesets of a processor.
> > 
> > However I didn't see why it's rational to flush pcp list when vmstat needs
> > flushing either.  I also don't know whether that "cacheline locality" hold
> > true or not, because I saw that the pcp page list is split from vmstats
> > since 2021:
> > 
> >     commit 28f836b6777b6f42dce068a40d83a891deaaca37
> >     Author: Mel Gorman <mgorman@techsingularity.net>
> >     Date:   Mon Jun 28 19:41:38 2021 -0700
> > 
> >     mm/page_alloc: split per cpu page lists and zone stats
> > 
> > I'm not even sure my A-b or R-b worth anything at all here, just offer
> > something I got from git archaeology so maybe helpful to readers and
> > reasoning to this patch.  The correctness of archaeology needs help from
> > others (Christoph and Gel?)..  I would just say if there's anything useful
> > or correct may worth collect some into the commit log.
> > 
> > So from what I can tell this patch makes sense.
> 
> One thing I forgot to mention, which may be a slight abi change, is that I
> think the pcp page drain is also triggered by /proc/PID/refresh_vm_stats
> (even though again I don't see why flushing pcp is strictly needed).  It's
> just that I don't know whether there's potential user app that can leverage
> this.
> 
> The worst case is we can drain pcp list for refresh_vm_stats procfs
> explicitly, but I'm not sure whether it'll be worthwhile either, probably
> just to be safe.

This is a good point.

Documentation/admin-guide/sysctl/vm.rst:

stat_refresh
============

Any read or write (by root only) flushes all the per-cpu vm statistics
into their global totals, for more accurate reports when testing
e.g. cat /proc/sys/vm/stat_refresh /proc/meminfo

As a side-effect, it also checks for negative totals (elsewhere reported
as 0) and "fails" with EINVAL if any are found, with a warning in dmesg.
(At time of writing, a few stats are known sometimes to be found negative,
with no ill effects: errors and warnings on these stats are suppressed.)


Will add "drain_all_pages(NULL)" call to the start of stat_refresh
handler.

Thanks.


