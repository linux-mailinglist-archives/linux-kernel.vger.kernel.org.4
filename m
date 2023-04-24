Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3666EC803
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDXImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjDXImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:42:22 -0400
X-Greylist: delayed 1574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 01:42:19 PDT
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E38E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:42:19 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197]) by mx-outbound16-184.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 24 Apr 2023 08:41:54 +0000
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-b8f4c437ce5so7167073276.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1682325714; x=1684917714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnGFUMY+UO4rKqbmguhM32hao10ZDlHndxQXqQg7boY=;
        b=ffuYXhdB4AJMmoxnSiuf6yuhyiCQ4XnsRz9OQlTofYMzyVQQhFwjflc6sNrUjDF1n7
         1w66pyEYOre4L4z/4FhXH09zoQ2V3FZ+16dGX2cwdlvMBlJPHPnWZteRiA8h2drnunGn
         AcF5pVz/aBAo2AJ6mMTbOsbOhyUyqx+DN/v+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682325714; x=1684917714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnGFUMY+UO4rKqbmguhM32hao10ZDlHndxQXqQg7boY=;
        b=EYrhc5Ez7Qc66UBVsPItQ1grX2i5jWiBZ4Sef/xmBrvKrsNhIvI+X7kapp6VDQbl+C
         zdvwSCh4Gv1FubPBCI7st0wRe2L8wLI519WNnKKUlcQCZAnQnOty+9h58n470AtiKlJ4
         I+FLIJeuqcG6M/HMmSpSmQPJ7GlEE4wJXbenH5ZZSZSPsTLWDTwqNzlvLsSOuuZl3l8v
         zRZO5YnlTA9ibYGSGO/A/EvT4SMJBI9I7U26YEKnhS5f7d2Wtz57MJjL6sJ1wa3CHKAC
         hPpX0dD7MSqq8v/RLwSHik0rq1DgbGKAwI6MJzO3Jgnkl/abQ6pDJ8vRDX5PC6bAxhLd
         Dgnw==
X-Gm-Message-State: AAQBX9fvdYwj4qc4BVInvwTxh/2eQ9GOZ6Uc6ku9y028oKLnxojAYgv2
        f1ymUzUXif6h6bYgdAjbXS98zyoW5EowbnK2mciyyGH8wU2xkmRpF8ZUCzjItAySCs1Br8AgJpN
        XaFsB6Mee58StYSxLjcgGjN+xnLP+j8Z67ZvLhqE5MMD119rKJT2WAB4DZicJ
X-Received: by 2002:a17:902:fb44:b0:1a5:16fb:628b with SMTP id lf4-20020a170902fb4400b001a516fb628bmr11876323plb.24.1682324151368;
        Mon, 24 Apr 2023 01:15:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350aqYdMj4KkgPMWMCIN/eDJCBGg2sbpKriNrnjTUF7eE7s2y+P7ZRiLJ2W2wRFi/S7dSzvl6tw==
X-Received: by 2002:a17:902:fb44:b0:1a5:16fb:628b with SMTP id lf4-20020a170902fb4400b001a516fb628bmr11876307plb.24.1682324150996;
        Mon, 24 Apr 2023 01:15:50 -0700 (PDT)
Received: from localhost.localdomain ([49.207.195.237])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709029a4a00b001a9293597efsm6089868plv.246.2023.04.24.01.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 01:15:50 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 2/3] arm64: dts: ti: k3-j721s2: fix wkup pinmux range
Date:   Mon, 24 Apr 2023 13:45:35 +0530
Message-Id: <20230424081536.12123-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230424081536.12123-1-sinthu.raja@ti.com>
References: <20230424081536.12123-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1682325714-304280-5481-1143-1
X-BESS-VER: 2019.1_20230419.1731
X-BESS-Apparent-Source-IP: 209.85.219.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNDIzsgQyM4CiFkZmSYnGpu
        YmBgYGRqnGlslmBubmiWYGSQYGaaYGBqZKtbEAiaaatUIAAAA=
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

The WKUP_PADCONFIG register region in J721S2 has multiple non-addressable
regions, accordingly split the existing wkup_pmx region as follows to avoid
the non-addressable regions and include the rest of valid WKUP_PADCONFIG
registers. Also update references to old nodes with new ones.

wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)

Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

Changes in V4:
- Correct the pinctrl node offsets as per the newly split wkup_pmx*
  nodes 

Changes in V3:
- Added Fix tag

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 because 0x190 is the last register of the
  IO PADCONFIG register set.

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 42 +++++-----
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 76 +++++++++----------
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 29 ++++++-
 3 files changed, 87 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 711757997804..a811a512262b 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -182,49 +182,49 @@ J721S2_IOPAD(0x004, PIN_INPUT, 0) /* (N24) MMC1_CMD */
 	};
 };
 
-&wkup_pmx0 {
+&wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
-			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
-			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
-			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
-			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
-			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
-			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
-			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
-			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
-			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
-			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
-			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
+			J721S2_WKUP_IOPAD(0x02C, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
+			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
+			J721S2_WKUP_IOPAD(0x01C, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
+			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
+			J721S2_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
+			J721S2_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
+			J721S2_WKUP_IOPAD(0x00C, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
+			J721S2_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
+			J721S2_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
+			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
 		>;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
-			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+			J721S2_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
+			J721S2_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
 		>;
 	};
 
 	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0bc, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
-			J721S2_WKUP_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
+			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
+			J721S2_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
 		>;
 	};
 
 	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
-			J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
+			J721S2_WKUP_IOPAD(0x06C, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
 		>;
 	};
 
 	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
-			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
+			J721S2_WKUP_IOPAD(0x078, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
+			J721S2_WKUP_IOPAD(0x07c, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 6141ae487cba..c689b22f3899 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -152,81 +152,81 @@ J721S2_IOPAD(0x004, PIN_INPUT, 0) /* (N24) MMC1_CMD */
 	};
 };
 
-&wkup_pmx0 {
+&wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
-			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
-			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
-			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
-			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
-			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
-			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
-			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
-			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
-			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
-			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
-			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
+			J721S2_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
+			J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
+			J721S2_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
+			J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
+			J721S2_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
+			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
+			J721S2_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
+			J721S2_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
+			J721S2_WKUP_IOPAD(0x00c, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
+			J721S2_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
+			J721S2_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
+			J721S2_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
 		>;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
-			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
+			J721S2_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
+			J721S2_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
 		>;
 	};
 
 	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0bc, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
-			J721S2_WKUP_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
+			J721S2_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
+			J721S2_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
 		>;
 	};
 
 	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
-			J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX */
+			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /*(C23) WKUP_GPIO0_4.MCU_MCAN1_TX */
 		>;
 	};
 
 	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0c0, PIN_INPUT, 7) /* (D26) WKUP_GPIO0_0 */
-			J721S2_WKUP_IOPAD(0x0a8, PIN_INPUT, 7) /* (B25) MCU_SPI0_D1.WKUP_GPIO0_69 */
+			J721S2_WKUP_IOPAD(0x058, PIN_INPUT, 7) /* (D26) WKUP_GPIO0_0 */
+			J721S2_WKUP_IOPAD(0x040, PIN_INPUT, 7) /* (B25) MCU_SPI0_D1.WKUP_GPIO0_69 */
 		>;
 	};
 
 	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x0c8, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
+			J721S2_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (C28) WKUP_GPIO0_2 */
 		>;
 	};
 
 	mcu_adc0_pins_default: mcu-adc0-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x134, PIN_INPUT, 0) /* (L25) MCU_ADC0_AIN0 */
-			J721S2_WKUP_IOPAD(0x138, PIN_INPUT, 0) /* (K25) MCU_ADC0_AIN1 */
-			J721S2_WKUP_IOPAD(0x13c, PIN_INPUT, 0) /* (M24) MCU_ADC0_AIN2 */
-			J721S2_WKUP_IOPAD(0x140, PIN_INPUT, 0) /* (L24) MCU_ADC0_AIN3 */
-			J721S2_WKUP_IOPAD(0x144, PIN_INPUT, 0) /* (L27) MCU_ADC0_AIN4 */
-			J721S2_WKUP_IOPAD(0x148, PIN_INPUT, 0) /* (K24) MCU_ADC0_AIN5 */
-			J721S2_WKUP_IOPAD(0x14c, PIN_INPUT, 0) /* (M27) MCU_ADC0_AIN6 */
-			J721S2_WKUP_IOPAD(0x150, PIN_INPUT, 0) /* (M26) MCU_ADC0_AIN7 */
+			J721S2_WKUP_IOPAD(0x0cc, PIN_INPUT, 0) /* (L25) MCU_ADC0_AIN0 */
+			J721S2_WKUP_IOPAD(0x0d0, PIN_INPUT, 0) /* (K25) MCU_ADC0_AIN1 */
+			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (M24) MCU_ADC0_AIN2 */
+			J721S2_WKUP_IOPAD(0x0d8, PIN_INPUT, 0) /* (L24) MCU_ADC0_AIN3 */
+			J721S2_WKUP_IOPAD(0x0dc, PIN_INPUT, 0) /* (L27) MCU_ADC0_AIN4 */
+			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (K24) MCU_ADC0_AIN5 */
+			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (M27) MCU_ADC0_AIN6 */
+			J721S2_WKUP_IOPAD(0x0e8, PIN_INPUT, 0) /* (M26) MCU_ADC0_AIN7 */
 		>;
 	};
 
 	mcu_adc1_pins_default: mcu-adc1-pins-default {
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x154, PIN_INPUT, 0) /* (P25) MCU_ADC1_AIN0 */
-			J721S2_WKUP_IOPAD(0x158, PIN_INPUT, 0) /* (R25) MCU_ADC1_AIN1 */
-			J721S2_WKUP_IOPAD(0x15c, PIN_INPUT, 0) /* (P28) MCU_ADC1_AIN2 */
-			J721S2_WKUP_IOPAD(0x160, PIN_INPUT, 0) /* (P27) MCU_ADC1_AIN3 */
-			J721S2_WKUP_IOPAD(0x164, PIN_INPUT, 0) /* (N25) MCU_ADC1_AIN4 */
-			J721S2_WKUP_IOPAD(0x168, PIN_INPUT, 0) /* (P26) MCU_ADC1_AIN5 */
-			J721S2_WKUP_IOPAD(0x16c, PIN_INPUT, 0) /* (N26) MCU_ADC1_AIN6 */
-			J721S2_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (N27) MCU_ADC1_AIN7 */
+			J721S2_WKUP_IOPAD(0x0ec, PIN_INPUT, 0) /* (P25) MCU_ADC1_AIN0 */
+			J721S2_WKUP_IOPAD(0x0f0, PIN_INPUT, 0) /* (R25) MCU_ADC1_AIN1 */
+			J721S2_WKUP_IOPAD(0x0f4, PIN_INPUT, 0) /* (P28) MCU_ADC1_AIN2 */
+			J721S2_WKUP_IOPAD(0x0f8, PIN_INPUT, 0) /* (P27) MCU_ADC1_AIN3 */
+			J721S2_WKUP_IOPAD(0x0fc, PIN_INPUT, 0) /* (N25) MCU_ADC1_AIN4 */
+			J721S2_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (P26) MCU_ADC1_AIN5 */
+			J721S2_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (N26) MCU_ADC1_AIN6 */
+			J721S2_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (N27) MCU_ADC1_AIN7 */
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index a353705a7463..fa31831e33e8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -50,7 +50,34 @@ mcu_ram: sram@41c00000 {
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x034>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx1: pinctrl@4301c038 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c038 0x00 0x02C>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx2: pinctrl@4301c068 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c068 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx3: pinctrl@4301c190 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c190 0x00 0x004>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.36.1

