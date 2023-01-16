Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B066C226
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjAPOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjAPOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:23:50 -0500
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 06:08:28 PST
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07022749E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:08:28 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NwYc90nXCzMqcMb;
        Mon, 16 Jan 2023 15:02:01 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NwYc81GLdzGsp;
        Mon, 16 Jan 2023 15:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1673877721;
        bh=A6GZwkHnaoIZ28gxZUhGOXzEzh7g91KUo/Qw0h2sKB4=;
        h=From:To:Cc:Subject:Date:From;
        b=TKYlhNeXlGFMKUiXm+/BS6fmCAtv53XpEYN8DQwHLt46AHrZdFVcNecmDMtHtcdiU
         k2mGbd4GTydvxcQCJdaW7uHqgZEYoUHAU+14U1MDwjsuLMEYjAIUDx9oKLG21b552p
         Oq8D9JQ4Omcf/3DENcTx+z6puBxwCytsM5LzT4m0=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-verdin: Do not power down eth-phy
Date:   Mon, 16 Jan 2023 15:01:52 +0100
Message-Id: <20230116140153.23938-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Currently if suspending using either freeze or memory state, the fec
driver tries to power down the phy which leads to crash of the kernel
and non-responsible kernel with the following call trace:

[   24.839889 ] Call trace:
[   24.839892 ]  phy_error+0x18/0x60
[   24.839898 ]  kszphy_handle_interrupt+0x6c/0x80
[   24.839903 ]  phy_interrupt+0x20/0x2c
[   24.839909 ]  irq_thread_fn+0x30/0xa0
[   24.839919 ]  irq_thread+0x178/0x2c0
[   24.839925 ]  kthread+0x154/0x160
[   24.839932 ]  ret_from_fork+0x10/0x20

Since there is currently no functionality in the phy subsystem to power
down phys let's just disable the feature of powering-down the ethernet
phy.

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 7e8b3b0fa306..4df3c9760151 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -102,6 +102,7 @@ reg_ethphy: regulator-ethphy {
 		off-on-delay = <500000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_eth>;
+		regulator-always-on;
 		regulator-boot-on;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
-- 
2.39.0

