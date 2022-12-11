Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31412649695
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 22:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLKV7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 16:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKV7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 16:59:08 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD805626B;
        Sun, 11 Dec 2022 13:59:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y16so10283202wrm.2;
        Sun, 11 Dec 2022 13:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKRcNZrnRBXI6gdczXEvStlv0bgBFdRbawYdiqFnDic=;
        b=qMCp2f/b7bmqXALk27j2TWuJHAWZDNTd+W7BajyQM5RMTc3Nod1YejLJftHGO70kSc
         gyaAJrfaIuE8pO5m69fHWqN9Hi3yRLGpRS7HO4vdYBaFvxYMtJTKhkOb4X/hWc0cVEPS
         SrDi1v+2Rt9bjSRQehEdHL9vCsTs9NLN3iNNTmLf4Ir/DpDKThQ4JaVXo1ixRmrDG6Jo
         dgmrLfA2URXcuPaeDwPZy68GlowofdhFCipzFb+Xs6J9ltMCo5O8ocRuP9s176mvc5Ic
         j/hvMfbHSW0ylZniUJqSgaVEX3a6aCFBv5Daw3KQzqqqk+YNQBBiSB/vcKazRz3LIX4L
         X3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKRcNZrnRBXI6gdczXEvStlv0bgBFdRbawYdiqFnDic=;
        b=OrM+oFTPjJEqilaRZEKQZP5H0kQqRxWAK4JKoFY9oJgNEyNU2IM+bBHaHJLnkgwmXd
         MXRulH8agbgBFMHVh+uoyv2eFLiSt0KbcfVzGe3ABsJxKz+/sZmD4B9EfJhgvB0YMwSu
         yPxBK7KwIx3v1clrwlrCotv7hgivbQNYHt6eb7GOaAVBW1ibLqSFe4ibahax0g2gtxdn
         K5besOIc1FJHe5rsJWFD88oDVRiCvT3En501e1H9XljSCO7e+uDoPjZNOwRRqS1xWVFg
         OSZNfD2L4FBkDdos5F3ILTr93L4nZO+yTv8N9LOGu0OKDh1vX3ns0xciO1T/voZ5hroe
         Ww9g==
X-Gm-Message-State: ANoB5plwhe8l8jkYOniMkMXmci1sN+9iARDEA/0GAZWT4l8VzpGFKIJG
        EKikonOKql6z+Pd6mGB3HGI=
X-Google-Smtp-Source: AA0mqf5aS27OreQX1/iLkZTDb0d9OUSWQWpl6lUa72cwg1AhquW/4YxnLPlQPX74aChmY86k4otqtQ==
X-Received: by 2002:adf:f645:0:b0:242:1e1f:2d89 with SMTP id x5-20020adff645000000b002421e1f2d89mr8382959wrp.60.1670795945335;
        Sun, 11 Dec 2022 13:59:05 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1484:ef11:b25c:4612])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b0022cc3e67fc5sm7042542wrs.65.2022.12.11.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 13:59:04 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH] clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback
Date:   Sun, 11 Dec 2022 21:58:43 +0000
Message-Id: <20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Having a clocksource_arch_init() callback always sets vdso_clock_mode to
VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
required for the riscv-timer.

This works for platforms where just riscv-timer clocksource is present.
On platforms where other clock sources are available we want them to
register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.

On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
move setting of vdso_clock_mode in the riscv-timer driver instead of doing
this in clocksource_arch_init() callback as done similarly for ARM/64
architecture.

[0] drivers/clocksource/renesas-ostm.c

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/Kconfig                | 1 -
 arch/riscv/kernel/time.c          | 9 ---------
 drivers/clocksource/timer-riscv.c | 7 +++++++
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7ea12de636bd..b269e062c1b1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,7 +12,6 @@ config 32BIT
 
 config RISCV
 	def_bool y
-	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_BINFMT_FLAT
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 8217b0f67c6c..42bee305e997 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -30,12 +30,3 @@ void __init time_init(void)
 	of_clk_init(NULL);
 	timer_probe();
 }
-
-void clocksource_arch_init(struct clocksource *cs)
-{
-#ifdef CONFIG_GENERIC_GETTIMEOFDAY
-	cs->vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER;
-#else
-	cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
-#endif
-}
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 969a552da8d2..7ec9668cd36d 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -29,6 +29,12 @@
 
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
 
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
+#else
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
+
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
 {
@@ -158,6 +164,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return -ENODEV;
 	}
 
+	riscv_clocksource.vdso_clock_mode = vdso_default;
 	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
 	       __func__, cpuid, hartid);
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
-- 
2.25.1

