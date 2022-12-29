Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB165929D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiL2WuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2WuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:50:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B955F42;
        Thu, 29 Dec 2022 14:50:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bx10so18505723wrb.0;
        Thu, 29 Dec 2022 14:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pHkqivt6f67irNbuQhpHiA1tWMOcGwgyjN35gn979k=;
        b=Yli7mHNFzGQhoCn7aw91t3u9/1u5SB02O1NkR7W+efSrpymfrp0zw5IHjDnlN2dYMp
         uiKSjApGAPXeupU3PEceX0aMiGVx0fxpn8o+LMW7P0ANKAPKhpAGS3yIxWIxi3wZ7SCZ
         JZ8BB/6V6Cre5SbPEDl5BX9rKf2JBipH+DkmhDku+IjvjW2Q1fC/ogDFAvbGSFPKMVaX
         JEZtrEuGbhxeJTuuFOM1BB+ggSwhH7Vj1yDCDaXxPyvIRt+hYxEjzbd9OiZouVYIGH7Z
         J//1hzHm5FznN7yksxVTTSItoUd1YHMl7GN/OKZalmshaujHERrh33pxRATlQFYPyXWY
         X6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pHkqivt6f67irNbuQhpHiA1tWMOcGwgyjN35gn979k=;
        b=OMwWW02F7iCHNwoH7qycT49XYmn3F8FranMgMt3g67N0wfGCxrtHA7YX/CDOtk4ue7
         l0k5bUED+ZyXsfHmcogrwkAkDKpuioKg1PCqCeDDMBvgLaTu+Rj1P5Lf+acbfhFrT7gU
         YZpZVan/TyCbPjNEzvfxJoPPYPBudvbGY0blJLSDhZcrbR57cDYCSaW3rUu9qyV14tbl
         jFKS9szmNsW4EX+pnCWDMidK/Glq+ltX4EmlkZAThiq3GR4Kovn/K3WNbq+Wli6dPO9M
         BAX5pjeXX1mHrDQnDfGoqEytX9wsoexZYYAGHZ9yAQlCbBwCDgMVtmjIv1pyFJwbB3P8
         cQnw==
X-Gm-Message-State: AFqh2koKvMoOmVmbscpBo/ILXWjh6Ww8Vt57A425J759cT1bY/ZxEpVm
        x2CM4Z3RUbrCtbOjB4Y2DnU=
X-Google-Smtp-Source: AMrXdXuAHURvza0jONNVDbmBntBXkmiTXZBHq9TEUxwwGlnr1ut7EMqEA3bQIVslZNW9Su6lxo5Q1g==
X-Received: by 2002:a5d:6e0c:0:b0:27d:a1ea:dcfa with SMTP id h12-20020a5d6e0c000000b0027da1eadcfamr9450830wrz.19.1672354213671;
        Thu, 29 Dec 2022 14:50:13 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:88e9:3a08:4328:85c4])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d58c2000000b0026a4bb75477sm18497702wrf.28.2022.12.29.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:50:12 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2] clocksource/drivers/riscv: Get rid of clocksource_arch_init() callback
Date:   Thu, 29 Dec 2022 22:46:01 +0000
Message-Id: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Tested-by: Samuel Holland <samuel@sholland.org>
---
RFC -> v2
* Dropped vdso_default static global variable
* Used IS_ENABLED() macro
* Included Tested-by from Samuel

RFC:
https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221211215843.24024-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 arch/riscv/Kconfig                | 1 -
 arch/riscv/kernel/time.c          | 9 ---------
 drivers/clocksource/timer-riscv.c | 5 +++++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..9c687da7756d 100644
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
index 55dad7965f43..c416e5e934bf 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -77,6 +77,11 @@ static struct clocksource riscv_clocksource = {
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
+#if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
+	.vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER,
+#else
+	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
+#endif
 };
 
 static int riscv_timer_starting_cpu(unsigned int cpu)
-- 
2.25.1

