Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BF6EC905
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjDXJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:33:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64A1729;
        Mon, 24 Apr 2023 02:32:56 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O7t1sZ014778;
        Mon, 24 Apr 2023 09:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=aVTYFLwanRDSxdt5ACJ6lBq7+3DEk/fUUzejH/aFh9s=;
 b=LH0O1O38yMi571T3iH3NEFRjmu91shz053jGck9lqmF1mU9X4FAdfw4s6wadMHR1sNF4
 +tDLl61sP0uP0dSWtw25hblP6nIgqYz5C6wp8GbncnYVgZUM/1hkBU+HdQg7WQbjh1vr
 thj/YYm1u0M+Wnf3KPm8dW8nm0Z/Dohj1ISvpdcR+wpcuNEjXOHMhISJ3i89flYqsgGm
 icoDANBzcAGRurVt72RivMlK1YTQm4EhdHy2gtyZvC6Jta43P7eYXfyWvCxeLMkPqTnf
 EaVa1/hpvrJoINBRfBs2GiqTVe++y6Cyg7ZVwppkI3ccqWxfzo/38tp9m8YV6cSDIq7l pg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q48geb0kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 09:32:52 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33O9Wl4g021202;
        Mon, 24 Apr 2023 09:32:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3q48nkpknf-1;
        Mon, 24 Apr 2023 09:32:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33O9WnHu021229;
        Mon, 24 Apr 2023 09:32:49 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33O9Wm2a021226;
        Mon, 24 Apr 2023 09:32:49 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 1CD0347CE; Mon, 24 Apr 2023 15:02:48 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v5 5/5] spi: spi-qcom-qspi: Add DMA mode support
Date:   Mon, 24 Apr 2023 15:02:41 +0530
Message-Id: <1682328761-17517-6-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O6LJqXttEjslpKijlt1VCZogF97EhuqK
X-Proofpoint-GUID: O6LJqXttEjslpKijlt1VCZogF97EhuqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240085
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver supports only PIO mode.

HW supports DMA, so add DMA mode support to the driver
for better performance for larger xfers.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v4 -> v5:
- dropped xfer_mode
- clear all interrupts in handle_err()
- dont log ptr value
- dropped some dev_err()
- converted some dev_err() to dev_warn_once()
- drop few redundant comments
- can_dma() disabled if iommus not present in dev_node
- other nits

v3 -> v4:
- corrected tabs spacing
- dropped dma data descriptors
- dropped INVALID from xfer_mode enum
- qspi_buswidth_to_iomode() to return iomode without shifting
- dropped non-functional change in qcom_qspi_set_speed()
- drop redundant call to wmb()
- fallback to pio if dma fails to setup
- use dmam_pool_create() the devm version
- thus drop dma_pool_destroy()
- set dma_alignment field in probe()
- other minor changes

v2 -> v3:
- dropped Reported-by tag

v1 -> v2:
- modified commit message
- addressed kernel test robot error
- correct placement of header file includes
- added more comments
- coding style related changes
- renamed variables
- used u32/u8 instead of uint32_t/8_t
- removed unnecessary casting
- retain same MSTR_CONFIG as PIO for DMA
- unset fragment bit only for last cmd_desc of last xfer
---
 drivers/spi/spi-qcom-qspi.c | 218 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 212 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index fab1553..a3991e6 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -2,6 +2,8 @@
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
 #include <linux/clk.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -62,6 +64,7 @@
 #define WR_FIFO_FULL		BIT(10)
 #define WR_FIFO_OVERRUN		BIT(11)
 #define TRANSACTION_DONE	BIT(16)
+#define DMA_CHAIN_DONE		BIT(31)
 #define QSPI_ERR_IRQS		(RESP_FIFO_UNDERRUN | HRESP_FROM_NOC_ERR | \
 				 WR_FIFO_OVERRUN)
 #define QSPI_ALL_IRQS		(QSPI_ERR_IRQS | RESP_FIFO_RDY | \
@@ -108,18 +111,34 @@
 #define RD_FIFO_RESET		0x0030
 #define RESET_FIFO		BIT(0)
 
+#define NEXT_DMA_DESC_ADDR	0x0040
+#define CURRENT_DMA_DESC_ADDR	0x0044
+#define CURRENT_MEM_ADDR	0x0048
+
 #define CUR_MEM_ADDR		0x0048
 #define HW_VERSION		0x004c
 #define RD_FIFO			0x0050
 #define SAMPLING_CLK_CFG	0x0090
 #define SAMPLING_CLK_STATUS	0x0094
 
+#define QSPI_ALIGN_REQ	32
 
 enum qspi_dir {
 	QSPI_READ,
 	QSPI_WRITE,
 };
 
+struct qspi_cmd_desc {
+	u32 data_address;
+	u32 next_descriptor;
+	u32 direction:1;
+	u32 multi_io_mode:3;
+	u32 reserved1:4;
+	u32 fragment:1;
+	u32 reserved2:7;
+	u32 length:16;
+};
+
 struct qspi_xfer {
 	union {
 		const void *tx_buf;
@@ -137,11 +156,23 @@ enum qspi_clocks {
 	QSPI_NUM_CLKS
 };
 
+/*
+ * Number of entries in sgt returned from spi framework that-
+ * will be supported. Can be modified as required.
+ * In practice, given max_dma_len is 64KB, the number of
+ * entries is not expected to exceed 1.
+ */
+#define QSPI_MAX_SG 5
+
 struct qcom_qspi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
+	struct dma_pool *dma_cmd_pool;
+	dma_addr_t dma_cmd_desc[QSPI_MAX_SG];
+	void *virt_cmd_desc[QSPI_MAX_SG];
+	unsigned int n_cmd_desc;
 	struct icc_path *icc_path_cpu_to_qspi;
 	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
@@ -153,21 +184,22 @@ static u32 qspi_buswidth_to_iomode(struct qcom_qspi *ctrl,
 {
 	switch (buswidth) {
 	case 1:
-		return SDR_1BIT << MULTI_IO_MODE_SHFT;
+		return SDR_1BIT;
 	case 2:
-		return SDR_2BIT << MULTI_IO_MODE_SHFT;
+		return SDR_2BIT;
 	case 4:
-		return SDR_4BIT << MULTI_IO_MODE_SHFT;
+		return SDR_4BIT;
 	default:
 		dev_warn_once(ctrl->dev,
 				"Unexpected bus width: %u\n", buswidth);
-		return SDR_1BIT << MULTI_IO_MODE_SHFT;
+		return SDR_1BIT;
 	}
 }
 
 static void qcom_qspi_pio_xfer_cfg(struct qcom_qspi *ctrl)
 {
 	u32 pio_xfer_cfg;
+	u32 iomode;
 	const struct qspi_xfer *xfer;
 
 	xfer = &ctrl->xfer;
@@ -179,7 +211,8 @@ static void qcom_qspi_pio_xfer_cfg(struct qcom_qspi *ctrl)
 	else
 		pio_xfer_cfg |= TRANSFER_FRAGMENT;
 	pio_xfer_cfg &= ~MULTI_IO_MODE_MSK;
-	pio_xfer_cfg |= qspi_buswidth_to_iomode(ctrl, xfer->buswidth);
+	iomode = qspi_buswidth_to_iomode(ctrl, xfer->buswidth);
+	pio_xfer_cfg |= iomode << MULTI_IO_MODE_SHFT;
 
 	writel(pio_xfer_cfg, ctrl->base + PIO_XFER_CFG);
 }
@@ -217,12 +250,22 @@ static void qcom_qspi_pio_xfer(struct qcom_qspi *ctrl)
 static void qcom_qspi_handle_err(struct spi_master *master,
 				 struct spi_message *msg)
 {
+	u32 int_status;
 	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	writel(0, ctrl->base + MSTR_INT_EN);
+	int_status = readl(ctrl->base + MSTR_INT_STATUS);
+	writel(int_status, ctrl->base + MSTR_INT_STATUS);
 	ctrl->xfer.rem_bytes = 0;
+
+	/* free cmd descriptors if they are around (DMA mode) */
+	for (i = 0; i < ctrl->n_cmd_desc; i++)
+		dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
+				  ctrl->dma_cmd_desc[i]);
+	ctrl->n_cmd_desc = 0;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 }
 
@@ -242,7 +285,7 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 	}
 
 	/*
-	 * Set BW quota for CPU as driver supports FIFO mode only.
+	 * Set BW quota for CPU.
 	 * We don't have explicit peak requirement so keep it equal to avg_bw.
 	 */
 	avg_bw_cpu = Bps_to_icc(speed_hz);
@@ -258,6 +301,102 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 	return 0;
 }
 
+static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, dma_addr_t dma_ptr,
+			uint32_t n_bytes)
+{
+	struct qspi_cmd_desc *virt_cmd_desc, *prev;
+	dma_addr_t dma_cmd_desc;
+
+	/* allocate for dma cmd descriptor */
+	virt_cmd_desc = dma_pool_alloc(ctrl->dma_cmd_pool, GFP_KERNEL | __GFP_ZERO, &dma_cmd_desc);
+	if (!virt_cmd_desc)
+		return -ENOMEM;
+
+	ctrl->virt_cmd_desc[ctrl->n_cmd_desc] = virt_cmd_desc;
+	ctrl->dma_cmd_desc[ctrl->n_cmd_desc] = dma_cmd_desc;
+	ctrl->n_cmd_desc++;
+
+	/* setup cmd descriptor */
+	virt_cmd_desc->data_address = dma_ptr;
+	virt_cmd_desc->direction = ctrl->xfer.dir;
+	virt_cmd_desc->multi_io_mode = qspi_buswidth_to_iomode(ctrl, ctrl->xfer.buswidth);
+	virt_cmd_desc->fragment = !ctrl->xfer.is_last;
+	virt_cmd_desc->length = n_bytes;
+
+	/* update previous descriptor */
+	if (ctrl->n_cmd_desc >= 2) {
+		prev = (ctrl->virt_cmd_desc)[ctrl->n_cmd_desc - 2];
+		prev->next_descriptor = dma_cmd_desc;
+		prev->fragment = 1;
+	}
+
+	return 0;
+}
+
+static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
+				struct spi_transfer *xfer)
+{
+	int ret;
+	struct sg_table *sgt;
+	dma_addr_t dma_ptr_sg;
+	unsigned int dma_len_sg;
+	int i;
+
+	if (ctrl->n_cmd_desc) {
+		dev_err(ctrl->dev, "Remnant dma buffers n_cmd_desc-%d\n", ctrl->n_cmd_desc);
+		return -EIO;
+	}
+
+	sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
+	if (!sgt->nents || sgt->nents > QSPI_MAX_SG) {
+		dev_warn_once(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
+		return -EAGAIN;
+	}
+
+	for (i = 0; i < sgt->nents; i++) {
+		dma_ptr_sg = sg_dma_address(sgt->sgl + i);
+		if (!IS_ALIGNED(dma_ptr_sg, QSPI_ALIGN_REQ)) {
+			dev_warn_once(ctrl->dev, "dma_address not aligned to %d\n", QSPI_ALIGN_REQ);
+			return -EAGAIN;
+		}
+	}
+
+	for (i = 0; i < sgt->nents; i++) {
+		dma_ptr_sg = sg_dma_address(sgt->sgl + i);
+		dma_len_sg = sg_dma_len(sgt->sgl + i);
+
+		ret = qcom_qspi_alloc_desc(ctrl, dma_ptr_sg, dma_len_sg);
+		if (ret)
+			goto cleanup;
+	}
+	return 0;
+
+cleanup:
+	for (i = 0; i < ctrl->n_cmd_desc; i++)
+		dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
+				  ctrl->dma_cmd_desc[i]);
+	ctrl->n_cmd_desc = 0;
+	return ret;
+}
+
+static void qcom_qspi_dma_xfer(struct qcom_qspi *ctrl)
+{
+	/* Setup new interrupts */
+	writel(DMA_CHAIN_DONE, ctrl->base + MSTR_INT_EN);
+
+	/* kick off transfer */
+	writel((u32)((ctrl->dma_cmd_desc)[0]), ctrl->base + NEXT_DMA_DESC_ADDR);
+}
+
+/* Switch to DMA if transfer length exceeds this */
+#define QSPI_MAX_BYTES_FIFO 64
+
+static bool qcom_qspi_can_dma(struct spi_controller *ctlr,
+			 struct spi_device *slv, struct spi_transfer *xfer)
+{
+	return xfer->len > QSPI_MAX_BYTES_FIFO;
+}
+
 static int qcom_qspi_transfer_one(struct spi_master *master,
 				  struct spi_device *slv,
 				  struct spi_transfer *xfer)
@@ -266,6 +405,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	int ret;
 	unsigned long speed_hz;
 	unsigned long flags;
+	u32 mstr_cfg;
 
 	speed_hz = slv->max_speed_hz;
 	if (xfer->speed_hz)
@@ -276,6 +416,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		return ret;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
+	mstr_cfg = readl(ctrl->base + MSTR_CONFIG);
 
 	/* We are half duplex, so either rx or tx will be set */
 	if (xfer->rx_buf) {
@@ -290,10 +431,36 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	ctrl->xfer.is_last = list_is_last(&xfer->transfer_list,
 					  &master->cur_msg->transfers);
 	ctrl->xfer.rem_bytes = xfer->len;
+
+	if (xfer->rx_sg.nents || xfer->tx_sg.nents) {
+		/* do DMA transfer */
+		if (!(mstr_cfg & DMA_ENABLE)) {
+			mstr_cfg |= DMA_ENABLE;
+			writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
+		}
+
+		ret = qcom_qspi_setup_dma_desc(ctrl, xfer);
+		if (ret != -EAGAIN) {
+			if (!ret)
+				qcom_qspi_dma_xfer(ctrl);
+			goto exit;
+		}
+		dev_warn_once(ctrl->dev, "DMA failure, falling back to PIO");
+		ret = 0; /* We'll retry w/ PIO */
+	}
+
+	if (mstr_cfg & DMA_ENABLE) {
+		mstr_cfg &= ~DMA_ENABLE;
+		writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
+	}
 	qcom_qspi_pio_xfer(ctrl);
 
+exit:
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
+	if (ret)
+		return ret;
+
 	/* We'll call spi_finalize_current_transfer() when done */
 	return 1;
 }
@@ -328,6 +495,16 @@ static int qcom_qspi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
+static int qcom_qspi_alloc_dma(struct qcom_qspi *ctrl)
+{
+	ctrl->dma_cmd_pool = dmam_pool_create("qspi cmd desc pool",
+		ctrl->dev, sizeof(struct qspi_cmd_desc), 0, 0);
+	if (!ctrl->dma_cmd_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static irqreturn_t pio_read(struct qcom_qspi *ctrl)
 {
 	u32 rd_fifo_status;
@@ -426,6 +603,7 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
 	int_status = readl(ctrl->base + MSTR_INT_STATUS);
 	writel(int_status, ctrl->base + MSTR_INT_STATUS);
 
+	/* PIO mode handling */
 	if (ctrl->xfer.dir == QSPI_WRITE) {
 		if (int_status & WR_FIFO_EMPTY)
 			ret = pio_write(ctrl);
@@ -449,6 +627,22 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
 		spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
 	}
 
+	/* DMA mode handling */
+	if (int_status & DMA_CHAIN_DONE) {
+		int i;
+
+		writel(0, ctrl->base + MSTR_INT_EN);
+		ctrl->xfer.rem_bytes = 0;
+
+		for (i = 0; i < ctrl->n_cmd_desc; i++)
+			dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
+					  ctrl->dma_cmd_desc[i]);
+		ctrl->n_cmd_desc = 0;
+
+		ret = IRQ_HANDLED;
+		spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
+	}
+
 	spin_unlock(&ctrl->lock);
 	return ret;
 }
@@ -517,7 +711,13 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret, "could not set DMA mask\n");
+
 	master->max_speed_hz = 300000000;
+	master->max_dma_len = 65536; /* as per HPG */
+	master->dma_alignment = QSPI_ALIGN_REQ;
 	master->num_chipselect = QSPI_NUM_CS;
 	master->bus_num = -1;
 	master->dev.of_node = pdev->dev.of_node;
@@ -528,6 +728,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->prepare_message = qcom_qspi_prepare_message;
 	master->transfer_one = qcom_qspi_transfer_one;
 	master->handle_err = qcom_qspi_handle_err;
+	if (of_property_read_bool(pdev->dev.of_node, "iommus"))
+		master->can_dma = qcom_qspi_can_dma;
 	master->auto_runtime_pm = true;
 
 	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
@@ -540,6 +742,10 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = qcom_qspi_alloc_dma(ctrl);
+	if (ret)
+		return ret;
+
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 250);
 	pm_runtime_enable(dev);
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

