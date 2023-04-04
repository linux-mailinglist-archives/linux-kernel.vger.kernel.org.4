Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEF6D588A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjDDGOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjDDGOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:14:24 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FC198A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:14:14 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230404061411epoutp032c09cc317ff5d28b6355205f3ea1c180~SpqfpyU-63076630766epoutp03e
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230404061411epoutp032c09cc317ff5d28b6355205f3ea1c180~SpqfpyU-63076630766epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680588851;
        bh=yxk3LInfyfp4SqA7cJhgXDlEraKJNgFGdKmVnOtMA/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzeKSiSyaSV0fqX5IBCm+/O+Ch/FsjM2kRf2NTFZRTROpMjRIraUTBKzvfwvLvF5g
         Z5yMSor5P8SLgj6YVsCnoj/hFnFmFKtm0X2spg6hP5gJwXQrHjkxYElaTjXFoRqWQU
         waRfQZZ+kQkyZ3mFb1RBYVUOHBAnEUZV7/aJPb8Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230404061410epcas2p1ffd783739455327a78232e7a39fcc776~SpqfFMjrp1839918399epcas2p14;
        Tue,  4 Apr 2023 06:14:10 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PrHXL134Xz4x9QF; Tue,  4 Apr
        2023 06:14:10 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.0D.61927.130CB246; Tue,  4 Apr 2023 15:14:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040~SpqeEw5ss0906409064epcas2p2W;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230404061409epsmtrp1d9839c642188df34f77c6026fd90d8b7~SpqeEBRS_0601006010epsmtrp1K;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-d2-642bc03137ec
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.CD.18071.130CB246; Tue,  4 Apr 2023 15:14:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230404061409epsmtip13822c512614a3630e8784a3b1881b187~Spqd5kGE73056630566epsmtip1T;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 3/3] spi: s3c64xx: support interrupt based pio mode
Date:   Tue,  4 Apr 2023 15:00:11 +0900
Message-Id: <20230404060011.108561-4-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230404060011.108561-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmua7RAe0Ug40PGS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZLec6mQr2yVccuvGYsYHxi0QXIyeH
        hICJxOuDGxm7GLk4hAR2MEq83jcLyvnEKPH9y212COcbo8TJ55PYYVrmdnVAVe1llNj7Yi0z
        hPORUeLz8y9sIFVsAtoS39cvZgVJiAgcZZTYvvMtmMMMMmvh0TlgVcICzhITpm0Bs1kEVCVO
        d/cwgdi8AnYSO57fY4LYJy+xesMBZhCbU8Be4mv7DRaQQRICH9kllk09A3WUi8TVvllQtrDE
        q+NboGwpiZf9bVB2tkT79D+sEHaFxMUNs9kgbGOJWc/agR7iALpOU2L9Ln0QU0JAWeLILRaQ
        CmYBPomOw3/ZIcK8Eh1tQhCNahL3p56DGiIjMenISqiLPST+THwNdrGQwCRGiY/rTSYwys1C
        mL+AkXEVo1hqQXFuemqxUYEhPMqS83M3MYLToJbrDsbJbz/oHWJk4mA8xCjBwawkwqvapZUi
        xJuSWFmVWpQfX1Sak1p8iNEUGHQTmaVEk/OBiTivJN7QxNLAxMzM0NzI1MBcSZxX2vZkspBA
        emJJanZqakFqEUwfEwenVAOThfDdzHOud52OROlpVp5Ztby1VOZrc3v93wm+4YffaYuv3DPx
        /jSunw7e1t5LItdKnE3MX8kjd4xNxVH0jep7dblDC2/MWVM+5aUX8wnLywtTqpNqm1oszhwW
        n8IQd5KpxSS0vMT33NG53/QW+y3Z8JaT8/Fa7lkzvOakzj7EFP7sh+DNn83nj+oKbleLMUn4
        fj64zuaAUjibTajjWf2XKaGRe5nu3ZET/vSjlbspqEknLHGh6YEM7yc3De1apxo41ApbMh2T
        2nTNKtku2Scuoe9kQfuDD403NQo2KvUxC9nMZiyMbnW8oL5l9e2ubafsv++fs/PaPMcYSb+e
        9aLNkW/7faOa1wv9KX7lelWJpTgj0VCLuag4EQDpn9hHDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK7hAe0Ug59PhCwezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALYoLpuU1JzMstQifbsEroyWc51MBfvk
        Kw7deMzYwPhFoouRk0NCwERiblcHYxcjF4eQwG5GiTv3tjBBJGQklj/rY4OwhSXutxxhhSh6
        zyhxcdorZpAEm4C2xPf1i8ESIgInGSV+n2liAnGYBf4wSkw98h9slLCAs8SEaVvARrEIqEqc
        7u4Bi/MK2EnseH4Pap28xOoNB8CmcgrYS3xtv8ECYgsB1fz+t4N5AiPfAkaGVYySqQXFuem5
        xYYFhnmp5XrFibnFpXnpesn5uZsYwSGrpbmDcfuqD3qHGJk4GA8xSnAwK4nwqnZppQjxpiRW
        VqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAtMp5WbA8W+OESgPN
        nrmFa/88KWE/nXXhxoyOiCYGPs8X5R16jUdeSk3iCfgfI1o1be6pewI32Fon8a5WdzHSYHn+
        ff67J4e6HTx8thedUl5h4Myv7JD++upavxlu2UJvj0+59viCWPC73NjfKwQW/Fwnwlbh8z6Q
        2z6z8oaDbZiOxAfV9tTdW02WHLnFcMrmyqtTYQX6r5IVU+Xvu2b35K5doifTxrdJ67c2X5SB
        /SdV4ZQ/0SJH7ui3dvX8lihknPBQLSZmz8J3EycZxzvbeK/R6zi6IEXUSGDPsh9//64+axj/
        /8X/lWK+jWrlkvl3l63NL5/Pl/grTjcs0lzikmL3xhuPZJ/3hjFYXD6lxFKckWioxVxUnAgA
        i1UC1MgCAAA=
X-CMS-MailID: 20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
        <CGME20230404061409epcas2p2b12a9cac014907e3930795cb67cb6040@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds IRQ based PIO mode instead of cpu polling.
By using the FIFO trigger level, interrupts are received.
CPU consumption is reduced in PIO mode because registers are not
constantly checked.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 54 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index bf1f3dcca202..f8986b05309e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -59,6 +59,8 @@
 #define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
 #define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
 #define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
+#define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
+#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
 #define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
 #define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
 #define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
@@ -567,6 +569,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
+	unsigned long time;
 	u32 status;
 	int loops;
 	u32 cpy_len;
@@ -577,6 +580,11 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	ms = xfer->len * 8 * 1000 / sdd->cur_speed;
 	ms += 10; /* some tolerance */
 
+	val = msecs_to_jiffies(ms);
+	time = wait_for_completion_timeout(&sdd->xfer_completion, val);
+	if (!time)
+		return -EIO;
+
 	val = msecs_to_loops(ms);
 	do {
 		status = readl(regs + S3C64XX_SPI_STATUS);
@@ -743,6 +751,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	u32 speed;
 	u8 bpw;
 	unsigned long flags;
+	u32 rdy_lv;
+	u32 val;
 
 	reinit_completion(&sdd->xfer_completion);
 
@@ -763,17 +773,41 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
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
+		if (!use_dma) {
+			reinit_completion(&sdd->xfer_completion);
+
+			rdy_lv = xfer->len;
+			/* Setup RDY_FIFO trigger Level
+			 * RDY_LVL =
+			 * fifo_lvl upto 64 byte -> N bytes
+			 *              128 byte -> RDY_LVL * 2 bytes
+			 *              256 byte -> RDY_LVL * 4 bytes
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
 		spin_lock_irqsave(&sdd->lock, flags);
 
 		/* Pending only which is to be done */
@@ -834,8 +868,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 			if (xfer->rx_buf)
 				xfer->rx_buf += xfer->len;
 
-			if (target_len > fifo_len)
-				xfer->len = fifo_len;
+			if (target_len >= fifo_len)
+				xfer->len = fifo_len - 1;
 			else
 				xfer->len = target_len;
 		}
@@ -1005,6 +1039,14 @@ static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
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

