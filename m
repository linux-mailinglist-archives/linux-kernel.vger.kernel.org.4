Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24E5EB021
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIZSiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiIZSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:37:44 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC0B6580D;
        Mon, 26 Sep 2022 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=6c+pv0oZJZdbxbzQ9QgG2de+M6SrcJe4oUVVauEVHWI=; b=Mz+MZFhTNTARfDVghkIAcVb0vP
        LKCz8yR0bfxlgjwwyLX/9UUOV3zVZVBOfeO99ha3yFn57hTIdIb9YLeGXCCrlK6i/nHsdVfJ8tUV5
        /rcOAXVPT2OaVo5nKidpSysT75OaX7feF5E1g7NEQ7VrhRkgUi9MVUe1MqoSZl9wSg5MnIUZVVx7h
        0z9F0BfpQRM+FNCvLOfWt7uFLcYWNkgmuObrPqXvNDji7ikrUd7KvhgvNO19b0+U1iV1DS13wiIJ3
        ZZpPmjL0sqmtbKU0iVzMOkvsFxXjN9LZL0V46n8nMXPxAOUueJkgQrJTf07hmPC6lcqC1SRuVFy7i
        sEzyhG7w==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz3-00B9PV-6V; Mon, 26 Sep 2022 20:37:37 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz1-007wc1-1Y;
        Mon, 26 Sep 2022 20:37:35 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     Dongjin Kim <tobetter@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 04/13] arm64: dts: rockchip: Add NOR flash to ODROID-M1
Date:   Mon, 26 Sep 2022 20:37:18 +0200
Message-Id: <20220926183727.1893566-5-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220926183727.1893566-1-aurelien@aurel32.net>
References: <20220926183727.1893566-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Rockchip Serial Flash Controller for the ODROID-M1 and add
the corresponding SPI NOR flash entry. The partitions addresses and
sizes are taken from the ODROID-M1 Partition Table page on the ODROID
wiki.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 .../boot/dts/rockchip/rk3568-odroid-m1.dts    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 112c65af3f55..877b9515ad98 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -409,6 +409,49 @@ &sdmmc0 {
 	status = "okay";
 };
 
+&sfc {
+	pinctrl-0 = <&fspi_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "SPL";
+				reg = <0x0 0xe0000>;
+			};
+			partition@e0000 {
+				label = "U-Boot Env";
+				reg = <0xe0000 0x20000>;
+			};
+			partition@100000 {
+				label = "U-Boot";
+				reg = <0x100000 0x200000>;
+			};
+			partition@300000 {
+				label = "splash";
+				reg = <0x300000 0x100000>;
+			};
+			partition@400000 {
+				label = "Filesystem";
+				reg = <0x400000 0xc00000>;
+			};
+		};
+	};
+};
+
 &tsadc {
 	rockchip,hw-tshut-mode = <1>;
 	rockchip,hw-tshut-polarity = <0>;
-- 
2.35.1

