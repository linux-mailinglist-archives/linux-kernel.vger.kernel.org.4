Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5423665EDD9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjAENum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjAENto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:49:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E8A5E08C;
        Thu,  5 Jan 2023 05:47:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B670161A7F;
        Thu,  5 Jan 2023 13:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5112C433F1;
        Thu,  5 Jan 2023 13:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926467;
        bh=4+rvH120BWpGoGjg3AEEzrUBIcxOEWqmOQBFI731bX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxHrsghkOYPO7e6eh6XFmq1/IOZqKAgjuX1UEwB89y0ZM6Wv8IMmrNZPbA8lnpQOk
         fuoJ0p1C09jXJ6+6Qn5EQ8VitAhQr+NtiQKwzMNf2kr5SRDMiYlWZpJBva8jVdHetV
         B6z13E94vc2kV5mMkx2S/HbXHMu2g0Sawn1KOO+T4rEuuhTpICC0bEp4JkZuYbKwSD
         VJhxdFN1Ninhe26fadcorrI7AfVJpmP0rwsmD0bArxsH+h950L5l9yr3b1Z/8/YnG1
         TbAGpRiYsIlEaAlW/6tM/SvYDd9YMbqkl/6kcJfNaYia7peKGUnZQGLgTZ6ChvvfuN
         BWdRBqphYG9tg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Parsons <lost.distance@yahoo.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org
Subject: [PATCH 24/27] leds: remove asic3 driver
Date:   Thu,  5 Jan 2023 14:46:19 +0100
Message-Id: <20230105134622.254560-25-arnd@kernel.org>
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

Since ASIC3 MFD driver is removed, the LED support is also
obsolete.

Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/Kconfig      |  11 ---
 drivers/leds/Makefile     |   1 -
 drivers/leds/leds-asic3.c | 177 --------------------------------------
 3 files changed, 189 deletions(-)
 delete mode 100644 drivers/leds/leds-asic3.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index be2eeb3d6fd3..9dbce09eabac 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -623,17 +623,6 @@ config LEDS_NETXBIG
 	  and 5Big Network v2 boards. The LEDs are wired to a CPLD and are
 	  controlled through a GPIO extension bus.
 
-config LEDS_ASIC3
-	bool "LED support for the HTC ASIC3"
-	depends on LEDS_CLASS=y
-	depends on MFD_ASIC3
-	default y
-	help
-	  This option enables support for the LEDs on the HTC ASIC3. The HTC
-	  ASIC3 LED GPIOs are inputs, not outputs, thus the leds-gpio driver
-	  cannot be used. This driver supports hardware blinking with an on+off
-	  period from 62ms to 125s. Say Y to enable LEDs on the HP iPAQ hx4700.
-
 config LEDS_TCA6507
 	tristate "LED Support for TCA6507 I2C chip"
 	depends on LEDS_CLASS && I2C
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index a790c967fce9..d30395d11fd8 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
-obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
diff --git a/drivers/leds/leds-asic3.c b/drivers/leds/leds-asic3.c
deleted file mode 100644
index 8cbc1b8bafa5..000000000000
-- 
2.39.0

