Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1F6F3DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjEBGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEBGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:50:42 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6706349CD
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:50:32 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230502065027epoutp02c493cd76c707f49944171995affc326f~bQOJyrzFB2352423524epoutp028
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230502065027epoutp02c493cd76c707f49944171995affc326f~bQOJyrzFB2352423524epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683010227;
        bh=iIRgxo8LLemVChWFJdSsgwuysWdI19wNyv7rZYtGkSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCQ1KuGFfLF8K9cVeOvuUbOxD+ewhcaq/KB3QtLU1WEkFNxXj3jprb/VoKkS6DRgD
         RvEwx4ovjvSoagy6LORm0fOaNiYa8qTHMOpya+rMlRNMsHkpPd0EjPCiD7GRVm6Whu
         zksNjG68zXl8n98EK8+CMsB8OLU4bMXMJ8Mm3rlc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230502065026epcas2p19d3c4a9ffab80125389881468bf943f4~bQOJbeGiJ1499014990epcas2p13;
        Tue,  2 May 2023 06:50:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q9W1F6Yxlz4x9Pr; Tue,  2 May
        2023 06:50:25 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.37.03265.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f~bQOIUJipz2143821438epcas2p3l;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230502065025epsmtrp22a83b3b5088516b42321064eba2fca70~bQOITgfi72944229442epsmtrp2O;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-a6-6450b2b11727
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.F9.28392.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epsmtip1c6c2a0abc02ed57c2f18f0b465f0f417~bQOIJZaUO1675316753epsmtip1V;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3 3/3] spi: s3c64xx: support interrupt based pio mode
Date:   Tue,  2 May 2023 15:28:13 +0900
Message-Id: <20230502062813.112434-4-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230502062813.112434-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmue7GTQEpBtdaTCwezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
        mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/Q
        K07MLS7NS9fLSy2xMjQwMDIFKkzIzph6pY2lYLd6xfn325gbGOfLdzFyckgImEi8Ot7D1sXI
        xSEksINRou/KY0YI5xOjxJ6HU6EynxklHk2ZzQjT0vT2AStEYhejxO3Jx5khnI+MErP6X7GA
        VLEJaEt8X78YrEpEYDGjxIKrO9lBHGaBG4wS3W82g1UJC7hJPH73nhXEZhFQlWju2ABm8wrY
        SdyfsBxqn7zE6g0HmEFsTgF7iXtNLWBTJQTusUs8aJjP1MXIAeS4SKz/XwJRLwz00hZ2CFtK
        4vO7vWwQdrZE+/Q/rBB2hcTFDbOh4sYSs561M4KMYRbQlFi/Sx9iorLEkVtgVzIL8El0HP7L
        DhHmlehoE4JoVJO4P/Uc1BAZiUlHVkLd4iExZV8pJEgmMUqsOr2EeQKj3CyE+QsYGVcxiqUW
        FOempxYbFRjCYyw5P3cTIzjhabnuYJz89oPeIUYmDsZDjBIczEoivB8K/VKEeFMSK6tSi/Lj
        i0pzUosPMZoCQ24is5Rocj4w5eaVxBuaWBqYmJkZmhuZGpgrifNK255MFhJITyxJzU5NLUgt
        gulj4uCUamBKCPA9ZcT7ZMr7F2Jl3Dvi3CK95oc2rnx95vKTRf9TN7BMu3lE6en2upzA3SKN
        YY8uLOr+ECE0M7Eqd+L92b9+eypO+yR4MZf1XJhG6plrTW26e1Z+8VdzPLqwfuUDpTd/gk4d
        zajOkq7levL7fePmjTpyOWnORu/Eu8LvThGS55mo726UOOfBxwUt9+8t+LSt/dLUl/vYtk88
        Hs4h0BD4oF0h6YFOrHD21rMaYt+1wzbJ3LQPaz9y6V7bHCFNW99fDGFeM3rm7M5fHjcj5dTH
        sluxLjmCN23fnPo5z2vxNv259cey7gXuiA30v/T19ZYcYfFzkzzNAmWXhMy5PWm74mprxln7
        LnpMmv1ndcOPSUosxRmJhlrMRcWJADigx3MBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO7GTQEpBpc7pS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbbGj4Qirxd7XW9ktNj2+xmpxedccNosZ5/cxWTR+vMnuwOVxfcknZo9NqzrZ
        PO5c28PmsXlJvUffllWMHp83yQWwRXHZpKTmZJalFunbJXBlTL3SxlKwW73i/PttzA2M8+W7
        GDk5JARMJJrePmDtYuTiEBLYwSgx9/sZFoiEjMTyZ31sELawxP2WI1BF7xklHt0F6eDkYBPQ
        lvi+fjFYQkRgKaPE4z2PWUAcZoF7jBIvJ31jAqkSFnCTePzuPVgHi4CqRHPHBjCbV8BO4v6E
        5YwQK+QlVm84wAxicwrYS9xragGrEQKqudL7lXUCI98CRoZVjJKpBcW56bnFhgVGeanlesWJ
        ucWleel6yfm5mxjB4amltYNxz6oPeocYmTgYDzFKcDArifB+KPRLEeJNSaysSi3Kjy8qzUkt
        PsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoHJ3XCzzvuUPeI/+wUq7e9vXXYr8flN
        po0KFtVO6+0rOIKnaq867HLxZ+vy2qWvbq4uDVwtkJNQIKDiYNtfa3rNNIrfbxr7OaG5no6N
        7XqRLcoTVXnSg6YJXlA/zZVrz26vrb1/t9Jv5me8dWsK33L4cntrO35cc0TaIfGJ+68DNpL+
        PnybUv/Uu7aFebvZmpwN60p+O71CJlziAffd2JuWshMvZdWJzZuVv/e+sMlzLh8ml8dT1zvU
        2Bl3V9kxB3Bf3XI8a45c5/PpyZf0Pu28sH76X870mboPK6pqph3boz7Z/2j8Xrvlu+7Gc4k/
        vHbtO7frptnLPmhuSptdrOnCm762bsLsuGS5kx4dK5RYijMSDbWYi4oTAa9gPaC+AgAA
X-CMS-MailID: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f
References: <20230502062813.112434-1-jaewon02.kim@samsung.com>
        <CGME20230502065025epcas2p34507ffad60b32e091ff0efeced9bc12f@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support interrupt based pio mode to optimize cpu usage.
When transmitting data size is larget than 32 bytes, operates with
interrupt based pio mode.

By using the FIFORDY INT, an interrupt can be triggered when
the desired size of data has been received. Using this, we can support
interrupt based pio mode.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 66 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2a8304678df9..323c6da9730b 100644
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
 
@@ -552,7 +556,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 }
 
 static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
-				struct spi_transfer *xfer)
+				struct spi_transfer *xfer, bool use_irq)
 {
 	void __iomem *regs = sdd->regs;
 	unsigned long val;
@@ -573,6 +577,12 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	if (RX_FIFO_LVL(status, sdd) < xfer->len)
 		usleep_range(time_us / 2, time_us);
 
+	if (use_irq) {
+		val = msecs_to_jiffies(ms);
+		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
+			return -EIO;
+	}
+
 	val = msecs_to_loops(ms);
 	do {
 		status = readl(regs + S3C64XX_SPI_STATUS);
@@ -735,10 +745,13 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	void *rx_buf = NULL;
 	int target_len = 0, origin_len = 0;
 	int use_dma = 0;
+	bool use_irq = false;
 	int status;
 	u32 speed;
 	u8 bpw;
 	unsigned long flags;
+	u32 rdy_lv;
+	u32 val;
 
 	reinit_completion(&sdd->xfer_completion);
 
@@ -759,17 +772,46 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
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
+			use_irq = true;
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
@@ -791,7 +833,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 		if (use_dma)
 			status = s3c64xx_wait_for_dma(sdd, xfer);
 		else
-			status = s3c64xx_wait_for_pio(sdd, xfer);
+			status = s3c64xx_wait_for_pio(sdd, xfer, use_irq);
 
 		if (status) {
 			dev_err(&spi->dev,
@@ -830,8 +872,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 			if (xfer->rx_buf)
 				xfer->rx_buf += xfer->len;
 
-			if (target_len > fifo_len)
-				xfer->len = fifo_len;
+			if (target_len >= fifo_len)
+				xfer->len = fifo_len - 1;
 			else
 				xfer->len = target_len;
 		}
@@ -1001,6 +1043,14 @@ static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
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

