Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403BC6F07C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbjD0PBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0PBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8861705
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682607617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTVeGQm8lCPYT8EkHXxb4V0K+dUAmwN0crOv/gQbSK8=;
        b=Y1jIeaKNdCGBo27PhFrfVFR1dYpk+0z/UJ7kSxN3QqQg0ZOSeK1laUT4eRdKfQMPRXgD2y
        v8yGEh0gTkhdNaaJsZfTzZyfTkKKStTseg7Yx1TPR533zd5j3a4Gi9pQmYzx766n4VXFvs
        4d5Pm1th/EibSBjGI5J5G/Nrx3nJM1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-krLzDO7HNeetmA238JzMOg-1; Thu, 27 Apr 2023 11:00:13 -0400
X-MC-Unique: krLzDO7HNeetmA238JzMOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5396BA0F386;
        Thu, 27 Apr 2023 15:00:10 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD5FB63F51;
        Thu, 27 Apr 2023 15:00:09 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 2B2564038D460; Thu, 27 Apr 2023 11:59:48 -0300 (-03)
Date:   Thu, 27 Apr 2023 11:59:48 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZEqN5J3b8m8QxNEP@tpad>
References: <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
 <ZEFB8FSKWms2VmaL@tpad>
 <ZEk2WHjwLl2qWZR3@tpad>
 <ZEoy2aYpGJ4/wOK7@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEoy2aYpGJ4/wOK7@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:31:21AM +0200, Michal Hocko wrote:
> On Wed 26-04-23 11:34:00, Marcelo Tosatti wrote:
> > On Thu, Apr 20, 2023 at 10:45:20AM -0300, Marcelo Tosatti wrote:
> [...]
> > > There are additional details that were not mentioned. When we think
> > > of flushing caches, or disabling per-CPU caches, this means that the
> > > isolated application loses the benefit of those caches (which means you
> > > are turning a "general purpose" programming environment into
> > > potentially slower environment for applications to execute).
> 
> I do not really buy this argument! Nothing is really free and somebody
> has to pay for the overhead. 

About the overhead, modern processors perform "cache locking":

https://xem.github.io/minix86/manual/intel-x86-and-64-manual-vol3/o_fe12b1e2a880e0ce-261.html

Which means that as long as memory is completly contained in a cacheline
(for write-back memory), then it is not necessary to perform the LOCK 
operation on the bus.
Multiple experiments have confirmed this is the case.

This is the case with per-CPU vmstat memory as well.

> You want highly specialized workload to
> enjoy all the performance while having high demand on latency yet the
> overhead has to pay everybody else.

Yes, the overhead is that code should avoid interrupting CPUs.

Your argument is that: "Avoiding the interruptions adds unsurmountable 
complexity therefore those workloads should not be supported" ?

It seems to me this argument can be used against any new piece of code 
of functionality that is added to the kernel, isnt it ?

The same argument could be used to reject (at the time) new additions 
such as RCU (because systems with large number of processors are a
a highly specialized workload), memory hotplug (same thing), PCI hotplug 
(same thing).

> > https://www.uwsg.indiana.edu/hypermail/linux/kernel/2012.0/06823.html
> 
> This is just talking about who benefits from isolation and I do not
> think there is any dispute in that regard. I haven't questioned that. My
> main argument was that those really need to be special and careful to
> achieve their goal 

I see.

> and Thomas says a very similar thing. I do not see
> any objection to an explicit programming model to achieve that goal.

Yes, but it seems to me that the best possible (and most widely
applicable) solution is to avoid any explicit programming if possible.

> > > (yes, of course, one has to be mindful of which system calls can be
> > > used, for example the execution time of system calls which take locks will
> > > depend on whether, and how many, users of those locks there are at a
> > > given moment).
> 
> This is simply not maintainble state. Once you enter the kernel you
> cannot really expect your _ultra low_ latency expectations.

Whether or not its OK to perform system calls is up to the application:
What matters is the latency expectation from the outside world [1]
VS how long it takes to execute a set of instructions.

I can give two concrete example:

1) Cyclictest use sys_nanosleep(). It makes sense
to abstract the details of HLT'ing to the operating system.

A whole class of programs (which must handle periodic tasks)
will sleep via the kernel.

2) The HPC example from Thomas, where:

"
 1     read_data_set() <- involving syscalls/OS obviously
 2     compute_set()   <- let me alone
 3     save_data_set() <- involving syscalls/OS obviously

       repeat the above...

then it's at his discretion to decide to inflict a particular isolation
set on the task which is obviously ineffective while doing #1 and #3 but
might provide the so desired 0.9% boost for compute_set() which
dominates the judgement."

It seems the operating system is capable of providing an isolation free
environment for the application without explicit knowledge from it
(other than taskset).

So all the above are good reasons to try and avoid an explicit
programming interface (again, i did write an explicit programming
interface, and seen in practice its downsides). I will assume you now
understand and agree that the additional complexity added to the kernel
is worthwhile (since its not that huge complexity to perform particular
work remotely, with appropriate locking and/or usage of lockless
algorithms, these things have been around and used in the kernel for a
while now). 

As for the next topic...

> [...]
> > > So it seems to me (unless there are points that show otherwise, which
> > > would indicate that explicit userspace interfaces are preferred) _not_
> > > requiring userspace changes is a superior solution.
> > > 
> > > Perhaps the complexity should be judged for individual cases 
> > > of interruptions, and if a given interruption-free conversion 
> > > is seen as too complex, then a "disable feature which makes use of per-CPU
> > > caches" style solution can be made (and then userspace has to
> > > explicitly request for that per-CPU feature to be disabled).
> > > 
> > > But i don't see that this patchset introduces unmanageable complexity,
> > > neither: 
> 
> As I've tried to explain, I disagree about the approach you are taking.
> You are fixing your problem at a wrong layer. You really need to address
> the fundamental issue and that is that you do not want housekeeping done
> on isolated cpu(s) while your workload is running there.

OK, that is a problem. But the fact is that there are interfaces to request
work to be performed on remote CPUs (usually on per-CPU data), and those
must be addressed one-by-one. We (as in the community) are looking into
ways to address multiple classes of interruptions at once, for example:

https://lpc.events/event/16/contributions/1218/
https://www.spinics.net/lists/linux-s390/msg57118.html

"The current CPU isolation is a best effort approach and I agree that for
more strict isolation modes we need to be able to enforce that and hunt
down offenders and think about them one by one."

But we can't block IPIs or requests for work to be executed remotely.

> vmstat updates are just one of schedule_on_cpu users who could disturb
> your workload.  

Yes. But its one case which we see right now. So our approach so far has
been to monitor the workload and remove individual interruptions that
are observed.

But as long as you have code that is doing:

	queue_work_on(CPU, &this_work);
	flush_work(&this_work);

There is nothing one can do about it other than:

	1) Return an error to avoid the interruption
	   (which is what we are trying here:
	   https://lpc.events/event/16/contributions/1218/).
	   However this might not be suitable for all cases
	   (because you rely on the functionality).
	2) Convert it to avoid the remote work somehow.
	3) Don't queue the work (which might result in incorrect
	   system operation).

Again, we are trying to widen the number of callsites that can be 
handled with certain approaches (see the above URLs).

> We do not want to chase every single one and keep
> doing that for ever as new callers of that API are added. See the
> point? 

Yes, agree with this point. Possible solutions:

1) Change the APIs so that any new users that attempt
to use the APIs are encouraged to avoid executing code on
isolated CPUs (or have to handle the errors).

/**
 * queue_work_on - queue work on specific cpu
 * @cpu: CPU number to execute work on
 * @wq: workqueue to use
 * @work: work to queue
 *
 * We queue the work to a specific CPU, the caller must ensure it
 * can't go away.  Callers that fail to ensure that the specified
 * CPU cannot go away will execute on a randomly chosen CPU.
 *
 * Return: %false if @work was already on a queue, %true otherwise.
 */
bool queue_work_on(int cpu, struct workqueue_struct *wq,
                   struct work_struct *work)
{

Perhaps _fail variants of APIs to queue remote work 
(https://lore.kernel.org/lkml/20220908192859.546633738@redhat.com/T/#mc25ddea62ff095dba61d244fbfdca1f61221c915)
plus
a checkpatch.pl error in case of addition of queue_work_on would 
be helpful?

2) Change the patch acceptance criteria to avoid introducing 
queue_work_on's to isolated CPUs.

If you have additional suggestions or ideas, they are welcome.

> "Fixing" vmstat will not make your isolated workload more
> reliable. You really need a more generic solution rather than a quick
> hack.

It does as long as no one else executes queue_work_on() :-)

Yes, i understand and agree this is weak and fragile.

> Also vmstat already has a concept of silencing - i.e. quiet_vmstat. IIRC
> this is used by NOHZ. I do not remember any details but if anything this
> is something I would have a look into.

Its not sufficient since what it does is only flushing the per-CPU
vmstats when entering idle. There has been work on a patchset
(https://lkml.org/lkml/2022/9/24/306) to improve the infrastructure, to
call quiet_vmstat on return to userspace when nohz_full is used, but
honestly the remote flushing is superior: it potentially avoids many
unecessary flushes (which can happen if the application performs a lot
of system calls).

> There is close to 0 benefit to teaching remote stat flushing. As I've
> said stats are only for debugging purposes and imprecise values
> shouldn't matter. So this just adds a complexity without any actual real
> benefit.

Well there is the need to request a synchronization of the events from
all CPUs, right? For example:

int vmstat_refresh(struct ctl_table *table, int write,
                   void *buffer, size_t *lenp, loff_t *ppos)
{
        long val;
        int err;
        int i;

        /*
         * The regular update, every sysctl_stat_interval, may come later
         * than expected: leaving a significant amount in per_cpu buckets.
         * This is particularly misleading when checking a quantity of HUGE
         * pages, immediately after running a test.  /proc/sys/vm/stat_refresh,
         * which can equally be echo'ed to or cat'ted from (by root),
         * can be used to update the stats just before reading them.
         *
         * Oh, and since global_zone_page_state() etc. are so careful to hide
         * transiently negative values, report an error here if any of
         * the stats is negative, so we know to go looking for imbalance.
         */
        err = schedule_on_each_cpu(refresh_vm_stats);

So if you let a remote CPU dirty its own cache, then at somepoint you
need to flush back that cache.

Are you suggesting to disable synchronization of the per-CPU
vmstats for a given CPU (if isolated, for example), and then any
callsites which require proper values must loop over all CPUs
when requesting uptodate statistics?

Works for me and the addresses the requests from users 
(since it removes the interruption to isolated CPUs).

