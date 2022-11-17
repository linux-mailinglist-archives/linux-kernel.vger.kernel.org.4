Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A800F62D886
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiKQKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiKQKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:53:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB62418B1E;
        Thu, 17 Nov 2022 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668682385; x=1700218385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PTd3Xp7lnmGYxmQRmdmHm6G+V0PfC+jWfJFuvF44HB8=;
  b=DT/s+jRTftfi9Bdcsv/fhjNmRmpTxkSwR2lFG2505M4h3dyNYvUZjqY8
   wsCmGonx25ady+M7bsp7w5qwpMQ7X85CY2IOp4XIuMWCGVStt+DZ8+Mbk
   NdTkYvZ3Dx0TOd6FNwPGhLzIK7JnBFbK9X/KXb+1uzZazGzHtL6mGOV5y
   QBF46kbPBy4jQwNyXHIAcrqNXsnZBfeywi+kYwNRXF6dk+BivCccmE3S6
   Ktxa28pOGLHlIB9PP3yoFFUlgAyvyXavytQtsK6tKOrYZgWI+Xes6JUpn
   CgXYl+iyknQ7F3InUnE8tmGJYu+cczv7JbMT/Y9R/1HPBtwlild7xSroa
   w==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="183965621"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 03:53:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 03:53:02 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 03:52:59 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 3/8] spi: Reintroduce spi_set_cs_timing()
Date:   Thu, 17 Nov 2022 12:52:44 +0200
Message-ID: <20221117105249.115649-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117105249.115649-1-tudor.ambarus@microchip.com>
References: <20221117105249.115649-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4ccf359849ce ("spi: remove spi_set_cs_timing()"), removed the
method as noboby used it. Nobody used it probably because some SPI
controllers use some default large cs-setup time that covers the usual
cs-setup time required by the spi devices. There are though SPI controllers
that have a smaller granularity for the cs-setup time and their default
value can't fulfill the spi device requirements. That's the case for the
at91 QSPI IPs where the default cs-setup time is half of the QSPI clock
period. This was observed when using an sst26vf064b SPI NOR flash which
needs a spi-cs-setup-ns = <7>; in order to be operated close to its maximum
104 MHz frequency.

Call spi_set_cs_timing() in spi_setup() just before calling spi_set_cs(),
as the latter needs the CS timings already set.
If spi->controller->set_cs_timing is not set, the method will return 0.
There's no functional impact expected for the existing drivers. Even if the
spi-mt65xx.c and spi-tegra114.c drivers set the set_cs_timing method,
there's no user for them as of now. The only tested user of this support
will be a SPI NOR flash that comunicates with the Atmel QSPI controller for
which the support follows in the next patches.

One will notice that this support is a bit different from the one that was
removed in commit 4ccf359849ce ("spi: remove spi_set_cs_timing()"),
because this patch adapts to the changes done after the removal: the move
of the cs delays to the spi device, the retirement of the lelgacy GPIO
handling. The mutex handling was removed from spi_set_cs_timing() because
we now always call spi_set_cs_timing() in spi_setup(), which already
handles the spi->controller->io_mutex, so use the mutex handling from
spi_setup().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b93a6085d9a0..3cc7bb4d03de 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3621,6 +3621,37 @@ static int __spi_validate_bits_per_word(struct spi_controller *ctlr,
 	return 0;
 }
 
+/**
+ * spi_set_cs_timing - configure CS setup, hold, and inactive delays
+ * @spi: the device that requires specific CS timing configuration
+ *
+ * Return: zero on success, else a negative error code.
+ */
+static int spi_set_cs_timing(struct spi_device *spi)
+{
+	struct device *parent = spi->controller->dev.parent;
+	int status = 0;
+
+	if (spi->controller->set_cs_timing && !spi->cs_gpiod) {
+		if (spi->controller->auto_runtime_pm) {
+			status = pm_runtime_get_sync(parent);
+			if (status < 0) {
+				pm_runtime_put_noidle(parent);
+				dev_err(&spi->controller->dev, "Failed to power device: %d\n",
+					status);
+				return status;
+			}
+
+			status = spi->controller->set_cs_timing(spi);
+			pm_runtime_mark_last_busy(parent);
+			pm_runtime_put_autosuspend(parent);
+		} else {
+			status = spi->controller->set_cs_timing(spi);
+		}
+	}
+	return status;
+}
+
 /**
  * spi_setup - setup SPI mode and clock rate
  * @spi: the device whose settings are being modified
@@ -3717,6 +3748,12 @@ int spi_setup(struct spi_device *spi)
 		}
 	}
 
+	status = spi_set_cs_timing(spi);
+	if (status) {
+		mutex_unlock(&spi->controller->io_mutex);
+		return status;
+	}
+
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
 		status = pm_runtime_resume_and_get(spi->controller->dev.parent);
 		if (status < 0) {
-- 
2.25.1

