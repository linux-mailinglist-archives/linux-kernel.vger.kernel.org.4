Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECC65EDB8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjAENrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjAENrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69C3F10C;
        Thu,  5 Jan 2023 05:47:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B88EB81AD7;
        Thu,  5 Jan 2023 13:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E9FC433D2;
        Thu,  5 Jan 2023 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926431;
        bh=py+J7Io7igGLkvTKhQuQwnmjg68rvRYi5ZkHo5Gcwck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNR50j4X56it5NK2HPfvo4WLzgECROMps0deXNlkrJctv0s5PCTpf3eLmbIxtaTLD
         uloOhvOnkqHAAtK2sx4Rc8g6IOsyWVAi5XiOFF6neO9LqqAjZo92F0LGzbSufGRAqj
         nY5fQlP/u5WiEgo6iFTuU/4qnySn8q7Pf6x3doe0f4UKB2obKxXi25qk/tL1tf/NM4
         owV2kzbi9wlinVjGWF12sk8ZR8Gym5HyDNtHIe+nWQxhDxOKRFYF9cDoDuGfMhcrYZ
         MmDrTAU32HyQCUTT6b57KPnV62yiePUmdQbytuj7IK/gUJV6oMMLPMkOp4k+Sf18Uy
         RZ1wR4+XuCUHw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 11/27] input: remove pxa930_rotary keyboard driver
Date:   Thu,  5 Jan 2023 14:46:06 +0100
Message-Id: <20230105134622.254560-12-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The pxa930 platform is getting removed and no upstream machine
ever defined a rotary keyboard device.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/Kconfig                |   9 -
 drivers/input/keyboard/Makefile               |   1 -
 drivers/input/keyboard/pxa930_rotary.c        | 195 ------------------
 .../platform_data/keyboard-pxa930_rotary.h    |  21 --
 4 files changed, 226 deletions(-)
 delete mode 100644 drivers/input/keyboard/pxa930_rotary.c
 delete mode 100644 include/linux/platform_data/keyboard-pxa930_rotary.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 5d481847d718..d98650426dc2 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -550,15 +550,6 @@ config KEYBOARD_PXA27x
 	  To compile this driver as a module, choose M here: the
 	  module will be called pxa27x_keypad.
 
-config KEYBOARD_PXA930_ROTARY
-	tristate "PXA930/PXA935 Enhanced Rotary Controller Support"
-	depends on CPU_PXA930 || CPU_PXA935
-	help
-	  Enable support for PXA930/PXA935 Enhanced Rotary Controller.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called pxa930_rotary.
-
 config KEYBOARD_PMIC8XXX
 	tristate "Qualcomm PMIC8XXX keypad support"
 	depends on MFD_PM8XXX
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 5ccfdf5c0222..aecef00c5d09 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
 obj-$(CONFIG_KEYBOARD_PINEPHONE)	+= pinephone-keyboard.o
 obj-$(CONFIG_KEYBOARD_PMIC8XXX)		+= pmic8xxx-keypad.o
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
-obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
 obj-$(CONFIG_KEYBOARD_QT1050)           += qt1050.o
 obj-$(CONFIG_KEYBOARD_QT1070)           += qt1070.o
 obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
deleted file mode 100644
index 2fe9dcfe0a6f..000000000000
diff --git a/include/linux/platform_data/keyboard-pxa930_rotary.h b/include/linux/platform_data/keyboard-pxa930_rotary.h
deleted file mode 100644
index 3271aa01cbe8..000000000000
-- 
2.39.0

