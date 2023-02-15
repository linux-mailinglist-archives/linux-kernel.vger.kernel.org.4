Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C15698216
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBORcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBORcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:32:21 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C5244A3;
        Wed, 15 Feb 2023 09:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676482321; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eoe67TwneMl/5/Tr/xoBlxst7yXuwE1u+Ibt8IaToVhkSnpCfVYUVDzgEy0WdBO1ls
    Q1rmxrK9PbbIJN5IPyQ9JvokvVTelcDeMvch0NljASk7jINp7mCH7NZjAVIliZChl+dv
    jyqpcVe0qAQcwIdG9csoIbj1S34efdiB48odYfGwbi2SgVQjpsV9+dS8pwhHI4XlurCi
    wKUUUESrrZqJRffTDg1d1XdRkEVA77/RyyrD6fL0/nbkJ9fdFUnhV1HTgQKo/u5RsMb4
    9bUUFIx6zolQUQnw8q7QmCiGYTQKWZ607AbDc35HrnT9CUJer6bv+/TYIwgHf5mhBiM1
    Sszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482321;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XW0+Qgb0myceiEMjaao1wM/4c+vauOGDaJPcYXWeNpY=;
    b=to/2qoEPvVNMKm4lNj1Y0CHDXtYUr8VjJgHJlDP8maxS2DCIEezZNM0O+BPx10Wg5W
    7cQTyymIN6wTCWa/ri5Ww+mL8Z/zJ9BSkwq1OV708Kb9DoMGmjIVQn4+JH1pcTwRt/NW
    Se5fKO34E7WAoWEQV7qKjaYfFh4DlzBYqSLf9NH1kvUq6PEbMkYz49h3mqeCP3gJ8J3P
    r+rPAqIZjdW0GJzTButZE6PSXjy+HKzDLNebfIYo/MIwdxjz3T9xz9l3xT+FFSHswii6
    qB8M3/UwmUlzM5QQ+d/evsYtMFP3q3RaWy5AJfdEw+TsCjaN3Vjq9Uqm++Y4xhgcMs0P
    XSgA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482321;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=XW0+Qgb0myceiEMjaao1wM/4c+vauOGDaJPcYXWeNpY=;
    b=EjjNBSCLDRCmFyY86H/68RbYMcYvBVCt+di/I/VNDo+ZdiU620ACs2N4rEDsifyHDb
    kN25Zj9L9v5EL6mQnb5QDgrW0m7F/O3GTogiUKOijZHOePqUuNK+2fEOjy3SvA/kA471
    7qE9m7jNKA4z+F3wW0tiQFB8whNpMRxEe22LNBt6rcDq4JXVLRJC7HAwPXN8EpYDPGyW
    7Bj++hieGlPS6zXRgG8SR5G2fnKE7U69szhN2GaNFsjuIbHikA00SnJ2H4ADXvUlTr+Z
    Q0yFjYotT/YlJXDfO2lkavL2j9mzvQw6CbxW3ilZIfTta+XKwA3kCulLV1RAtYdLz1QO
    s48Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZrWLJ"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1FHW0ZCQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 15 Feb 2023 18:32:00 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     riccardo Mottola <riccardo.mottola@libero.it>, paul@boddie.org.uk,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 2/3] MIPS: DTS: CI20: fixes for WiFi/Bluetooth
Date:   Wed, 15 Feb 2023 18:31:57 +0100
Message-Id: <142872751b252b6028ea574593d53110d6e0c4a5.1676482318.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1676482318.git.hns@goldelico.com>
References: <cover.1676482318.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CI20 has a BCM4330 based WiFi and Bluetooth module.

- add proper power supply regulators
- fix polarity of some GPIOs
- add a simple pwrseq node for WiFi
- reduce max-frequency for WiFi since 50 MHz seems not to work
- add fixed regulators to activate the BT_WAKE and WL_WAKE gpios
  before the chip is powered up.
  This can not be done by the driver since it is not loaded if
  compiled as kernel module before the WiFi/BT module responds.
- add clock chain from the external i2c rtc through the clk32k
  to the WiFi and Bluetooth module.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 77 ++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 8f21d2304737c..139507d8c26e3 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -97,13 +97,45 @@ ir: ir {
 		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
 	};
 
+	/* WORKAROUND: Keeping WLAN wake high before power on. No simple driver fix */
+	wlan0_wake: fixedregulator@4 {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan0_wake";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpd 9 GPIO_ACTIVE_HIGH>;/* WL_WAKE */
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	/* WORKAROUND: Keeping BT wake high before power on. No simple driver fix */
+	bt_wake: fixedregulator@7 {
+		compatible = "regulator-fixed";
+		regulator-name = "bt_wake";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpf 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	wlan0_pwrseq: wlan0_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpf 7 GPIO_ACTIVE_LOW>;
+		clocks = <&rtc_dev>;
+		clock-names = "clk32k";
+		post-power-on-delay-ms = <150>;
+	};
+
 	wlan0_power: fixedregulator@1 {
 		compatible = "regulator-fixed";
 
 		regulator-name = "wlan0_power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 
-		gpio = <&gpb 19 GPIO_ACTIVE_LOW>;
+		gpio = <&gpb 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		regulator-always-on;
 	};
 
 	otg_power: fixedregulator@2 {
@@ -159,6 +191,9 @@ &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pins_mmc0>;
 
+	vmmc-supply = <&vcc_33>;
+	vqmmc-supply = <&vcc_33>;	/* VDDIOMSC */
+
 	cd-gpios = <&gpf 20 GPIO_ACTIVE_LOW>;
 };
 
@@ -166,21 +201,34 @@ &mmc1 {
 	status = "okay";
 
 	bus-width = <4>;
-	max-frequency = <50000000>;
+	max-frequency = <25000000>;
 	non-removable;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&pins_mmc1>;
 
+	vmmc-supply = <&wlan0_power>;
+	vqmmc-supply = <&wlan0_io>;
+
+	mmc-pwrseq = <&wlan0_pwrseq>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	brcmf: wifi@1 {
-/*		reg = <4>;*/
+		reg = <1>;
 		compatible = "brcm,bcm4330-fmac";
 		vcc-supply = <&wlan0_power>;
-		device-wakeup-gpios = <&gpd 9 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpf 7 GPIO_ACTIVE_LOW>;
 	};
 };
 
+&rtc_dev {
+	clocks = <&ext_rtc 0>, <&ext_rtc 0>;
+	clock-names = "rtc", "clk32k";
+
+	system-power-controller;
+};
+
 &uart0 {
 	status = "okay";
 
@@ -204,11 +252,16 @@ &uart2 {
 
 	bluetooth {
 		compatible = "brcm,bcm4330-bt";
-		reset-gpios = <&gpf 8 GPIO_ACTIVE_HIGH>;
-		vcc-supply = <&wlan0_power>;
-		device-wakeup-gpios = <&gpf 5 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpf 6 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpf 4 GPIO_ACTIVE_LOW>;
+		vbat-supply = <&wlan0_power &bt_wake>;
+		vddio-supply = <&wlan0_power>;
+		max-speed = <115200>;	/* stay with default data rate */
+		brcm,bt-pcm-int-params = [01 02 00 01 01];
+		shutdown-gpios = <&gpf 4 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpf 8 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&gpf>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+		clocks = <&rtc_dev>;
+		clock-names = "clk32k";
 	};
 };
 
@@ -270,7 +323,7 @@ vcc_25: LDO_REG5 {
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
-			wifi_io: LDO_REG6 {
+			wlan0_io: LDO_REG6 {
 				regulator-name = "LDO_REG6";
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
@@ -344,7 +397,7 @@ &i2c4 {
 
 	clock-frequency = <400000>;
 
-		rtc@51 {
+		ext_rtc: rtc@51 {
 			compatible = "nxp,pcf8563";
 			reg = <0x51>;
 
-- 
2.38.1

