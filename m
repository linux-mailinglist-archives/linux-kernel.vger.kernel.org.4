Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592806C5273
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVR21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00552F40
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679506057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iR+Hza8vVZTVE2qW51B1MEPt2e97eU4CXWnswjrDo50=;
        b=f4tZQzehPD/B5sjYwo74Y3lNoQKzPYDAYpLS1QeteNb0SsWzGdyVZkep/V/8p3ypaczi7/
        GdbygBvXpXIz/d8oWMt/bz6/uK4C8K8ABvjnc8/hdujIJJcquxXXNzOGxO05pf+P3bJwFa
        W9WkFdPtA191YBkETjbqTT+bn7CzF08=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-YsSTzsMdOCW6vn4SQ4aysw-1; Wed, 22 Mar 2023 13:27:31 -0400
X-MC-Unique: YsSTzsMdOCW6vn4SQ4aysw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A57885A588;
        Wed, 22 Mar 2023 17:27:30 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E97040C83AC;
        Wed, 22 Mar 2023 17:27:30 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 7117A4038C705; Wed, 22 Mar 2023 11:20:55 -0300 (-03)
Date:   Wed, 22 Mar 2023 11:20:55 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <ZBsOx1abWfBTdGFl@tpad>
References: <20230320180332.102837832@redhat.com>
 <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
 <ZBiu8csaxB/zrOAS@tpad>
 <ZBrUruIsOjdaqiFv@dhcp22.suse.cz>
 <ZBrlKeZTsHgRW021@tpad>
 <ZBsEGMEfEI98Wpwq@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsEGMEfEI98Wpwq@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=0.9 required=5.0 tests=DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:35:20PM +0100, Michal Hocko wrote:
> On Wed 22-03-23 08:23:21, Marcelo Tosatti wrote:
> > On Wed, Mar 22, 2023 at 11:13:02AM +0100, Michal Hocko wrote:
> > > On Mon 20-03-23 16:07:29, Marcelo Tosatti wrote:
> > > > On Mon, Mar 20, 2023 at 07:25:55PM +0100, Michal Hocko wrote:
> > > > > On Mon 20-03-23 15:03:32, Marcelo Tosatti wrote:
> > > > > > This patch series addresses the following two problems:
> > > > > > 
> > > > > > 1. A customer provided evidence indicating that a process
> > > > > >    was stalled in direct reclaim:
> > > > > > 
> > > > > This is addressed by the trivial patch 1.
> > > > > 
> > > > > [...]
> > > > > >  2. With a task that busy loops on a given CPU,
> > > > > >     the kworker interruption to execute vmstat_update
> > > > > >     is undesired and may exceed latency thresholds
> > > > > >     for certain applications.
> > > > > 
> > > > > Yes it can but why does that matter?
> > > > 
> > > > It matters for the application that is executing and expects
> > > > not to be interrupted.
> > > 
> > > Those workloads shouldn't enter the kernel in the first place, no?
> > 
> > It depends on the latency requirements and individual system calls.
> > 
> > > Otherwise the in kernel execution with all the direct or indirect
> > > dependencies (e.g. via locks) can throw any latency expectations off the
> > > window.
> > > 
> > > > > > By having vmstat_shepherd flush the per-CPU counters to the
> > > > > > global counters from remote CPUs.
> > > > > > 
> > > > > > This is done using cmpxchg to manipulate the counters,
> > > > > > both CPU locally (via the account functions),
> > > > > > and remotely (via cpu_vm_stats_fold).
> > > > > > 
> > > > > > Thanks to Aaron Tomlin for diagnosing issue 1 and writing
> > > > > > the initial patch series.
> > > > > > 
> > > > > > 
> > > > > > Performance details for the kworker interruption:
> > > > > > 
> > > > > > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > > > > > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > > > > > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > > > > > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> > > > > >  
> > > > > > The example above shows an additional 7us for the
> > > > > > 
> > > > > >         oslat -> kworker -> oslat
> > > > > > 
> > > > > > switches. In the case of a virtualized CPU, and the vmstat_update
> > > > > > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > > > > > observed in the guest is higher than 50us, violating the acceptable
> > > > > > latency threshold for certain applications.
> > > > > 
> > > > > I do not think we have ever promissed any specific latency guarantees
> > > > > for vmstat. These are statistics have been mostly used for debugging
> > > > > purposes AFAIK. I am not aware of any specific user space use case that
> > > > > would be latency sensitive. Your changelog doesn't go into details there
> > > > > either.
> > > > 
> > > > There is a class of workloads for which response time can be
> > > > of interest. MAC scheduler is an example:
> > > > 
> > > > https://par.nsf.gov/servlets/purl/10090368
> > > 
> > > Yes, I am not disputing low latency workloads in general. I am just
> > > saying that you haven't really established a very sound justification
> > > here.
> > 
> > The -v7 cover letter was updated with additional details, 
> > as you requested (perhaps you missed it):
> > 
> > "Performance details for the kworker interruption:
> > 
> > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> > 
> > The example above shows an additional 7us for the
> > 
> >         oslat -> kworker -> oslat
> > 
> > switches. In the case of a virtualized CPU, and the vmstat_update
> > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > observed in the guest is higher than 50us, violating the acceptable
> > latency threshold for certain applications."
> 
> Yes, I have seen that but it doesn't really give a wider context to
> understand why those numbers matter.

OK.

"In the case of RAN, a MAC scheduler with TTI=1ms, this causes >100us
interruption observed in a guest (which is above the safety
threshold for this application)."

Is that OK?


> > > Of course there are workloads which do not want to conflict with
> > > any in kernel house keeping. Those have to be configured and implemented
> > > very carefully though. Vmstat as such should not collide with those
> > > workloads as long as they do not interact with the kernel in a way
> > > counters are updated. Is this hard or impossible to avoid? 
> > 
> > The practical problem we have been seeing is -RT app initialization.
> > For example:
> > 
> > 1) mlock();
> > 2) enter loop without system calls
> 
> OK, that is what I have kinda expected. Would have been better to
> mention it explicitly.
> 
> I expect this to be a very common pattern and vmstat might not be the
> only subsystem that could interfere later on. Would it make more sense
> to address this by a more generic solution? E.g. a syscall to flush all
> per-cpu caches so they won't interfere later unless userspace hits the
> kernel path in some way (e.g. flush_cpu_caches(cpu_set_t cpumask, int flags)?
> The above pattern could then be implemented as
> 
> 	do_initial_setup()
> 	sched_setaffinity(getpid(), cpumask);
> 	flush_cpu_caches(cpumask, 0);
> 	do_userspace_loop()

I would argue that fixing this without introducing a userspace tunable 
is more generic as all programs (modified to use a syscall or not)
benefit from the improvement. HPC workloads, for example.

But it might be necessary to do what you suggest for other
reasons (where you'd want a behaviour to be enabled which
is undesired for other application types).

