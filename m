Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455B97273B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 02:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjFHA0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 20:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFHA0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 20:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202832128;
        Wed,  7 Jun 2023 17:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 983E26418B;
        Thu,  8 Jun 2023 00:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C6C433D2;
        Thu,  8 Jun 2023 00:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686183959;
        bh=740oLFl6KOxb2WVmh9iX8854m0FdqLwbIEptbd6/PdA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RhsZR+ZRhLNMYTFEzvnyuOruwGMARDw+3aNQFfZlQPGxC2D8NZERShBMYvOCGcTw8
         GNEXuSmN4kkcoFvKFSIg/IU1T8ZmJF1m+oJdczK0kKbd4NAFuIr8iYEu9iFg8wSrAb
         uulUdvQjnUBl9cRDtZvzHc5DrJQgCnHH+CzlEOZokRPiK2wVF+08f47+ntCK3CffzH
         8GF11ZmmKnG/T/andTDdvfMnmVPr55SrKoUIHIfZ7Nai+5SD9WHfG/YnCszXFFl+2M
         zNvpelZ6iu1J4d6y1I+nTywkwc8qLQe7QDyki4n36fEG99BvLuPGojOdMAWeQ/7wi0
         K7aCltu2CKleg==
Date:   Thu, 8 Jun 2023 09:25:54 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Thaler <dthaler@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-Id: <20230608092554.4b6f7f2c7fb0db9fb359ef0d@kernel.org>
In-Reply-To: <20230607192611.GA143@W11-BEAU-MD.localdomain>
References: <20230516212658.2f5cc2c6@gandalf.local.home>
        <20230517165028.GA71@W11-BEAU-MD.localdomain>
        <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
        <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
        <20230601152414.GA71@W11-BEAU-MD.localdomain>
        <20230601-legten-festplatten-fe053c6f16a4@brauner>
        <20230601162921.GA152@W11-BEAU-MD.localdomain>
        <20230606223752.65dd725c04b11346b45e0546@kernel.org>
        <20230606170549.GA71@W11-BEAU-MD.localdomain>
        <20230607230702.03c6d3a213d527a221bdc533@kernel.org>
        <20230607192611.GA143@W11-BEAU-MD.localdomain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 12:26:11 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Wed, Jun 07, 2023 at 11:07:02PM +0900, Masami Hiramatsu wrote:
> > On Tue, 6 Jun 2023 10:05:49 -0700
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > On Tue, Jun 06, 2023 at 10:37:52PM +0900, Masami Hiramatsu wrote:
> > > > Hi Beau,
> > > > 
> > > > On Thu, 1 Jun 2023 09:29:21 -0700
> > > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > > 
> > > > > > > These are stubs to integrate namespace support. I've been working on a
> > > > > > > series that adds a tracing namespace support similiar to the IMA
> > > > > > > namespace work [1]. That series is ending up taking more time than I
> > > > > > 
> > > > > > Look, this is all well and nice but you've integrated user events with
> > > > > > tracefs. This is currently a single-instance global filesystem. So what
> > > > > > you're effectively implying is that you're namespacing tracefs by
> > > > > > hanging it off of struct user namespace making it mountable by
> > > > > > unprivileged users. Or what's the plan?
> > > > > > 
> > > > > 
> > > > > We don't have plans for unprivileged users currently. I think that is a
> > > > > great goal and requires a proper tracing namespace, which we currently
> > > > > don't have. I've done some thinking on this, but I would like to hear
> > > > > your thoughts and others on how to do this properly. We do talk about
> > > > > this in the tracefs meetings (those might be out of your time zone
> > > > > unfortunately).
> > > > > 
> > > > > > That alone is massive work with _wild_ security implications. My
> > > > > > appetite for exposing more stuff under user namespaces is very low given
> > > > > > the amount of CVEs we've had over the years.
> > > > > > 
> > > > > 
> > > > > Ok, I based that approach on the feedback given in LPC 2022 - Containers
> > > > > and Checkpoint/Retore MC [1]. I believe you gave feedback to use user
> > > > > namespaces to provide the encapsulation that was required :)
> > > > 
> > > > Even with the user namespace, I think we still need to provide separate
> > > > "eventname-space" for each application, since it may depend on the context
> > > > who and where it is launched. I think the easiest solution is (perhaps)
> > > > providing a PID-based new groups for each instance (the PID-prefix or 
> > > > suffix will be hidden from the application).
> > > > I think it may not good to allow unprivileged user processes to detect
> > > > the registered event name each other by default.
> > > > 
> > > 
> > > Regarding PID, are you referring the PID namespace the application
> > > resides within? Or the actual single PID of the process?
> > 
> > I meant the actual single PID of the process. That will be the safest
> > way by default.
> > 
> 
> How do you feel about instead of single PID using the effective user ID?
> 
> That way we wouldn't have so many events on the system, and the user is
> controlling what runs and can share events.

I think that is another option, and maybe good for some application which
does not use thread but forking worker process for data isolation. And
also, I think that can be covered by the tracer namespace too.

One concern is that if the system uses finer grained access control like
SELinux, it will still be problematic, because one of those processes is
compromised, the event-name is detected.
(In this case, the events still needs to be separated for each process?)

I think there are two points: allowing users to choose the most secure or 
relaxed method, and which should be the default behavior.

> 
> I could see a way for admins to also override the user_event suffix on a
> per-user basis to allow for broader event name scopes if required (IE:
> Our k8s and production scenarios).
> 
> > > 
> > > In production we monitor things in sets that encompass more than a
> > > single application. A requirement we need is the ability to group
> > > like-processes together for monitoring purposes.
> > > 
> > > We really need a way to know these set of events are for this group, the
> > > easiest way to do that is by the system name provided on each event. If
> > > this were to be single PID (and not the PID namespace), then we wouldn't
> > > be able to achieve this requirement. Ideally an admin would be able to
> > > setup the name in some way that means something to them in user-space.
> > 
> > Would you mean using the same events between several different processes?
> > I think it needs more care about security concerns. More on this later.
> > 
> > If not, I think admin has a way to identify which processes are running in
> > the same group outside of ftrace, and can set the filter correctly.
> > 
> 
> Agree that's possible, but it's going to be a massive amount of events
> for both tracefs and perf_event ring buffers to handle (we need a perf
> FD per trace_event ID).

So, for that case, it will need "sharing" events among the different
processes.

> 
> > > 
> > > IE: user_events_critical as a system name, vs knowing (user_events_5
> > > or user_events_6 or user_events_8) are "critical".
> > 
> > My thought is the latter. Then the process can not access to the
> > other process's namespace each other.
> > 
> > > 
> > > Another simple example is the same "application" but it gets exec'd more
> > > than once. Each time it execs the system name would change if it was
> > > really by the actual PID vs PID namespace. This would be very hard to
> > > manage on a perf_event or eBPF level for us. It would also vastly
> > > increase the number of trace_events that would get created on the
> > > system.
> > 
> > Indeed. But fundamentally allowing user to create (register) the new 
> > event means such DoS attack can happen. That's why we have a limitation
> > of the max number of user_events. (BTW, I want to make this number
> > controllable from sysctl or tracefs. Also, we need something against the
> > event-id space contamination by this DoS attack.) 
> > I also think it would be better to have some rate-limit about registering
> > new events.
> > 
> 
> Totally agree here.
> 
> > > 
> > > > > 
> > > > > > > anticipated.
> > > > > > 
> > > > > > Yet you were confident enough to leave the namespacing stubs for this
> > > > > > functionality in the code. ;)
> > > > > > 
> > > > > > What is the overall goal here? Letting arbitrary unprivileged containers
> > > > > > define their own custom user event type by mounting tracefs inside
> > > > > > unprivileged containers? If so, what security story is going to
> > > > > > guarantee that writing arbitrary tracepoints from random unprivileged
> > > > > > containers is safe?
> > > > > > 
> > > > > 
> > > > > Unprivileged containers is not a goal, however, having a per-pod
> > > > > user_event system name, such as user_event_<pod_name>, would be ideal
> > > > > for certain diagnostic scenarios, such as monitoring the entire pod.
> > > > 
> > > > That can be done in the user-space tools, not in the kernel.
> > > > 
> > > 
> > > Right, during k8s pod creation we would create the group and name it
> > > something that makes sense to the operator as an example. I'm sure there
> > > are lots of scenarios user-space can do. However, they almost always
> > > involve more than 1 application together in our scenarios.
> > 
> > Yeah, if it is always used with k8s in the backend servers, it maybe OK.
> > But if it is used in more unreliable environment, we need to consider
> > about malicious normal users.
> > 
> > > 
> > > > > When you have a lot of containers, you also want to limit how many
> > > > > tracepoints each container can create, even if they are given access to
> > > > > the tracefs file. The per-group can limit how many events/tracepoints
> > > > > that container can go create, since we currently only have 16-bit
> > > > > identifiers for trace_event's we need to be cautious we don't run out.
> > > > 
> > > > I agree, we need to have a knob to limit it to avoid DoS attack.
> > > > 
> > > > > user_events in general has tracepoint validators to ensure the payloads
> > > > > coming in are "safe" from what the kernel might do with them, such as
> > > > > filtering out data.
> > > > 
> > > > [...]
> > > > > > > changing the system name of user_events on a per-namespace basis.
> > > > > > 
> > > > > > What is the "system name" and how does it protect against namespaces
> > > > > > messing with each other?
> > > > > 
> > > > > trace_events in the tracing facility require both a system name and an
> > > > > event name. IE: sched/sched_waking, sched is the system name,
> > > > > sched_waking is the event name. For user_events in the root group, the
> > > > > system name is "user_events". When groups are introduced, the system
> > > > > name can be "user_events_<GUID>" for example.
> > > > 
> > > > So my suggestion is using PID in root pid namespace instead of GUID
> > > > by default.
> > > > 
> > > 
> > > By default this would be fine as long as admins can change this to a larger
> > > group before activation for our purposes. PID however, might be a bit
> > > too granular of an identifier for our scenarios as I've explained above.
> > > 
> > > I think these logical steps make sense:
> > > 1. Create "event namespace" (Default system name suffix, max count)
> > > 2. Setup "event namespace" (Change system name suffix, max count)
> > > 3. Attach "event namespace"
> > > 
> > > I'm not sure we know what to attach to in #3 yet, so far both a tracer
> > > namespace and user namespace have been proposed. I think we need to
> > > answer that. Right now everything is in the root "event namespace" and
> > > is simply referred to by default as "user_events" as the system name
> > > without a suffix, and with the boot configured max event count.
> > 
> > OK, so I think we are on the same page :)
> > 
> > I think the user namespace is not enough for protecting events on
> > multi-user system without containers. So it has less flexibility.
> > The new tracer namespace may be OK, we still need a helper user
> > program like 'user_eventd' for managing access based on some policy.
> > If we have a way to manage it with SELinux etc. it will be the best
> > I think. (Perhaps using UNIX domain socket will give us such flexibility.)
> > 
> 
> I'm adding Mathieu to CC since I think he had a few cases where a static
> namespace wasn't enough and we might need hierarchy support.
> 
> If we don't need hierarchy support, I think it's a lot easier to do. I
> like the idea of a per-user event namespace vs a per-PID event namespace
> knowing what we have to do to monitor all of this via perf. Like I said
> above, that will be a huge amount of events compared to a per-user or
> namespace approach.

I think we can start with non hierarchy, but just grouping it. Adding
hierarchy can be done afterwards.

> 
> But I do like where this is headed and glad we are having this
> conversation :)

Yeah, me too :)

Thank you!

> 
> Thanks,
> -Beau


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
