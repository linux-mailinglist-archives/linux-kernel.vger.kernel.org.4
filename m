Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E664874DBA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGJQxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjGJQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A112E;
        Mon, 10 Jul 2023 09:52:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B61F56607014;
        Mon, 10 Jul 2023 17:52:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007953;
        bh=xVJiHHBgSYdFFPYuWJ0JCFP5E3jXfJPB/JrJpxl+6Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILdbPwQegcxLF21efO2MVdXrkDFfjrKje0WkWItjlWMyshyr30keRfkX+PVggOLD6
         ro7IZlA6+Xo3ZPNX6I63gHJU7qjYqioTlRLvXhqer/F3ayyV3+7h8QbuccpDMcvcQU
         dskGp8j7x83sjxe08NDt6iWL9vRh+/MWJQ6Eq70EBbBYkRadQxrsEErIce4DjBEXlB
         nIlFaS1kbbmMONkiHG8eohByLRilIm6HAOp9nZnhTPKVyNBgAJXWE2CFNovYYQolBL
         AbET5kYr2AZ+QaalpAA+y9qJHppphCeIZWxpT7N/r9wnKd9RCzzXize3E66n8Gv7rl
         zLK0f2EYdwxBQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2B29B4807F2; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 13/13] arm64: dts: rockchip: rock-5a: add fan support
Date:   Mon, 10 Jul 2023 18:52:28 +0200
Message-Id: <20230710165228.105983-14-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary DT changes for the Rock 5A board to enable support for
the PWM controlled heat sink fan.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 156c93b22382..ad6fec5514a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -47,6 +47,14 @@ io-led {
 		};
 	};
 
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 95 145 195 255>;
+		fan-supply = <&vcc_5v0>;
+		pwms = <&pwm3 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+
 	vcc12v_dcin: vcc12v-dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -286,6 +294,12 @@ rtl8211f_rst: rtl8211f-rst {
 	};
 };
 
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm3m1_pins>;
+	status = "okay";
+};
+
 &saradc {
 	vref-supply = <&avcc_1v8_s0>;
 	status = "okay";
-- 
2.40.1

