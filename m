Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAF65EDDE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjAENvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjAENua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:50:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44642633A5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:48:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C94F861A97
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B0FC433F1;
        Thu,  5 Jan 2023 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926474;
        bh=QBATBldnH97j5a6wP3U8v0ZSqqSKFF/ptzvMtMvWpXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvnVDZ2vUQM0fzq9itEWzBKAhHayYLScwyZdwppqa16XKQcyNHgYqWfR/RXQ6V+ED
         wg/S26ahAb0oSb9cgC51u2xkAKAmaam6yIahXRISXtILLQAo1MWg4uQG+fk4h0Mi9m
         9CIMyvGlbY3dlzvKMqTIaD0NM0cQoyeq8weFcFRTyTvc2w6qCqSnbKMz9sHHgBMGCo
         yfJr5ZdOCIQmNaczYJGMaOcSr/sh5fwcDWbusTVKZniMnOTgtS7IVmJLJ0DqROys+w
         UKtyUHzuh8yYXorHO1hHCFLcEBsxEaC9EEzzyldSnGqbYI2smDTlvQvPl0rihRDSKl
         fERV8ww6lKz/Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 27/27] mfd: remove htc-pasic3 driver
Date:   Thu,  5 Jan 2023 14:46:22 +0100
Message-Id: <20230105134622.254560-28-arnd@kernel.org>
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

The htc-pasic3 MFD device was only used in the PXA magician
machine that is now removed, so this can be recycled as well.

Cc: Lee Jones <lee@kernel.org>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig            |   9 --
 drivers/mfd/Makefile           |   2 -
 drivers/mfd/htc-pasic3.c       | 210 ---------------------------------
 include/linux/mfd/htc-pasic3.h |  54 ---------
 4 files changed, 275 deletions(-)
 delete mode 100644 drivers/mfd/htc-pasic3.c
 delete mode 100644 include/linux/mfd/htc-pasic3.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5ea07a65f150..5c24841e5699 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -541,15 +541,6 @@ config MFD_HI655X_PMIC
 	help
 	  Select this option to enable Hisilicon hi655x series pmic driver.
 
-config HTC_PASIC3
-	tristate "HTC PASIC3 LED/DS1WM chip support"
-	select MFD_CORE
-	help
-	  This core driver provides register access for the LED/DS1WM
-	  chips labeled "AIC2" and "AIC3", found on HTC Blueangel and
-	  HTC Magician devices, respectively. Actual functionality is
-	  handled by the leds-pasic3 and ds1wm drivers.
-
 config MFD_INTEL_QUARK_I2C_GPIO
 	tristate "Intel Quark MFD I2C GPIO"
 	depends on PCI
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4969ea6e24f1..09712495f4f4 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -17,8 +17,6 @@ obj-$(CONFIG_MFD_ENE_KB3930)	+= ene-kb3930.o
 obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
 
-obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
-
 obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
 obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
deleted file mode 100644
index 0c46b7e64b2d..000000000000
diff --git a/include/linux/mfd/htc-pasic3.h b/include/linux/mfd/htc-pasic3.h
deleted file mode 100644
index 3d3ed67bd969..000000000000
-- 
2.39.0

