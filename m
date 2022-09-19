Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9815BCB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiISMAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiISMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:00:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C62CE10;
        Mon, 19 Sep 2022 05:00:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so6065258wrm.2;
        Mon, 19 Sep 2022 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YyuZYNDbdz2ryLjnMj9yFtb53BEy8YLyKwUzbSOHOQU=;
        b=Elyp1EsP1bpsP87QKAQ+FeXi5VwsuljIyoBvuuVUz1OFCBkIDDy4HlAxuClTc2zCVw
         HDFZc+v9SD74lGmzcNXQVkQYqn2CQlqeAxcnd0WOruBbaSdBgKPf9EwC1oaktBxFn7Dq
         haJ5h/HPT/9gtDB6WWtwj5K4ZzCwMfYzyoOFnov+2kLiGsEXd73wLUjE0LOlpBWK7ZM/
         YMbon1rZ18LRApbwwIzyV7dZaI0eeoXXGQAfNvgpYvVNkTVCZ+4ZX1C3bzFydeNM+2FN
         oNOk/Ya5+sx9XO0Ke+9v6fOf9wjk4UIqHA2reRn25dyDHbbjCjRp6UuPl7avP6e61p4f
         3ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YyuZYNDbdz2ryLjnMj9yFtb53BEy8YLyKwUzbSOHOQU=;
        b=hqSYi+7L/8ZB0yQ5gWRaSBwHhIoRjjt4Xxn5sZY9vXVCBLRQGEVrF5JYilE4v+98YY
         xJB8d3djl2hi50ROCmlTsuuzAW85825WFWV6KvmZfduBk0efu+ZEH7tKm9ve//IHk0xX
         ZXu+RYaDSAUsCvlAZFgO2cm1BtPgcRIwuimfaYZLH1Tn8Ir4g42O90chCYw4V78QFZ29
         XsVmeOU0Nl3uH5ibpn06rWFZu932dv6Bl6PGx/nQMIH9CDLrgZ5NN8XO3uiQJBfRFN9j
         ggCC2VZZXYoq4oF7xGxivXdkc4u6wb5LrqK5wMzCH54pfqUNjW4XLMBgW1mY7DCZ5Phx
         eFMQ==
X-Gm-Message-State: ACrzQf3lqKR9HKg6AcyenhPQZF+3OpT+NpfqIiQIcqHhg1mj2ZVyGJNM
        2nRU2jJkaViJgdY9KgtuLtM4Hm9aay4MeA==
X-Google-Smtp-Source: AMsMyM71LMr5fNJEoFkFRL5dM5AXid8iTkt1RCduV2fmLzymQ0IVeU0vn79PQ8N2PYhfV+9SsIdLlA==
X-Received: by 2002:a05:6000:1f83:b0:228:6278:796b with SMTP id bw3-20020a0560001f8300b002286278796bmr10045832wrb.520.1663588814912;
        Mon, 19 Sep 2022 05:00:14 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c231a00b003b47a99d928sm13511604wmo.18.2022.09.19.05.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:00:14 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: r9a07g043: Hide WDT2 clock and reset entries for RZ/Five
Date:   Mon, 19 Sep 2022 12:58:39 +0100
Message-Id: <20220919115839.151442-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Make the clock and reset entries for WDT2 only visible for RZ/G2UL (ARM64)
as the RZ/Five SoC doesn't have the WDT2 channel.

While at it, add the WDT2 clocks to r9a07g043_crit_mod_clks[] list as WDT
CH2 is specifically to check the operation of Cortex-M33 CPU on the RZ/G2UL
SoC and we dont want to turn off the clocks of WDT2 if it isn't enabled by
Cortex-A55.

Fixes: 95d48d270305 ("clk: renesas: r9a07g043: Add support for RZ/Five SoC")
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 37475465100d..06692274025d 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -158,10 +158,12 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x548, 0),
 	DEF_MOD("wdt0_clk",	R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
 				0x548, 1),
+#ifdef CONFIG_ARM64
 	DEF_MOD("wdt2_pclk",	R9A07G043_WDT2_PCLK, R9A07G043_CLK_P0,
 				0x548, 4),
 	DEF_MOD("wdt2_clk",	R9A07G043_WDT2_CLK, R9A07G043_OSCCLK,
 				0x548, 5),
+#endif
 	DEF_MOD("spi_clk2",	R9A07G043_SPI_CLK2, R9A07G043_CLK_SPI1,
 				0x550, 0),
 	DEF_MOD("spi_clk",	R9A07G043_SPI_CLK, R9A07G043_CLK_SPI0,
@@ -269,7 +271,9 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_OSTM1_PRESETZ, 0x834, 1),
 	DEF_RST(R9A07G043_OSTM2_PRESETZ, 0x834, 2),
 	DEF_RST(R9A07G043_WDT0_PRESETN, 0x848, 0),
+#ifdef CONFIG_ARM64
 	DEF_RST(R9A07G043_WDT2_PRESETN, 0x848, 2),
+#endif
 	DEF_RST(R9A07G043_SPI_RST, 0x850, 0),
 	DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),
@@ -311,6 +315,8 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 #ifdef CONFIG_ARM64
 	MOD_CLK_BASE + R9A07G043_GIC600_GICCLK,
 	MOD_CLK_BASE + R9A07G043_IA55_CLK,
+	MOD_CLK_BASE + R9A07G043_WDT2_PCLK,
+	MOD_CLK_BASE + R9A07G043_WDT2_CLK,
 #endif
 #ifdef CONFIG_RISCV
 	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
-- 
2.25.1

