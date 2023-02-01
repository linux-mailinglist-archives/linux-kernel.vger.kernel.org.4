Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66829686589
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBALqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBALqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:46:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E7DB1207E;
        Wed,  1 Feb 2023 03:46:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586DE4B3;
        Wed,  1 Feb 2023 03:46:54 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F0963F882;
        Wed,  1 Feb 2023 03:46:09 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:46:07 +0000
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
Message-ID: <Y9pQ/939u9O6teX0@FVFF77S0Q05N>
References: <20230127162409.2505312-1-elver@google.com>
 <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
 <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N>
 <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 10:33:40AM +0100, Marco Elver wrote:
> On Mon, 30 Jan 2023 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
> > > This again feels like a deficiency with access_ok(). Is there a better
> > > primitive than access_ok(), or can we have something that gives us the
> > > guarantee that whatever it says is "ok" is a userspace address?
> >
> > I don't think so, since this is contextual and temporal -- a helper can't give
> > a single correct answert in all cases because it could change.
 
One thing I just realised to note -- these mappings are installed in a distinct
set of page tables that the kernel transiently switches to within the context
of a task, they're not inside the same page tables as userspace associated with
that task. So you can have distinct mappings at the same VA at different times.

> That's fair, but unfortunate.

Yup. :)

> Just curious: would copy_from_user_nofault() reliably fail if it tries to
> access one of those mappings but where access_ok() said "ok"?

Generally, no. Most architectures don't have special instructions for accessing
user memory specifically and are reliant on people not making uaccesses while
such mappings are installed. That's generally enforced by mutual exclusion;
userspace can't issue any new syscalls within the context of that task since it
isn't executing while the special mappings are installed, and usually IRQs
would be disabled, preventing IPIs and such. There *might* be a latent issue
with interruptible EFI runtime services.

On arm64, yes. Our uacccess routines including copy_from_user_nofault() use out
`LDTR` and `STTR` instructions, which use the same permissions as accesses from
userspace, and we create the special mappings without user access permissions,
so any uaccess to those will fault. There are some special cases (e.g. the
futex code), but those are never invoked in a context where the special
mappings are in place.

> Though that would probably restrict us to only creating watchpoints
> for addresses that are actually mapped in the task.

As above, since this is contextual and temporal, that wouldn't actually protect
us.

Consider a user task with something mapped at 0xCAFEF00D:

* access_ok(0xCAFEF00D, 1) is true

* copy_from_user_nofault(dst, 0xCAFEF00D, 1) succeeds without faulting.

... so we would be able to install a watchpoint.

However, after this the task might *transiently* use a different mapping (e.g.
the idmap), which could have an unrelated mapping at 0xCAFEF00D (for which
copy_from_user_nofault() would fault).

> > In the cases we switch to another mapping, we could try to ensure that we
> > enable/disable potentially unsafe watchpoints/breakpoints.
> 
> That seems it'd be too hard to reason that it's 100% safe, everywhere,
> on every arch. I'm still convinced we can prohibit creation of such
> watchpoints in the first place, but need something other than
> access_ok().

As above, I don't think that can be an ahead-of-time check. If we want the
watchpoints to fire on kernel-mode accesses to user memory, we need a temporal
boundary around when userspace mappings are transiently switched with other
mappings.

While that's arch specific, there are relatively few places that do that
switch.

> > Taking a look at arm64, our idmap code might actually be ok, since we usually
> > mask all the DAIF bits (and the 'D' or 'Debug' bit masks HW
> > breakpoints/watchpoints). For EFI we largely switch to another thread (but not
> > always), so that would need some auditing.
> >
> > So if this only needs to work in per-task mode rather than system-wide mode, I
> > reckon we can have some save/restore logic around those special cases where we
> > transiently install a mapping, which would protect us.
> 
> It should only work in per-task mode.

Ok, that makes the problem much simpler; with that in mind arm64 might already
be safe today.

That rules out a user task trying to monitor a kthread, which is the common
case (e.g. most EFI RTS calls or use of the idmap for idle).

There are a few rare cases where we do this within the context of a user task.
In those cases we're already doing a bunch of work to transiently switch page
tables and other state, so we could add some hooks to transiently disable
watchpoints and call those at the same time.

> > For the threads that run with special mappings in the low half, I'm not sure
> > what to do. If we've ruled out system-wide monitoring I believe those would be
> > protected from unprivileged users.
> 
> Can the task actually access those special mappings, or is it only
> accessible by the kernel?

They're only accessible by the kernel, and are not accessible by a uaccess or
actual userspace access.

As above, they're in a distinct set of page tables (so not accessible from
other threads within the same process), and they're mapped with kernel
permissions, so the uaccess routines should fault.

Thanks,
Mark.
