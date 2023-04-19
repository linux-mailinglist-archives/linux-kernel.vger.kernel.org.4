Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E866E8841
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjDTCrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDTCrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245455591
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681958761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBHgiDj+95EzAOotDC3ydO7WWfEOGMVmeF30APsbfiE=;
        b=E2K02cWH9aYE8sN4c6xF3r6U7OfN6HzbHMQduGcu1A6CXsDn2dzPem4Es1FNBnxd2HPU9J
        yNGYzsL9rW9H6NF64dyHbDY7XLBF/P6YvaiyVz8v+IjspuIR8Ypyeq+fnJwXGTx4ddr1cu
        awe2aZhhd9s4BxXNXLEsWW29WJXNzoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-k_H-sxnrOnW8IgJPLsr2-g-1; Wed, 19 Apr 2023 22:42:00 -0400
X-MC-Unique: k_H-sxnrOnW8IgJPLsr2-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83214811E7D;
        Thu, 20 Apr 2023 02:41:59 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C8492026D16;
        Thu, 20 Apr 2023 02:41:59 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id AED50403D6B55; Wed, 19 Apr 2023 13:35:12 -0300 (-03)
Date:   Wed, 19 Apr 2023 13:35:12 -0300
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
Message-ID: <ZEAYQBJmVwsjpjGY@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Apr 19, 2023 at 04:35:51PM +0200, Michal Hocko wrote:
> On Wed 19-04-23 10:48:03, Marcelo Tosatti wrote:
> > On Wed, Apr 19, 2023 at 02:24:01PM +0200, Frederic Weisbecker wrote:
> [...]
> > > 2) Run critical code
> > > 3) Optionally do something once you're done
> > > 
> > > If vmstat is going to be the only thing to wait for on 1), then the remote
> > > solution looks good enough (although I leave that to -mm guys as I'm too
> > > clueless about those matters), 
> > 
> > I am mostly clueless too, but i don't see a problem with the proposed
> > patch (and no one has pointed any problem either).
> 
> I really hate to repeat myself again. The biggest pushback has been on
> a) justification and b) single purpose solution which is very likely
> incomplete. For a) we are getting the story piece by piece which doesn't
> speed up the process. You are proposing a non-trivial change to an
> already convoluted code so having a solid justification is something
> that shouldn't be all that surprising.

The justification is simple and concise:

 2. With a task that busy loops on a given CPU,
    the kworker interruption to execute vmstat_update
    is undesired and may exceed latency thresholds
    for certain applications.

Performance details for the kworker interruption:   

oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...

The example above shows an additional 7us for the

       	oslat -> kworker -> oslat

switches. In the case of a virtualized CPU, and the vmstat_update
interruption in the host (of a qemu-kvm vcpu), the latency penalty
observed in the guest is higher than 50us, violating the acceptable 
latency threshold for certain applications.

---

An additional use-case is what has been noted by Andrew Theurer:

Nearly every telco we work with for 5G RAN is demanding <20 usec CPU latency
as measured by cyclictest & oslat.  We cannot achieve under 20 usec with 
the vmstats interruption.

---

It seems to me this is solid justification (it seems you want 
particular microsecond values, but those depend on application
and the CPU). The point is there are several applications which do not
want to be interrupted (we can ignore the specifics and focus on
that fact).

Moreover, unrelated interruptions might occur close in time
(for example, random function call IPIs generated by other
kernel subsystems), which renders the "lets just consider this 
one application, running on this CPU, to decide what to do" 
short sighted.

> b) is what concerns me more though. There are other per-cpu specific
> things going on that require some regular flushing. Just to mention
> another one that your group has been brought up was the memcg pcp
> caches. Again with a non-trivial proposal to deal with that problem
> [1]. 

Yes.

> It has turned out that we can do a simpler thing [2]. 

For the particular memcg case, there was a simpler fix.

For the vmstat_update case, i don't see a simpler fix. 

> I do not think it is a stretch to expect that similar things will pop
> out every now and then

Agree.

> and rather than dealing with each one in its own way it
> kinda makes sense to come up with a more general concept so that all
> those cases can be handled at a single place at least. 

I can understand where you are coming from. Unfortunately,
for some cases it is appropriate to perform the work from a
remote CPU (and i think this is one such case).

> All I hear about
> that is that the code of those special applications would need to be
> changed to use that. 

This is a burden for application writers and for system configuration.

Or it could be done automatically (from outside of the application).
Which is what is described and implemented here:

https://lore.kernel.org/lkml/20220204173537.429902988@fedora.localdomain/

"Task isolation is divided in two main steps: configuration and
activation.

Each step can be performed by an external tool or the latency
sensitive application itself. util-linux contains the "chisol" tool
for this purpose."

But not only that, the second thing is:

"> Another important point is this: if an application dirties                                                                          
> its own per-CPU vmstat cache, while performing a system call,                                                                       

Or while handling a VM-exit from a vCPU.

This are, in my mind, sufficient reasons to discard the "flush per-cpu
caches" idea. This is also why i chose to abandon the prctrl interface
patchset.

> and a vmstat sync event is triggered on a different CPU, you'd have to:                                                             
>                                                                                                                                     
> 1) Wait for that CPU to return to userspace and sync its stats                                                                      
> (unfeasible).                                                                                                                       
>                                                                                                                                     
> 2) Queue work to execute on that CPU (undesirable, as that causes                                                                   
> an interruption).                                                                                                                   
>                                                                                                                                     
> 3) Remotely sync the vmstat for that CPU."

So the only option is to remotely sync vmstat for the CPU
(unless you have a better suggestion).

> Well, true but is that bar so impractical that we
> are going to grow kernel complexity and therefore a maintenance burden?

Honestly, this patchset is just using cmpxchg to transfer data from
per-CPU counters to global counters. I don't see why its that 
complicated.

If you have a suggestion on how to reduce the apparent complexity,
that would be great.

> Everything for a very specialized workloads?

Well the kernel has been increasing in complexity, and the maintenance
burden has increased as a side-effect, to accomodate more workloads
than it was initially designed for.

> [1] http://lkml.kernel.org/r/20221102020243.522358-1-leobras@redhat.com
> [2] http://lkml.kernel.org/r/20230317134448.11082-1-mhocko@kernel.org
> -- 
> Michal Hocko
> SUSE Labs
> 
> 

