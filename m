Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17DD61E10F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiKFIvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiKFIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:50:56 -0500
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A859FEE1B;
        Sun,  6 Nov 2022 01:50:48 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 15F041007FA;
        Sun,  6 Nov 2022 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667724647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvVMLiuM+XeZ0ADmdp7nYgDyGhyaL6XbW/9kpCQCWGs=;
        b=KoKDbAsFd0Q7TrVi1k6jLVIkUPdeGEuPyy0MaUNB0crwRGb1k6RQl49+uVB6mdL+VsRyp6
        pLAXBv2iZCH9vx33nKcK9m6jbR8Rxx/eWLdBEi6tUQXR9EXrR9pJClSVP+h0fcyxqYHBur
        agxBoH+/axY77lP4t/nJhDIq5pUyn6c=
Received: from frank-G5.. (fttx-pool-80.245.79.199.bambit.de [80.245.79.199])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 81F3E360707;
        Sun,  6 Nov 2022 08:50:46 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 11/11] arm64: dts: mt7986: add BPI-R3 nand/nor overlays
Date:   Sun,  6 Nov 2022 09:50:34 +0100
Message-Id: <20221106085034.12582-12-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106085034.12582-1-linux@fw-web.de>
References: <20221106085034.12582-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 7abe5213-43d3-49b9-acfc-560d931496e8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add devicetree overlays for using nand and nor on BPI-R3.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 +
 .../mediatek/mt7986a-bananapi-bpi-r3-nand.dts | 53 +++++++++++++++
 .../mediatek/mt7986a-bananapi-bpi-r3-nor.dts  | 67 +++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index e8902f2cc58f..d42208c4090d 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
new file mode 100644
index 000000000000..e12ff825bb50
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nand.dts
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+
+/dts-v1/;
+/plugin/;
+
+//dtc -O dtb -o bpi-r3-nand.dtbo mt7986a-bananapi-bpi-r3-nand.dts
+
+/ {
+	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	fragment@0 {
+		target-path = "/soc/spi@1100a000";
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			spi_nand: spi_nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <10000000>;
+				spi-tx-buswidth = <4>;
+				spi-rx-buswidth = <4>;
+
+				partitions {
+					compatible = "fixed-partitions";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					partition@0 {
+						label = "bl2";
+						reg = <0x0 0x80000>;
+						read-only;
+					};
+
+					partition@80000 {
+						label = "reserved";
+						reg = <0x80000 0x300000>;
+					};
+
+					partition@380000 {
+						label = "fip";
+						reg = <0x380000 0x200000>;
+						read-only;
+					};
+
+					partition@580000 {
+						label = "ubi";
+						reg = <0x580000 0x7a80000>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
new file mode 100644
index 000000000000..f11ffd9c4bce
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dts
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+
+/dts-v1/;
+/plugin/;
+
+//dtc -O dtb -o bpi-r3-nor.dtbo mt7986a-bananapi-bpi-r3-nor.dts
+
+/ {
+	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
+
+	fragment@0 {
+		target-path = "/soc/spi@1100a000";
+		__overlay__ {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			flash@0 {
+				compatible = "jedec,spi-nor";
+				reg = <0>;
+				spi-max-frequency = <10000000>;
+
+				partitions {
+					compatible = "fixed-partitions";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					partition@0 {
+						label = "bl2";
+						reg = <0x0 0x20000>;
+						read-only;
+					};
+
+					partition@20000 {
+						label = "reserved";
+						reg = <0x20000 0x20000>;
+					};
+
+					partition@40000 {
+						label = "u-boot-env";
+						reg = <0x40000 0x40000>;
+					};
+
+					partition@80000 {
+						label = "reserved2";
+						reg = <0x80000 0x80000>;
+					};
+
+					partition@100000 {
+						label = "fip";
+						reg = <0x100000 0x80000>;
+						read-only;
+					};
+
+					partition@180000 {
+						label = "recovery";
+						reg = <0x180000 0xa80000>;
+					};
+
+					partition@c00000 {
+						label = "fit";
+						reg = <0xc00000 0x1400000>;
+						compatible = "denx,fit";
+					};
+				};
+			};
+		};
+	};
+};
-- 
2.34.1

