Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC06D76CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjDEI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjDEI1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:27:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC841BEA;
        Wed,  5 Apr 2023 01:27:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B3B26603112;
        Wed,  5 Apr 2023 09:27:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680683259;
        bh=PZ1ID2Zw3PwezwwvcnYi3Nauvrfa7qCQvMEH4PdczCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QcVBuLpvczD59XicL2WXQBYFR4gr0aeRvE0uqJVBzmC6RUm5JzFq5QGtHUvCgksFA
         x+dpafbaEOS7Pt8RmuWS1KAXu9OEedmsLUdDwFDg49DyxUX2VMjD2obIqZ1nKx/s2G
         eTkpAEzrRHP/UWdRPKIZQDu6FhbsyhniKJXBgZN75sbcRjDajA1H+c72ESWZQu1n4p
         Tq4fewmEqXuiP6dvXZdDcSSYQsXlf/3YD60CoOHgXPGdFeMbX5s+nSKNeZjFgJxNxt
         fGHC+qTfeLBo3F5m+T+eOAwvgfh0CGxng4/112U1ScVsrjfPuI8dKhUnpdxfPwaoBg
         pePa7Jd/bQ0qQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Shreeya Patel <shreeya.patel@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v3] arm64: dts: rockchip: Enable RTC support for Rock 5B
Date:   Wed,  5 Apr 2023 13:57:11 +0530
Message-Id: <20230405082711.46303-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node to enable RTC support for Rock 5B board.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
---

Changes in v3:
  - Use a generic node name.

Changes in v2:
  - Make the subject and commit message  more descriptive.
  - Add a Reviewed-by tag.

 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 95805cb0adfa..e63138eb7e8d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -27,6 +27,31 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 	};
 };
 
+&i2c6 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+	};
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
-- 
2.30.2

