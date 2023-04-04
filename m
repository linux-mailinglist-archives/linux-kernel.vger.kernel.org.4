Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF116D5886
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjDDGOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjDDGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:14:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05D1BD3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:14:14 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230404061411epoutp04650c1f85f911e2649b1b0fad4cbf224a~Spqf3XkBp1353913539epoutp04c
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230404061411epoutp04650c1f85f911e2649b1b0fad4cbf224a~Spqf3XkBp1353913539epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680588851;
        bh=YQOG1kLeNL9nH5IWx9ZXFg49ubwXjRePXvvk/rBA5sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moGK9aQ6rGZz68HV8SUkk1EZTj7Osu6VBDVZzlQLc/NVYnwxNvBmgZulN1ZDCwSAr
         Ac8ZMNwAM3ZEe/QI2I7GsZ6y/p9JwTVGl0QNv4Djk+tvehaViOqmWsX53fzr95lRw4
         gVS7BsqUdS/fnjBP25LrHR54fm0RZCwev6fqxKIY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230404061410epcas2p3ed4775b794f5044995c9189358693dcd~Spqe5UZWt2176821768epcas2p3V;
        Tue,  4 Apr 2023 06:14:10 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PrHXK667Gz4x9Ps; Tue,  4 Apr
        2023 06:14:09 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.64.08750.130CB246; Tue,  4 Apr 2023 15:14:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9~Spqd8hiBD1839518395epcas2p1z;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230404061409epsmtrp2c8139b86953002546b0ad0c67c0bb5d3~Spqd7oiwq2104021040epsmtrp2Q;
        Tue,  4 Apr 2023 06:14:09 +0000 (GMT)
X-AuditID: b6c32a47-9f5fe7000000222e-48-642bc031f31b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.8A.31821.130CB246; Tue,  4 Apr 2023 15:14:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230404061409epsmtip1817a63890854b59df50249b212ce1c96~Spqdub5Uw3067630676epsmtip1F;
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
Subject: [PATCH 1/3] spi: s3c64xx: support spi polling mode using devicetree
Date:   Tue,  4 Apr 2023 15:00:09 +0900
Message-Id: <20230404060011.108561-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230404060011.108561-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmqa7hAe0UgwnTdS0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZjzcsYSzYL12xa9VR1gbGx2JdjJwc
        EgImEnsX/mIBsYUEdjBKzFyV0sXIBWR/YpTY8O0GO4TzmVHi9eQeZpiO2xvnsUEkdjFKTLy3
        lBXC+cgo0fCrFWwWm4C2xPf1i8ESIgJHGSW273wL5jALfGOUWHh0DhtIlbCAj8TU+fvBOlgE
        VCU+HXrOCGLzCthJPJvfxg6xT15i9YYDYLs5BewlvrbfYAEZJCHwlV3i6b0FjBBFLhKzzzxn
        gbCFJV4d3wLVLCXx+d1eNgg7W6J9+h9WCLtC4uKG2VBxY4lZz9qB5nAAXacpsX6XPogpIaAs
        ceQW2ERmAT6JjsN/2SHCvBIdbUIQjWoS96eegxoiIzHpyEomCNtD4ujPbUyQQJnEKNG8+BPz
        BEa5WQgLFjAyrmIUSy0ozk1PLTYqMIZHWXJ+7iZGcBrUct/BOOPtB71DjEwcjIcYJTiYlUR4
        Vbu0UoR4UxIrq1KL8uOLSnNSiw8xmgLDbiKzlGhyPjAR55XEG5pYGpiYmRmaG5kamCuJ80rb
        nkwWEkhPLEnNTk0tSC2C6WPi4JRqYIo+q6tnc3VPbxJzj7uysu3tu6dU4n8X+lbV/3tyJGHx
        8dXN+jb7pCdq711RcpWx/SfXoYx5PO3rXU1mCz3/0PbJjuVUgsZFx5+xGRMcp+/9rmqWUOX4
        5Orx0AS9tM1LeE9Ndmr0fcI3f63xHM1FqzKvt7q5S1U5HuayWPLoRtyUtS8f3Ow6tVE54X/e
        VuPIpcde1s88viW1YwPrFt5YFsvQOVo8/RfEMiOL9zu2Cud8KdYu2hchlCewqsurMPtlBb/u
        Tb53bh9fb4kQ+DY1wVdk7qOmOQ676v7E5XW/rj/4vlBQxPXC6Wsra8oyl8ieKasSVl/tablw
        t9C6PQur/lzMN2KZ98C/cpnOqisvzyuxFGckGmoxFxUnAgBcjLubDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK7hAe0Ug3UX2S0ezNvGZrH4x3Mm
        i6kPn7BZXN6vbTH/yDlWix0NR1gt9r7eym6x6fE1VovLu+awWcw4v4/JovHjTXaL1r1H2B14
        PK4v+cTssWlVJ5vHnWt72Dw2L6n36NuyitHj8ya5ALYoLpuU1JzMstQifbsErozHG5YwFuyX
        rti16ihrA+NjsS5GTg4JAROJ2xvnsXUxcnEICexglNhzfS4zREJGYvmzPjYIW1jifssRVoii
        94wSP6feYARJsAloS3xfvxgsISJwklHi95kmJhCHWeAPo8TUI/+ZQKqEBXwkps7fzwJiswio
        Snw69Bysm1fATuLZ/DZ2iBXyEqs3HABbzSlgL/G1/QZYvRBQze9/O5gnMPItYGRYxSiZWlCc
        m55bbFhglJdarlecmFtcmpeul5yfu4kRHLJaWjsY96z6oHeIkYmD8RCjBAezkgivapdWihBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MB/9c0PnAtXjj
        BTc5xqPWz1fXhVjNiJY86+EzvYf9P8fee8u6fu29U+C4JtRu5TdVE70qNsl3epPEJs2YucpU
        ru3G/v3hrvVKNc8tuLjPV1VO+zK9tnztY3XGS0KPp098befgfVXr1XTnXRsPzZfmql0Xd8t/
        6iH2B5s7LZctOtjeXny5dYNpQedp01OOIiaTnv/g9PnU/U/0AntldP8Wrt1vxV1mBUvxrtb/
        kPFd0jTww7ZFsXGu5zw6Xh8WkK0MWn8q/PtjcRvbI326fG3yGzgdHSfM4f5kp/5sa+qs88UC
        P5leKC7sy077vaivZpmDSdSO1UFWs0V+Pv1137Vx/6f7U8KYrjnuDVW7G66oo8RSnJFoqMVc
        VJwIAH5ggYTIAgAA
X-CMS-MailID: 20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9
References: <20230404060011.108561-1-jaewon02.kim@samsung.com>
        <CGME20230404061409epcas2p15750d5844aa8d3655d1bfd094fac14a9@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new 'samsung,spi-polling' property to support polling mode.
In some environments, polling mode is required even if DMA is supported.
Changed it to support not only with quick but also optinally with
devicetree.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-s3c64xx.c                 | 23 +++++++++++++++++------
 include/linux/platform_data/spi-s3c64xx.h |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 71d324ec9a70..bf1f3dcca202 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -116,7 +116,6 @@
 #define S3C64XX_SPI_TRAILCNT		S3C64XX_SPI_MAX_TRAILCNT
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-#define is_polling(x)	(x->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
 
 #define RXBUSY    (1<<2)
 #define TXBUSY    (1<<3)
@@ -198,6 +197,17 @@ struct s3c64xx_spi_driver_data {
 	unsigned int			port_id;
 };
 
+static bool s3c64xx_is_polling(struct s3c64xx_spi_driver_data *sdd)
+{
+	if (sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_POLL)
+		return true;
+
+	if (sdd->cntrlr_info->polling)
+		return true;
+
+	return false;
+}
+
 static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 {
 	void __iomem *regs = sdd->regs;
@@ -353,7 +363,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
-	if (is_polling(sdd))
+	if (s3c64xx_is_polling(sdd))
 		return 0;
 
 	/* Requests DMA channels */
@@ -383,7 +393,7 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
-	if (is_polling(sdd))
+	if (s3c64xx_is_polling(sdd))
 		return 0;
 
 	/* Releases DMA channels if they are allocated */
@@ -749,7 +759,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 			return status;
 	}
 
-	if (!is_polling(sdd) && (xfer->len > fifo_len) &&
+	if (!s3c64xx_is_polling(sdd) && (xfer->len > fifo_len) &&
 	    sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		use_dma = 1;
 
@@ -1067,6 +1077,7 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		sci->num_cs = temp;
 	}
 
+	sci->polling = of_property_read_bool(dev->of_node, "samsung,spi-polling");
 	sci->no_cs = of_property_read_bool(dev->of_node, "no-cs-readback");
 
 	return sci;
@@ -1171,7 +1182,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	if (sdd->port_conf->has_loopback)
 		master->mode_bits |= SPI_LOOP;
 	master->auto_runtime_pm = true;
-	if (!is_polling(sdd))
+	if (!s3c64xx_is_polling(sdd))
 		master->can_dma = s3c64xx_spi_can_dma;
 
 	sdd->regs = devm_ioremap_resource(&pdev->dev, mem_res);
@@ -1295,7 +1306,7 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
-	if (!is_polling(sdd)) {
+	if (!s3c64xx_is_polling(sdd)) {
 		dma_release_channel(sdd->rx_dma.ch);
 		dma_release_channel(sdd->tx_dma.ch);
 	}
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index 5df1ace6d2c9..cb7b8ddc899f 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -35,6 +35,7 @@ struct s3c64xx_spi_info {
 	int src_clk_nr;
 	int num_cs;
 	bool no_cs;
+	bool polling;
 	int (*cfg_gpio)(void);
 };
 
-- 
2.17.1

