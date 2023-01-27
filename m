Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0F67ED5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjA0SZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjA0SZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:25:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 725ED37B54;
        Fri, 27 Jan 2023 10:25:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 962632F;
        Fri, 27 Jan 2023 10:15:26 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.11.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2E63FA58;
        Fri, 27 Jan 2023 10:14:42 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:14:35 +0000
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
Message-ID: <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
References: <20230127162409.2505312-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127162409.2505312-1-elver@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Apologies for having not replies on v1...

On Fri, Jan 27, 2023 at 05:24:09PM +0100, Marco Elver wrote:
> Allow the creation of restricted breakpoint perf events that also fire
> in the kernel (perf_event_attr::exclude_kernel=0), if:
> 
>   1. No sample information is requested; samples may contain IPs,
>      registers, or other information that may disclose kernel addresses.
> 
>   2. The breakpoint (viz. data watchpoint) is on a user address.

I think there's a potential problem here w.r.t. what constitutes a "user
address". Below, the patch assumes that any address which access_ok() is happy
with is a user address, but that's not always the case, and it's not
necessarily always safe to allow watchpoints on such addresses.

For example, UEFI runtime services may live in low adddresses below
TASK_SIZE_MAX, and there are times when we run code in an idmap (or other
low-half mapping) when we cannot safely take an exception for things like idle,
suspend, kexec, pagetable rewriting on arm64, etc.

So I think this may introduce functional issues (e.g. a mechanism to crash the
kernel) in addition to any potential information disclosure, and I would not
want this to be generally available to unprivileged users.

Most of those happen in kernel threads, but they can also happen in the context
of user threads (e.g. if triggering suspend/idle via sysfs), so special care
will be needed, as above.

> The rules constrain the allowable perf events such that no sensitive
> kernel information can be disclosed.
> 
> Despite no explicit kernel information disclosure, the following
> questions may need answers:
> 
>  1. Q: Is obtaining information that the kernel accessed a particular
>     user's known memory location revealing new information?
> 
>     A: Given the kernel's user space ABI, there should be no "surprise
>     accesses" to user space memory in the first place.

I think that may be true for userspace, but not true for other transient
mappings in the low half of the address space. Ignoring the functional concern
above, for idmap'd code this would at least provide a mechanism to probe for
the phyiscal address of that code (and by extension, reveal the phyiscal
location of the entire kernel).

>  2. Q: Does causing breakpoints on user memory accesses by the kernel
>     potentially impact timing in a sensitive way?
> 
>     A: Since hardware breakpoints trigger regardless of the state of
>     perf_event_attr::exclude_kernel, but are filtered in the perf
>     subsystem, this possibility already exists independent of the
>     proposed change.

Hmm... arm64's HW breakpoints and watchpoints have HW privilege filters, so I'm
not sure the above statement is generally/necessarily true.

> Motivation:  Data breakpoints on user addresses that also fire in the
> kernel provide complete coverage to track and debug accesses, not just
> in user space but also through the kernel. For example, tracking where
> user space invokes syscalls with pointers to specific memory.
> 
> Breakpoints can be used for more complex dynamic analysis, such as race
> detection, memory-safety error detection, or data-flow analysis. Larger
> deployment by linking such dynamic analysis into binaries in production
> only becomes possible when no additional capabilities are required by
> unprivileged users. To improve coverage, it should then also be possible
> to enable breakpoints on user addresses that fire in the kernel with no
> additional capabilities.

I can understand the argument for watchpoints (modulo my concerns above), but
there's no need to support instruction breakpoints, right? i.e. there's no
legitimate reason for a user to want to monitor a given user address
system-wide, regardless of what's running?

IIUC this only makes sense for watchpoints, and only in the context of a given
task.

Thanks,
Mark.

> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> 
> Changelog
> ~~~~~~~~~
> 
> v2:
> * Commit message (motivation, more explanation).
> * Apply ack.
> 
> v1: https://lkml.kernel.org/r/20220902100057.404817-1-elver@google.com
> * Rebase.
> 
> RFC: https://lkml.kernel.org/r/20220601093502.364142-1-elver@google.com
> ---
>  include/linux/perf_event.h |  8 +-------
>  kernel/events/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index c6a3bac76966..a95a6b889b00 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1463,13 +1463,7 @@ static inline int perf_is_paranoid(void)
>  	return sysctl_perf_event_paranoid > -1;
>  }
>  
> -static inline int perf_allow_kernel(struct perf_event_attr *attr)
> -{
> -	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
> -		return -EACCES;
> -
> -	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
> -}
> +extern int perf_allow_kernel(struct perf_event_attr *attr);
>  
>  static inline int perf_allow_cpu(struct perf_event_attr *attr)
>  {
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d56328e5080e..0f1fc9aef294 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3174,6 +3174,12 @@ static int perf_event_modify_attr(struct perf_event *event,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (!event->attr.exclude_kernel) {
> +		err = perf_allow_kernel(attr);
> +		if (err)
> +			return err;
> +	}
> +
>  	WARN_ON_ONCE(event->ctx->parent_ctx);
>  
>  	mutex_lock(&event->child_mutex);
> @@ -12289,6 +12295,38 @@ perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
>  	return is_capable || ptrace_may_access(task, ptrace_mode);
>  }
>  
> +/*
> + * Check if unprivileged users are allowed to set up breakpoints on user
> + * addresses that also count when the kernel accesses them.
> + */
> +static bool perf_allow_kernel_breakpoint(struct perf_event_attr *attr)
> +{
> +	if (attr->type != PERF_TYPE_BREAKPOINT)
> +		return false;
> +
> +	/*
> +	 * The sample may contain IPs, registers, or other information that may
> +	 * disclose kernel addresses or timing information. Disallow any kind of
> +	 * additional sample information.
> +	 */
> +	if (attr->sample_type)
> +		return false;
> +
> +	/*
> +	 * Only allow kernel breakpoints on user addresses.
> +	 */
> +	return access_ok((void __user *)(unsigned long)attr->bp_addr, attr->bp_len);
> +}
> +
> +int perf_allow_kernel(struct perf_event_attr *attr)
> +{
> +	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable() &&
> +	    !perf_allow_kernel_breakpoint(attr))
> +		return -EACCES;
> +
> +	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
> +}
> +
>  /**
>   * sys_perf_event_open - open a performance event, associate it to a task/cpu
>   *
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 
