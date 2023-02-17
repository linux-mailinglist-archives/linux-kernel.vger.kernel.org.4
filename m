Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1096B69B2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQSx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBQSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:53:08 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1948B5A39A;
        Fri, 17 Feb 2023 10:53:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w13so1860757wrl.13;
        Fri, 17 Feb 2023 10:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuYdi9JDEfUk3bSVOxhib3+XS2kP3hKiS/trU9amA0Y=;
        b=jBbUGhXuPutU68xy8v1/tTsH0FNkiWcyXEw0HRthPl4z3nkGFqNw+kj5VJ7Wh9Q584
         CIu6EA9SF2weK+TuPLhmITSGD3rWzVwFmy7XYY3YGKls9yoDKsBPPLv/VFcFViTGQ/ig
         KCFgVY4rEeesYCejYw+zVbjhqijsiAohmzZeKk+1VKP9eXTPzaYvsHGH8y8XVbVikxrj
         GLED2JiK1fhLGqY2ujnZyPnMkH+kzM7Bnt6RuCmxKBM/Mg9s3l3yqKcFB9Hga2l5ICR1
         P+T8w0OicRCBtXvTBGvWuGpzL0W7dpN5artCkgvfoQD2s11ogxjcxPnazs4at/hr60V9
         dCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuYdi9JDEfUk3bSVOxhib3+XS2kP3hKiS/trU9amA0Y=;
        b=URe9rRqqQHXeFLTZu1CNo38fL9RUdlZKdyK7cQjN7PIHKIEJkcPETSwORWxXVxQBc2
         b9YLWCtTzvWadI00lzF1bxr68UBAOm+O8x2Zbwh8kWlxS7uQi41n4GBwMHUxakom5Hup
         lxpj1APWoohaSYDmZ/GVhmC1J9IuBR1/4WYCCgq36yBjO0ee9/zHcexOxiTxT40vzCMw
         lWBbnfBPn6MXyu/h7qMLUm5pukKHnngAPWpdLrjFbmsrLvslnoCfJdv5pBmEqDSTh1jA
         La2AHdyi6AldUjcX4YX4kzw+sStWEzUxj8PI/JkoVYqMR0IHGvg5ZKiUGKAUIDkIpxUV
         TjwQ==
X-Gm-Message-State: AO0yUKWwYJV+TJ9HsqrZG1gQ7cRGz3yTJK9qyFTLnBL198wZ/aIICFSV
        qzZeoM42MVTpKB31MsbUY+bYmNflyqL/CQ==
X-Google-Smtp-Source: AK7set8PNytjo88R/CSuQUpQ6yNfiv2mI4cAeSeVkEQxv9w+c+gUg8tywgNqdnVB1ce+k+fDvDn5Tg==
X-Received: by 2002:adf:f646:0:b0:2c6:e87f:f19 with SMTP id x6-20020adff646000000b002c6e87f0f19mr2032734wrp.57.1676659980387;
        Fri, 17 Feb 2023 10:53:00 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8bd:e692:c27f:c09d])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003db0ad636d1sm2964514wms.28.2023.02.17.10.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:52:59 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/4] arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels
Date:   Fri, 17 Feb 2023 18:52:25 +0000
Message-Id: <20230217185225.43310-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From R01UH0968EJ0100 Rev.1.00 HW manual the interrupt numbers for SSI
channels have been updated,

SPI 329 - SSIF0 is now marked as reserved
SPI 333 - SSIF1 is now marked as reserved
SPI 335 - SSIF2 is now marked as reserved
SPI 336 - SSIF2 is now marked as reserved
SPI 341 - SSIF3 is now marked as reserved

This patch drops the above IRQs from SoC DTSI.

Fixes: 559f2b0708c70 ("arm64: dts: renesas: r9a07g043: Add SSI{1,2,3} nodes and fillup the SSI0 stub node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index c8a83e42c4f3..a9700654b421 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -80,9 +80,8 @@ ssi0: ssi@10049c00 {
 			reg = <0 0x10049c00 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(326) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(327) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(328) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(329) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <SOC_PERIPHERAL_IRQ(328) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI0_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI0_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -101,9 +100,8 @@ ssi1: ssi@1004a000 {
 			reg = <0 0x1004a000 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(330) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(331) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(332) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(333) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <SOC_PERIPHERAL_IRQ(332) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI1_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI1_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -121,10 +119,8 @@ ssi2: ssi@1004a400 {
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a400 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(334) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(335) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(336) IRQ_TYPE_EDGE_RISING>,
 				     <SOC_PERIPHERAL_IRQ(337) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			interrupt-names = "int_req", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI2_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI2_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -143,9 +139,8 @@ ssi3: ssi@1004a800 {
 			reg = <0 0x1004a800 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(338) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(339) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(340) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(341) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <SOC_PERIPHERAL_IRQ(340) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI3_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI3_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
-- 
2.25.1

