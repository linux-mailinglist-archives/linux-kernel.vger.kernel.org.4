Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD14673F95
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjASRJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjASRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:09:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79352872BA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:09:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z5so2519627wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlUPFT5LnAx9YsUAxMPVVxhEMNKGvpW7llEko3PxJJc=;
        b=yhzy7rhZNGRyyFFztwDyv6b+ynsjiqP7Yo3+hZMwQDKqWScxMNvHS9Jtrgg9vOG5Pg
         drnkfX+KeQ1d8Bu+of5dAru12C5P8a6RE7LpUfEC5E06GPKFKYBftxzDxU48byKgWJIx
         zVeBpSVWr/8VeF9O9sRPe8EXOndY5R0rEILIYnqnxBmDt8uqMcE3k+rAZaovz7nj2Elx
         3tX0pKxIl5FqU75PBtGRbcsDLUhHFpuRnQb4JB/0/kWB4adpDBHtIvAaNsPWOyepahI9
         PjSTUPzhBD8ahLymqqY4i3NVhAQwl26hPFWwSoNY7CPEcc7ItYVQo6b/ULDsmDTH7tiy
         IsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlUPFT5LnAx9YsUAxMPVVxhEMNKGvpW7llEko3PxJJc=;
        b=6U5aP3zrXD5lZ8QqMWG8YIAIkWe9Izeft/9U1VovXxHZp6AVzjuZUIctuPISlv6UnZ
         cVCYr0xcW0sbSmoOsNjaMx76UrbpjkteYDfGrO6KuzjQBrenOVG30842VY03cOe7UkkV
         E1AIIFTm8j2ltEdUooc5CLtvus0EMNwgxWD8xYl4l+K74JwgZT9KW5u+Syjb/4wSv3wC
         O+CZaP9cVzD4asb3lcVS3rc1eAaKUfniwn9J61gzDAcrm6GRXagScR2xRcwSiA+vSoSq
         MZVIrYgVQ0q0mVuDwwDZWF5Rbz07iNCy4scrvgtBHNehsVkAERcDsLk4r9DAjCILHGy1
         Gidw==
X-Gm-Message-State: AFqh2kpswXwhwgm1k9ovq57AvCUqVSVEhNZRab42x+DpiymtBKMj9eyz
        HkyVnFqOAIBDiSYxsqnExQfvcg==
X-Google-Smtp-Source: AMrXdXvHQSKEQ/RdT4gpmXWZ3OAen7L9xGEUoiYMPNpCEiEUmm1oaSDe9qel5bZaULsKuhg8fBJAgQ==
X-Received: by 2002:adf:a3d9:0:b0:2bd:deaf:6a88 with SMTP id m25-20020adfa3d9000000b002bddeaf6a88mr9992146wrb.17.1674148154050;
        Thu, 19 Jan 2023 09:09:14 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id bu9-20020a056000078900b002be1dcb6efbsm8738701wrb.9.2023.01.19.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:09:13 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 19 Jan 2023 18:08:53 +0100
Subject: [PATCH v2 2/3] arm64: dts: mediatek: add i2c support for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221122-mt8365-i2c-support-v2-2-e4c7c514e781@baylibre.com>
References: <20221122-mt8365-i2c-support-v2-0-e4c7c514e781@baylibre.com>
In-Reply-To: <20221122-mt8365-i2c-support-v2-0-e4c7c514e781@baylibre.com>
To:     Qii Wang <qii.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-i2c@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3qzpqDF5qfsZV4KFvmmkuAuRkJdkE+nj1hKT6VsiEUg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjyXk2DWa0vY1hFgtNfd4QTVahKvP0ZkrY5dVux337
 SpiXGkOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY8l5NgAKCRArRkmdfjHURdyLD/
 0STpm6+z3UnD9cuzRfXOhPP7k4MXyxU7tyhUjhe7GaHnlEHZbXPMJ+L0M05jPyPCla0vFPcMDJJyrM
 9Zg1Mkl3SnkvD2sWiVJg6uvZsqIGnPpBeo33iKV3EmpjMxw6Shw1NPNb61FpEQX0fdriFOnoBvTgC1
 vybtbcFuEFu2QgKKRlhMo2TKUqBb5WlaPBqZD0LpAv0IQM+BR05th9TDcjpREv8WXkgu5s75T/sn8a
 /hq780PeuNb4AC9ququQ7mixh73ajBrCSuCoWBORqsYOkvegWqklX5G/tAd7r43F+6t2inGtnEVVgD
 5Jd3BB9r+Mma7U2VmM7bBCFPMDnem6Q1vg/KBogizDT5EQelJTEsF1QmMxj+yoLjVhTSvNaofvYba1
 GmKKacDExAHvwAMiOkebr26DzK30nEkmsxitcA5mo1QF9RRgAHyuQV0buR2IxZSM/7G2Se3LljeLXu
 EJiYLwjTGrxSWWqkYa024eK0IO0KS//GwNgrm3ckgyiCFnx4848OuqzUF6F8jYBYgmZ5F2o0RBIU7q
 VZ3oTKfPMUgfLatolft/J5pvr9bnz4bK0dr2V4QcQGLjy+5J2VvpPEQj+0haNMoM20gG0G2vebEWE8
 uJ7f2udZP3tXCg8UuXwxInHrgexGGnbYvXgJyMo2g3KHprRrOP5iVKt8TieA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four I2C master channels in MT8365 with a same HW architecture.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index a32f2b7507be..013beb50b4aa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -282,6 +282,58 @@ pwm: pwm@11006000 {
 			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
 		};
 
+		i2c0: i2c@11007000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x11007000 0 0xa0>, <0 0x11000080 0 0x80>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C0_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@11008000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x11008000 0 0xa0>, <0 0x11000100 0 0x80>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C1_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@11009000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x11009000 0 0xa0>, <0 0x11000180 0 0x80>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C2_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@1100f000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x1100f000 0 0xa0>, <0 0x11000200 0 0x80>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C3_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi: spi@1100a000 {
 			compatible = "mediatek,mt8365-spi", "mediatek,mt7622-spi";
 			reg = <0 0x1100a000 0 0x100>;

-- 
b4 0.10.1
