Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE86F595F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjECNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F825597
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683121984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tczHhYhOeJbdic2TiJp7l5vCyhvHMfRkKWturQUv+ak=;
        b=gXYtrdvfOGIHY5LorCXMLckmUdmts66obqkXN3nF6t+7AYVJxQ2djLiy7kI0XGxoUwyczd
        QW9rQ3yH8he8HrGPa7xYl6Ngm9q1ExPIHdfbNVNhTvNWjkCld0r5pgAwAVrjCDCEuCo/8o
        suVwMQvxlNnYkkIREpPS5YX9ZHSzHQs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-ziH0VEKMOAS5kGvzp0Dcig-1; Wed, 03 May 2023 09:53:00 -0400
X-MC-Unique: ziH0VEKMOAS5kGvzp0Dcig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFE243814943;
        Wed,  3 May 2023 13:52:59 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73AF7C15BAD;
        Wed,  3 May 2023 13:52:59 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 544B6401E144D; Wed,  3 May 2023 10:51:21 -0300 (-03)
Date:   Wed, 3 May 2023 10:51:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZFJm2QJrwDpeAzvi@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <1a481d68-930e-9418-a9aa-befdcfe36928@suse.cz>
 <ZEA95uBeUECRvO5e@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEA95uBeUECRvO5e@tpad>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 04:15:50PM -0300, Marcelo Tosatti wrote:
> On Wed, Apr 19, 2023 at 06:47:30PM +0200, Vlastimil Babka wrote:
> > On 4/19/23 13:29, Marcelo Tosatti wrote:
> > > On Wed, Apr 19, 2023 at 08:14:09AM -0300, Marcelo Tosatti wrote:
> > >> This was tried before:
> > >> https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/
> > >> 
> > >> My conclusion from that discussion (and work) is that a special system
> > >> call:
> > >> 
> > >> 1) Does not allow the benefits to be widely applied (only modified
> > >> applications will benefit). Is not portable across different operating systems. 
> > >> 
> > >> Removing the vmstat_work interruption is a benefit for HPC workloads, 
> > >> for example (in fact, it is a benefit for any kind of application, 
> > >> since the interruption causes cache misses).
> > >> 
> > >> 2) Increases the system call cost for applications which would use
> > >> the interface.
> > >> 
> > >> So avoiding the vmstat_update update interruption, without userspace 
> > >> knowledge and modifications, is a better than solution than a modified
> > >> userspace.
> > > 
> > > Another important point is this: if an application dirties
> > > its own per-CPU vmstat cache, while performing a system call,
> > > and a vmstat sync event is triggered on a different CPU, you'd have to:
> > > 
> > > 1) Wait for that CPU to return to userspace and sync its stats
> > > (unfeasible).
> > > 
> > > 2) Queue work to execute on that CPU (undesirable, as that causes
> > > an interruption).
> > 
> > So you're saying the application might do a syscall from the isolcpu, so
> > IIUC it cannot expect any latency guarantees at that very moment, 
> 
> Why not? cyclictest uses nanosleep and its the main tool for measuring
> latency.
> 
> > but then
> > it immediately starts expecting them again after returning to userspace, 
> 
> No, the expectation more generally is this:
> 
> For certain types of applications (for example PLC software or
> RAN processing), upon occurrence of an event, it is necessary to
> complete a certain task in a maximum amount of time (deadline).
> 
> One way to express this requirement is with a pair of numbers,
> deadline time and execution time, where:
> 
>         * deadline time: length of time between event and deadline.
>         * execution time: length of time it takes for processing of event
>                           to occur on a particular hardware platform
>                           (uninterrupted).
> 
> The particular values depend on use-case. For the case
> where the realtime application executes in a virtualized
> guest, an interruption which must be serviced in the host will cause
> the following sequence of events:
> 
>         1) VM-exit
>         2) execution of IPI (and function call) (or switch to kwork
> 	thread to execute some work item).
>         3) VM-entry
> 
> Which causes an excess of 50us latency as observed by cyclictest
> (this violates the latency requirement of vRAN application with 1ms TTI,
> for example).
> 
> > and
> > a single interruption for a one-time flush after the syscall would be too
> > intrusive?
> 
> Generally, if you can't complete the task (which involves executing a
> number of instructions) before the deadline, then its a problem.
> 
> One-time flush? You mean to switch between:
> 
> rt-app -> kworker (to execute vmstat_update flush) -> rt-app
> 
> My measurement, which probably had vmstat_update code/data in cache, took 7us.
> It might be the case that the code to execute must be brought in from
> memory, which takes even longer.
> 
> > (elsewhere in the thread you described an RT app initialization that may
> > generate vmstats to flush and then entry userspace loop, again, would a
> > single interruption soon after entering the loop be so critical?)
> 
> 1) It depends on the application. For the use-case above, where < 50us
> interruption is desired, yes it is critical.
> 
> 2) The interruptions can come from different sources.
> 
> Time
> 0			rt-app executing instruction 1
> 1			rt-app executing instruction 2
> 2			scheduler switches between rt-app and kworker
> 3			kworker runs vmstat_work
> 4			scheduler switches between kworker and rt-app
> 5			rt-app executing instruction 3
> 6			ipi to handle a KVM request IPI
> 7			fill in your preferred IPI handler
> 
> So the argument "a single interruption might not cause your deadline
> to be exceeded" fails (because the time to handle the 
> different interruptions might sum).
> 
> Does that make sense?

Ping ? (just want to double check the reasoning above makes sense).


