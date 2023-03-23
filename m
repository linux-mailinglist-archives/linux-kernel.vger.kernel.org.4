Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8071A6C7095
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCWS4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:56:05 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1D12B609;
        Thu, 23 Mar 2023 11:56:01 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 9C1825FD09;
        Thu, 23 Mar 2023 21:55:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679597759;
        bh=ed9AeSLzPB6ZrfljopDiIm60hYwrFfEp8kaOKxNGdNU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=rgtT4PGb3ikHO1fOwokuFMAglPXKKSFeslNFC54blWwHc2meiZCC7EOwOyR85R1/1
         OnJSfffzOA3lze++dGtwxh/3CWDHqKqB2kyJOnCJe2bxupQmn/fSJTqSd3UE0o4681
         mlCqC6ZcAa3nLrE819pVerDJfe03YsWl4g3TQVc+B2zYhVKcwK3U6nHjIFEdlPAoZG
         YBRrDbNlnq2kG7ARS4boObxNsiWd/keQWmbv0QS9T9122Xj5HpHKB+joiQ+ktQsRuJ
         rdDGl2oYoZXn3YjgG2RsiqRMM1DoCRbEhbB+WRfczmiPa7/vqI4flQSkzmTMWH2pCo
         xHmnZLJLLfLow==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 23 Mar 2023 21:55:58 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <jianxin.pan@amlogic.com>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <rockosov@gmail.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1] arm64: dts: meson: a1: place pwrc and secure-monitor under /firmware
Date:   Thu, 23 Mar 2023 21:55:48 +0300
Message-ID: <20230323185548.13731-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/23 12:44:00 #20998559
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, meson power secure controller was a child of secure monitor node.
But secure monitor isn't the bus in terms of device tree subsystem, so
of_platform initialization code doesn't populate its children
(of_platform_default_populate() API).

Therefore in the current device tree meson power secure controller isn't
probed at all.

If we place meson power secure controller and secure monitor nodes under
'/firmware', they will be populated automatically from of_platform
initialization.

Fixes: 04dd0b6584cd ("arm64: dts: meson: a1: add secure power domain controller")
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 77023a29b6e7..44c651254dc5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -72,8 +72,10 @@ linux,cma {
 		};
 	};
 
-	sm: secure-monitor {
-		compatible = "amlogic,meson-gxbb-sm";
+	firmware {
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+		};
 
 		pwrc: power-controller {
 			compatible = "amlogic,meson-a1-pwrc";
-- 
2.36.0

