Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D074B51D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjGGQ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGQ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:28:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371EC2102;
        Fri,  7 Jul 2023 09:28:34 -0700 (PDT)
Received: from localhost (unknown [188.27.60.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 884B26606FEE;
        Fri,  7 Jul 2023 17:28:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688747312;
        bh=Ief3Uz/0TJdx6oLRMTJ+yX/x6uF+9WAIZcWT6R5LfIg=;
        h=From:To:Cc:Subject:Date:From;
        b=WxxkNs4txkB8dmMYi2qEBfiSOnjl7Z6CBcbqf5j9aR6tb/6hSrzfciKXLHuYmjCUh
         uW5hkqXWTvB5GT0NBmh5G0+jZnZc+xAV+fIL2lRmOPr6/4brJTONXMvBc5L8L+C+Yj
         bNSqa24l+hlBmOgakpw34PmcbfvenVDg8iuTZnWHgEjLna3FUlVWfAn2ew6Gy6KHzh
         Hgko3/sMEX/jRljb6/1PQsRYlTGt48IDyex3RmtBjfFueS3B/DVgzSnscButUu6WOI
         Xqxi3KkeGH+Nno40oTF7Tv6YWdua9BYnPNS7NqV20x70mKzK2XS85ZOWkGyjIsTyq2
         BFBDx4WCuOmjQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] arm64: dts: rockchip: Update sound card label on rk3588-rock-5b
Date:   Fri,  7 Jul 2023 19:28:22 +0300
Message-ID: <20230707162822.676024-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio-graph-card driver uses the 'label' property to register the
sound card in the system, but the currently assigned string is too
generic and cannot be supported by alsa-project/alsa-ucm-conf:

  card 0: Analog [Analog]

Use the more specific naming "rk3588-es8316", which is still generic
enough to be shared with other compatible boards, e.g. Rock 5A. The
audio card will be listed as:

  card 0: rk3588es8316 [rk3588-es8316]

While at it, update also the DT node name, as there will be additional
sound related nodes available, i.e. for HDMI. Note that this involves
moving the node one position up, to preserve the alphabetical order.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 51537030f8e3..87f4d5e9458d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -18,17 +18,9 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
-	fan: pwm-fan {
-		compatible = "pwm-fan";
-		cooling-levels = <0 95 145 195 255>;
-		fan-supply = <&vcc5v0_sys>;
-		pwms = <&pwm1 0 50000 0>;
-		#cooling-cells = <2>;
-	};
-
-	sound {
+	analog-sound {
 		compatible = "audio-graph-card";
-		label = "Analog";
+		label = "rk3588-es8316";
 
 		widgets = "Microphone", "Mic Jack",
 			  "Headphone", "Headphones";
@@ -43,6 +35,14 @@ sound {
 		pinctrl-0 = <&hp_detect>;
 	};
 
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 95 145 195 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm1 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+
 	vcc5v0_sys: vcc5v0-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
-- 
2.41.0

