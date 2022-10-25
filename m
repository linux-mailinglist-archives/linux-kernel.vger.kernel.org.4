Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85360C31E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJYFJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJYFIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:08:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C91D6B92
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:07:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so10256268pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bD/BtAQN/mgXdSVc+qWiP0fK8CJ8sS2VxsOkaJUfRFA=;
        b=HgVPGe1Ld4Q1aeOPbDi2caWN5qPOhod4TbdUPCLHZktN6MidoV+5BOHiM//Af2LwfH
         sUz7pkR97BiLWNp+U5pQ2/qE8G7rXT8bw51lQirPRj5pmRGEJRFN3fNPe1mSRt8rjpnG
         LG/dQXGoiBsQV26N76nofPcfAhS53hDyC+GLi7jovjuYP/p3xiXEOWm+61mejG3soare
         X/mp8XMEHuw7eIlO6Y+zRm+rfQLIsPULUoyiJruTG/JIeWkGWilCLTH8mF/2YPMQGK0g
         y31W7M5Dsf2rfiYG11b3koyf21lgbJ4hcPQbcO3gce4Mo60TOZvyBJ6OCGSU99o+rkve
         1lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD/BtAQN/mgXdSVc+qWiP0fK8CJ8sS2VxsOkaJUfRFA=;
        b=xwMmd7Bna32JLlyTOhKliqkKRL6dn/4HmrdgKFyhm0o0QdZhf2eCanX8pUJTRCLN6t
         L2WkpPNSe9kRyAa3XmoOP+geRUlcsj9Z6+M9avjvv3TX2ZM74QEMLx6Tp5/5AJE0hRM/
         XH/qYKJ1cNIaCqRZ6HyxN9UQCV/Lxa4G09+Ns13INe1zt+K/C0p8DNTVWR1OhwvM3oCV
         ItXMaNePQBxOQMhrQwyfJu3xelH8h/7QmZsaSeAK5X3kI0tO2bPIXjctIe02JrymB12w
         DOmSgfvwRkADYHvCyamo0FsqJPzxvOCTfO8HBIg/gqZCxxVEtV+okBjD+H0qajlbjqCj
         rX7g==
X-Gm-Message-State: ACrzQf1qQYre16nV6ZkM1hQMN+aNsF4375jxS7bdc5L1xHjYEA2RUQsr
        ktGtg2++oJs5x9YnQSsPZFmWSQ==
X-Google-Smtp-Source: AMsMyM7g0T0DQFAgc4+OJk6MYO+6snZ8FPKkEjXwCRmdMm98PvFtVQgCFER4z/Fj+vEJfjMT2U6asQ==
X-Received: by 2002:a17:90a:8988:b0:212:e1b9:e8fd with SMTP id v8-20020a17090a898800b00212e1b9e8fdmr18158009pjn.148.1666674467431;
        Mon, 24 Oct 2022 22:07:47 -0700 (PDT)
Received: from localhost ([122.172.87.26])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a115600b00200a85fa777sm4458505pje.1.2022.10.24.22.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:07:46 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:37:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/11] cpufreq: remove sa1100 driver
Message-ID: <20221025050744.43ttt5u2hx3q7dy5@vireshk-i7>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-6-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021155000.4108406-6-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-22, 17:49, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sa11xx platform has two cpufreq drivers, one for the older
> StrongARM1100 SoC, and a second one for StrongARM1110. After
> the removal of most SA1100 based machines, this driver is unused,
> and only the sa1110-cpufreq driver remains.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig          |   2 +-
>  drivers/cpufreq/Kconfig.arm      |   3 -
>  drivers/cpufreq/Makefile         |   1 -
>  drivers/cpufreq/sa1100-cpufreq.c | 206 -------------------------------
>  4 files changed, 1 insertion(+), 211 deletions(-)
>  delete mode 100644 drivers/cpufreq/sa1100-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2a84fc63371e..8466f78651fc 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -37,7 +37,7 @@ config CPU_FREQ_STAT
>  
>  choice
>  	prompt "Default CPUFreq governor"
> -	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> +	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1110_CPUFREQ
>  	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
>  	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
>  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 82e5de1f6f8c..8f7a1065f344 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -277,9 +277,6 @@ config ARM_S5PV210_CPUFREQ
>  
>  	  If in doubt, say N.
>  
> -config ARM_SA1100_CPUFREQ
> -	bool
> -
>  config ARM_SA1110_CPUFREQ
>  	bool
>  
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 49b98c62c5af..8de99b213146 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -78,7 +78,6 @@ obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
>  obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
>  obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
>  obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
> -obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
>  obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
>  obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
>  obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
> diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
> deleted file mode 100644
> index 252b9fc26124..000000000000
> --- a/drivers/cpufreq/sa1100-cpufreq.c
> +++ /dev/null
> @@ -1,206 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * cpu-sa1100.c: clock scaling for the SA1100
> - *
> - * Copyright (C) 2000 2001, The Delft University of Technology
> - *
> - * Authors:
> - * - Johan Pouwelse (J.A.Pouwelse@its.tudelft.nl): initial version
> - * - Erik Mouw (J.A.K.Mouw@its.tudelft.nl):
> - *   - major rewrite for linux-2.3.99
> - *   - rewritten for the more generic power management scheme in
> - *     linux-2.4.5-rmk1
> - *
> - * This software has been developed while working on the LART
> - * computing board (http://www.lartmaker.nl/), which is
> - * sponsored by the Mobile Multi-media Communications
> - * (http://www.mobimedia.org/) and Ubiquitous Communications
> - * (http://www.ubicom.tudelft.nl/) projects.
> - *
> - * The authors can be reached at:
> - *
> - *  Erik Mouw
> - *  Information and Communication Theory Group
> - *  Faculty of Information Technology and Systems
> - *  Delft University of Technology
> - *  P.O. Box 5031
> - *  2600 GA Delft
> - *  The Netherlands
> - *
> - * Theory of operations
> - * ====================
> - *
> - * Clock scaling can be used to lower the power consumption of the CPU
> - * core. This will give you a somewhat longer running time.
> - *
> - * The SA-1100 has a single register to change the core clock speed:
> - *
> - *   PPCR      0x90020014    PLL config
> - *
> - * However, the DRAM timings are closely related to the core clock
> - * speed, so we need to change these, too. The used registers are:
> - *
> - *   MDCNFG    0xA0000000    DRAM config
> - *   MDCAS0    0xA0000004    Access waveform
> - *   MDCAS1    0xA0000008    Access waveform
> - *   MDCAS2    0xA000000C    Access waveform
> - *
> - * Care must be taken to change the DRAM parameters the correct way,
> - * because otherwise the DRAM becomes unusable and the kernel will
> - * crash.
> - *
> - * The simple solution to avoid a kernel crash is to put the actual
> - * clock change in ROM and jump to that code from the kernel. The main
> - * disadvantage is that the ROM has to be modified, which is not
> - * possible on all SA-1100 platforms. Another disadvantage is that
> - * jumping to ROM makes clock switching unnecessary complicated.
> - *
> - * The idea behind this driver is that the memory configuration can be
> - * changed while running from DRAM (even with interrupts turned on!)
> - * as long as all re-configuration steps yield a valid DRAM
> - * configuration. The advantages are clear: it will run on all SA-1100
> - * platforms, and the code is very simple.
> - *
> - * If you really want to understand what is going on in
> - * sa1100_update_dram_timings(), you'll have to read sections 8.2,
> - * 9.5.7.3, and 10.2 from the "Intel StrongARM SA-1100 Microprocessor
> - * Developers Manual" (available for free from Intel).
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/init.h>
> -#include <linux/cpufreq.h>
> -#include <linux/io.h>
> -
> -#include <asm/cputype.h>
> -
> -#include <mach/generic.h>
> -#include <mach/hardware.h>
> -
> -struct sa1100_dram_regs {
> -	int speed;
> -	u32 mdcnfg;
> -	u32 mdcas0;
> -	u32 mdcas1;
> -	u32 mdcas2;
> -};
> -
> -
> -static struct cpufreq_driver sa1100_driver;
> -
> -static struct sa1100_dram_regs sa1100_dram_settings[] = {
> -	/*speed,     mdcnfg,     mdcas0,     mdcas1,     mdcas2,   clock freq */
> -	{ 59000, 0x00dc88a3, 0xcccccccf, 0xfffffffc, 0xffffffff},/*  59.0 MHz */
> -	{ 73700, 0x011490a3, 0xcccccccf, 0xfffffffc, 0xffffffff},/*  73.7 MHz */
> -	{ 88500, 0x014e90a3, 0xcccccccf, 0xfffffffc, 0xffffffff},/*  88.5 MHz */
> -	{103200, 0x01889923, 0xcccccccf, 0xfffffffc, 0xffffffff},/* 103.2 MHz */
> -	{118000, 0x01c29923, 0x9999998f, 0xfffffff9, 0xffffffff},/* 118.0 MHz */
> -	{132700, 0x01fb2123, 0x9999998f, 0xfffffff9, 0xffffffff},/* 132.7 MHz */
> -	{147500, 0x02352123, 0x3333330f, 0xfffffff3, 0xffffffff},/* 147.5 MHz */
> -	{162200, 0x026b29a3, 0x38e38e1f, 0xfff8e38e, 0xffffffff},/* 162.2 MHz */
> -	{176900, 0x02a329a3, 0x71c71c1f, 0xfff1c71c, 0xffffffff},/* 176.9 MHz */
> -	{191700, 0x02dd31a3, 0xe38e383f, 0xffe38e38, 0xffffffff},/* 191.7 MHz */
> -	{206400, 0x03153223, 0xc71c703f, 0xffc71c71, 0xffffffff},/* 206.4 MHz */
> -	{221200, 0x034fba23, 0xc71c703f, 0xffc71c71, 0xffffffff},/* 221.2 MHz */
> -	{235900, 0x03853a23, 0xe1e1e07f, 0xe1e1e1e1, 0xffffffe1},/* 235.9 MHz */
> -	{250700, 0x03bf3aa3, 0xc3c3c07f, 0xc3c3c3c3, 0xffffffc3},/* 250.7 MHz */
> -	{265400, 0x03f7c2a3, 0xc3c3c07f, 0xc3c3c3c3, 0xffffffc3},/* 265.4 MHz */
> -	{280200, 0x0431c2a3, 0x878780ff, 0x87878787, 0xffffff87},/* 280.2 MHz */
> -	{ 0, 0, 0, 0, 0 } /* last entry */
> -};
> -
> -static void sa1100_update_dram_timings(int current_speed, int new_speed)
> -{
> -	struct sa1100_dram_regs *settings = sa1100_dram_settings;
> -
> -	/* find speed */
> -	while (settings->speed != 0) {
> -		if (new_speed == settings->speed)
> -			break;
> -
> -		settings++;
> -	}
> -
> -	if (settings->speed == 0) {
> -		panic("%s: couldn't find dram setting for speed %d\n",
> -		      __func__, new_speed);
> -	}
> -
> -	/* No risk, no fun: run with interrupts on! */
> -	if (new_speed > current_speed) {
> -		/* We're going FASTER, so first relax the memory
> -		 * timings before changing the core frequency
> -		 */
> -
> -		/* Half the memory access clock */
> -		MDCNFG |= MDCNFG_CDB2;
> -
> -		/* The order of these statements IS important, keep 8
> -		 * pulses!!
> -		 */
> -		MDCAS2 = settings->mdcas2;
> -		MDCAS1 = settings->mdcas1;
> -		MDCAS0 = settings->mdcas0;
> -		MDCNFG = settings->mdcnfg;
> -	} else {
> -		/* We're going SLOWER: first decrease the core
> -		 * frequency and then tighten the memory settings.
> -		 */
> -
> -		/* Half the memory access clock */
> -		MDCNFG |= MDCNFG_CDB2;
> -
> -		/* The order of these statements IS important, keep 8
> -		 * pulses!!
> -		 */
> -		MDCAS0 = settings->mdcas0;
> -		MDCAS1 = settings->mdcas1;
> -		MDCAS2 = settings->mdcas2;
> -		MDCNFG = settings->mdcnfg;
> -	}
> -}
> -
> -static int sa1100_target(struct cpufreq_policy *policy, unsigned int ppcr)
> -{
> -	unsigned int cur = sa11x0_getspeed(0);
> -	unsigned int new_freq;
> -
> -	new_freq = sa11x0_freq_table[ppcr].frequency;
> -
> -	if (new_freq > cur)
> -		sa1100_update_dram_timings(cur, new_freq);
> -
> -	PPCR = ppcr;
> -
> -	if (new_freq < cur)
> -		sa1100_update_dram_timings(cur, new_freq);
> -
> -	return 0;
> -}
> -
> -static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
> -{
> -	cpufreq_generic_init(policy, sa11x0_freq_table, 0);
> -	return 0;
> -}
> -
> -static struct cpufreq_driver sa1100_driver __refdata = {
> -	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -			  CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
> -	.verify		= cpufreq_generic_frequency_table_verify,
> -	.target_index	= sa1100_target,
> -	.get		= sa11x0_getspeed,
> -	.init		= sa1100_cpu_init,
> -	.name		= "sa1100",
> -};
> -
> -static int __init sa1100_dram_init(void)
> -{
> -	if (cpu_is_sa1100())
> -		return cpufreq_register_driver(&sa1100_driver);
> -	else
> -		return -ENODEV;
> -}
> -
> -arch_initcall(sa1100_dram_init);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
