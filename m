Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F311970CBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjEVVE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjEVVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:04:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE08C94;
        Mon, 22 May 2023 14:04:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684789457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NByQKI51jy2j672ZUXdG7FihvnPAeSwdTvvAedoGpTg=;
        b=MX+9r6HXu/5QEBqc2yVGdayzLN9QC3Spcof7x6wlSwPAvG+JCGl3dIF3Tqjwo831B+7A0z
        HjgfkuU57m3Mx12VWLwF1kWcZOoV7A8fkpM0+EmI1ItXgmcU/k6TXgHZPx8IDVYMbQizgt
        tGVREPK3sLYjlK2mAsLydenhzGmSLA3xyVTQNIN837Vka6O+yHpXvp2jLe0l2HJV7Nc9Qe
        pnPkq0PwnFymxCDoDBNb/vRRCWh8VNuMos17F9fUWM3d52sMdPly/QVK6LuLIuAUqckaId
        NvxIeaxkD6G74LbIeNkj/Kr2rL0IzG/VT2eU1eqW2iuY9+IYD3SC/W2JWHiiMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684789457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NByQKI51jy2j672ZUXdG7FihvnPAeSwdTvvAedoGpTg=;
        b=vhXfTHSmkg8sMek6N/YM9Kxa/vm8sXoYRsypyfUtGXP1dQSKCaL+3v90Q5MYWJoZJcTP6l
        6NVrzQcJMR+6yiAA==
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [patch V4 33/37] cpu/hotplug: Allow "parallel" bringup up to
 CPUHP_BP_KICK_AP_STATE
In-Reply-To: <4ca39e58-055f-432c-8124-7c747fa4e85b@sirena.org.uk>
References: <20230512203426.452963764@linutronix.de>
 <20230512205257.240231377@linutronix.de>
 <4ca39e58-055f-432c-8124-7c747fa4e85b@sirena.org.uk>
Date:   Mon, 22 May 2023 23:04:17 +0200
Message-ID: <87bkicw01a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22 2023 at 20:45, Mark Brown wrote:
> On Fri, May 12, 2023 at 11:07:50PM +0200, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 
>> There is often significant latency in the early stages of CPU bringup, and
>> time is wasted by waking each CPU (e.g. with SIPI/INIT/INIT on x86) and
>> then waiting for it to respond before moving on to the next.
>> 
>> Allow a platform to enable parallel setup which brings all to be onlined
>> CPUs up to the CPUHP_BP_KICK_AP state. While this state advancement on the
>> control CPU (BP) is single-threaded the important part is the last state
>> CPUHP_BP_KICK_AP which wakes the to be onlined CPUs up.
>
> We're seeing a regression on ThunderX2 systems with 256 CPUs with an
> arm64 defconfig running -next which I've bisected to this patch.  Before
> this commit we bring up 256 CPUs:
>
> [   29.137225] GICv3: CPU254: found redistributor 11e03 region 1:0x0000000441f60000
> [   29.137238] GICv3: CPU254: using allocated LPI pending table @0x00000008818e0000
> [   29.137305] CPU254: Booted secondary processor 0x0000011e03 [0x431f0af1]
> [   29.292421] Detected PIPT I-cache on CPU255
> [   29.292635] GICv3: CPU255: found redistributor 11f03 region 1:0x0000000441fe0000
> [   29.292648] GICv3: CPU255: using allocated LPI pending table @0x00000008818f0000
> [   29.292715] CPU255: Booted secondary processor 0x0000011f03 [0x431f0af1]
> [   29.292859] smp: Brought up 2 nodes, 256 CPUs
> [   29.292864] SMP: Total of 256 processors activated.
>
> but after we only bring up 255, missing the 256th:
>
> [   29.165888] GICv3: CPU254: found redistributor 11e03 region 1:0x0000000441f60000
> [   29.165901] GICv3: CPU254: using allocated LPI pending table @0x00000008818e0000
> [   29.165968] CPU254: Booted secondary processor 0x0000011e03 [0x431f0af1]
> [   29.166120] smp: Brought up 2 nodes, 255 CPUs
> [   29.166125] SMP: Total of 255 processors activated.
>
> I can't immediately see an issue with the patch itself, for systems
> without CONFIG_HOTPLUG_PARALLEL=y it should replace the loop over
> cpu_present_mask done by for_each_present_cpu() with an open coded one.
> I didn't check the rest of the series yet.
>
> The KernelCI bisection bot also isolated an issue on Odroid XU3 (a 32
> bit arm system) with the final CPU of the 8 on the system not coming up
> to the same patch:
>
>   https://groups.io/g/kernelci-results/message/42480?p=%2C%2C%2C20%2C0%2C0%2C0%3A%3Acreated%2C0%2Call-cpus%2C20%2C2%2C0%2C99054444
>
> Other boards I've checked (including some with multiple CPU clusters)
> seem to be bringing up all their CPUs so it doesn't seem to just be
> general breakage.

That does not make any sense at all and my tired brain does not help
either.

Can you please apply the below debug patch and provide the output?

Thanks,

        tglx
---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 005f863a3d2b..90a9b2ae8391 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1767,13 +1767,20 @@ static void __init cpuhp_bringup_mask(const struct cpumask *mask, unsigned int n
 {
 	unsigned int cpu;
 
+	pr_info("Bringup max %u CPUs to %d\n", ncpus, target);
+
 	for_each_cpu(cpu, mask) {
 		struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
+		int ret;
+
+		pr_info("Bringup CPU%u left %u\n", cpu, ncpus);
 
 		if (!--ncpus)
 			break;
 
-		if (cpu_up(cpu, target) && can_rollback_cpu(st)) {
+		ret = cpu_up(cpu, target);
+		pr_info("Bringup CPU%u %d\n", cpu, ret);
+		if (ret && can_rollback_cpu(st)) {
 			/*
 			 * If this failed then cpu_up() might have only
 			 * rolled back to CPUHP_BP_KICK_AP for the final
