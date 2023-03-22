Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1606C4BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCVNf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:35:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93371CADF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:35:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82CAD33B66;
        Wed, 22 Mar 2023 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679492121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0BhUqkihiqoY/S89jX4MrGerxrgdsCByMEWhwt4Uu8w=;
        b=p2oEIxaFTztjDc1HcQrtLXYozgttFgklgC5TTCWHzK3Oz5wLYOPQ3EnYi5vZqgWH6ygStQ
        C0nxY46P4GqyJhz0wTpBBO3juB7g20YBpyrd1Gse66IHXNUX0VxH/AXcmZYVYXIQrJTrqL
        RCgv9gjxlukdv8Indk60FhWSvRE4yIc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63ED713416;
        Wed, 22 Mar 2023 13:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xvOJFRkEG2QkBQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Mar 2023 13:35:21 +0000
Date:   Wed, 22 Mar 2023 14:35:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZBsEGMEfEI98Wpwq@dhcp22.suse.cz>
References: <20230320180332.102837832@redhat.com>
 <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
 <ZBiu8csaxB/zrOAS@tpad>
 <ZBrUruIsOjdaqiFv@dhcp22.suse.cz>
 <ZBrlKeZTsHgRW021@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBrlKeZTsHgRW021@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-03-23 08:23:21, Marcelo Tosatti wrote:
> On Wed, Mar 22, 2023 at 11:13:02AM +0100, Michal Hocko wrote:
> > On Mon 20-03-23 16:07:29, Marcelo Tosatti wrote:
> > > On Mon, Mar 20, 2023 at 07:25:55PM +0100, Michal Hocko wrote:
> > > > On Mon 20-03-23 15:03:32, Marcelo Tosatti wrote:
> > > > > This patch series addresses the following two problems:
> > > > > 
> > > > > 1. A customer provided evidence indicating that a process
> > > > >    was stalled in direct reclaim:
> > > > > 
> > > > This is addressed by the trivial patch 1.
> > > > 
> > > > [...]
> > > > >  2. With a task that busy loops on a given CPU,
> > > > >     the kworker interruption to execute vmstat_update
> > > > >     is undesired and may exceed latency thresholds
> > > > >     for certain applications.
> > > > 
> > > > Yes it can but why does that matter?
> > > 
> > > It matters for the application that is executing and expects
> > > not to be interrupted.
> > 
> > Those workloads shouldn't enter the kernel in the first place, no?
> 
> It depends on the latency requirements and individual system calls.
> 
> > Otherwise the in kernel execution with all the direct or indirect
> > dependencies (e.g. via locks) can throw any latency expectations off the
> > window.
> > 
> > > > > By having vmstat_shepherd flush the per-CPU counters to the
> > > > > global counters from remote CPUs.
> > > > > 
> > > > > This is done using cmpxchg to manipulate the counters,
> > > > > both CPU locally (via the account functions),
> > > > > and remotely (via cpu_vm_stats_fold).
> > > > > 
> > > > > Thanks to Aaron Tomlin for diagnosing issue 1 and writing
> > > > > the initial patch series.
> > > > > 
> > > > > 
> > > > > Performance details for the kworker interruption:
> > > > > 
> > > > > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > > > > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > > > > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > > > > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> > > > >  
> > > > > The example above shows an additional 7us for the
> > > > > 
> > > > >         oslat -> kworker -> oslat
> > > > > 
> > > > > switches. In the case of a virtualized CPU, and the vmstat_update
> > > > > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > > > > observed in the guest is higher than 50us, violating the acceptable
> > > > > latency threshold for certain applications.
> > > > 
> > > > I do not think we have ever promissed any specific latency guarantees
> > > > for vmstat. These are statistics have been mostly used for debugging
> > > > purposes AFAIK. I am not aware of any specific user space use case that
> > > > would be latency sensitive. Your changelog doesn't go into details there
> > > > either.
> > > 
> > > There is a class of workloads for which response time can be
> > > of interest. MAC scheduler is an example:
> > > 
> > > https://par.nsf.gov/servlets/purl/10090368
> > 
> > Yes, I am not disputing low latency workloads in general. I am just
> > saying that you haven't really established a very sound justification
> > here.
> 
> The -v7 cover letter was updated with additional details, 
> as you requested (perhaps you missed it):
> 
> "Performance details for the kworker interruption:
> 
> oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> 
> The example above shows an additional 7us for the
> 
>         oslat -> kworker -> oslat
> 
> switches. In the case of a virtualized CPU, and the vmstat_update
> interruption in the host (of a qemu-kvm vcpu), the latency penalty
> observed in the guest is higher than 50us, violating the acceptable
> latency threshold for certain applications."

Yes, I have seen that but it doesn't really give a wider context to
understand why those numbers matter.

> > Of course there are workloads which do not want to conflict with
> > any in kernel house keeping. Those have to be configured and implemented
> > very carefully though. Vmstat as such should not collide with those
> > workloads as long as they do not interact with the kernel in a way
> > counters are updated. Is this hard or impossible to avoid? 
> 
> The practical problem we have been seeing is -RT app initialization.
> For example:
> 
> 1) mlock();
> 2) enter loop without system calls

OK, that is what I have kinda expected. Would have been better to
mention it explicitly.

I expect this to be a very common pattern and vmstat might not be the
only subsystem that could interfere later on. Would it make more sense
to address this by a more generic solution? E.g. a syscall to flush all
per-cpu caches so they won't interfere later unless userspace hits the
kernel path in some way (e.g. flush_cpu_caches(cpu_set_t cpumask, int flags)?
The above pattern could then be implemented as

	do_initial_setup()
	sched_setaffinity(getpid(), cpumask);
	flush_cpu_caches(cpumask, 0);
	do_userspace_loop()

-- 
Michal Hocko
SUSE Labs
