Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26551724494
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbjFFNiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjFFNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33D12D;
        Tue,  6 Jun 2023 06:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC49762B4D;
        Tue,  6 Jun 2023 13:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E865C433EF;
        Tue,  6 Jun 2023 13:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686058678;
        bh=rwRJU4dA7H36UcTPEUz7Yplp6r5Exdcdk93rtl/HYAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d/R/Q/nlfdcQMmHuOjZt9MdJfBYy5S1FIlzopQx4ZikGL0Tzkw7SFV4VurBbma8UL
         pkTTSDTfaI8MwHwcDaX401wEZzg5Op0yLdIzbwhPzwuKRbe/l9c1iDNQUw0n7wgIAF
         0IxOfWUWmuH2BfevMH64WnRQwixQx1YLkPPXZQZ8OL4LuQnHigzV6DWs1q4+8J4Syo
         OQ0CXrXkecT9iMHLTYJ1fI74G65qhwFn5nAmZnSs8O7cd8vXWxbPqYlpGyZfojqoMy
         2g9VA0Gv0Y/6uQQe+XD9Jc6CTBDxpHGFloJiTsqkxrynJUChHV6E8EXAWCHg7FH6Di
         5k2rVgzIHEUTQ==
Date:   Tue, 6 Jun 2023 22:37:52 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Thaler <dthaler@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-Id: <20230606223752.65dd725c04b11346b45e0546@kernel.org>
In-Reply-To: <20230601162921.GA152@W11-BEAU-MD.localdomain>
References: <20230509163050.127d5123@rorschach.local.home>
        <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local>
        <20230515192407.GA85@W11-BEAU-MD.localdomain>
        <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
        <20230516212658.2f5cc2c6@gandalf.local.home>
        <20230517165028.GA71@W11-BEAU-MD.localdomain>
        <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
        <20230601-urenkel-holzofen-cd9403b9cadd@brauner>
        <20230601152414.GA71@W11-BEAU-MD.localdomain>
        <20230601-legten-festplatten-fe053c6f16a4@brauner>
        <20230601162921.GA152@W11-BEAU-MD.localdomain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Beau,

On Thu, 1 Jun 2023 09:29:21 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > > These are stubs to integrate namespace support. I've been working on a
> > > series that adds a tracing namespace support similiar to the IMA
> > > namespace work [1]. That series is ending up taking more time than I
> > 
> > Look, this is all well and nice but you've integrated user events with
> > tracefs. This is currently a single-instance global filesystem. So what
> > you're effectively implying is that you're namespacing tracefs by
> > hanging it off of struct user namespace making it mountable by
> > unprivileged users. Or what's the plan?
> > 
> 
> We don't have plans for unprivileged users currently. I think that is a
> great goal and requires a proper tracing namespace, which we currently
> don't have. I've done some thinking on this, but I would like to hear
> your thoughts and others on how to do this properly. We do talk about
> this in the tracefs meetings (those might be out of your time zone
> unfortunately).
> 
> > That alone is massive work with _wild_ security implications. My
> > appetite for exposing more stuff under user namespaces is very low given
> > the amount of CVEs we've had over the years.
> > 
> 
> Ok, I based that approach on the feedback given in LPC 2022 - Containers
> and Checkpoint/Retore MC [1]. I believe you gave feedback to use user
> namespaces to provide the encapsulation that was required :)

Even with the user namespace, I think we still need to provide separate
"eventname-space" for each application, since it may depend on the context
who and where it is launched. I think the easiest solution is (perhaps)
providing a PID-based new groups for each instance (the PID-prefix or 
suffix will be hidden from the application).
I think it may not good to allow unprivileged user processes to detect
the registered event name each other by default.

> 
> > > anticipated.
> > 
> > Yet you were confident enough to leave the namespacing stubs for this
> > functionality in the code. ;)
> > 
> > What is the overall goal here? Letting arbitrary unprivileged containers
> > define their own custom user event type by mounting tracefs inside
> > unprivileged containers? If so, what security story is going to
> > guarantee that writing arbitrary tracepoints from random unprivileged
> > containers is safe?
> > 
> 
> Unprivileged containers is not a goal, however, having a per-pod
> user_event system name, such as user_event_<pod_name>, would be ideal
> for certain diagnostic scenarios, such as monitoring the entire pod.

That can be done in the user-space tools, not in the kernel.

> When you have a lot of containers, you also want to limit how many
> tracepoints each container can create, even if they are given access to
> the tracefs file. The per-group can limit how many events/tracepoints
> that container can go create, since we currently only have 16-bit
> identifiers for trace_event's we need to be cautious we don't run out.

I agree, we need to have a knob to limit it to avoid DoS attack.

> user_events in general has tracepoint validators to ensure the payloads
> coming in are "safe" from what the kernel might do with them, such as
> filtering out data.

[...]
> > > changing the system name of user_events on a per-namespace basis.
> > 
> > What is the "system name" and how does it protect against namespaces
> > messing with each other?
> 
> trace_events in the tracing facility require both a system name and an
> event name. IE: sched/sched_waking, sched is the system name,
> sched_waking is the event name. For user_events in the root group, the
> system name is "user_events". When groups are introduced, the system
> name can be "user_events_<GUID>" for example.

So my suggestion is using PID in root pid namespace instead of GUID
by default.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
