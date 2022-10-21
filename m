Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52379608054
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJUUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJUUwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:52:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F7724E3BB;
        Fri, 21 Oct 2022 13:52:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7901B82A2F;
        Fri, 21 Oct 2022 20:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1089AC433C1;
        Fri, 21 Oct 2022 20:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385563;
        bh=8eCH9atahvEr0WXs+pF71eF7mEyYYY9L5s/MdlDrKY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5moiIRXL4PgFGqTLnevZBOQsmhfzY6qk4CeHLVqKm0mMfL33kMdbUfF70pB9oVTL
         U97jOwM14auU5ew4nH6XmkN4xuZ3GW5R1Gb5K1GCATrI9ekKNWu6T9ifVFss5uB0X5
         sx8+/JWqFKVBzWCc8tmcZYh3pj3zQxCKj/1jsSeUp7cJ3U9Y7LQisakMm0MCKFoX41
         5DBlOyjmyRJhq1YBHEtZO0kEuQM3AAfSeZqb5fHQCqznWN9TsgxKCj2955nxwD+vIC
         4FUnjnjLGcAQ+I1fp+ivFzo1bDYcciAgJU86ZNHJg4T/ExbcNs4M4CYh2tJzHI8dab
         RWJ7WM2slNstQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 19/21] spi: remove s3c24xx driver
Date:   Fri, 21 Oct 2022 22:27:52 +0200
Message-Id: <20221021203329.4143397-19-arnd@kernel.org>
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

The s3c24xx platform was removed,s o there are no remaining users
for its spi driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                     |   1 -
 drivers/spi/Kconfig             |  18 -
 drivers/spi/Makefile            |   2 -
 drivers/spi/spi-s3c24xx-regs.h  |  41 ---
 drivers/spi/spi-s3c24xx.c       | 596 --------------------------------
 include/linux/spi/s3c24xx-fiq.h |  33 --
 include/linux/spi/s3c24xx.h     |  20 --
 7 files changed, 711 deletions(-)
 delete mode 100644 drivers/spi/spi-s3c24xx-regs.h
 delete mode 100644 drivers/spi/spi-s3c24xx.c
 delete mode 100644 include/linux/spi/s3c24xx-fiq.h
 delete mode 100644 include/linux/spi/s3c24xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index caf196041e3a..331301006f93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18088,7 +18088,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/samsung,spi*.yaml
 F:	drivers/spi/spi-s3c*
 F:	include/linux/platform_data/spi-s3c64xx.h
-F:	include/linux/spi/s3c24xx-fiq.h
 
 SAMSUNG SXGBE DRIVERS
 M:	Byungho An <bh74.an@samsung.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bf0dc704abbe..5992b5db8d76 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -818,24 +818,6 @@ config SPI_QCOM_GENI
 	  This driver can also be built as a module.  If so, the module
 	  will be called spi-geni-qcom.
 
-config SPI_S3C24XX
-	tristate "Samsung S3C24XX series SPI"
-	depends on ARCH_S3C24XX
-	select SPI_BITBANG
-	help
-	  SPI driver for Samsung S3C24XX series ARM SoCs
-
-config SPI_S3C24XX_FIQ
-	bool "S3C24XX driver with FIQ pseudo-DMA"
-	depends on SPI_S3C24XX
-	select FIQ
-	help
-	  Enable FIQ support for the S3C24XX SPI driver to provide pseudo
-	  DMA by using the fast-interrupt request framework, This allows
-	  the driver to get DMA-like performance when there are either
-	  no free DMA channels, or when doing transfers that required both
-	  TX and RX data paths.
-
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX/Exynos SoC series type SPI"
 	depends on (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index ae5ba0109d4b..4cd32f76402c 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -109,8 +109,6 @@ obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= spi-realtek-rtl.o
 obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
-obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
-spi-s3c24xx-hw-y			:= spi-s3c24xx.o
 obj-$(CONFIG_SPI_S3C64XX)		+= spi-s3c64xx.o
 obj-$(CONFIG_SPI_SC18IS602)		+= spi-sc18is602.o
 obj-$(CONFIG_SPI_SH)			+= spi-sh.o
diff --git a/drivers/spi/spi-s3c24xx-regs.h b/drivers/spi/spi-s3c24xx-regs.h
deleted file mode 100644
index f51464ab5677..000000000000
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
deleted file mode 100644
index ef25b5e93900..000000000000
diff --git a/include/linux/spi/s3c24xx-fiq.h b/include/linux/spi/s3c24xx-fiq.h
deleted file mode 100644
index d2842ac1de27..000000000000
diff --git a/include/linux/spi/s3c24xx.h b/include/linux/spi/s3c24xx.h
deleted file mode 100644
index 9b8bb22d5b0c..000000000000
-- 
2.29.2

