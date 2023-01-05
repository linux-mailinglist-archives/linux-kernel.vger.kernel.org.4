Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F1F65EDA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjAENrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjAENrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57AC392DE;
        Thu,  5 Jan 2023 05:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D6E61A8E;
        Thu,  5 Jan 2023 13:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5215C433F0;
        Thu,  5 Jan 2023 13:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926418;
        bh=e0rh5Q1bzQ8kguah32CkujzsiMLyOjXpRZxvgw1rRWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0tYaLv60QsWy4N9wnWs0/+eaczcOajHC71ZYibLcn7TND7gAHGOU5jtuozHMp0DQ
         3XJaPZVrv+BtsooQmaasqyyqZ4s2OO3ckd7LvzQlVmZYeHalgJtxgMrP7TXJgYhPqI
         EcZrAYQyZGnLN2T3oPsD3MUrlidyqkmck6KgeMsXuNZhFrD1rEi1io9yqC6AccrEaQ
         udyiBnuK1oFmgEQxzYl7zeHNZ0Jel54gC1eJxB6ACi9Dyd8tsm3euZUzRtnYAE7Pgz
         iBg3sJfeKAN97o5LCWc0jQEvIbPvPz6ghf9PEoDRAHAAlyhvWU6nUXuOnhkg0uPNjm
         wft5EvutZxUfQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        Peter Edwards <sweetlilmre@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 06/27] power: remove z2_battery driver
Date:   Thu,  5 Jan 2023 14:46:01 +0100
Message-Id: <20230105134622.254560-7-arnd@kernel.org>
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

The PXA z2 platform is gone, and this driver is now orphaned.

Cc: linux-pm@vger.kernel.org
Cc: Peter Edwards <sweetlilmre@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/Kconfig      |   6 -
 drivers/power/supply/Makefile     |   1 -
 drivers/power/supply/z2_battery.c | 318 ------------------------------
 include/linux/z2_battery.h        |  17 --
 4 files changed, 342 deletions(-)
 delete mode 100644 drivers/power/supply/z2_battery.c
 delete mode 100644 include/linux/z2_battery.h

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 98d4e9364606..b7fdcfd5d4e7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -422,12 +422,6 @@ config BATTERY_MAX1721X
 	  Say Y here to enable support for the MAX17211/MAX17215 standalone
 	  battery gas-gauge.
 
-config BATTERY_Z2
-	tristate "Z2 battery driver"
-	depends on I2C && MACH_ZIPIT2
-	help
-	  Say Y to include support for the battery on the Zipit Z2.
-
 config BATTERY_TWL4030_MADC
 	tristate "TWL4030 MADC battery driver"
 	depends on TWL4030_MADC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 2fb02f19a9e0..38737ea9b9d5 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_BATTERY_DA9150)	+= da9150-fg.o
 obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
-obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
 obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
diff --git a/drivers/power/supply/z2_battery.c b/drivers/power/supply/z2_battery.c
deleted file mode 100644
index 0ba4a590a0a5..000000000000
diff --git a/include/linux/z2_battery.h b/include/linux/z2_battery.h
deleted file mode 100644
index 9e8be7a7cd25..000000000000
-- 
2.39.0

