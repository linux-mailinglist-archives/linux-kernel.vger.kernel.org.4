Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9765EE70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjAEOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjAENt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:49:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356B4EC8A;
        Thu,  5 Jan 2023 05:47:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB9A0B81AE4;
        Thu,  5 Jan 2023 13:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6BBC433D2;
        Thu,  5 Jan 2023 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926459;
        bh=0C2s8Htv8j/a9ZgxMURdUzKBZYXWV4XjhbJ2Xum7PQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCVjnh5Np8xRhW7xrU3mVDHXFFRFK058PFVL+U8xsvba7kysjoSsO3PUkwWSRNSn+
         opIXXvDuuvK5nCAKRfjJrKhzmp0yHDxRZIkspXbwxrfnC64lfDD+iDMG+ZImTv/Kcl
         HGvtsbJKaUGYSoY06qI02gaptaI+iP3wYqvocYBkq1puT+uYaQ+v+YUcYlOveQ5Xzi
         g+/H+iiLJIXDhk+3yPPfXBAQfPAq2iOLK2SQBEGJhYxz0GNDl6rAZlJoMwHMtZ++4q
         gxOShUc2KeTcOh8FvoEJdmlFaoTfn0PvMrGgz+g39JZEqOn7iYLiMqc9DUd2p7Au64
         QuptAdBYvDekg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ian Molton <spyro@f2s.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 21/27] mmc: remove tmio_mmc driver
Date:   Thu,  5 Jan 2023 14:46:16 +0100
Message-Id: <20230105134622.254560-22-arnd@kernel.org>
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

With the TMIO MFD support gone, the corresponding MMC host driver can
be removed as well. The remaining tmio_mmc_core module however is still
used by both the Renesas and Socionext host drivers.

Cc: Ian Molton <spyro@f2s.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig    |   8 --
 drivers/mmc/host/Makefile   |   1 -
 drivers/mmc/host/tmio_mmc.c | 227 ------------------------------------
 3 files changed, 236 deletions(-)
 delete mode 100644 drivers/mmc/host/tmio_mmc.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f0456ad4b597..e1b88b51cc80 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -655,14 +655,6 @@ config MMC_SDHCI_SPRD
 config MMC_TMIO_CORE
 	tristate
 
-config MMC_TMIO
-	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3 || COMPILE_TEST
-	select MMC_TMIO_CORE
-	help
-	  This provides support for the SD/MMC cell found in TC6393XB,
-	  T7L66XB and also HTC ASIC3
-
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 063d87764966..b498c17cd124 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
 obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
 obj-$(CONFIG_MMC_SPI)		+= of_mmc_spi.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
-obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o
 obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+= renesas_sdhi_sys_dmac.o
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
deleted file mode 100644
index 53a2ad9a24b8..000000000000
-- 
2.39.0

