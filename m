Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF2666C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjALIkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbjALIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:39:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83560120A8;
        Thu, 12 Jan 2023 00:38:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id l22so13243552eja.12;
        Thu, 12 Jan 2023 00:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUWkiR+UQMgXBfpC9mIn3EeZJt9TQxJKOvR+2AKPIgE=;
        b=c0LRb3/PE7rmLtGoqfyYlZjHJVi49VpfQjHTkHXa6tZ1qbqTt0scOSe42OPcLIv58Q
         BQWOy2P7SIxQcgLruRiavql/1nl919kIZ8oQdU5OxXMgZ4J1w0G+0l54+vahZjudyYhX
         2RjK5DsWIm/oUtXH0geLJXcxTHEowuTvSdb0XRK1GGeayG25GBl2UrVlplvgIFLhBURU
         Lt++Bz/ZTlsleqxNbCXmYbwiptLCFHjzpxgqN0KqOn7PwtIqoruwivb6bwm3KkbaRkkR
         N1mkWyQnt+8U7aFSztQnLdhWtiVy0D0U6o/nJKpBx8KYTdQmnpHyiC7DVldLdMVd/+cV
         o1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUWkiR+UQMgXBfpC9mIn3EeZJt9TQxJKOvR+2AKPIgE=;
        b=MKE6HeAmEFIj0firmPd0fUHAqVu2Dc7d7QFlibv8TW5rzBQiPBXP3yqICrtre4bmaA
         a35vuNPuaN0JEsMvyDdGEOHYKbH6c67OnR3hWSi8E3ux3msaKlq6CIeSOt8A5bUMfBuG
         /a/sUtXma20A/NVyDaR5m310hYOda71yTmHKFhBcvC4m2wic8QRz8RgWipU5bENMuxcz
         Q0B6GPDISLgyM2BknsM6biwDsAOKkyOLHx2odgRmHzB3ocrrC1brRHg2uk5dzzmuoVOt
         ienc8gyoK21w9xfB+BPq4ik0B+j0ps8O/APWXb/mnMUJ4e3+nnuDhBo74Qe3n9Wec9nz
         YYUg==
X-Gm-Message-State: AFqh2kpoHTG3r8zcsZvkP9/h3xNqGN4BK7EWtp7YPiXK6Hy3s1VOooXj
        1UYH3lvc0wG2BSSmwZcVdW8=
X-Google-Smtp-Source: AMrXdXuA5C/J/5hLb8BxvXGlILNQEkhlBc5eaD2+xGbudPNazmmtiFbiWGfLyYPWE4YBBMZRgiEnog==
X-Received: by 2002:a17:907:674f:b0:864:e562:c427 with SMTP id qm15-20020a170907674f00b00864e562c427mr2049446ejc.48.1673512690036;
        Thu, 12 Jan 2023 00:38:10 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm5670410ejv.189.2023.01.12.00.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:38:09 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/4] ARM: s3c: remove obsolete s3c-cpu-freq header
Date:   Thu, 12 Jan 2023 09:37:43 +0100
Message-Id: <20230112083746.9551-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s3c-cpu-freq header was previously included by:

  ./arch/arm/mach-s3c/mach-bast.c
  ./arch/arm/mach-s3c/mach-osiris-dvs.c
  ./arch/arm/mach-s3c/mach-osiris.c
  ./include/linux/soc/samsung/s3c-cpufreq-core.h

Commit a4946a153cb9 ("ARM: s3c: remove all s3c24xx support") removes the
files in ./arch/arm/mach-s3c/; commit daf0ee583fc7 ("cpufreq: remove
s3c24xx drivers") removes the file s3c-cpufreq-core.h.

Remove this obsolete header file.

This issue was identified, as s3c-cpu-freq.h referred to the removed config
ARM_S3C_CPUFREQ.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/soc/samsung/s3c-cpu-freq.h | 145 -----------------------
 1 file changed, 145 deletions(-)
 delete mode 100644 include/linux/soc/samsung/s3c-cpu-freq.h

diff --git a/include/linux/soc/samsung/s3c-cpu-freq.h b/include/linux/soc/samsung/s3c-cpu-freq.h
deleted file mode 100644
index 63e88fd5dea2..000000000000
--- a/include/linux/soc/samsung/s3c-cpu-freq.h
+++ /dev/null
@@ -1,145 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2006-2007 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C CPU frequency scaling support - driver and board
- */
-#ifndef __LINUX_SOC_SAMSUNG_S3C_CPU_FREQ_H
-#define __LINUX_SOC_SAMSUNG_S3C_CPU_FREQ_H
-
-#include <linux/cpufreq.h>
-
-struct s3c_cpufreq_info;
-struct s3c_cpufreq_board;
-struct s3c_iotimings;
-
-/**
- * struct s3c_freq - frequency information (mainly for core drivers)
- * @fclk: The FCLK frequency in Hz.
- * @armclk: The ARMCLK frequency in Hz.
- * @hclk_tns: HCLK cycle time in 10ths of nano-seconds.
- * @hclk: The HCLK frequency in Hz.
- * @pclk: The PCLK frequency in Hz.
- *
- * This contains the frequency information about the current configuration
- * mainly for the core drivers to ensure we do not end up passing about
- * a large number of parameters.
- *
- * The @hclk_tns field is a useful cache for the parts of the drivers that
- * need to calculate IO timings and suchlike.
- */
-struct s3c_freq {
-	unsigned long	fclk;
-	unsigned long	armclk;
-	unsigned long	hclk_tns;	/* in 10ths of ns */
-	unsigned long	hclk;
-	unsigned long	pclk;
-};
-
-/**
- * struct s3c_cpufreq_freqs - s3c cpufreq notification information.
- * @freqs: The cpufreq setting information.
- * @old: The old clock settings.
- * @new: The new clock settings.
- * @pll_changing: Set if the PLL is changing.
- *
- * Wrapper 'struct cpufreq_freqs' so that any drivers receiving the
- * notification can use this information that is not provided by just
- * having the core frequency alone.
- *
- * The pll_changing flag is used to indicate if the PLL itself is
- * being set during this change. This is important as the clocks
- * will temporarily be set to the XTAL clock during this time, so
- * drivers may want to close down their output during this time.
- *
- * Note, this is not being used by any current drivers and therefore
- * may be removed in the future.
- */
-struct s3c_cpufreq_freqs {
-	struct cpufreq_freqs	freqs;
-	struct s3c_freq		old;
-	struct s3c_freq		new;
-
-	unsigned int		pll_changing:1;
-};
-
-#define to_s3c_cpufreq(_cf) container_of(_cf, struct s3c_cpufreq_freqs, freqs)
-
-/**
- * struct s3c_clkdivs - clock divisor information
- * @p_divisor: Divisor from FCLK to PCLK.
- * @h_divisor: Divisor from FCLK to HCLK.
- * @arm_divisor: Divisor from FCLK to ARMCLK (not all CPUs).
- * @dvs: Non-zero if using DVS mode for ARMCLK.
- *
- * Divisor settings for the core clocks.
- */
-struct s3c_clkdivs {
-	int		p_divisor;
-	int		h_divisor;
-	int		arm_divisor;
-	unsigned char	dvs;
-};
-
-#define PLLVAL(_m, _p, _s) (((_m) << 12) | ((_p) << 4) | (_s))
-
-/**
- * struct s3c_pllval - PLL value entry.
- * @freq: The frequency for this entry in Hz.
- * @pll_reg: The PLL register setting for this PLL value.
- */
-struct s3c_pllval {
-	unsigned long		freq;
-	unsigned long		pll_reg;
-};
-
-/**
- * struct s3c_cpufreq_board - per-board cpu frequency informatin
- * @refresh: The SDRAM refresh period in nanoseconds.
- * @auto_io: Set if the IO timing settings should be generated from the
- *	initialisation time hardware registers.
- * @need_io: Set if the board has external IO on any of the chipselect
- *	lines that will require the hardware timing registers to be
- *	updated on a clock change.
- * @max: The maxium frequency limits for the system. Any field that
- *	is left at zero will use the CPU's settings.
- *
- * This contains the board specific settings that affect how the CPU
- * drivers chose settings. These include the memory refresh and IO
- * timing information.
- *
- * Registration depends on the driver being used, the ARMCLK only
- * implementation does not currently need this but the older style
- * driver requires this to be available.
- */
-struct s3c_cpufreq_board {
-	unsigned int	refresh;
-	unsigned int	auto_io:1;	/* automatically init io timings. */
-	unsigned int	need_io:1;	/* set if needs io timing support. */
-
-	/* any non-zero field in here is taken as an upper limit. */
-	struct s3c_freq	max;	/* frequency limits */
-};
-
-/* Things depending on frequency scaling. */
-#ifdef CONFIG_ARM_S3C_CPUFREQ
-#define __init_or_cpufreq
-#else
-#define __init_or_cpufreq __init
-#endif
-
-/* Board functions */
-
-#ifdef CONFIG_ARM_S3C_CPUFREQ
-extern int s3c_cpufreq_setboard(struct s3c_cpufreq_board *board);
-#else
-
-static inline int s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
-{
-	return 0;
-}
-#endif  /* CONFIG_ARM_S3C_CPUFREQ */
-
-#endif
-- 
2.17.1

