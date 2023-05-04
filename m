Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1226F65E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjEDHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEDHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:35:17 -0400
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C502358D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:35:00 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198]) by mx-outbound19-253.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 04 May 2023 07:34:45 +0000
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-64380c45e84so257729b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1683185684; x=1685777684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s7oVHe0hpnuo3lFcvbzvKxfd16PFOp9/qLeZLiOcDE=;
        b=TtVLGmbM7YpqlILyNvbKecKvW1Tkz7ud2L+JWkP/HfKziSMVtWk7dYaabJsu+Av799
         GJ0KbSIXlalWz1oyRGoANvfbHkDRVU7Lp8s66E5xKUZoEHSp6HmJBins0Z55g8w11IlH
         Oqo3rdFTFrJGNkR4LwqpR7A1qoGde5YG9bVGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683185684; x=1685777684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s7oVHe0hpnuo3lFcvbzvKxfd16PFOp9/qLeZLiOcDE=;
        b=E8Qh6bq/EUryw4wRU9BcgE11PpFYcbCKC1D9rKIZ/0bdIiLioOSc3VQnVSgcHlu+E8
         CW6v3ATsc2oGSb4GwM+uuQWO/S6GPny2Ey5N4tLHsDScwiMuse7MeGG0kVg0wSb6jJm3
         +xMmIuGjIOeUTVv5UQksmqNL7Z4z6oGqqL+4cDyRLa1NYt+E8daDIJ1C5+Gx0xYZsww5
         egG/oZpKyyHnSWUsbUrflwcGfY9OJjs30HHBAZYolBOxpPo9nbHX8xV4Cza/4hlA1bKM
         CBjFkQBfTdEWwISe/zwSGc1yQZuvmm7bosuzCIiQOsxLavwRCIbq8UdHNcTuLnH24DLE
         pqVQ==
X-Gm-Message-State: AC+VfDxIT+fcxVbYp/mrpt75e+69Ovl8FfGkZVcx/OGr80Dlv8nrvUMX
        94um1RQrmSxrzfv0vUJXvxMCdzIAgcpxcNGPRKtB3VNgspQMtrSSIX3jsNF4BztUQhATifFLStn
        OS/+OTEoCCeBHqqYhQtaSNfcMavUh0WN0f3/fYpdfNzJma61tWSlnKx1NhnrL
X-Received: by 2002:a05:6a00:cd3:b0:623:8592:75c4 with SMTP id b19-20020a056a000cd300b00623859275c4mr1550785pfv.29.1683185683816;
        Thu, 04 May 2023 00:34:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DW3NjbJ2HG7UhpJeJ0fnPX+I/Msvt6GmKpBvI84Y+NIAqIBDoERC6FUcWHp6H2BDAy3x7kA==
X-Received: by 2002:a05:6a00:cd3:b0:623:8592:75c4 with SMTP id b19-20020a056a000cd300b00623859275c4mr1550773pfv.29.1683185683410;
        Thu, 04 May 2023 00:34:43 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id q22-20020aa79616000000b0063f1a1e3003sm22884865pfg.166.2023.05.04.00.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:34:42 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>
Subject: [PATCH V5 1/2] arm64: dts: ti: k3-j721s2: fix wkup pinmux range
Date:   Thu,  4 May 2023 13:04:31 +0530
Message-Id: <20230504073432.6438-2-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230504073432.6438-1-sinthu.raja@ti.com>
References: <20230504073432.6438-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1683185684-305117-5467-1404-1
X-BESS-VER: 2019.1_20230502.2000
X-BESS-Apparent-Source-IP: 209.85.210.198
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNDI3MgIyM4CiSUkpBklJqc
        ZpJilGpimWaUYpaeaGphYppgbGqWZpKaZKtbEAnPuft0IAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.247924 [from 
        cloudscan8-159.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

No changes in V5.

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
index 27a43a8ecffd..67bcf906ded1 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -175,49 +175,49 @@ J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
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
index b4b9edfe2d12..a7caf1c3404d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -146,81 +146,81 @@ J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
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

