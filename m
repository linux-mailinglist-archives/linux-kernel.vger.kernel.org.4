Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2465F5F81A1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJHAlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHAlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:41:20 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Oct 2022 17:41:19 PDT
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A989AD2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eR+NXbMh3/vLaZ91+a3etBbDh8A2NsKZ4EZHQPgJfxk=; b=VzuxhddR0YEMAAoajLtBWxOyP4
        9HRXlm0qE7NhJuFgdRaQJThTd+aC5EVn7KWv0xmjjrPXNh4P70/DdhOzFAjDFKv82Q00mh1xybNmI
        Au6kx7bg3r8xo+KeK8V7wy7k2NvYelMVEnWr1lHHWqHpgu/Wh5ckk/qWhoCe7S9aiGpl9h6yZEYRf
        /V1M5clEGT5yM5rSSHqicw6cyq/qqdeHR8cdc2WOQYP2pGfZWko1jvtL1Iyvzm5ZF5gxpQZF2kC5N
        B8wS3whsSA0hf5oY30PXLI4M27ukv2EEXTgBSuP6DJcNe4RyGu4ZS87PelRxrQTqxeWgdtCq1fK6q
        coJ+CP/A==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1ogx3K-000AIf-2o; Fri, 07 Oct 2022 23:46:49 +0000
From:   Bastian Germann <bage@debian.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Bastian Germann <bage@debian.org>
Subject: [PATCH 1/1] arm64: allwinner: a64: enable Bluetooth on Pinebook
Date:   Sat,  8 Oct 2022 01:45:53 +0200
Message-Id: <20221007234553.12328-2-bage@debian.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221007234553.12328-1-bage@debian.org>
References: <20221007234553.12328-1-bage@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Pinebook has an RTL8723CS WiFi + BT chip. BT is connected to UART1
and uses PL5 as device wake GPIO and PL6 as host wake GPIO.
The I2C controlling signals are connected to R_I2C bus.

Enable it in the device tree.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Bastian Germann <bage@debian.org>
---
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 620cb3ef5f6c..19ba87c411ed 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -406,6 +406,19 @@ &uart0 {
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723cs-bt";
+		device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
+		host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+	};
+};
+
 &usb_otg {
 	dr_mode = "host";
 };
-- 
2.37.2

