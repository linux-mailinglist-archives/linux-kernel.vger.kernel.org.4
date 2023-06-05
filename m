Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2D722E68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjFESNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjFESNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:13:01 -0400
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC58E6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:12:59 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197]) by mx-outbound43-10.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 05 Jun 2023 18:12:56 +0000
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39826f057a0so4854598b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1685988776; x=1688580776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEiNRZDZjWnkzNY9AoYu0FIiGrH0hmi+XSngmRPIxu4=;
        b=iv0eGdz4wb51P7q6ZQV6FokGeFdOloom2QiCmGAbLdk4F02oKP4L1EZiAI6ONxBFwR
         xm5oxqGCDDeiEjGXHWVE/X4enTjmuJZ4EkiPDyloS6+uNCyLdvgB0BXvANtwICPJ7zm3
         C3IEOrW0RSHfdwjAsZf9eJACJk6G+u66QTfmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988776; x=1688580776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEiNRZDZjWnkzNY9AoYu0FIiGrH0hmi+XSngmRPIxu4=;
        b=aJU+tkxRz3kdDfEnEPqW6cYyuoHz2IAJqY3idhu3E2j9BkQJRy0gGnBUiOjkM9IOJ3
         IfTZsX6wXsY0GromgzIGR4gtCQNBan7uROeJ0Wcwo4413cR16OftEn7uK7hOf4rDCApu
         i3L7EH6XhSfEB6YEx1cErmwRKB5ISUChT/BCnNW7TdiXAr39f5vobDaeYFtLrOp5i3UE
         6jurIyKbSnBoy4cQEsQPyXV1cGUrbgYhrHxdL/7hB8zCKwb+fEuNxt+hiF7XpEDokPSF
         GZF2EoRHGPpV3RywUr3LHEdg2xvGmIU0+/bHOLTBG9PCPlquWRTX0JTdI7FjR+Yfukbp
         nK1Q==
X-Gm-Message-State: AC+VfDxYccfWEGNJQkGeK0aLAjROgUjcWq7MtOZfOYtCpryx7DrN5iTp
        20tFg6ysRvGVZTr9MaHbHqvubUwNdfdQEN8KZEF8VzWK1pGfdrQHQC6UdSSH20dfFA2uG9iBmO9
        SLpyzKAgXCdT+E458klIpN4C4czvgET8iXBSV/JkD3uoMK22OOULuvZhC2Csb
X-Received: by 2002:a05:6a20:e619:b0:10a:be5c:6e2d with SMTP id my25-20020a056a20e61900b0010abe5c6e2dmr2446153pzb.39.1685986933604;
        Mon, 05 Jun 2023 10:42:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7niwQ6oqcZbl4tSMUgkwVEOqD7UX6n+xTcgK6jiCDqg4/oQz6awofepRrmuvDWlsF2EEzsqw==
X-Received: by 2002:a05:6a20:e619:b0:10a:be5c:6e2d with SMTP id my25-20020a056a20e61900b0010abe5c6e2dmr2446131pzb.39.1685986933254;
        Mon, 05 Jun 2023 10:42:13 -0700 (PDT)
Received: from LAP789U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id z6-20020aa785c6000000b0064d2ad04cccsm5619653pfn.175.2023.06.05.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 10:42:12 -0700 (PDT)
From:   sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, afd@ti.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabiya.d@mistralsolutions.com,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am69-sk: Enable MCU CPSW2G
Date:   Mon,  5 Jun 2023 23:12:02 +0530
Message-Id: <20230605174202.159278-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1685988776-311018-5448-27564-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 209.85.167.197
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyMrY0AbIygIJGiWlGpsYGJs
        nG5mkWlkZmFhapBqYGhpaGhsaJKYmppkq1sQDBv8m0QQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248613 [from 
        cloudscan18-126.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO, NO_REAL_NAME
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

Add device tree support to enable MCU CPSW for AM69 SK

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index bc49ba534790..4b7d9280d76f 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -104,6 +104,32 @@ vdd_sd_dv: regulator-tlv71033 {
 	};
 };
 
+&wkup_pmx0 {
+	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
+			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
+			J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
+			J784S4_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
+			J784S4_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
+			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
+			J784S4_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
+			J784S4_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
+			J784S4_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
+			J784S4_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
+			J784S4_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
+			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
+		>;
+	};
+
+	mcu_mdio_pins_default: mcu-mdio-pins-default {
+		pinctrl-single,pins = <
+			J784S4_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
+			J784S4_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
+		>;
+	};
+};
+
 &main_pmx0 {
 	main_uart8_pins_default: main-uart8-pins-default {
 		pinctrl-single,pins = <
@@ -178,3 +204,27 @@ &main_sdhci1 {
 &main_gpio0 {
 	status = "okay";
 };
+
+&mcu_cpsw {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_cpsw_pins_default>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mdio_pins_default>;
+
+	mcu_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&mcu_cpsw_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&mcu_phy0>;
+};
-- 
2.25.1

