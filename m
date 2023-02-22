Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FF69F9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjBVRJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjBVRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:09:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD7F1D91D;
        Wed, 22 Feb 2023 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0TAvvo14Qx7KmfBZu7UsxLB837fK9qdKtlwvM4WjoiQ=; b=oP8oBokRtn2LCXWRP7DV1gOWJU
        jjxl+fYdrXqlx+oMTq8mBhyY45N51W5QEpV/cIBwyvn6mFg+ylHyUPnNV9lM+u5LgYA5x9Kl35dgD
        34VHGwbZNXPgIQ4t7i+V4Kfycfim/kHR0bIg8CqH76F0E9YK4JMflPe7L6JMLzxtqTnGZqTfui7WZ
        64HH11bV4DyJEC5GE4IZ2naTfZds8GTxamSHwgJEDwDzAkMJH2TyzNppXRkplgD8qyzFM1mbDiCwE
        qdnPq/stpCjXDisQWruDWhN9BnXjHRMo0uZl2dgx+SjRQbjYWnmDTpX2vhWT/loyFyf1A/U/Z1RYd
        R05a76qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUsbb-00CbSp-2G;
        Wed, 22 Feb 2023 17:08:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E022C30013F;
        Wed, 22 Feb 2023 18:08:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C722720DD8076; Wed, 22 Feb 2023 18:08:33 +0100 (CET)
Date:   Wed, 22 Feb 2023 18:08:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        tiwai@suse.de, jolsa@kernel.org, vbabka@suse.cz,
        keescook@chromium.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, bp@alien8.de, bhe@redhat.com,
        eric.devolder@oracle.com, hpa@zytor.com, jroedel@suse.de,
        dave.hansen@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com, x86@kernel.org,
        xiexiuqi@huawei.com
Subject: Re: [RFC PATCH v4] x86/kdump: terminate watchdog NMI interrupt to
 avoid kdump crashes
Message-ID: <Y/ZMEesgPnRR3LsG@hirez.programming.kicks-ass.net>
References: <20230217120604.435608-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217120604.435608-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 08:06:04PM +0800, Zeng Heng wrote:
> If the cpu panics within the NMI interrupt context, there could be
> unhandled NMI interrupts in the background which are blocked by processor
> until next IRET instruction executes. Since that, it prevents nested
> NMI handler execution.
> 
> In case of IRET execution during kdump reboot and no proper NMIs handler
> registered at that point (such as during EFI loader), we need to ensure
> watchdog no work any more, or kdump would crash later. So call
> perf_event_exit_cpu() at the very last moment in the panic shutdown.
> 
> !! Here I know it's not allowed to call perf_event_exit_cpu() within nmi
> context, because of mutex_lock, smp_call_function and so on.
> Is there any experts know about the similar function which allowed to call
> within atomic context (Neither x86_pmu_disable() nor x86_pmu_disable_all()
> do work after my practice)?
> 
> Thank you in advance.
> 
> Here provide one of test case to reproduce the concerned issue:
>   1. # cat uncorrected
>      CPU 1 BANK 4
>      STATUS uncorrected 0xc0
>      MCGSTATUS  EIPV MCIP
>      ADDR 0x1234
>      RIP 0xdeadbabe
>      RAISINGCPU 0
>      MCGCAP SER CMCI TES 0x6
>   2. # modprobe mce_inject
>   3. # mce-inject uncorrected
> 
> Mce-inject would trigger kernel panic under NMI interrupt context. In
> addition, we need another NMI interrupt raise (such as from watchdog)
> during panic process. Set proper watchdog threshold value and/or add an
> artificial delay to make sure watchdog interrupt raise during the panic
> procedure and the involved issue would occur.
> 
> Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>   v1: add dummy NMI interrupt handler in EFI loader
>   v2: tidy up changelog, add comments (by Ingo Molnar)
>   v3: add iret_to_self() to deal with blocked NMIs in advance
>   v4: call perf_event_exit_cpu() to terminate watchdog in panic shutdown
> 
>  arch/x86/kernel/crash.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 305514431f26..f46df94bbdad 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/memblock.h>
> +#include <linux/perf_event.h>
> 
>  #include <asm/processor.h>
>  #include <asm/hardirq.h>
> @@ -170,6 +171,15 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  #ifdef CONFIG_HPET_TIMER
>  	hpet_disable();
>  #endif
> +
> +	/*
> +	 * If the cpu panics within the NMI interrupt context,
> +	 * we need to ensure no more NMI interrupts blocked by
> +	 * processor. In case of IRET execution during kdump
> +	 * path and no proper NMIs handler registered at that
> +	 * point, here terminate watchdog in panic shutdown.
> +	 */
> +	perf_event_exit_cpu(smp_processor_id());

This kills all of perf, including but not limited to the hardware
watchdog. However, it does nothing to external NMI sources like the NMI
button found on some HP machines.

Still I suppose it is sufficient for the normal case.

>  	crash_save_cpu(regs, safe_smp_processor_id());
>  }
> 
> --
> 2.25.1
> 
