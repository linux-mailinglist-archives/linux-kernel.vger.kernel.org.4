Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70DA608018
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJUUrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJUUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:46:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11BD2995C9;
        Fri, 21 Oct 2022 13:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A496FCE2BD4;
        Fri, 21 Oct 2022 20:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEA3C433D6;
        Fri, 21 Oct 2022 20:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385112;
        bh=tq2/NapKhyhj/nZ7UhIrjnv6uKjQg8q5BUCehbxRKV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SB3QFe5LK0b+E/lFpE+2wEY35sjtJodRiiuoDy9SLn5Cqeu0V/vx5oviEBkxpnoqP
         vvm12zSEEnmDRnYlw2pbjdkW6Gfx+FT75vQFcbslNL4I19GusCdiFRJMQRowqqGF5w
         /pn1S70gZTkepqPHjiaNIaB/RAFOgP8HuWbQqilStb3w6UUVAyaFtrYR504COnoE5Q
         Q8UACn9Mvil3BLSmCJZ3dnhqa4u64sVt4Yh1rQDqSgWrYKip3Geqd/G2OnUgME95AR
         qdcQ0XADqEcloCkpN4EQ/KUo5+RC2XAGHOqMk6SO9LnEQuCmQSjy36QUy5rViHDuIn
         wsDWlpY+5/9+w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 10/21] mmc: remove s3cmci driver
Date:   Fri, 21 Oct 2022 22:27:43 +0200
Message-Id: <20221021203329.4143397-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The s3c24xx platform is gone, so this driver can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                              |    6 -
 drivers/mmc/host/Kconfig                 |   43 -
 drivers/mmc/host/Makefile                |    1 -
 drivers/mmc/host/s3cmci.c                | 1777 ----------------------
 drivers/mmc/host/s3cmci.h                |   75 -
 include/linux/platform_data/mmc-s3cmci.h |   51 -
 6 files changed, 1953 deletions(-)
 delete mode 100644 drivers/mmc/host/s3cmci.c
 delete mode 100644 drivers/mmc/host/s3cmci.h
 delete mode 100644 include/linux/platform_data/mmc-s3cmci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2caf42b0328a..503ebd9800db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17920,12 +17920,6 @@ S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/scsi/zfcp_*
 
-S3C24XX SD/MMC Driver
-M:	Ben Dooks <ben-linux@fluff.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/mmc/host/s3cmci.*
-
 SAA6588 RDS RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 79d8ddf1f616..75e8c364243d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -619,49 +619,6 @@ config MMC_SPI
 
 	  If unsure, or if your system has no SPI master driver, say N.
 
-config MMC_S3C
-	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C24XX || COMPILE_TEST
-	depends on S3C24XX_DMAC || COMPILE_TEST
-	help
-	  This selects a driver for the MCI interface found in
-	  Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
-	  If you have a board based on one of those and a MMC/SD
-	  slot, say Y or M here.
-
-	  If unsure, say N.
-
-config MMC_S3C_HW_SDIO_IRQ
-	bool "Hardware support for SDIO IRQ"
-	depends on MMC_S3C
-	help
-	  Enable the hardware support for SDIO interrupts instead of using
-	  the generic polling code.
-
-choice
-	prompt "Samsung S3C SD/MMC transfer code"
-	depends on MMC_S3C
-
-config MMC_S3C_PIO
-	bool "Use PIO transfers only"
-	help
-	  Use PIO to transfer data between memory and the hardware.
-
-	  PIO is slower than DMA as it requires CPU instructions to
-	  move the data. This has been the traditional default for
-	  the S3C MCI driver.
-
-config MMC_S3C_DMA
-	bool "Use DMA transfers only"
-	help
-	  Use DMA to transfer data between memory and the hardware.
-
-	  Currently, the DMA support in this driver seems to not be
-	  working properly and needs to be debugged before this
-	  option is useful.
-
-endchoice
-
 config MMC_SDRICOH_CS
 	tristate "MMC/SD driver for Ricoh Bay1Controllers"
 	depends on PCI && PCMCIA
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 0baeb0b004f7..885e19e21e75 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -34,7 +34,6 @@ obj-$(CONFIG_MMC_MVSDIO)	+= mvsdio.o
 obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
 obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
 obj-$(CONFIG_MMC_SPI)		+= of_mmc_spi.o
-obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
deleted file mode 100644
index 8d5929a32d34..000000000000
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
deleted file mode 100644
index 8b65d7ad9f97..000000000000
diff --git a/include/linux/platform_data/mmc-s3cmci.h b/include/linux/platform_data/mmc-s3cmci.h
deleted file mode 100644
index bacb86db3112..000000000000
-- 
2.29.2

