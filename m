Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5B65A39A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiLaKtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiLaKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:48:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E602E0D9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g1so19349300edj.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4BAr3YDTtam7xHcR497eo7kHS6EX5vNVSsGQ3XZdVg=;
        b=ROLV5VC2YJKbZIZ4NSupPBjokbyz8XDtxDKZEsyZDegv7Y+nQwgg0Q77od8riAm9pN
         p43uc2oajTE0nu4DFsjAsTSe9BrclZmI8xi7O8Dl+xMukDXIX+mkHEGyIauIsItG+zUG
         LxA7cy/5n+BRZ4JdiD2454avSuVEdlMlUP+Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4BAr3YDTtam7xHcR497eo7kHS6EX5vNVSsGQ3XZdVg=;
        b=m4jBI+yygtznwkplj2dRCtTR01rjjvRq9yH6RUB1i9DVQ81pMalFVQ6yDFwUuJxqgF
         a3cqyNt6yNBb7LNc4cupEdCqew4WxPcQxBwmruw/dShOzHnp17vl3oY0EukHHHKEEgHU
         hVfcE4qGnvJhTxLo9Tfmo4OY2O52sRNPTjCB8jESV/FKg2R6rn+RWXvIfL3ziAQ9PZYJ
         TUZFvhKGfsN6el20nRWW1uFVvsPACFki2CNxEL/aVP2VZw0mWmjK5LrtXCS5T7rt/v35
         9U6dhelwjqVYHbq3jJHxF/nWUBaLvkj+zMJIOs3Cub+5qrd2nbVZ57zvPWTk5tjrs/Ap
         gtfA==
X-Gm-Message-State: AFqh2kqBpj1xVS0MfYc2WWL+ijV48ZDnHM8SFrLN9ytPIe1nRvnfNE+l
        oZdHrTupfcsZIQeLLCc8vHBywfr4Q5jZ6FwnS+Q=
X-Google-Smtp-Source: AMrXdXu1wnYLFYK3qlYdujbtgm9DCm5pkd5o4YS26KynkC7DDnX2QN12NN+FZg2mjdguJa8CIhfhog==
X-Received: by 2002:a05:6402:f05:b0:45c:834b:f28c with SMTP id i5-20020a0564020f0500b0045c834bf28cmr31101282eda.9.1672483686562;
        Sat, 31 Dec 2022 02:48:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090655c400b0083ffb81f01esm10765438ejp.136.2022.12.31.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 02:48:06 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     tommaso.merciai@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>, jagan@amarulasolutions.com,
        angelo@amarulasolutions.com, anthony@amarulasolutions.com,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH 10/11] arm64: dts: imx8mn: add dumy clock
Date:   Sat, 31 Dec 2022 11:47:35 +0100
Message-Id: <20221231104736.12635-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
References: <20221231104736.12635-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dummy clock was the only fixed rate clock not initialized from the
device tree. So let's add it to the device tree like we did for the
others fixed rate clocks.

This is a preparation patch for the upcoming support to setup all the
clocks directly from the device tree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 11 +++++++++--
 drivers/clk/imx/clk-imx8mn.c              |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index b7d91df71cc2..1949db3e08f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -217,6 +217,13 @@ clk_ext4: clock-ext4 {
 		clock-output-names = "clk_ext4";
 	};
 
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "dummy";
+	};
+
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7
@@ -614,9 +621,9 @@ clk: clock-controller@30380000 {
 				reg = <0x30380000 0x10000>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-					 <&clk_ext3>, <&clk_ext4>;
+					 <&clk_ext3>, <&clk_ext4>, <&clk_dummy>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
-					      "clk_ext3", "clk_ext4";
+					      "clk_ext3", "clk_ext4", "dummy";
 				assigned-clocks = <&clk IMX8MN_CLK_A53_SRC>,
 						<&clk IMX8MN_CLK_A53_CORE>,
 						<&clk IMX8MN_CLK_NOC>,
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index af256ade554f..e1f059dc5afa 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -331,7 +331,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	clk_hw_data->num = IMX8MN_CLK_END;
 	hws = clk_hw_data->hws;
 
-	hws[IMX8MN_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
+	hws[IMX8MN_CLK_DUMMY] = imx_get_clk_hw_by_name(np, "dummy");
 	hws[IMX8MN_CLK_24M] = imx_get_clk_hw_by_name(np, "osc_24m");
 	hws[IMX8MN_CLK_32K] = imx_get_clk_hw_by_name(np, "osc_32k");
 	hws[IMX8MN_CLK_EXT1] = imx_get_clk_hw_by_name(np, "clk_ext1");
-- 
2.32.0

