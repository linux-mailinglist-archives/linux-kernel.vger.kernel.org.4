Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054786F3B21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjEAX6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 19:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjEAXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 19:55:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D66435BF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 16:55:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b60365f53so3703410b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 16:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682985354; x=1685577354;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuwyJlMhOzHc7pD19rcBJm7YGGdkgt4st5TSnBpxtCA=;
        b=u7Fbet5GsM/a+tKDG1jIQjylhg8yDIGsEfB3R3METzXxmxTlMfZIrKJcjG1Eg5BKJj
         MlFOPCIdB1Kzok6k4VO3kofHLnjOICQw4gU2tuQOBg05zhDbFsggy6hJcjAmZMRGAXf0
         rUtZb8K8J1C2NtGocYCnTuPL/7q8UuOvuWeleHqtXMOc3hyp4VTgoMKde+PprRxEq3U9
         3NCfHp5mczh1hPm51YYXtT/w0nBzMFK+Xv4D4Xzjfds97FS7WzOT/O5styDeQpozCahx
         aw/N9G2On9yOd5m0BdC1sLbhcBfoO3yIW/1WaAekonzfxEBWX3WbGIXs9NTSCve1lAj1
         n8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682985354; x=1685577354;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuwyJlMhOzHc7pD19rcBJm7YGGdkgt4st5TSnBpxtCA=;
        b=RoPcoghUQGGV6YU+meL/N53SUwv1xRaUKDlRgbAiE5j0OZpeL5QhPLq1yJIk82ULvY
         Ru462PlifPDyr6wCDU01qtEAVtZo/x5Ofuqvx70gzdntHjPAS71tHOmtB4RhwS0W/dsU
         UAXc/P5nLHCpIBhtVPXBK9abFXr2ZzOVpzvTrJCY88ZIVhm8LKRKaPmJCfQvirNtjz7z
         Iv+i235wmUzeCpQWV7H4/vtWHF8fwHENZoQz0VcP9BPGdmGRJiet1IREd0nuPtBmvUlV
         w6XewWnWQa27D/ek3mRGgGqs9JXOhblU/zYjkl5vMZimEycog6mXVIAvZHSHmy165XWr
         0Dtw==
X-Gm-Message-State: AC+VfDxGzr+leQUdmr7IhQy/KyvCpOZ5aB6XzzWZ/7wi62n/7XAhmwI3
        3ntvVVlRzov4/480nCJLvvgDrAglVjz+M70xKjqG4A==
X-Google-Smtp-Source: ACHHUZ4SgBzSoTxFJ9j/mzMx+FBKsdjE/IfAfq6NZWT2hwrYFJsUY4cczelg66bWFkmYBXKaJT4LqQ==
X-Received: by 2002:a05:6a20:6f03:b0:f8:b39b:b24e with SMTP id gt3-20020a056a206f0300b000f8b39bb24emr16225285pzb.11.1682985354255;
        Mon, 01 May 2023 16:55:54 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t2-20020a628102000000b0063b1e7ffc5fsm20413877pfd.39.2023.05.01.16.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 16:55:53 -0700 (PDT)
Date:   Mon, 01 May 2023 16:55:53 -0700 (PDT)
X-Google-Original-Date: Mon, 01 May 2023 16:55:31 PDT (-0700)
Subject:     Re: [patch 26/37] riscv: Switch to hotplug core state synchronization
In-Reply-To: <20230414232310.817955867@linutronix.de>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org, dwmw@infradead.org,
        andrew.cooper3@citrix.com, brgerst@gmail.com,
        arjan@linux.intel.com, pbonzini@redhat.com, paulmck@kernel.org,
        thomas.lendacky@amd.com, seanjc@google.com,
        oleksandr@natalenko.name, pmenzel@molgen.mpg.de,
        gpiccoli@igalia.com, lucjan.lucjanov@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, dwmw@amazon.co.uk,
        usama.arif@bytedance.com, jgross@suse.com,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        linux@armlinux.org.uk, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        linux-csky@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, linux-parisc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, sabrapan@amazon.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tglx@linutronix.de
Message-ID: <mhng-fd944caa-93db-40e0-8ea8-bc52772a261a@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023 16:44:55 PDT (-0700), tglx@linutronix.de wrote:
> Switch to the CPU hotplug core state tracking and synchronization
> mechanim. No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/Kconfig              |    1 +
>  arch/riscv/include/asm/smp.h    |    2 +-
>  arch/riscv/kernel/cpu-hotplug.c |   14 +++++++-------
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -116,6 +116,7 @@ config RISCV
>  	select HAVE_RSEQ
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
> +	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>  	select IRQ_DOMAIN
>  	select IRQ_FORCED_THREADING
>  	select MODULES_USE_ELF_RELA if MODULES
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -64,7 +64,7 @@ asmlinkage void smp_callin(void);
>
>  #if defined CONFIG_HOTPLUG_CPU
>  int __cpu_disable(void);
> -void __cpu_die(unsigned int cpu);
> +static inline void __cpu_die(unsigned int cpu) { }
>  #endif /* CONFIG_HOTPLUG_CPU */
>
>  #else
> --- a/arch/riscv/kernel/cpu-hotplug.c
> +++ b/arch/riscv/kernel/cpu-hotplug.c
> @@ -8,6 +8,7 @@
>  #include <linux/sched.h>
>  #include <linux/err.h>
>  #include <linux/irq.h>
> +#include <linux/cpuhotplug.h>
>  #include <linux/cpu.h>
>  #include <linux/sched/hotplug.h>
>  #include <asm/irq.h>
> @@ -48,17 +49,15 @@ int __cpu_disable(void)
>  	return ret;
>  }
>
> +#ifdef CONFIG_HOTPLUG_CPU
>  /*
> - * Called on the thread which is asking for a CPU to be shutdown.
> + * Called on the thread which is asking for a CPU to be shutdown, if the
> + * CPU reported dead to the hotplug core.
>   */
> -void __cpu_die(unsigned int cpu)
> +void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
>  {
>  	int ret = 0;
>
> -	if (!cpu_wait_death(cpu, 5)) {
> -		pr_err("CPU %u: didn't die\n", cpu);
> -		return;
> -	}
>  	pr_notice("CPU%u: off\n", cpu);
>
>  	/* Verify from the firmware if the cpu is really stopped*/
> @@ -75,9 +74,10 @@ void arch_cpu_idle_dead(void)
>  {
>  	idle_task_exit();
>
> -	(void)cpu_report_death();
> +	cpuhp_ap_report_dead();
>
>  	cpu_ops[smp_processor_id()]->cpu_stop();
>  	/* It should never reach here */
>  	BUG();
>  }
> +#endif

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
