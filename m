Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E365EDBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjAENsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjAENra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04E392DE;
        Thu,  5 Jan 2023 05:47:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7CF6B81AE6;
        Thu,  5 Jan 2023 13:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F52EC433F0;
        Thu,  5 Jan 2023 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926447;
        bh=ersO1VXXlu3ws/sJ8m/B71Z2PrStTpAMrvLMqntlN9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IK+36d/kRwJ3aZTNO18hBxJrEVM2hrs/c7qEUX0DXgR282A+y4QoY7/qf4rBjjDR2
         SYQxJgcnTSqfUMu7NDmFPz1056m/L1oCy9u8UmfsVSQF+rsVlNNJGZvb1XYgBWl2SY
         Dt9/IDSOajFuu9+VbQ4NjRUKKrUxattoZnD97ThBnI8CIyDJP+HT6SUULW9wxQPthA
         OJ7fFf8ge2KDWTYZygnzfkwZK5BkIMYg+lHgzm8hl4RmnijCgBwpXjQSo/UC7H7nUs
         aS4Rd7HMKSfPs7oilNGoLprbtHsT1O/pHEOPNZhCfrLQwlD5ZOy2SP7cUAty4tWi8X
         Xa50CLLeYpxKQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH 17/27] rtc: remove v3020 driver
Date:   Thu,  5 Jan 2023 14:46:12 +0100
Message-Id: <20230105134622.254560-18-arnd@kernel.org>
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

The v3020 RTC driver was exclusively used by the now removed
cm-x300.c machine.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/Kconfig                     |   9 -
 drivers/rtc/Makefile                    |   1 -
 drivers/rtc/rtc-v3020.c                 | 369 ------------------------
 include/linux/platform_data/rtc-v3020.h |  41 ---
 4 files changed, 420 deletions(-)
 delete mode 100644 drivers/rtc/rtc-v3020.c
 delete mode 100644 include/linux/platform_data/rtc-v3020.h

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 530b4a94ed42..2ba72de0fa47 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1212,15 +1212,6 @@ config RTC_DRV_RP5C01
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rp5c01.
 
-config RTC_DRV_V3020
-	tristate "EM Microelectronic V3020"
-	help
-	  If you say yes here you will get support for the
-	  EM Microelectronic v3020 RTC chip.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called rtc-v3020.
-
 config RTC_DRV_GAMECUBE
 	tristate "Nintendo GameCube, Wii and Wii U RTC"
 	depends on GAMECUBE || WII || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index d3c042dcbc73..59eb30289335 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -176,7 +176,6 @@ obj-$(CONFIG_RTC_DRV_TI_K3)	+= rtc-ti-k3.o
 obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
 obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
 obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
-obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
 obj-$(CONFIG_RTC_DRV_VT8500)	+= rtc-vt8500.o
 obj-$(CONFIG_RTC_DRV_WILCO_EC)	+= rtc-wilco-ec.o
 obj-$(CONFIG_RTC_DRV_WM831X)	+= rtc-wm831x.o
diff --git a/drivers/rtc/rtc-v3020.c b/drivers/rtc/rtc-v3020.c
deleted file mode 100644
index 4e8341c49f51..000000000000
diff --git a/include/linux/platform_data/rtc-v3020.h b/include/linux/platform_data/rtc-v3020.h
deleted file mode 100644
index e55d82cebf80..000000000000
-- 
2.39.0

