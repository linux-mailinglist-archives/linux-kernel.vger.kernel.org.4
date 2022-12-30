Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F5C65694C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiL0KHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiL0KHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:07:35 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF564C6;
        Tue, 27 Dec 2022 02:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=MFUNeq3Y8GcJH9bDlEKq9WaByHZjyHz4SS+VcCmqW98=;
        b=DwOqS6xJqzsDKlj06s4oDcoY5JpfLV/4xQUecvmQZj1SLnGj9Dfft/JX5LUOxlpceZf5Gzp9a3ljt
         qZS7MHun1CQCaF0wNdsLo1zn/t88Jm3RzaiH/fGNl1OH6uKIBzXrRbsq+n/3C4jkrcBjHfs+e35iFp
         c7+OpMKWew5SLK9jct/UqG0ViHedCB4BiYY7vyqzOcTSDbilJrIAlVQUHDGc7nMEd3MC1KKBoCu3U1
         dU5B9HmAsm6WSLN8tdBgVtNNBS2mIYX+Gtn9uQUwofXF5XAPC8DCrxkSafNGMD6P+cT7D6PSCtEvhd
         1Y4cdlzplx1aub2SBhKmVVi0ck6rZdA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000012,0.032822)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.099154), Hit: No, Details: v2.42.0; Id: 15.52ka2n.1gl9gpper.3mu; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 27 Dec 2022 13:07:09 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v3 1/3] fpga: microchip-spi: move SPI I/O buffers out of stack
Date:   Tue, 27 Dec 2022 13:04:48 +0300
Message-Id: <20221227100450.2257-2-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
References: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As spi-summary doc says:
 > I/O buffers use the usual Linux rules, and must be DMA-safe.
 > You'd normally allocate them from the heap or free page pool.
 > Don't use the stack, or anything that's declared "static".

Replace spi_write() with spi_write_then_read(), which is dma-safe for
on-stack buffers. Use allocated buffers for transfers used in
spi_sync_transfer().

Although everything works OK with stack-located I/O buffers, better
follow the doc to be safe.

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/microchip-spi.c | 93 ++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 7436976ea904..e72fedd93a27 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -42,46 +42,55 @@
 struct mpf_priv {
 	struct spi_device *spi;
 	bool program_mode;
+	u8 tx __aligned(ARCH_KMALLOC_MINALIGN);
+	u8 rx __aligned(ARCH_KMALLOC_MINALIGN);
 };
 
-static int mpf_read_status(struct spi_device *spi)
+static int mpf_read_status(struct mpf_priv *priv)
 {
-	u8 status = 0, status_command = MPF_SPI_READ_STATUS;
-	struct spi_transfer xfers[2] = { 0 };
-	int ret;
-
 	/*
 	 * HW status is returned on MISO in the first byte after CS went
 	 * active. However, first reading can be inadequate, so we submit
 	 * two identical SPI transfers and use result of the later one.
 	 */
-	xfers[0].tx_buf = &status_command;
-	xfers[1].tx_buf = &status_command;
-	xfers[0].rx_buf = &status;
-	xfers[1].rx_buf = &status;
-	xfers[0].len = 1;
-	xfers[1].len = 1;
-	xfers[0].cs_change = 1;
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = &priv->tx,
+			.rx_buf = &priv->rx,
+			.len = 1,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &priv->tx,
+			.rx_buf = &priv->rx,
+			.len = 1,
+		},
+	};
+	u8 status;
+	int ret;
+
+	priv->tx = MPF_SPI_READ_STATUS;
+
+	ret = spi_sync_transfer(priv->spi, xfers, 2);
+	if (ret)
+		return ret;
 
-	ret = spi_sync_transfer(spi, xfers, 2);
+	status = priv->rx;
 
 	if ((status & MPF_STATUS_SPI_VIOLATION) ||
 	    (status & MPF_STATUS_SPI_ERROR))
-		ret = -EIO;
+		return -EIO;
 
-	return ret ? : status;
+	return status;
 }
 
 static enum fpga_mgr_states mpf_ops_state(struct fpga_manager *mgr)
 {
 	struct mpf_priv *priv = mgr->priv;
-	struct spi_device *spi;
 	bool program_mode;
 	int status;
 
-	spi = priv->spi;
 	program_mode = priv->program_mode;
-	status = mpf_read_status(spi);
+	status = mpf_read_status(priv);
 
 	if (!program_mode && !status)
 		return FPGA_MGR_STATE_OPERATING;
@@ -186,12 +195,12 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 }
 
 /* Poll HW status until busy bit is cleared and mask bits are set. */
-static int mpf_poll_status(struct spi_device *spi, u8 mask)
+static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
 {
 	int status, retries = MPF_STATUS_POLL_RETRIES;
 
 	while (retries--) {
-		status = mpf_read_status(spi);
+		status = mpf_read_status(priv);
 		if (status < 0)
 			return status;
 
@@ -205,32 +214,32 @@ static int mpf_poll_status(struct spi_device *spi, u8 mask)
 	return -EBUSY;
 }
 
-static int mpf_spi_write(struct spi_device *spi, const void *buf, size_t buf_size)
+static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
 {
-	int status = mpf_poll_status(spi, 0);
+	int status = mpf_poll_status(priv, 0);
 
 	if (status < 0)
 		return status;
 
-	return spi_write(spi, buf, buf_size);
+	return spi_write_then_read(priv->spi, buf, buf_size, NULL, 0);
 }
 
-static int mpf_spi_write_then_read(struct spi_device *spi,
+static int mpf_spi_write_then_read(struct mpf_priv *priv,
 				   const void *txbuf, size_t txbuf_size,
 				   void *rxbuf, size_t rxbuf_size)
 {
 	const u8 read_command[] = { MPF_SPI_READ_DATA };
 	int ret;
 
-	ret = mpf_spi_write(spi, txbuf, txbuf_size);
+	ret = mpf_spi_write(priv, txbuf, txbuf_size);
 	if (ret)
 		return ret;
 
-	ret = mpf_poll_status(spi, MPF_STATUS_READY);
+	ret = mpf_poll_status(priv, MPF_STATUS_READY);
 	if (ret < 0)
 		return ret;
 
-	return spi_write_then_read(spi, read_command, sizeof(read_command),
+	return spi_write_then_read(priv->spi, read_command, sizeof(read_command),
 				   rxbuf, rxbuf_size);
 }
 
@@ -242,7 +251,6 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 	const u8 isc_en_command[] = { MPF_SPI_ISC_ENABLE };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
-	struct spi_device *spi;
 	u32 isc_ret = 0;
 	int ret;
 
@@ -251,9 +259,7 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 		return -EOPNOTSUPP;
 	}
 
-	spi = priv->spi;
-
-	ret = mpf_spi_write_then_read(spi, isc_en_command, sizeof(isc_en_command),
+	ret = mpf_spi_write_then_read(priv, isc_en_command, sizeof(isc_en_command),
 				      &isc_ret, sizeof(isc_ret));
 	if (ret || isc_ret) {
 		dev_err(dev, "Failed to enable ISC: spi_ret %d, isc_ret %u\n",
@@ -261,7 +267,7 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 		return -EFAULT;
 	}
 
-	ret = mpf_spi_write(spi, program_mode, sizeof(program_mode));
+	ret = mpf_spi_write(priv, program_mode, sizeof(program_mode));
 	if (ret) {
 		dev_err(dev, "Failed to enter program mode: %d\n", ret);
 		return ret;
@@ -274,11 +280,9 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 
 static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
 {
-	u8 spi_frame_command[] = { MPF_SPI_FRAME };
 	struct spi_transfer xfers[2] = { 0 };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
-	struct spi_device *spi;
 	int ret, i;
 
 	if (count % MPF_SPI_FRAME_SIZE) {
@@ -287,18 +291,18 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
 		return -EINVAL;
 	}
 
-	spi = priv->spi;
-
-	xfers[0].tx_buf = spi_frame_command;
-	xfers[0].len = sizeof(spi_frame_command);
+	xfers[0].tx_buf = &priv->tx;
+	xfers[0].len = 1;
 
 	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
 		xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
 		xfers[1].len = MPF_SPI_FRAME_SIZE;
 
-		ret = mpf_poll_status(spi, 0);
-		if (ret >= 0)
-			ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
+		ret = mpf_poll_status(priv, 0);
+		if (ret >= 0) {
+			priv->tx = MPF_SPI_FRAME;
+			ret = spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
+		}
 
 		if (ret) {
 			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
@@ -317,12 +321,9 @@ static int mpf_ops_write_complete(struct fpga_manager *mgr,
 	const u8 release_command[] = { MPF_SPI_RELEASE };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
-	struct spi_device *spi;
 	int ret;
 
-	spi = priv->spi;
-
-	ret = mpf_spi_write(spi, isc_dis_command, sizeof(isc_dis_command));
+	ret = mpf_spi_write(priv, isc_dis_command, sizeof(isc_dis_command));
 	if (ret) {
 		dev_err(dev, "Failed to disable ISC: %d\n", ret);
 		return ret;
@@ -330,7 +331,7 @@ static int mpf_ops_write_complete(struct fpga_manager *mgr,
 
 	usleep_range(1000, 2000);
 
-	ret = mpf_spi_write(spi, release_command, sizeof(release_command));
+	ret = mpf_spi_write(priv, release_command, sizeof(release_command));
 	if (ret) {
 		dev_err(dev, "Failed to exit program mode: %d\n", ret);
 		return ret;
-- 
2.38.2


