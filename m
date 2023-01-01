Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4865AAE9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAAR6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjAAR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:58:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35712DC8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:58:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk9so62233598ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsYrEdCaHlgX8drO/C/Unhu39WRz/1FMxnB9rmFaTNg=;
        b=OEtlIibZSYDv4KHy0g5ZT8e7sDptPOx0fTR/kA+cE0JzCl4xqXwofj3NX30ebTdtEy
         XKNXcGNIYorwvhatoXWPpI7o62BMeayGEfdLejTu6x4Tjhv1soh6y3qYosOGXQI2KDc8
         Hxq0Hfw9VOWHEZ4UYecLq18VH/6W/tsI0XwIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsYrEdCaHlgX8drO/C/Unhu39WRz/1FMxnB9rmFaTNg=;
        b=mB+KyGTgZkZv+HdFj2J9HQutWbbNRUwvv6h0qmJI6fI6WaOrlNv5oAprscAk/PRgCl
         Mmk7jKT8eIXC1KSuTf3oUEUH11IfWYL550eA5xPWF4zSSRQXHLO05eO5GHUYpMHt9xAZ
         fMo1wUGacH6OYjtNOsYbJtyAqTP2/LOVD0Uyp6jMD8YQtT+X0jgLHV+339LvRkMIi9Z9
         hzfXlnTd/9Bs+GYW/l6OijjBj128i59TYnRCVM+pJXimg2ndSO1bxXu+r2eW0d1ri8oz
         Pg/i+zv6vz5F2DTsTbdTRK3HMuNPsO8wJWLWNkydkJYaKlMwIddT0w6oPhjQ51jYwAFR
         rSzA==
X-Gm-Message-State: AFqh2kots1AS8WTZ0sibBAXjW3+TFj9YVSUFcrkwxcoJXVvuh6UI185W
        5ACTkxX+T+4ku09L4VaCmLovGUIun4e1ExxA56k=
X-Google-Smtp-Source: AMrXdXuu991g9oTbSJB3EhShFeufVC0HBwXhEGZH63P1DyNgk/EnqXbULOn+ZNOhYczR53kB8jdbgg==
X-Received: by 2002:a17:907:76ad:b0:7c0:f2cf:23fb with SMTP id jw13-20020a17090776ad00b007c0f2cf23fbmr35278937ejc.52.1672595881217;
        Sun, 01 Jan 2023 09:58:01 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:58:00 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
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
Subject: [RFC PATCH v2 10/11] arm64: dts: imx8mn: add dumy clock
Date:   Sun,  1 Jan 2023 18:57:39 +0100
Message-Id: <20230101175740.1010258-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

