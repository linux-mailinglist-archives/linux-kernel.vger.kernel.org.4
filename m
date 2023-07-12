Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC006750C52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGLPVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjGLPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:21:46 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BBE1FC2;
        Wed, 12 Jul 2023 08:21:41 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9DD1386B27;
        Wed, 12 Jul 2023 17:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1689175299;
        bh=cpCAb67TfJ//ML5P+tOkTrQ9lar76jsEYptXnqk6V0I=;
        h=From:To:Cc:Subject:Date:From;
        b=OQ3hvu5aAGPEK+AMkE4JwmY4q2qu2XvHUStWPiLGQ01qmvNNXwjCx/FzogauFJU2N
         xu7NseIcT6e880HRwLLQ+2/ABarfQps4rUe2579i4zsq2a0iusmV5GHjQpK4347wns
         kyfgEl1U1yIbWJ5tGl5+qQFqlzMTammruo7v3GaUwsLmq7KCMXdPBaDJFhmSQKgujn
         7rLAmcIeJ0mfqL1D8msRnLkqUvCfDOhd/oYJjsQwYjjV1tMnsB0g4Do4Av/VpNTZTB
         CGQjXhC670Nc7jrLlPpr98AriyZZO5L8MRoqN7OePOA2ivfdxlSe5XntWkBi//u1M6
         Ko756q8shexlA==
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ARM: dts: at91: ksz9477_evb: Add missing timer nodes
Date:   Wed, 12 Jul 2023 17:21:11 +0200
Message-Id: <20230712152111.3756211-1-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change the KSZ9477-EVB board hangs just after passing
execution flow from u-boot to Linux kernel.

This code has been copied from at91-sama5d3_xplained.dts.

Test setup: Linux 6.5-rc1
Config:     arch/arm/configs/sama5_defconfig
Toolchain:  gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabi

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 .../boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
index 14af1fd6d247..99cd6d15998b 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts
@@ -162,6 +162,18 @@
 	};
 };
 
+&tcb0 {
+	timer0: timer@0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>;
+	};
+
+	timer1: timer@1 {
+		compatible = "atmel,tcb-timer";
+		reg = <1>;
+	};
+};
+
 &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usba_vbus>;
-- 
2.20.1

