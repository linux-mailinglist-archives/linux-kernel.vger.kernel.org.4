Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A11069B2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBQSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBQSxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:53:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98199B47E;
        Fri, 17 Feb 2023 10:53:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 4-20020a05600c22c400b003dc4fd6e61dso1631107wmg.5;
        Fri, 17 Feb 2023 10:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfIONDg+O2l728W8A/aybDWdqbMjXKRnoq5DkHutY6w=;
        b=YrxtQiPX9M3C+lD2QeuVTpsDV5P7zs4BnzO+hhD0Av8dAOJEIkWlWw2d7N0vZqSq5o
         aG4od0chT1ahVBLC3KBnr5w1E6vvccTyVE9/pbkECuBTcG6Q9W6CpXYn22K4fuTRPfFW
         SIrFO3ZUU9efFhBT875hujS5eEFrPQRe98imv00AS3YPiWXEvY1biHX9fpmMteIPJeJ9
         kurfJvTNIA3ZBGcQUObRGq01RWjVU1E1Wrvta8cqMQVmyiL5Lk9wFjoHfiBxDyzb9vGx
         dfyNLy2d+BW+BOkYSzVkpTbyXyvoPfQ+hF/Mj3jSLwNm6zd5i2s3oghxvMmKLd8tWz/h
         STUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfIONDg+O2l728W8A/aybDWdqbMjXKRnoq5DkHutY6w=;
        b=4ttmjsITcGe7albYR6Oxp49ioWSF6obEqaMTl367sJDaDjBvH41ePQGuQs9/OEquVl
         XMb9FaLvmDkVSHioh6mUbXGaqFqEGDuvw1o7arrMPvoBpt/MQaFjdXf5Gf6kY9cfnOx3
         Jt5wKAckpkc0AOtxtWS4dlz+WLnk/wokuBPyn48pvsCo5bQ19NyfYf0K20Itix9zZa4A
         6vv/H9hNoKr1B63D5pH0/uhE2n6i9Lf/DLFom+p5vGJdHhI3SaURI6YRXjsiNrWlycvl
         3MxArEY2H3BbgHZMe4Jazr+qgG0arCGBtmzWY6Dqr0IzTSoq3EjKBrfUty0T3QAdSLQW
         LLOA==
X-Gm-Message-State: AO0yUKW3gPzkaioeU6AADf0zqAXrYX7wPxYCceGv5BwvRX3bEC+/uicD
        V2moulEl2d30JuY3dhTJEAQ=
X-Google-Smtp-Source: AK7set++oN2hA/FfTXPb0kTH6fMsVlvXGOL4SRHfrT9+iz9dKfCI1C9tK2rzna4D4Mh66rSyISTt6A==
X-Received: by 2002:a05:600c:998:b0:3e2:20c7:6544 with SMTP id w24-20020a05600c099800b003e220c76544mr2458262wmp.19.1676659979332;
        Fri, 17 Feb 2023 10:52:59 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8bd:e692:c27f:c09d])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003db0ad636d1sm2964514wms.28.2023.02.17.10.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:52:58 -0800 (PST)
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
Subject: [PATCH 3/4] arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels
Date:   Fri, 17 Feb 2023 18:52:24 +0000
Message-Id: <20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From R01UH0914EJ0120 Rev.1.20 HW manual the interrupt numbers for SSI
channels have been updated,

SPI 329 - SSIF0 is now marked as reserved
SPI 333 - SSIF1 is now marked as reserved
SPI 335 - SSIF2 is now marked as reserved
SPI 336 - SSIF2 is now marked as reserved
SPI 341 - SSIF3 is now marked as reserved

This patch drops the above IRQs from SoC DTSI.

Fixes: 92a341315afc9 ("arm64: dts: renesas: r9a07g044: Add SSI support")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Hi Geert,

As this is is a fixes patch and we are still waiting for [0] to be merged
shall do the same for V2L SoC?

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 68bd70210d08..9945dcf38031 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -184,9 +184,8 @@ ssi0: ssi@10049c00 {
 			reg = <0 0x10049c00 0 0x400>;
 			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD SOC_PREFIX(SSI0_PCLK2)>,
 				 <&cpg CPG_MOD SOC_PREFIX(SSI0_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -205,9 +204,8 @@ ssi1: ssi@1004a000 {
 			reg = <0 0x1004a000 0 0x400>;
 			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD SOC_PREFIX(SSI1_PCLK2)>,
 				 <&cpg CPG_MOD SOC_PREFIX(SSI1_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -225,10 +223,8 @@ ssi2: ssi@1004a400 {
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a400 0 0x400>;
 			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 335 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			interrupt-names = "int_req", "dma_rt";
 			clocks = <&cpg CPG_MOD SOC_PREFIX(SSI2_PCLK2)>,
 				 <&cpg CPG_MOD SOC_PREFIX(SSI2_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -247,9 +243,8 @@ ssi3: ssi@1004a800 {
 			reg = <0 0x1004a800 0 0x400>;
 			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 339 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 341 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD SOC_PREFIX(SSI3_PCLK2)>,
 				 <&cpg CPG_MOD SOC_PREFIX(SSI3_PCLK_SFR)>,
 				 <&audio_clk1>, <&audio_clk2>;
-- 
2.25.1

