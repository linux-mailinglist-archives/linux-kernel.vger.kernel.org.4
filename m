Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B8169F3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjBVLut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjBVLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:50:36 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CEC366A7;
        Wed, 22 Feb 2023 03:50:35 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 8A7665FD63;
        Wed, 22 Feb 2023 14:50:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677066633;
        bh=CsQGfUCkH2ZamwaiMkFtrGFlOwLHzQzG+8+VcxmQvAI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=caAUX07/ARkhhcAYGdi1TUU4bLJuMsAU0bp0VovhAsMfUHcFnog5xxbv5CHjytMf0
         9z/F9+WVgw0wbIAFv1Bl0AtUEiWg8XiyueXBrNwNiQr7XUMahjQG4eUnQAMyg4BuGD
         aNPT4m0MOD5DcOXnXDKATRtBTrtVtFu2J676ONOQHxPDysplknntSZPWbozWmt0mRh
         Zu0iZiOcu/itWhxh2nDu9bzDruMj9J+hKaFe/KA9M/yVbo8iWvG6H0796ao47zLMfY
         O2sQOS8D3cw/LpVWtMoMwg/N4rWP+yUqcZVUG8ugyAk/K1+hhkMT4xeQQy3ZUBHiGg
         UizC/hSUL4Yxw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Feb 2023 14:50:33 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 2/3] firmware: meson: use CONFIG_MESON_SM with CONFIG_ARM
Date:   Wed, 22 Feb 2023 14:50:19 +0300
Message-ID: <20230222115020.55867-3-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230222115020.55867-1-avromanov@sberdevices.ru>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/22 06:32:00 #20888384
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson SM driver has one strong disturbing requirement.
It's size of the memory page, it should be equal to 4K.
ARM 32-bit arch always uses 4K page and doesn't support
bigger sizes. So it's not a stop factor.

Anyway, meson sm driver was tested in the meson-a1 ARM
board and it works correctly.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/firmware/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
index f2fdd3756648..20303b7394fb 100644
--- a/drivers/firmware/meson/Kconfig
+++ b/drivers/firmware/meson/Kconfig
@@ -6,6 +6,6 @@ config MESON_SM
 	tristate "Amlogic Secure Monitor driver"
 	depends on ARCH_MESON || COMPILE_TEST
 	default y
-	depends on ARM64_4K_PAGES
+	depends on ARM || ARM64_4K_PAGES
 	help
 	  Say y here to enable the Amlogic secure monitor driver
-- 
2.38.1

