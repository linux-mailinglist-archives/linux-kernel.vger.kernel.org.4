Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94006C9E63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjC0ImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjC0Ikk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:40:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABC79011
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:37:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n19so4559833wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679906256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqhIf7wHsvu3kZClALu/ZsQ43yPjSHEDO4Bh0IFxfIc=;
        b=EpF4bswPemDl0JZJE9D+4PT3BzzlS4hfJiB2TK92VFL77g71aVLufzqQ5Fo6DyiMCo
         hFM4ot0X3q7EQ89s1XxiRUo2vWxwc8ncDAA6peztjZLZkCKbkiwwbFVfiU4dxnNNTl6V
         o03bJurfJpxst8BRGMAD82OK3r77iYoLQEROOeHeNLuaW3LMEp7c63jsNLPY9jyWrcFv
         Y22LOquQqTI9lf0v8QoL6jtfPbyvDn/vRg82mJKfEtcDty+bsEDAX+gJTLkCugLMJHOH
         ShGsEjitGj70QSo0C6/q+fz1py2M3zoK9jhHh+KM9u0LphnJ1aJ0Ko9HWPibxShw/dS7
         5hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679906256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqhIf7wHsvu3kZClALu/ZsQ43yPjSHEDO4Bh0IFxfIc=;
        b=QDxibk4fkTvHReJiuFE7vRfX7TSykR0t7YAwh+8eiywTSMYkgpsqma0Oj3k9ahliUm
         gMNLKl0Gdp3nKcq2PD8Q2KQiPxl/0HVgccNhQkieLTYYvIZDvDlPs0y7jYY7rYVG4EIi
         V6e4QOsDurqgtgEDwZgwxOT8kVV5HtBLvbjqjYujn0QshkGJ62SX2A5jm1mWikocsRZP
         gnKoh4ScrgfxthsA8AUz2A60vKjEDgpXawNGUm1aXi2cYTeW2qWqyXTJXzfI0fDvN4ge
         WN0ipIUTuHomBc+r4Y1TmOVs8v3Adcia27m4yfgOtwVnDVnF1XTbKMP742lUE+CU4kh/
         BP7A==
X-Gm-Message-State: AO0yUKWNCERP/wsjmGIII//fvvVkHKYnYweE/Eo4MH1GCg/QMonNmepy
        ViwzjTfPL6fKPP70JPq2e4MC5QY4eTxcrZ5Yz0w=
X-Google-Smtp-Source: AKy350YB3hUjVcz0HOV1xxqPG0tO8HVJ4mGr2zVXdfCBPNZ+4aF8LZfZ1VQeKrnHcLZ/uW+VJANqNg==
X-Received: by 2002:a5d:67cd:0:b0:2d7:babe:104c with SMTP id n13-20020a5d67cd000000b002d7babe104cmr8240818wrw.15.1679905687738;
        Mon, 27 Mar 2023 01:28:07 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id p5-20020adfce05000000b002d64fcb362dsm19192398wrn.111.2023.03.27.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:28:07 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 27 Mar 2023 10:27:57 +0200
Subject: [PATCH v5 1/2] arm64: dts: mediatek: add i2c support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221122-mt8365-i2c-support-v5-1-6e4f3b54937f@baylibre.com>
References: <20221122-mt8365-i2c-support-v5-0-6e4f3b54937f@baylibre.com>
In-Reply-To: <20221122-mt8365-i2c-support-v5-0-6e4f3b54937f@baylibre.com>
To:     Qii Wang <qii.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2696; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=751COW4mlyt6NiZw3ZmEVilTCKVZTkOYnz6i1pHU/mc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkIVOVvwFm7qKdwZ5fqAIYMGktI6dKizeGbo8hx4Vw
 M+z3ib6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCFTlQAKCRArRkmdfjHURS6mD/
 91U/H9o3Iw//cFCuK0mX1vV/fLdKa97DGN2ufyavXj+EIOEP2fyuPl99rsk+I75f22AWZL7Huchr7/
 7Un6yH9x0pgxIeA6btYsxNmcfSTNxKV0Zpm2yyBAZu5S2Il9b24eC7QuUWpQnoZekAhQDJnAomDyqI
 c+yAwJgszvZyeSnARrUzyjFAM1E9hiB46/VxBomQmS4qUF+8Jokk+xY6RvEr46TZysSA3jhvWn7uJY
 IJNa7E6IQUST8XWeTmZH86DwJukLcZcSz5hDLPvjO4IseLFF5zYaL1O12kdRaMxX3juJSBvBh6vlDF
 Yl9DrF3uNa9bHaGO5pigeTm7xKXSLAeAYv/FS5k+ILRQGOselZlEocceg9Fu+O11ssCHe6ArS7EZdD
 qHxmmG3DBIk43L2RCfqYom4rDrBx6QANBbzc1WfXqwGi4ncBs/6AdxzZE5s8Ok9EyHvBR9Ea2/g3WI
 4U0/ifwyO/bEGQHoIAVkdNvDGptUOHAVcXznUtB8V93G5ju3Lu38EjBU7BgCd7UKfOfooX355KkkDi
 siiDNUnNQdAWTsX3oxqmYp5tHirvCCQsEenvPO9xQirAiZRd+g85tPqx+A/m2L+HkW/RNeYbCZV0Rk
 CjLndADLN2vSn53AaED+wNEfeCqswSy4rdhKDK5hG9UYEg/fvc9B60hdtc1w==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four I2C master channels in MT8365 with a same HW architecture.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 15ac4c1f0966..b70f4d256f63 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -282,6 +282,42 @@ pwm: pwm@11006000 {
 			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
 		};
 
+		i2c0: i2c@11007000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x11007000 0 0xa0>, <0 0x11000080 0 0x80>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C0_AXI>, <&infracfg CLK_IFR_AP_DMA>;
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
+			clocks = <&infracfg CLK_IFR_I2C1_AXI>, <&infracfg CLK_IFR_AP_DMA>;
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
+			clocks = <&infracfg CLK_IFR_I2C2_AXI>, <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi: spi@1100a000 {
 			compatible = "mediatek,mt8365-spi", "mediatek,mt7622-spi";
 			reg = <0 0x1100a000 0 0x100>;
@@ -295,6 +331,18 @@ spi: spi@1100a000 {
 			status = "disabled";
 		};
 
+		i2c3: i2c@1100f000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x1100f000 0 0xa0>, <0 0x11000200 0 0x80>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C3_AXI>, <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		ssusb: usb@11201000 {
 			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";
 			reg = <0 0x11201000 0 0x2e00>, <0 0x11203e00 0 0x0100>;

-- 
2.25.1

