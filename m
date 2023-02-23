Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DD6A04C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjBWJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjBWJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:28:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8214AFEB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:28:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso11867732pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UjYf5J3J9XUndvOCZh6Z2mddp8OlC3USsn2OpMMQFcQ=;
        b=fzy43LkRNYzLBqeigNgTlVG3MgLUKnye9UyydsNIaeLaWFKo+evR+6Os+9PGcUOG8G
         apL/w9t1Uuf57Uo75+X97K7KP2LjXJy93YK3ueA56y02wPibb2CctXAwhOzkfe/zFP5n
         cNzTMz433bVZosZhDkFI48gQgs0mctxXyc4k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjYf5J3J9XUndvOCZh6Z2mddp8OlC3USsn2OpMMQFcQ=;
        b=NS/fYIezsi/Gw6m5eQHrEqTX3s2awQZCS1p+H5mAzpj8m3BjTkiwLGHlTa9ms9B2R0
         mDsXXP6gqHif9llnfh9TTwmFOH+7gjGGAoR8JP0Mcl9mZHYi1TPbdRMmj9EWFHnKa/rb
         RHk4aKkoy5okBeuyzFoBCLoiCJzF6X0Kkx63WiD6uPxrLtsSstU63Ar98msDJJ+tBwbW
         DLLRBQylajNsskYFTOt2/xY67I/WDKWhcf9/evOelGoqDf9BHn4OYHRhyTaXP/2HU2YW
         fQz/KNPGc+j6U8DyWu+glAttxQGAdNR/WEpDYS7NR2O+ghdqI8FNXbYyS81Bf/xk1hjl
         h4fg==
X-Gm-Message-State: AO0yUKXPDtS6ArZoTsCXv+S7ChQl5+EgmZP72ZWrn0UTHl0JlfAFroq7
        fYjOnTDyXqkOvEfaDUS6l4UzmA==
X-Google-Smtp-Source: AK7set8uXHWcK3Hy+r3E1WdhKcS7IcC6e6RewXaM+OA3MLeiDF94C8dGG47KHbC0gVknZdGAQrZdIQ==
X-Received: by 2002:a05:6a20:7f8a:b0:b8:841d:85bb with SMTP id d10-20020a056a207f8a00b000b8841d85bbmr12167567pzj.0.1677144527784;
        Thu, 23 Feb 2023 01:28:47 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:24fe:6a37:3375:c5bc])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b0056d7cc80ea4sm6642222pfd.110.2023.02.23.01.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:28:47 -0800 (PST)
Date:   Thu, 23 Feb 2023 17:28:43 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, will@kernel.org
Subject: Re: [PATCH v3 0/8] arm64/ftrace: Add support for
 DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <Y/cxy1RY+Bex1qzG@google.com>
References: <20230123134603.1064407-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134603.1064407-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:45:55PM +0000, Mark Rutland wrote:
> Hi Catalin, Steve,
> 
> I'm not sure how we want to merge this, so I've moved the core ftrace
> patch to the start of the series so that it can more easily be placed on
> a stable branch if we want that to go via the ftrace tree and the rest
> to go via arm64.
> 
> This is cleanly pasing the ftrace selftests from v6.2-rc3 (results in
> the final patch).
> 
> Aside from that, usual cover letter below.
> 
> This series adds a new DYNAMIC_FTRACE_WITH_CALL_OPS mechanism, and
> enables support for this on arm64. This significantly reduces the
> overhead of tracing when a callsite/tracee has a single associated
> tracer, avoids a number of issues that make it undesireably and
> infeasible to use dynamically-allocated trampolines (e.g. branch range
> limitations), and makes it possible to implement support for
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS in future.
> 
> The main idea is to give each ftrace callsite an associated pointer to
> an ftrace_ops. The architecture's ftrace_caller trampoline can recover
> the ops pointer and invoke ops->func from this without needing to use
> ftrace_ops_list_func, which has to iterate through all registered ops.
> 
> To make this work, we use -fpatchable-function-entry=M,N, there N NOPs
> are placed before the function entry point. On arm64 NOPs are always 4
> bytes, so by allocating 2 per-function NOPs, we have enough space to
> place a 64-bit value. So that we can manipulate the pointer atomically,
> we need to align instrumented functions to at least 8 bytes, which we
> can ensure using -falign-functions=8.

Does this work all the time? Or is it influenced by other Kconfig
options?

I'm getting random misaligned patch-site warnings like the following:

Misaligned patch-site gic_handle_irq+0x0/0x12c
Misaligned patch-site __traceiter_initcall_level+0x0/0x60
Misaligned patch-site __traceiter_initcall_start+0x0/0x60
Misaligned patch-site __traceiter_initcall_finish+0x0/0x68
Misaligned patch-site do_one_initcall+0x0/0x300
Misaligned patch-site do_one_initcall+0x2b0/0x300
Misaligned patch-site match_dev_by_label+0x0/0x50
Misaligned patch-site match_dev_by_uuid+0x0/0x48
Misaligned patch-site wait_for_initramfs+0x0/0x68
Misaligned patch-site panic_show_mem+0x0/0x88
Misaligned patch-site 0xffffffd3b4fef074
[...]
(I assume the unresolved symbol(s) are from modules.)

The warnings were seen on next-20230223 and many versions before, with
Debian's GCC 12.2 cross compile toolchain. I also tried next-20230223
with Linaro's toolchains gcc-linaro-12.2.1-2023.01-x86_64_aarch64-linux-gnu
and gcc-linaro-13.0.0-2022.11-x86_64_aarch64-linux-gnu and the warnings
appeared as well.

Checking panic_show_mem in various places from the Debian GCC's build:

$ aarch64-linux-gnu-nm init/initramfs.o | grep panic_show_mem
0000000000000070 t panic_show_mem
$ aarch64-linux-gnu-nm init/built-in.a | grep panic_show_mem
0000000000000070 t panic_show_mem
$ aarch64-linux-gnu-nm built-in.a | grep panic_show_mem
0000000000000070 t panic_show_mem
$ aarch64-linux-gnu-nm vmlinux.a | grep panic_show_mem
0000000000000070 t panic_show_mem
$ aarch64-linux-gnu-nm vmlinux.o | grep panic_show_mem
0000000000001534 t panic_show_mem
$ aarch64-linux-gnu-nm vmlinux | grep panic_show_mem
ffffffc0080158dc t panic_show_mem

Looks like individual object files do have functions aligned at 8-byte
boundaries, but when all the object files are collected and linked
together into vmlinux.o, the higher alignment gets dropped and some
functions end up on 4-byte boundaries.


Regards
ChenYu

> 
> Each callsite ends up looking like:
> 
> 	# Aligned to 8 bytes
> 	func - 8:
> 		< pointer to ops >
> 	func:
> 		BTI		// optional
> 		MOV	X9, LR
> 		NOP		// patched to `BL ftrace_caller`
> 	func_body:
> 
> When entering ftrace_caller, the LR points at func_body, and the
> ftrace_ops can be recovered at a negative offset from this the LR value:
> 
> 	BIC	<tmp>, LR, 0x7		// Align down (skips BTI)
> 	LDR	<tmp>, [<tmp>, #-16]	// load ops pointer
> 
> The ftrace_ops::func (and any other ftrace_ops fields) can then be
> recovered from this pointer to the ops.
> 
> The first three patches enable the function alignment, working around
> cases where GCC drops alignment for cold functions or when building with
> '-Os'.
> 
> The final four patches implement support for
> DYNAMIC_FTRACE_WITH_CALL_OPS on arm64. As noted in the final patch, this
> results in a significant reduction in overhead:
> 
>   Before this series:
> 
>   Number of tracers     || Total time  | Per-call average time (ns)
>   Relevant | Irrelevant || (ns)        | Total        | Overhead
>   =========+============++=============+==============+============
>          0 |          0 ||      94,583 |         0.95 |           -
>          0 |          1 ||      93,709 |         0.94 |           -
>          0 |          2 ||      93,666 |         0.94 |           -
>          0 |         10 ||      93,709 |         0.94 |           -
>          0 |        100 ||      93,792 |         0.94 |           -
>   ---------+------------++-------------+--------------+------------
>          1 |          1 ||   6,467,833 |        64.68 |       63.73
>          1 |          2 ||   7,509,708 |        75.10 |       74.15
>          1 |         10 ||  23,786,792 |       237.87 |      236.92
>          1 |        100 || 106,432,500 |     1,064.43 |     1063.38
>   ---------+------------++-------------+--------------+------------
>          1 |          0 ||   1,431,875 |        14.32 |       13.37
>          2 |          0 ||   6,456,334 |        64.56 |       63.62
>         10 |          0 ||  22,717,000 |       227.17 |      226.22
>        100 |          0 || 103,293,667 |      1032.94 |     1031.99
>   ---------+------------++-------------+--------------+--------------
> 
>   Note: per-call overhead is estiamated relative to the baseline case
>   with 0 relevant tracers and 0 irrelevant tracers.
> 
>   After this series:
> 
>   Number of tracers     || Total time  | Per-call average time (ns)
>   Relevant | Irrelevant || (ns)        | Total        | Overhead
>   =========+============++=============+==============+============
>          0 |          0 ||      94,541 |         0.95 |           -
>          0 |          1 ||      93,666 |         0.94 |           -
>          0 |          2 ||      93,709 |         0.94 |           -
>          0 |         10 ||      93,667 |         0.94 |           -
>          0 |        100 ||      93,792 |         0.94 |           -
>   ---------+------------++-------------+--------------+------------
>          1 |          1 ||     281,000 |         2.81 |        1.86
>          1 |          2 ||     281,042 |         2.81 |        1.87
>          1 |         10 ||     280,958 |         2.81 |        1.86
>          1 |        100 ||     281,250 |         2.81 |        1.87
>   ---------+------------++-------------+--------------+------------
>          1 |          0 ||     280,959 |         2.81 |        1.86
>          2 |          0 ||   6,502,708 |        65.03 |       64.08
>         10 |          0 ||  18,681,209 |       186.81 |      185.87
>        100 |          0 || 103,550,458 |     1,035.50 |     1034.56
>   ---------+------------++-------------+--------------+------------
> 
>   Note: per-call overhead is estiamated relative to the baseline case
>   with 0 relevant tracers and 0 irrelevant tracers.
> 
> 
> This version of the series can be found in my kernel.org git repo:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
> 
> Tagged as:
> 
>   arm64-ftrace-per-callsite-ops-20230113
> 
> Since v1 [1]:
> * Fold in Ack from Rafael
> * Update comments/commits with description of the GCC issue
> * Move the cold attribute changes to compiler_types.h
> * Drop the unnecessary changes to the weak attribute
> * Move declaration of ftrace_ops earlier
> * Clean up and improve commit messages
> * Regenerate statistics on misaligned text symbols
> 
> Since v2 [2]:
> * Fold in Steve's Reviewed-by tag
> * Move core ftrace patch to the start of the series
> * Add ftrace selftest reults to final patch
> * Use FUNCTION_ALIGNMENT_4B by default
> * Fix commit message typos
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20230109135828.879136-1-mark.rutland@arm.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20230113180355.2930042-1-mark.rutland@arm.com/
> 
> Thanks,
> Mark.
> 
> Mark Rutland (8):
>   ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
>   Compiler attributes: GCC cold function alignment workarounds
>   ACPI: Don't build ACPICA with '-Os'
>   arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
>   arm64: insn: Add helpers for BTI
>   arm64: patching: Add aarch64_insn_write_literal_u64()
>   arm64: ftrace: Update stale comment
>   arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
> 
>  arch/arm64/Kconfig                  |   4 +
>  arch/arm64/Makefile                 |   5 +-
>  arch/arm64/include/asm/ftrace.h     |  15 +--
>  arch/arm64/include/asm/insn.h       |   1 +
>  arch/arm64/include/asm/linkage.h    |   4 +-
>  arch/arm64/include/asm/patching.h   |   2 +
>  arch/arm64/kernel/asm-offsets.c     |   4 +
>  arch/arm64/kernel/entry-ftrace.S    |  32 +++++-
>  arch/arm64/kernel/ftrace.c          | 158 +++++++++++++++++++++++++++-
>  arch/arm64/kernel/patching.c        |  17 +++
>  drivers/acpi/acpica/Makefile        |   2 +-
>  include/linux/compiler_attributes.h |   6 --
>  include/linux/compiler_types.h      |  27 +++++
>  include/linux/ftrace.h              |  18 +++-
>  kernel/exit.c                       |   9 +-
>  kernel/trace/Kconfig                |   7 ++
>  kernel/trace/ftrace.c               | 109 ++++++++++++++++++-
>  17 files changed, 380 insertions(+), 40 deletions(-)
> 
> -- 
> 2.30.2
> 
> 
