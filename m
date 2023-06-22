Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DED73A2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjFVOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjFVOOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:14:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305D1FED;
        Thu, 22 Jun 2023 07:13:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666eef03ebdso3242634b3a.1;
        Thu, 22 Jun 2023 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687443236; x=1690035236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZIzshyEXvO+GMr2MxUbz2W/g/qd87fRl8ljhcscWKk=;
        b=TRYsQWHby4zYuQr124gQ98AaJGzMIdSoi6qDkUhzHtwtstnHkYqno37q79yEBUxN2C
         4tTJR/WX+egbkny3j/QE9SpQq0GKcI5O8oZ0vtO4cyETWsjvXSeEE9ftPronuaCDoxKT
         xpR3Hn9oRq/qMuuBOwVFI/KDza9LtbdUgugHQnYnsaMh7b1NxTr1phJN060UzCwJHIkj
         zf3IV0+UQF3nex1yxNCPApw8NGtX/rfPXrrLDlla6qBvq+gQxhStvNNBn67DwMK0PCzs
         +W5tAB/chkGN7OwhnnQ5xHDQQ4ON9UnsvBgRdYGvtCAmqZFPTpQRiHwd1vBwnKiCHWFW
         YW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687443236; x=1690035236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZIzshyEXvO+GMr2MxUbz2W/g/qd87fRl8ljhcscWKk=;
        b=eE1tnWIVz2vIlluf01X/hHsWsGWYa+iVJ1A9LB4DqoSLZQBbvvKoRoLrr5mGPclGRS
         PKAuDUut69lq8qGrgxYgQ9b2Bo+bJOhZDP1tXs0YZ62NknLHe8wH8DauwhuQHP4cCi2D
         3r4VL+OS2JKOfU70OZHc2V5BmrfmLf2tQoLv1tPFzdzcdQ0bq1bZYkHKQ2kc6+S1Wq3T
         /v6XWlvTa7WrlBNt/C1B8Hy4G9s6ewXYmWU1xmzJ/WPjKdJzNPY1f8nx14FrErQ8T5fU
         b4whCy78rKi13IcIaVc3+0gEwInT7PAu3qC0zdNcr3Lx9wnUMmKpc0MrCSVrWdYV7K3A
         iTeA==
X-Gm-Message-State: AC+VfDwiP47l+nAf9EVLDvCCk3I9HtX1cXFBlNvoPp/ilnbkH9kOCGls
        T+gS50Bf0wmp6bj37wmYQuY=
X-Google-Smtp-Source: ACHHUZ50JoZHxIG2jJV56QASNGxSs75mNnBcI2+doxpz2bbf560w3L/K7bsW8mzupmpYvyiKd4Tnnw==
X-Received: by 2002:a05:6a00:1486:b0:66a:3818:8aa3 with SMTP id v6-20020a056a00148600b0066a38188aa3mr6308934pfu.0.1687443235960;
        Thu, 22 Jun 2023 07:13:55 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i20-20020aa79094000000b0065a1b05193asm4604268pfa.185.2023.06.22.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:13:55 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3 3/3] clk: nuvoton: Use clk_parent_data instead of string for parent clock
Date:   Thu, 22 Jun 2023 14:13:43 +0000
Message-Id: <20230622141343.13595-4-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622141343.13595-1-ychuang570808@gmail.com>
References: <20230622141343.13595-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

For the declaration of parent clocks, use struct clk_parent_data instead
of a string. Due to the change in the passed arguments, replace the usage
of devm_clk_hw_register_mux() with clk_hw_register_mux_parent_data() for
all cases.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 306 ++++++++++++++++++++++---------
 1 file changed, 219 insertions(+), 87 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 733750dda0f4..f1fe7edd21b5 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -63,167 +63,298 @@ static DEFINE_SPINLOCK(ma35d1_lock);
 #define PLL_MODE_SS             2
 
 static const struct clk_parent_data ca35clk_sel_clks[] = {
-	{ .index = 0 },  /* HXT */
-	{ .index = 1 },  /* CAPLL */
-	{ .index = 2 }   /* DDRPLL */
+	{ .fw_name = "hxt", },
+	{ .fw_name = "capll", },
+	{ .fw_name = "ddrpll", },
 };
 
-static const char *const sysclk0_sel_clks[] = {
-	"epll_div2", "syspll"
+static const struct clk_parent_data sysclk0_sel_clks[] = {
+	{ .fw_name = "epll_div2", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const sysclk1_sel_clks[] = {
-	"hxt", "syspll"
+static const struct clk_parent_data sysclk1_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const axiclk_sel_clks[] = {
-	"capll_div2", "capll_div4"
+static const struct clk_parent_data axiclk_sel_clks[] = {
+	{ .fw_name = "capll_div2", },
+	{ .fw_name = "capll_div4", },
 };
 
-static const char *const ccap_sel_clks[] = {
-	"hxt", "vpll", "apll", "syspll"
+static const struct clk_parent_data ccap_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "vpll", },
+	{ .fw_name = "apll", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const sdh_sel_clks[] = {
-	"syspll", "apll", "dummy", "dummy"
+static const struct clk_parent_data sdh_sel_clks[] = {
+	{ .fw_name = "syspll", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const dcu_sel_clks[] = {
-	"epll_div2", "syspll"
+static const struct clk_parent_data dcu_sel_clks[] = {
+	{ .fw_name = "epll_div2", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const gfx_sel_clks[] = {
-	"epll", "syspll"
+static const struct clk_parent_data gfx_sel_clks[] = {
+	{ .fw_name = "epll", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const dbg_sel_clks[] = {
-	"hirc", "syspll"
+static const struct clk_parent_data dbg_sel_clks[] = {
+	{ .fw_name = "hirc", },
+	{ .fw_name = "syspll", },
 };
 
-static const char *const timer0_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer0_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer1_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer1_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer2_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer2_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer3_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer3_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer4_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer4_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer5_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer5_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer6_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer6_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer7_sel_clks[] = {
-	"hxt", "lxt", "pclk0", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer7_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk0", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer8_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer8_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer9_sel_clks[] = {
-	"hxt", "lxt", "pclk1", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer9_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk1", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer10_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer10_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const timer11_sel_clks[] = {
-	"hxt", "lxt", "pclk2", "dummy", "dummy", "lirc", "dummy", "hirc"
+static const struct clk_parent_data timer11_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk2", },
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "lirc", },
+	{ .index = -1, },
+	{ .fw_name = "hirc", },
 };
 
-static const char *const uart_sel_clks[] = {
-	"hxt", "sysclk1_div2", "dummy", "dummy"
+static const struct clk_parent_data uart_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "sysclk1_div2", },
 };
 
-static const char *const wdt0_sel_clks[] = {
-	"dummy", "lxt", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wdt0_sel_clks[] = {
+	{ .index = -1, },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wdt1_sel_clks[] = {
-	"dummy", "lxt", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wdt1_sel_clks[] = {
+	{ .index = -1, },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wdt2_sel_clks[] = {
-	"dummy", "lxt", "pclk4_div4096", "lirc"
+static const struct clk_parent_data wdt2_sel_clks[] = {
+	{ .index = -1, },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "pclk4_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wwdt0_sel_clks[] = {
-	"dummy", "dummy", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wwdt0_sel_clks[] = {
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wwdt1_sel_clks[] = {
-	"dummy", "dummy", "pclk3_div4096", "lirc"
+static const struct clk_parent_data wwdt1_sel_clks[] = {
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "pclk3_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const wwdt2_sel_clks[] = {
-	"dummy", "dummy", "pclk4_div4096", "lirc"
+static const struct clk_parent_data wwdt2_sel_clks[] = {
+	{ .index = -1, },
+	{ .index = -1, },
+	{ .fw_name = "pclk4_div4096", },
+	{ .fw_name = "lirc", },
 };
 
-static const char *const spi0_sel_clks[] = {
-	"pclk1", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi0_sel_clks[] = {
+	{ .fw_name = "pclk1", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const spi1_sel_clks[] = {
-	"pclk2", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi1_sel_clks[] = {
+	{ .fw_name = "pclk2", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const spi2_sel_clks[] = {
-	"pclk1", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi2_sel_clks[] = {
+	{ .fw_name = "pclk1", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const spi3_sel_clks[] = {
-	"pclk2", "apll", "dummy", "dummy"
+static const struct clk_parent_data spi3_sel_clks[] = {
+	{ .fw_name = "pclk2", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const qspi0_sel_clks[] = {
-	"pclk0", "apll", "dummy", "dummy"
+static const struct clk_parent_data qspi0_sel_clks[] = {
+	{ .fw_name = "pclk0", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const qspi1_sel_clks[] = {
-	"pclk0", "apll", "dummy", "dummy"
+static const struct clk_parent_data qspi1_sel_clks[] = {
+	{ .fw_name = "pclk0", },
+	{ .fw_name = "apll", },
 };
 
-static const char *const i2s0_sel_clks[] = {
-	"apll", "sysclk1_div2", "dummy", "dummy"
+static const struct clk_parent_data i2s0_sel_clks[] = {
+	{ .fw_name = "apll", },
+	{ .fw_name = "sysclk1_div2", },
 };
 
-static const char *const i2s1_sel_clks[] = {
-	"apll", "sysclk1_div2", "dummy", "dummy"
+static const struct clk_parent_data i2s1_sel_clks[] = {
+	{ .fw_name = "apll", },
+	{ .fw_name = "sysclk1_div2", },
 };
 
-static const char *const can_sel_clks[] = {
-	"apll", "vpll"
+static const struct clk_parent_data can_sel_clks[] = {
+	{ .fw_name = "apll", },
+	{ .fw_name = "vpll", },
 };
 
-static const char *const cko_sel_clks[] = {
-	"hxt", "lxt", "hirc", "lirc", "capll_div4", "syspll",
-	"ddrpll", "epll_div2", "apll", "vpll", "dummy", "dummy",
-	"dummy", "dummy", "dummy", "dummy"
+static const struct clk_parent_data cko_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
+	{ .fw_name = "hirc", },
+	{ .fw_name = "lirc", },
+	{ .fw_name = "capll_div4", },
+	{ .fw_name = "syspll", },
+	{ .fw_name = "ddrpll", },
+	{ .fw_name = "epll_div2", },
+	{ .fw_name = "apll", },
+	{ .fw_name = "vpll", },
 };
 
-static const char *const smc_sel_clks[] = {
-	"hxt", "pclk4"
+static const struct clk_parent_data smc_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "pclk4", },
 };
 
-static const char *const kpi_sel_clks[] = {
-	"hxt", "lxt"
+static const struct clk_parent_data kpi_sel_clks[] = {
+	{ .fw_name = "hxt", },
+	{ .fw_name = "lxt", },
 };
 
 static const struct clk_div_table ip_div_table[] = {
@@ -255,11 +386,12 @@ static struct clk_hw *ma35d1_clk_mux_parent(struct device *dev, const char *name
 
 static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
 				     void __iomem *reg, u8 shift, u8 width,
-				     const char *const *parents, int num_parents)
+				     const struct clk_parent_data *pdata,
+				     int num_pdata)
 {
-	return devm_clk_hw_register_mux(dev, name, parents, num_parents,
-					CLK_SET_RATE_NO_REPARENT, reg, shift,
-					width, 0, &ma35d1_lock);
+	return clk_hw_register_mux_parent_data(dev, name, pdata, num_pdata,
+					       CLK_SET_RATE_NO_REPARENT, reg, shift,
+					       width, 0, &ma35d1_lock);
 }
 
 static struct clk_hw *ma35d1_clk_divider(struct device *dev, const char *name,
-- 
2.34.1

