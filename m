Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B374DB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjGJQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjGJQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04F115;
        Mon, 10 Jul 2023 09:52:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BF9D6607011;
        Mon, 10 Jul 2023 17:52:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007952;
        bh=5gfqP3n6JjVI7mvmyViy3tF4VZ4HgaaoXQiCBJkMdHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRHOXVMdvXzNxcVh5XUUZ8XGCQuLSgz5Narnemjq4Xz1X8nV8MHJmvBpFE6sEjuWb
         YKYpcIJpsgmU8RYfFjm4Xs7RhDLGWoA2t8qmEtwdZpSSeqencI3gZE0ES4MVaem0sO
         WFXEccC2v9teJFxxdmlwT18nQdHlgTxqqElRNYh6/K4PomawMPh1bTn6L0BjdCmj+C
         t5z+tqNzsCiQe0C0k9yN9d2Etrhk+4PfA6gdpgMCQiLpHkL6CChXjSlCMST1WhdxmT
         kssUoPwJtQw1sYvwz4nookq2x3PGC+n3xIv69jBi9R1oQupCi54qU4wnLYj2cN+ur0
         3H64agKwP78Ug==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 273804807EF; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 10/13] arm64: dts: rockchip: rock-5a: add vdd_npu_s0 regulator
Date:   Mon, 10 Jul 2023 18:52:25 +0200
Message-Id: <20230710165228.105983-11-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the NPU regulator.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 0b18d4230eef..c4471dfe574f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -166,6 +166,23 @@ regulator-state-mem {
 &i2c2 {
 	status = "okay";
 
+	vdd_npu_s0: rk8602@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_npu_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <950000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
 	eeprom: eeprom@50 {
 		compatible = "belling,bl24c16a", "atmel,24c16";
 		reg = <0x50>;
-- 
2.40.1

