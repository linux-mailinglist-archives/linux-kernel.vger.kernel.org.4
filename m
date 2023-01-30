Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F265680B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjA3KqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjA3KqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:46:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81BFA302A0;
        Mon, 30 Jan 2023 02:46:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 460BD16A3;
        Mon, 30 Jan 2023 02:46:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.13.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDCED3F71E;
        Mon, 30 Jan 2023 02:46:11 -0800 (PST)
Date:   Mon, 30 Jan 2023 10:46:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v2] perf: Allow restricted kernel breakpoints on user
 addresses
Message-ID: <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N>
References: <20230127162409.2505312-1-elver@google.com>
 <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 08:00:00AM +0100, Marco Elver wrote:
> On Fri, 27 Jan 2023 at 19:14, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Marco,
> >
> > Apologies for having not replies on v1...
> >
> > On Fri, Jan 27, 2023 at 05:24:09PM +0100, Marco Elver wrote:
> > > Allow the creation of restricted breakpoint perf events that also fire
> > > in the kernel (perf_event_attr::exclude_kernel=0), if:
> > >
> > >   1. No sample information is requested; samples may contain IPs,
> > >      registers, or other information that may disclose kernel addresses.
> > >
> > >   2. The breakpoint (viz. data watchpoint) is on a user address.
> >
> > I think there's a potential problem here w.r.t. what constitutes a "user
> > address". Below, the patch assumes that any address which access_ok() is happy
> > with is a user address, but that's not always the case, and it's not
> > necessarily always safe to allow watchpoints on such addresses.
> 
> Isn't that a deficiency with access_ok()?
> 
> https://www.kernel.org/doc/html/latest/core-api/mm-api.html#c.access_ok
> "Checks if a pointer to a block of memory in user space is valid. [...]"

Arguably yes, but it's not really solvable in the current API design.

One issue is that this is contextual, and access_ok() is implicitly limited to
some scenarios but not others. It's not meant to work for arbitrarty pointers
in arbitrary contexts (as e.g. it has no way of distinguishing an idmap from
userspace).

We largely don't take implicit context into account in access_ok(), other than
the tag removal stuff we do on arm64 (and on x86 for LAM), and I don't think
anyone was all that happy about extending it for that.

> > For example, UEFI runtime services may live in low adddresses below
> > TASK_SIZE_MAX, and there are times when we run code in an idmap (or other
> > low-half mapping) when we cannot safely take an exception for things like idle,
> > suspend, kexec, pagetable rewriting on arm64, etc.
> >
> > So I think this may introduce functional issues (e.g. a mechanism to crash the
> > kernel) in addition to any potential information disclosure, and I would not
> > want this to be generally available to unprivileged users.
> >
> > Most of those happen in kernel threads, but they can also happen in the context
> > of user threads (e.g. if triggering suspend/idle via sysfs), so special care
> > will be needed, as above.
> 
> These are good points.
> 
> > > The rules constrain the allowable perf events such that no sensitive
> > > kernel information can be disclosed.
> > >
> > > Despite no explicit kernel information disclosure, the following
> > > questions may need answers:
> > >
> > >  1. Q: Is obtaining information that the kernel accessed a particular
> > >     user's known memory location revealing new information?
> > >
> > >     A: Given the kernel's user space ABI, there should be no "surprise
> > >     accesses" to user space memory in the first place.
> >
> > I think that may be true for userspace, but not true for other transient
> > mappings in the low half of the address space. Ignoring the functional concern
> > above, for idmap'd code this would at least provide a mechanism to probe for
> > the phyiscal address of that code (and by extension, reveal the phyiscal
> > location of the entire kernel).
> 
> This again feels like a deficiency with access_ok(). Is there a better
> primitive than access_ok(), or can we have something that gives us the
> guarantee that whatever it says is "ok" is a userspace address?

I don't think so, since this is contextual and temporal -- a helper can't give
a single correct answert in all cases because it could change.

In the cases we switch to another mapping, we could try to ensure that we
enable/disable potentially unsafe watchpoints/breakpoints.

Taking a look at arm64, our idmap code might actually be ok, since we usually
mask all the DAIF bits (and the 'D' or 'Debug' bit masks HW
breakpoints/watchpoints). For EFI we largely switch to another thread (but not
always), so that would need some auditing.

So if this only needs to work in per-task mode rather than system-wide mode, I
reckon we can have some save/restore logic around those special cases where we
transiently install a mapping, which would protect us.

For the threads that run with special mappings in the low half, I'm not sure
what to do. If we've ruled out system-wide monitoring I believe those would be
protected from unprivileged users.

Thanks,
Mark.

> > >  2. Q: Does causing breakpoints on user memory accesses by the kernel
> > >     potentially impact timing in a sensitive way?
> > >
> > >     A: Since hardware breakpoints trigger regardless of the state of
> > >     perf_event_attr::exclude_kernel, but are filtered in the perf
> > >     subsystem, this possibility already exists independent of the
> > >     proposed change.
> >
> > Hmm... arm64's HW breakpoints and watchpoints have HW privilege filters, so I'm
> > not sure the above statement is generally/necessarily true.
> 
> Right, I can see this being a valid concern on those architectures
> that do support HW privilege filters.
> 
> > > Motivation:  Data breakpoints on user addresses that also fire in the
> > > kernel provide complete coverage to track and debug accesses, not just
> > > in user space but also through the kernel. For example, tracking where
> > > user space invokes syscalls with pointers to specific memory.
> > >
> > > Breakpoints can be used for more complex dynamic analysis, such as race
> > > detection, memory-safety error detection, or data-flow analysis. Larger
> > > deployment by linking such dynamic analysis into binaries in production
> > > only becomes possible when no additional capabilities are required by
> > > unprivileged users. To improve coverage, it should then also be possible
> > > to enable breakpoints on user addresses that fire in the kernel with no
> > > additional capabilities.
> >
> > I can understand the argument for watchpoints (modulo my concerns above), but
> > there's no need to support instruction breakpoints, right? i.e. there's no
> > legitimate reason for a user to want to monitor a given user address
> > system-wide, regardless of what's running?
> >
> > IIUC this only makes sense for watchpoints, and only in the context of a given
> > task.
> 
> Right, there shouldn't be a need for instruction breakpoints, the
> kernel shouldn't be executing user code.
> 
> Thanks,
> -- Marco
