Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EDE6E733F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjDSG2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjDSG2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:28:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C2C7A92
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:27:58 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230419062756epoutp044cf1100593d4bfe2a487c8362ebd7558~XQhywyLls1322213222epoutp040
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230419062756epoutp044cf1100593d4bfe2a487c8362ebd7558~XQhywyLls1322213222epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681885676;
        bh=b+coslB2peZ0p6nQKsqxpiNPVdUjf7aKTCFH32tKovU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osbkaqRHhl0kYsC+3eyeKTR80xRLR30Nztn9/JxHp9i8uEv8GCIv8J8BU2V7wyd3W
         tDKIZ17bbPPbkzVVEY+BB5ekcRdwdd+0riYpV/RrvOTs5kOg0nxZBHdE8oZxv6GWy/
         9nfj+U2HRQ/eINSNnXVHnEIwbiL5z7Qsulml2UHU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230419062756epcas2p2d7d6dde7ad54dd6382d8a430985220c9~XQhyXvfic0810708107epcas2p2z;
        Wed, 19 Apr 2023 06:27:56 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q1W7J0ZCnz4x9Q1; Wed, 19 Apr
        2023 06:27:56 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.C2.09961.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd~XQhxblEQF1700617006epcas2p48;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419062755epsmtrp2fa7d8d50512cb513ff544bfc27a74370~XQhxa3Sqr0106901069epsmtrp2S;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
X-AuditID: b6c32a45-bb5ff700000026e9-55-643f89eb8831
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.65.08279.BE98F346; Wed, 19 Apr 2023 15:27:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230419062755epsmtip2f767e554dd57b52e647e502fe222dc6b~XQhxPTaia0394003940epsmtip2X;
        Wed, 19 Apr 2023 06:27:55 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 4/4] spi: s3c64xx: support interrupt based pio mode
Date:   Wed, 19 Apr 2023 15:06:39 +0900
Message-Id: <20230419060639.38853-5-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230419060639.38853-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmme7rTvsUgx9HLCwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/Q
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzri8fQF7QZN2xYfLM5gaGJ8rdjFyckgImEgsudzD3sXI
        xSEksINRYs7hXywQzidGiYN7/jOCVAkJfGOUWLvaD6bj8stWJoiivYwSew49hXI+Mkq8fg/i
        cHKwCWhLfF+/mBUkISKwmFFi798vzCAOs8ANRonuN5tZQKqEBdwk+t7NYgexWQRUJfa/2cgG
        YvMK2EocfDmHFWKfvMTqDQeYQWxOATuJhZ+usYEMkhB4xC6xbN1fRogiF4lLp9uYIGxhiVfH
        t7BD2FISn9/tZYOwsyXap/+BGlohcXHDbKi4scSsZ+1AcziArtOUWL9LH8SUEFCWOHIL7Exm
        AT6JjsN/2SHCvBIdbUIQjWoS96eegxoiIzHpyEqoAzwklm/9ygwJlImMEq0rZjBPYJSbhbBg
        ASPjKkax1ILi3PTUYqMCQ3iUJefnbmIEpzwt1x2Mk99+0DvEyMTBeIhRgoNZSYT3jKtVihBv
        SmJlVWpRfnxRaU5q8SFGU2DYTWSWEk3OBybdvJJ4QxNLAxMzM0NzI1MDcyVxXmnbk8lCAumJ
        JanZqakFqUUwfUwcnFINTDKhJsb6331TNkZudrLgZjhStHmzQIjQhlcr3fPE3KwcS3jFZP9f
        lha/PDtCydBqItvxVGbVXSvTJDKzxfO4vxyWCPQIiVE7ano2ZdfPLSeeZOxuEVj9ONbDeEbp
        zaTadlWPaSIaP+263kQeOpaVqd9y52izdNPxmpo5xiWrg1/7sHSz+nad0zE8NM91/r+7Pbf6
        rfzs33BwKfisN7Hybdm6cN7urKpvzzR3Wvw0vO9d6zIz9KLO772dIR0O1y+enyAsLbiASbVJ
        o3vK1RPXq2vnzd+/rDJx9e4z/Cznl7/xrr4f3x9l4+zypJr/kdKBqqoN0sFbnRPPyAcUL9S3
        6BBpq2HQOH5Ov9zcJ1GJpTgj0VCLuag4EQCnsoYoAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO7rTvsUg32rhCwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlXN6+gL2gSbviw+UZTA2MzxW7
        GDk5JARMJC6/bGXqYuTiEBLYzSjxcuUWJoiEjMTyZ31sELawxP2WI6wQRe8ZJd58uQBWxCag
        LfF9/WJWEFtEYCmjxM1uKZAiZoF7QJMmfQMrEhZwk+h7N4sdxGYRUJXY/2Yj2FReAVuJgy/n
        sEJskJdYveEAM4jNKWAnsfDTNbAaIaCa3fPesk9g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgx
        t7g0L10vOT93EyM4OLU0dzBuX/VB7xAjEwfjIUYJDmYlEd4zrlYpQrwpiZVVqUX58UWlOanF
        hxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTBJs9oE+My+4KvyTyzyrVBp8vP3B+1W
        Pitc+8o0/6ro9w8Fll/u7U78z2ZWcjeBc6a09Zl5epUv/vVHvdq/2+y38cc2sRWJLfnlBzxW
        Zgi4zfOo/V0qOH3xxgWPrxvzSHX5h7G05xlO/zf5VXVzaMvX1qt6TYXBTSXbH4T8r2IzfXCR
        Z5bZde/uSFG/9SFL0+r7Epa718p2HAhiDp7j9ijBo4NxzvE/S/sCPu59MSMyRXt6h5aYLq/h
        55nmrXpq5olG8eoT/rYubnk4c3Ku+pd9/rel24Nuch98IHdESnHanznTNsX/NN57YmUyO1+/
        wS4F64dp7xjqjsuUru0/+KPM2vtL4YmrDfFV/EvUdyixFGckGmoxFxUnAgDvFAnMvQIAAA==
X-CMS-MailID: 20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd
References: <20230419060639.38853-1-jaewon02.kim@samsung.com>
        <CGME20230419062755epcas2p43a1127f4bb28cf1cf3f42e5d3cc597cd@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt based pio mode is supported to reduce CPU load.
If transfer size is larger than 32 byte, it is processed using interrupt.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 82 ++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cf3060b2639b..ce1afb9a4ed4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -58,6 +58,8 @@
 #define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
 #define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
 #define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
+#define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
+#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
 #define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
 #define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
 #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
@@ -114,6 +116,8 @@
 
 #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
 
+#define S3C64XX_SPI_POLLING_SIZE	32
+
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 #define is_polling(x)	(x->cntrlr_info->polling)
 
@@ -552,10 +556,11 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 }
 
 static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
-				struct spi_transfer *xfer)
+				struct spi_transfer *xfer, int use_irq)
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
+	unsigned long time;
 	u32 status;
 	int loops;
 	u32 cpy_len;
@@ -563,17 +568,24 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	int ms;
 	u32 tx_time;
 
-	/* sleep during signal transfer time */
-	status = readl(regs + S3C64XX_SPI_STATUS);
-	if (RX_FIFO_LVL(status, sdd) < xfer->len) {
-		tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
-		usleep_range(tx_time / 2, tx_time);
-	}
-
 	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
 	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
 	ms += 10; /* some tolerance */
 
+	if (use_irq) {
+		val = msecs_to_jiffies(ms);
+		time = wait_for_completion_timeout(&sdd->xfer_completion, val);
+		if (!time)
+			return -EIO;
+	} else {
+		/* sleep during signal transfer time */
+		status = readl(regs + S3C64XX_SPI_STATUS);
+		if (RX_FIFO_LVL(status, sdd) < xfer->len) {
+			tx_time = (xfer->len * 8 * 1000 * 1000) / sdd->cur_speed;
+			usleep_range(tx_time / 2, tx_time);
+		}
+	}
+
 	val = msecs_to_loops(ms);
 	do {
 		cpu_relax();
@@ -737,10 +749,13 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	void *rx_buf = NULL;
 	int target_len = 0, origin_len = 0;
 	int use_dma = 0;
+	int use_irq = 0;
 	int status;
 	u32 speed;
 	u8 bpw;
 	unsigned long flags;
+	u32 rdy_lv;
+	u32 val;
 
 	reinit_completion(&sdd->xfer_completion);
 
@@ -761,17 +776,46 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		use_dma = 1;
 
-	} else if (xfer->len > fifo_len) {
+	} else if (xfer->len >= fifo_len) {
 		tx_buf = xfer->tx_buf;
 		rx_buf = xfer->rx_buf;
 		origin_len = xfer->len;
-
 		target_len = xfer->len;
-		if (xfer->len > fifo_len)
-			xfer->len = fifo_len;
+		xfer->len = fifo_len - 1;
 	}
 
 	do {
+		/* transfer size is greater than 32, change to IRQ mode */
+		if (xfer->len > S3C64XX_SPI_POLLING_SIZE)
+			use_irq = 1;
+
+		if (use_irq) {
+			reinit_completion(&sdd->xfer_completion);
+
+			rdy_lv = xfer->len;
+			/* Setup RDY_FIFO trigger Level
+			 * RDY_LVL =
+			 * fifo_lvl up to 64 byte -> N bytes
+			 *               128 byte -> RDY_LVL * 2 bytes
+			 *               256 byte -> RDY_LVL * 4 bytes
+			 */
+			if (fifo_len == 128)
+				rdy_lv /= 2;
+			else if (fifo_len == 256)
+				rdy_lv /= 4;
+
+			val = readl(sdd->regs + S3C64XX_SPI_MODE_CFG);
+			val &= ~S3C64XX_SPI_MODE_RX_RDY_LVL;
+			val |= (rdy_lv << S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT);
+			writel(val, sdd->regs + S3C64XX_SPI_MODE_CFG);
+
+			/* Enable FIFO_RDY_EN IRQ */
+			val = readl(sdd->regs + S3C64XX_SPI_INT_EN);
+			writel((val | S3C64XX_SPI_INT_RX_FIFORDY_EN),
+					sdd->regs + S3C64XX_SPI_INT_EN);
+
+		}
+
 		spin_lock_irqsave(&sdd->lock, flags);
 
 		/* Pending only which is to be done */
@@ -793,7 +837,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		if (use_dma)
 			status = s3c64xx_wait_for_dma(sdd, xfer);
 		else
-			status = s3c64xx_wait_for_pio(sdd, xfer);
+			status = s3c64xx_wait_for_pio(sdd, xfer, use_irq);
 
 		if (status) {
 			dev_err(&spi->dev,
@@ -832,8 +876,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 			if (xfer->rx_buf)
 				xfer->rx_buf += xfer->len;
 
-			if (target_len > fifo_len)
-				xfer->len = fifo_len;
+			if (target_len >= fifo_len)
+				xfer->len = fifo_len - 1;
 			else
 				xfer->len = target_len;
 		}
@@ -1003,6 +1047,14 @@ static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
 		dev_err(&spi->dev, "TX underrun\n");
 	}
 
+	if (val & S3C64XX_SPI_ST_RX_FIFORDY) {
+		complete(&sdd->xfer_completion);
+		/* No pending clear irq, turn-off INT_EN_RX_FIFO_RDY */
+		val = readl(sdd->regs + S3C64XX_SPI_INT_EN);
+		writel((val & ~S3C64XX_SPI_INT_RX_FIFORDY_EN),
+				sdd->regs + S3C64XX_SPI_INT_EN);
+	}
+
 	/* Clear the pending irq by setting and then clearing it */
 	writel(clr, sdd->regs + S3C64XX_SPI_PENDING_CLR);
 	writel(0, sdd->regs + S3C64XX_SPI_PENDING_CLR);
-- 
2.17.1

