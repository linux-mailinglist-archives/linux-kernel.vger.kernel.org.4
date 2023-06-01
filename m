Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB487192B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjFAFt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjFAFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:48:29 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE151707;
        Wed, 31 May 2023 22:47:18 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id E0DF446CCD;
        Thu,  1 Jun 2023 08:46:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-vdzO11An;
        Thu, 01 Jun 2023 08:46:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598401;
        bh=x9FOqoVdtIK6AvjUk/vZreQ0aPbCN0QKaGLmIFcDMG0=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ceW5BAfp7bZQZhhD9v8TtpXf4C1bHNhnLN6IffLMR5AkhohSctwWssM2PckFcT+xG
         IYeEz1+zxkhgRu8fLK2cgtfsxJWoAINS4gyrA061ItvE2IlFlEf7uu3iy05TdcRAEg
         0Im3hBI7uAamqtcdJQuIyQMv2lN5wV0V0i6Qh0hc=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 41/43] ARM: dts: ep93xx: Add I2S and AC97 nodes
Date:   Thu,  1 Jun 2023 08:45:46 +0300
Message-Id: <20230601054549.10843-23-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Add the audio interfaces present in EP93xx SoCs.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/boot/dts/ep93xx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/ep93xx.dtsi b/arch/arm/boot/dts/ep93xx.dtsi
index 6da556ceaf04..c8028534dda7 100644
--- a/arch/arm/boot/dts/ep93xx.dtsi
+++ b/arch/arm/boot/dts/ep93xx.dtsi
@@ -301,6 +301,17 @@ ide: ide@800a0000 {
 			pinctrl-0 = <&ide_default_pins>;
 		};
 
+		ac97: ac97@80880000 {
+			compatible = "cirrus,ep9301-ac97";
+			#sound-dai-cells = <0>;
+			reg = <0x80880000 0xac>;
+			interrupt-parent = <&vic0>;
+			interrupts = <6>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ac97_default_pins>;
+			status = "disabled";
+		};
+
 		uart0: uart@808c0000 {
 			compatible = "arm,primecell";
 			reg = <0x808c0000 0x1000>;
-- 
2.37.4

