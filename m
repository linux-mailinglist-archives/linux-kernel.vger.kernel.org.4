Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B16EBC4C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDWBet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDWBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F33626AF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682213636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+j+WldzPLpT07r48+1gwjsUCiy0gcgWWenpVe5DddM=;
        b=YCuG6Gz4ItJYdvxmqocGMxLNGtlIp+shMMkxytB60m4zCViZpnVslWukvrTzPhwywKQR71
        Kk8nuSrXhWWUqcBJ9giDutX9dUiDq/dgoAT3gcNwScCfz/sVVs/ipnGZDuAmhT/D3r9+aK
        ydSQ7BQ40gWsIb3Sj/1y0px/B0ng8qk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-tQ7YNTSfMBu-trzLnxHTkA-1; Sat, 22 Apr 2023 21:33:50 -0400
X-MC-Unique: tQ7YNTSfMBu-trzLnxHTkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E34CD811E7C;
        Sun, 23 Apr 2023 01:33:49 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A3942166B33;
        Sun, 23 Apr 2023 01:33:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id F282A403BD904; Thu, 20 Apr 2023 10:45:20 -0300 (-03)
Date:   Thu, 20 Apr 2023 10:45:20 -0300
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
Message-ID: <ZEFB8FSKWms2VmaL@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEAYQBJmVwsjpjGY@tpad>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 01:35:12PM -0300, Marcelo Tosatti wrote:
> Hi Michal,
> 
> On Wed, Apr 19, 2023 at 04:35:51PM +0200, Michal Hocko wrote:
> > On Wed 19-04-23 10:48:03, Marcelo Tosatti wrote:
> > > On Wed, Apr 19, 2023 at 02:24:01PM +0200, Frederic Weisbecker wrote:
> > [...]
> > > > 2) Run critical code
> > > > 3) Optionally do something once you're done
> > > > 
> > > > If vmstat is going to be the only thing to wait for on 1), then the remote
> > > > solution looks good enough (although I leave that to -mm guys as I'm too
> > > > clueless about those matters), 
> > > 
> > > I am mostly clueless too, but i don't see a problem with the proposed
> > > patch (and no one has pointed any problem either).
> > 
> > I really hate to repeat myself again. The biggest pushback has been on
> > a) justification and b) single purpose solution which is very likely
> > incomplete. For a) we are getting the story piece by piece which doesn't
> > speed up the process. You are proposing a non-trivial change to an
> > already convoluted code so having a solid justification is something
> > that shouldn't be all that surprising.
> 
> The justification is simple and concise:
> 
>  2. With a task that busy loops on a given CPU,
>     the kworker interruption to execute vmstat_update
>     is undesired and may exceed latency thresholds
>     for certain applications.
> 
> Performance details for the kworker interruption:   
> 
> oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> 
> The example above shows an additional 7us for the
> 
>        	oslat -> kworker -> oslat
> 
> switches. In the case of a virtualized CPU, and the vmstat_update
> interruption in the host (of a qemu-kvm vcpu), the latency penalty
> observed in the guest is higher than 50us, violating the acceptable 
> latency threshold for certain applications.
> 
> ---
> 
> An additional use-case is what has been noted by Andrew Theurer:
> 
> Nearly every telco we work with for 5G RAN is demanding <20 usec CPU latency
> as measured by cyclictest & oslat.  We cannot achieve under 20 usec with 
> the vmstats interruption.
> 
> ---
> 
> It seems to me this is solid justification (it seems you want 
> particular microsecond values, but those depend on application
> and the CPU). The point is there are several applications which do not
> want to be interrupted (we can ignore the specifics and focus on
> that fact).
> 
> Moreover, unrelated interruptions might occur close in time
> (for example, random function call IPIs generated by other
> kernel subsystems), which renders the "lets just consider this 
> one application, running on this CPU, to decide what to do" 
> short sighted.
> 
> > b) is what concerns me more though. There are other per-cpu specific
> > things going on that require some regular flushing. Just to mention
> > another one that your group has been brought up was the memcg pcp
> > caches. Again with a non-trivial proposal to deal with that problem
> > [1]. 
> 
> Yes.
> 
> > It has turned out that we can do a simpler thing [2]. 
> 
> For the particular memcg case, there was a simpler fix.
> 
> For the vmstat_update case, i don't see a simpler fix. 
> 
> > I do not think it is a stretch to expect that similar things will pop
> > out every now and then
> 
> Agree.
> 
> > and rather than dealing with each one in its own way it
> > kinda makes sense to come up with a more general concept so that all
> > those cases can be handled at a single place at least. 
> 
> I can understand where you are coming from. Unfortunately,
> for some cases it is appropriate to perform the work from a
> remote CPU (and i think this is one such case).
> 
> > All I hear about
> > that is that the code of those special applications would need to be
> > changed to use that. 
> 
> This is a burden for application writers and for system configuration.
> 
> Or it could be done automatically (from outside of the application).
> Which is what is described and implemented here:
> 
> https://lore.kernel.org/lkml/20220204173537.429902988@fedora.localdomain/
> 
> "Task isolation is divided in two main steps: configuration and
> activation.
> 
> Each step can be performed by an external tool or the latency
> sensitive application itself. util-linux contains the "chisol" tool
> for this purpose."
> 
> But not only that, the second thing is:
> 
> "> Another important point is this: if an application dirties                                                                          
> > its own per-CPU vmstat cache, while performing a system call,                                                                       
> 
> Or while handling a VM-exit from a vCPU.
> 
> This are, in my mind, sufficient reasons to discard the "flush per-cpu
> caches" idea. This is also why i chose to abandon the prctrl interface
> patchset.

There are additional details that were not mentioned. When we think
of flushing caches, or disabling per-CPU caches, this means that the
isolated application loses the benefit of those caches (which means you
are turning a "general purpose" programming environment into
potentially slower environment for applications to execute).

(yes, of course, one has to be mindful of which system calls can be
used, for example the execution time of system calls which take locks will
depend on whether, and how many, users of those locks there are at a
given moment).

For example, if we flush the vm-stats at every system call return,
and the application happens to switch between different phases of 

	isolated, userspace only behaviour (computation)
	system call intensive behaviour

(which is an HPC example Thomas Gleixner mentioned in a different
thread), then you see the disadvantage of the "special" environment
where flushing is performed on return to system calls.

So it seems to me (unless there are points that show otherwise, which
would indicate that explicit userspace interfaces are preferred) _not_
requiring userspace changes is a superior solution.

Perhaps the complexity should be judged for individual cases 
of interruptions, and if a given interruption-free conversion 
is seen as too complex, then a "disable feature which makes use of per-CPU
caches" style solution can be made (and then userspace has to
explicitly request for that per-CPU feature to be disabled).

But i don't see that this patchset introduces unmanageable complexity,
neither: 

01b44456a7aa7c3b24fa9db7d1714b208b8ef3d8 mm/page_alloc: replace local_lock with normal spinlock
4b23a68f953628eb4e4b7fe1294ebf93d4b8ceee mm/page_alloc: protect PCP lists with a spinlock


