Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312A765FFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjAFMCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:02:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C81A3728A9;
        Fri,  6 Jan 2023 04:02:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58F7F11FB;
        Fri,  6 Jan 2023 04:03:30 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5011E3F23F;
        Fri,  6 Jan 2023 04:02:46 -0800 (PST)
Date:   Fri, 6 Jan 2023 12:02:39 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Beeman Strong <beeman@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: Expected rdpmc behavior during context swtich and a RISC-V
 conundrum
Message-ID: <Y7gN32eHJNyWBvVD@FVFF77S0Q05N>
References: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:59:24AM -0800, Atish Patra wrote:
> Hi All,
> There was a recent uabi update[1] for RISC-V that allows the users to
> read cycle and instruction count without any checks.
> We tried to restrict that behavior to address security concerns
> earlier but it resulted in breakage for some user space
> applications[2].
> Thus, previous behavior was restored where a user on RISC-V platforms
> can directly read cycle or instruction count[3].
> 
> Comparison with other ISAs w.r.t user space access of counters:
> ARM64
>   -- Enabled/Disabled via (/proc/sys/kernel/perf_user_access)
>   -- Only for task bound events configured via perf.
> 
> X86
>  --- rdpmc instruction
>  --- Enable/Disable via “/sys/devices/cpu/rdpmc”
> -- Before v4.0
>  -- any process (even without active perf event) rdpmc
> After v4.0
> -- Default behavior changed to support only active events in a
> process’s context.
> -- Configured through perf similar to ARM64
> -- Continue to maintain backward compatibility for unrestricted access
> by writing 2 to “/sys/devices/cpu/rdpmc”
> 
> IMO, RISC-V should only enable user space access through perf similar
> to ARM64 and x86 (post v4.0).
> However, we do have to support the legacy behavior to avoid
> application breakage.
> As per my understanding a direct user space access can lead to the
> following problems:
> 
> 1) There is no context switch support, so counts from other contexts are exposed
> 2) If a perf user is allocated one of these counters, the counter
> value will be written
> 
> Looking at the x86 code as it continues to allow the above behavior,
> rdpmc_always_available_key is enabled in the above case. However,
> during the context switch (cr4_update_pce_mm)
> only dirty counters are cleared. It only prevents leakage from perf
> task to rdpmc task.
> 
> How does the context switch of counters work for users who enable
> unrestricted access by writing 2 to “/sys/devices/cpu/rdpmc” ?
> Otherwise, rdpmc users likely get noise from other applications. Is
> that expected ?

Regardless of leakage, they're also going to get random jumps in the visible
values of the cycle count and instruction count as the task is context-switched
(and/or if those values get reset across idle, as can happen on arm64), so
those aren't going to be useful unless a number of other constraints apply.

AFAICT the affected package was actually a library of intrinsics; does this
affect a real application, or was this just in tests? If it's the latter there
might still be scope to properly lock this down...

Thanks,
Mark.

> This can be a security concern also where a rogue rdpmc user
> application can monitor other critical applications to initiate side
> channel attack.
> 
> Am I missing something? Please correct my understanding of the x86
> implementation if it is wrong.
> 
> [1] https://lore.kernel.org/lkml/20221201135110.3855965-1-conor.dooley@microchip.com/
> [2] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE?pli=1
> [3] https://lore.kernel.org/all/YxIzgYP3MujXdqwj@aurel32.net/T/
> 
> -- 
> Regards,
> Atish
