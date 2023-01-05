Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE565EDC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjAENsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjAENrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C73D9DF;
        Thu,  5 Jan 2023 05:47:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 812EFB81ADD;
        Thu,  5 Jan 2023 13:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FD3C433EF;
        Thu,  5 Jan 2023 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926421;
        bh=dEuDRHQ7Sm3N5Gxt4MXi3ZvxmHYSAXFo1vd8BJvQn2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OchErH5pzoqwPQBxaeD1KmpvM0Qf2mQyORTo8uiK9ZSVEqrBoYdnvxeA9fgltxI2w
         K+lt7wSpOAQhtFngzLS1YPMeDa7u8YyYfUQzWhLEXx//v+NcMwVVGMZ14j5B4yYwtc
         Gz2llC+hREtLN7T2j8TJhoapsu4Tvl9H9Ea4U+iywIe1WfdqiSsa91X/PN/QU6vkOj
         vpceBO4bgkeM8GC/d+9oF8hnTDs4VEmb/5XPegk8IVnpcFPmYY/oaZHAn80aeJ5bzl
         P3e/3RKK1j7yO5jllOrMfT/qGfdO1mmg+SQO7/JuMeTPBucaMAGW81RqdaLxPIKrsw
         0Y6heMtAHqsQg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 07/27] power: remove tosa_battery driver
Date:   Thu,  5 Jan 2023 14:46:02 +0100
Message-Id: <20230105134622.254560-8-arnd@kernel.org>
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

The PXA tosa machine is removed, so this driver is no longer
in use.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/Kconfig        |   7 -
 drivers/power/supply/Makefile       |   1 -
 drivers/power/supply/tosa_battery.c | 512 ----------------------------
 3 files changed, 520 deletions(-)
 delete mode 100644 drivers/power/supply/tosa_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index b7fdcfd5d4e7..3c37f3a6431c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -195,13 +195,6 @@ config BATTERY_SAMSUNG_SDI
 	  Say Y to enable support for Samsung SDI battery data.
 	  These batteries are used in Samsung mobile phones.
 
-config BATTERY_TOSA
-	tristate "Sharp SL-6000 (tosa) battery"
-	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
-	help
-	  Say Y to enable support for the battery on the Sharp Zaurus
-	  SL-6000 (tosa) models.
-
 config BATTERY_COLLIE
 	tristate "Sharp SL-5500 (collie) battery"
 	depends on SA1100_COLLIE && MCP_UCB1200
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 38737ea9b9d5..55c1aae91d1d 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+= samsung-sdi-battery.o
-obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
 obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
 obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
 obj-$(CONFIG_BATTERY_IPAQ_MICRO) += ipaq_micro_battery.o
diff --git a/drivers/power/supply/tosa_battery.c b/drivers/power/supply/tosa_battery.c
deleted file mode 100644
index 73d4aca4c386..000000000000
-- 
2.39.0

