Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF246D6B23
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjDDSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjDDSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:03:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4D4687;
        Tue,  4 Apr 2023 11:03:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334HCIWf011465;
        Tue, 4 Apr 2023 18:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=DrPOWjwYr/69zhuxEKo4W/WWCnat/PgCE9ubKirkIMs=;
 b=MIytwJfe8in0uoroKqvB1Bf6nYrJhI7dkL5Z6HgGmgF5cfQkMPPUmv0TgF3NkSvE/rqT
 94n14e9eqRKQ2VIbkVt5B41LR1inyfF759IzDT67RRJaqKs7x6KM3vpm55CwlL11QcRJ
 g3tMAysUAVSceeUZZYKUjKVwzbYnK4ji3BYZb7+x+hil9rnVxknGHvzeUpjqR3YQ5bIc
 68cQZhFRqp37MADE9AqUCVzZzPg39YTHTpayfc+n0X9N706u1ecUfF4re1vPyLCu7pY6
 AHDVHIdl/S3rThifFjEksuv8KAkUThnwcM4aw8aXfVBetCJ6/ils//B5SvyiMrpSTlqt uw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnbt0ntk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 18:03:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 334I3QxO021656;
        Tue, 4 Apr 2023 18:03:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3ppdpkvtrg-1;
        Tue, 04 Apr 2023 18:03:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 334I3RFh021663;
        Tue, 4 Apr 2023 18:03:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 334I3Rla021662;
        Tue, 04 Apr 2023 18:03:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 0E3B63B69; Tue,  4 Apr 2023 23:33:27 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
Date:   Tue,  4 Apr 2023 23:33:20 +0530
Message-Id: <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DbCB8Eq5AY3SbVH1XXdbaPWQaU0frJio
X-Proofpoint-GUID: DbCB8Eq5AY3SbVH1XXdbaPWQaU0frJio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_09,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040165
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For performance improvement in terms of number of interrupts.
Code flow for DMA mode...
Allocate for DMA pools in probe()
For xfers with len > 64 bytes, return true from can_dma()
Thus framework creates and maps an sg table for each xfer buffer.
In transfer_one() enable DMA in MSTR_CONFIG.
Split the dma buffer of each entry of sgt into a maximum of 3 parts...
Unaligned head, aligned middle and tail.
For each part create a dma_cmd_descriptor.
For head and tail allocate dma_data_descriptors
  For tx, copy the data into allocated data descriptors
  For rx, remember the original buffers to copy from-
  allocated descriptors after xfer is complete
For middle part use the aligned dma buffer.
Link each dma_cmd_descriptor to next.
Thus create a chain of descriptors.
Kick-off the xfer by copying 1st cmd descriptor to-
NEXT_DMA_DESC_ADDR register.
On receiving DMA_CHAIN_DONE interrupt, complete the xfer and-
free descriptors.
If timeout happens handle error by freeing descriptors.
In remove() free DMA pools.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/spi/spi-qcom-qspi.c | 429 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 398 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index fab1553..64c3bec 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -13,7 +13,8 @@
 #include <linux/pm_opp.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
-
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
 
 #define QSPI_NUM_CS		2
 #define QSPI_BYTES_PER_WORD	4
@@ -62,6 +63,7 @@
 #define WR_FIFO_FULL		BIT(10)
 #define WR_FIFO_OVERRUN		BIT(11)
 #define TRANSACTION_DONE	BIT(16)
+#define DMA_CHAIN_DONE		BIT(31)
 #define QSPI_ERR_IRQS		(RESP_FIFO_UNDERRUN | HRESP_FROM_NOC_ERR | \
 				 WR_FIFO_OVERRUN)
 #define QSPI_ALL_IRQS		(QSPI_ERR_IRQS | RESP_FIFO_RDY | \
@@ -108,6 +110,10 @@
 #define RD_FIFO_RESET		0x0030
 #define RESET_FIFO		BIT(0)
 
+#define NEXT_DMA_DESC_ADDR		0x0040
+#define CURRENT_DMA_DESC_ADDR	0x0044
+#define CURRENT_MEM_ADDR		0x0048
+
 #define CUR_MEM_ADDR		0x0048
 #define HW_VERSION		0x004c
 #define RD_FIFO			0x0050
@@ -120,6 +126,22 @@ enum qspi_dir {
 	QSPI_WRITE,
 };
 
+struct qspi_cmd_desc {
+	uint32_t data_address;
+	uint32_t next_descriptor;
+	uint32_t direction:1;
+	uint32_t multi_io_mode:3;
+	uint32_t reserved1:4;
+	uint32_t fragment:1;
+	uint32_t reserved2:7;
+	uint32_t length:16;
+	//------------------------//
+	uint8_t *bounce_src;
+	uint8_t *bounce_dst;
+	uint32_t bounce_length;
+};
+
+#define QSPI_MAX_NUM_DESC 5
 struct qspi_xfer {
 	union {
 		const void *tx_buf;
@@ -137,11 +159,30 @@ enum qspi_clocks {
 	QSPI_NUM_CLKS
 };
 
+enum qspi_xfer_mode {
+	QSPI_INVALID,
+	QSPI_FIFO,
+	QSPI_DMA
+};
+
+/* number of entries in sgt returned from spi framework that we can support */
+#define QSPI_QCOM_MAX_SG 5
+
 struct qcom_qspi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
+	struct dma_pool *dma_cmd_pool;
+	struct dma_pool *dma_data_pool;
+	dma_addr_t dma_cmd_desc[3*QSPI_QCOM_MAX_SG];
+	dma_addr_t dma_data_desc[2*QSPI_QCOM_MAX_SG];
+	void *virt_cmd_desc[3*QSPI_QCOM_MAX_SG];
+	void *virt_data_desc[2*QSPI_QCOM_MAX_SG];
+	unsigned int n_cmd_desc;
+	unsigned int n_data_desc;
+	int xfer_mode;
+	u32 iomode;
 	struct icc_path *icc_path_cpu_to_qspi;
 	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
@@ -151,18 +192,25 @@ struct qcom_qspi {
 static u32 qspi_buswidth_to_iomode(struct qcom_qspi *ctrl,
 				   unsigned int buswidth)
 {
+	u32 ret;
+
+	/* for DMA we dont write to PIO_XFER_CFG register, so don't shift */
 	switch (buswidth) {
 	case 1:
-		return SDR_1BIT << MULTI_IO_MODE_SHFT;
+		ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_1BIT : SDR_1BIT << MULTI_IO_MODE_SHFT);
+		break;
 	case 2:
-		return SDR_2BIT << MULTI_IO_MODE_SHFT;
+		ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_2BIT : SDR_2BIT << MULTI_IO_MODE_SHFT);
+		break;
 	case 4:
-		return SDR_4BIT << MULTI_IO_MODE_SHFT;
+		ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_4BIT : SDR_4BIT << MULTI_IO_MODE_SHFT);
+		break;
 	default:
 		dev_warn_once(ctrl->dev,
 				"Unexpected bus width: %u\n", buswidth);
-		return SDR_1BIT << MULTI_IO_MODE_SHFT;
+		ret = (ctrl->xfer_mode == QSPI_DMA ? SDR_1BIT : SDR_1BIT << MULTI_IO_MODE_SHFT);
 	}
+	return ret;
 }
 
 static void qcom_qspi_pio_xfer_cfg(struct qcom_qspi *ctrl)
@@ -223,6 +271,21 @@ static void qcom_qspi_handle_err(struct spi_master *master,
 	spin_lock_irqsave(&ctrl->lock, flags);
 	writel(0, ctrl->base + MSTR_INT_EN);
 	ctrl->xfer.rem_bytes = 0;
+
+	if (ctrl->xfer_mode == QSPI_DMA) {
+		int ii;
+
+		/* free cmd and data descriptors */
+		for (ii = 0; ii < ctrl->n_data_desc; ii++)
+			dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[ii],
+					  ctrl->dma_data_desc[ii]);
+		ctrl->n_data_desc = 0;
+
+		for (ii = 0; ii < ctrl->n_cmd_desc; ii++)
+			dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[ii],
+					  ctrl->dma_cmd_desc[ii]);
+		ctrl->n_cmd_desc = 0;
+	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 }
 
@@ -230,6 +293,7 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 {
 	int ret;
 	unsigned int avg_bw_cpu;
+	unsigned int peak_bw_cpu;
 
 	if (speed_hz == ctrl->last_speed)
 		return 0;
@@ -241,12 +305,16 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 		return ret;
 	}
 
+	avg_bw_cpu = Bps_to_icc(speed_hz);
 	/*
-	 * Set BW quota for CPU as driver supports FIFO mode only.
-	 * We don't have explicit peak requirement so keep it equal to avg_bw.
+	 * Set BW quota for CPU for FIFO to avg_bw
+	 * as we don't have explicit peak requirement.
+	 * TBD TBD TBD - change this as required for DMA.
+	 * As of now same peak requirement seems to be working.
 	 */
-	avg_bw_cpu = Bps_to_icc(speed_hz);
-	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, avg_bw_cpu, avg_bw_cpu);
+	peak_bw_cpu = ctrl->xfer_mode == QSPI_FIFO ? avg_bw_cpu : avg_bw_cpu;
+
+	ret = icc_set_bw(ctrl->icc_path_cpu_to_qspi, avg_bw_cpu, peak_bw_cpu);
 	if (ret) {
 		dev_err(ctrl->dev, "%s: ICC BW voting failed for cpu: %d\n",
 			__func__, ret);
@@ -258,6 +326,186 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 	return 0;
 }
 
+/* aligned to 32 bytes, not to cross 1KB boundary */
+#define QSPI_ALIGN_REQ		32
+#define QSPI_BOUNDARY_REQ	1024
+
+int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
+			dma_addr_t dma_ptr, uint32_t n_bytes)
+{
+	struct qspi_cmd_desc *virt_cmd_desc, *prev;
+	uint8_t *virt_data_desc;
+	dma_addr_t dma_cmd_desc, dma_data_desc;
+
+	if (virt_ptr && n_bytes >= QSPI_ALIGN_REQ) {
+		dev_err(ctrl->dev,
+			"Exiting to avert memory overwrite, n_bytes-%d\n", n_bytes);
+		return -ENOMEM;
+	}
+
+	/* allocate for dma cmd descriptor */
+	virt_cmd_desc = (struct qspi_cmd_desc *)dma_pool_alloc(ctrl->dma_cmd_pool,
+		GFP_KERNEL, &dma_cmd_desc);
+	if (!virt_cmd_desc) {
+		dev_err(ctrl->dev,
+			"Could not allocate for cmd_desc\n");
+		return -ENOMEM;
+	}
+	ctrl->virt_cmd_desc[ctrl->n_cmd_desc] = virt_cmd_desc;
+	ctrl->dma_cmd_desc[ctrl->n_cmd_desc] = dma_cmd_desc;
+	ctrl->n_cmd_desc++;
+
+	/* allocate for dma data descriptor if unaligned else use pre-aligned */
+	if (virt_ptr) {
+		virt_data_desc = (uint8_t *)dma_pool_zalloc(ctrl->dma_data_pool,
+			GFP_KERNEL, &dma_data_desc);
+		if (!virt_data_desc) {
+			dev_err(ctrl->dev,
+				"Could not allocate for data_desc\n");
+			return -ENOMEM;
+		}
+		ctrl->virt_data_desc[ctrl->n_data_desc] = virt_data_desc;
+		ctrl->dma_data_desc[ctrl->n_data_desc] = dma_data_desc;
+		ctrl->n_data_desc++;
+
+		/*
+		 * for tx copy xfer data into allocated buffer
+		 * for rx setup bounce info to copy after xfer
+		 */
+		if (ctrl->xfer.dir == QSPI_WRITE) {
+			memcpy(virt_data_desc, virt_ptr, n_bytes);
+		} else {
+			virt_cmd_desc->bounce_src = virt_data_desc;
+			virt_cmd_desc->bounce_dst = virt_ptr;
+			virt_cmd_desc->bounce_length = n_bytes;
+		}
+	} else {
+		dma_data_desc = dma_ptr;
+	}
+
+	/* setup cmd descriptor */
+	virt_cmd_desc->data_address = (uint32_t)(uintptr_t)(dma_data_desc);
+	virt_cmd_desc->next_descriptor = 0;
+	virt_cmd_desc->direction = ctrl->xfer.dir;
+	virt_cmd_desc->multi_io_mode = ctrl->iomode;
+	virt_cmd_desc->reserved1 = 0;
+	virt_cmd_desc->fragment = 0;
+	virt_cmd_desc->reserved2 = 0;
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
+	unsigned int sg_total_len = 0;
+	dma_addr_t dma_ptr_sg;
+	unsigned int dma_len_sg;
+	uint32_t prolog_bytes, aligned_bytes, epilog_bytes;
+	dma_addr_t aligned_ptr;
+	int ii;
+	uint8_t *byte_ptr;
+
+	if (ctrl->n_cmd_desc || ctrl->n_data_desc) {
+		dev_err(ctrl->dev, "Remnant dma buffers cmd-%d, data-%d\n",
+			ctrl->n_cmd_desc, ctrl->n_data_desc);
+		return -EIO;
+	}
+
+	sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
+	if (!sgt->nents || sgt->nents > QSPI_QCOM_MAX_SG) {
+		dev_err(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
+		return -EINVAL;
+	}
+
+	for (ii = 0; ii < sgt->nents; ii++)
+		sg_total_len += sg_dma_len(sgt->sgl + ii);
+	if (sg_total_len != xfer->len) {
+		dev_err(ctrl->dev, "Data lengths mismatch\n");
+		return -EINVAL;
+	}
+
+	if (ctrl->xfer.dir == QSPI_READ)
+		byte_ptr = (uint8_t *)xfer->rx_buf;
+	else
+		byte_ptr = (uint8_t *)xfer->tx_buf;
+
+	for (ii = 0; ii < sgt->nents; ii++) {
+		dma_ptr_sg = sg_dma_address(sgt->sgl + ii);
+		dma_len_sg = sg_dma_len(sgt->sgl + ii);
+
+		aligned_ptr = PTR_ALIGN(dma_ptr_sg, QSPI_ALIGN_REQ);
+
+		prolog_bytes = min(dma_len_sg, (unsigned int)(aligned_ptr - dma_ptr_sg));
+		if (prolog_bytes) {
+			ret = qcom_qspi_alloc_desc(ctrl, byte_ptr, 0, prolog_bytes);
+			if (ret)
+				goto cleanup;
+			byte_ptr += prolog_bytes;
+		}
+
+		aligned_bytes = PTR_ALIGN_DOWN(dma_len_sg - prolog_bytes, QSPI_ALIGN_REQ);
+		if (aligned_bytes) {
+			ret = qcom_qspi_alloc_desc(ctrl, 0, aligned_ptr, aligned_bytes);
+			if (ret)
+				goto cleanup;
+			byte_ptr += aligned_bytes;
+		}
+
+		epilog_bytes = dma_len_sg - prolog_bytes - aligned_bytes;
+		if (epilog_bytes) {
+			ret = qcom_qspi_alloc_desc(ctrl, byte_ptr, 0, epilog_bytes);
+			if (ret)
+				goto cleanup;
+			byte_ptr += epilog_bytes;
+		}
+	}
+	return 0;
+
+cleanup:
+	dev_err(ctrl->dev, "ERROR cleanup in setup_dma_desc\n");
+	for (ii = 0; ii < ctrl->n_data_desc; ii++)
+		dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[ii],
+				  ctrl->dma_data_desc[ii]);
+	ctrl->n_data_desc = 0;
+
+	for (ii = 0; ii < ctrl->n_cmd_desc; ii++)
+		dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[ii],
+				  ctrl->dma_cmd_desc[ii]);
+	ctrl->n_cmd_desc = 0;
+	return ret;
+}
+
+static void qcom_qspi_dma_xfer(struct qcom_qspi *ctrl)
+{
+	/* Ack any previous interrupts that might be hanging around */
+	writel(DMA_CHAIN_DONE, ctrl->base + MSTR_INT_STATUS);
+
+	/* Setup new interrupts */
+	writel(DMA_CHAIN_DONE, ctrl->base + MSTR_INT_EN);
+
+	/* flush all writes */
+	wmb();
+
+	/* kick off transfer */
+	writel((uint32_t)(uintptr_t)(ctrl->dma_cmd_desc)[0], ctrl->base + NEXT_DMA_DESC_ADDR);
+}
+
+/* Switch to DMA if transfer length exceeds this */
+#define QSPI_MAX_BYTES_FIFO 64
+#define NO_TX_DATA_DELAY_FOR_DMA 1
+#define DMA_CONDITIONAL (xfer->len > QSPI_MAX_BYTES_FIFO)
+
 static int qcom_qspi_transfer_one(struct spi_master *master,
 				  struct spi_device *slv,
 				  struct spi_transfer *xfer)
@@ -266,6 +514,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	int ret;
 	unsigned long speed_hz;
 	unsigned long flags;
+	u32 mstr_cfg;
 
 	speed_hz = slv->max_speed_hz;
 	if (xfer->speed_hz)
@@ -276,6 +525,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		return ret;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
+	mstr_cfg = readl(ctrl->base + MSTR_CONFIG);
 
 	/* We are half duplex, so either rx or tx will be set */
 	if (xfer->rx_buf) {
@@ -290,7 +540,31 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	ctrl->xfer.is_last = list_is_last(&xfer->transfer_list,
 					  &master->cur_msg->transfers);
 	ctrl->xfer.rem_bytes = xfer->len;
-	qcom_qspi_pio_xfer(ctrl);
+
+	if (DMA_CONDITIONAL) {
+		ctrl->xfer_mode = QSPI_DMA;
+		ctrl->iomode = qspi_buswidth_to_iomode(ctrl, ctrl->xfer.buswidth);
+#if NO_TX_DATA_DELAY_FOR_DMA
+		mstr_cfg &= ~(TX_DATA_OE_DELAY_MSK | TX_DATA_DELAY_MSK);
+#endif
+		mstr_cfg &= ~FB_CLK_EN;
+		mstr_cfg &= ~PIN_WPN;
+		mstr_cfg |= DMA_ENABLE;
+		writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
+
+		ret = qcom_qspi_setup_dma_desc(ctrl, xfer);
+		if (ret) {
+			spin_unlock_irqrestore(&ctrl->lock, flags);
+			return ret;
+		}
+		qcom_qspi_dma_xfer(ctrl);
+	} else {
+		ctrl->xfer_mode = QSPI_FIFO;
+		mstr_cfg &= ~DMA_ENABLE;
+		mstr_cfg |= FB_CLK_EN | PIN_WPN;
+		writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
+		qcom_qspi_pio_xfer(ctrl);
+	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
@@ -298,6 +572,15 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	return 1;
 }
 
+static bool qcom_qspi_can_dma(struct spi_controller *ctlr,
+			 struct spi_device *slv, struct spi_transfer *xfer)
+{
+	if (DMA_CONDITIONAL)
+		return true;
+	else
+		return false;
+}
+
 static int qcom_qspi_prepare_message(struct spi_master *master,
 				     struct spi_message *message)
 {
@@ -328,6 +611,40 @@ static int qcom_qspi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
+static int qcom_qspi_alloc_dma(struct qcom_qspi *ctrl)
+{
+	/* allocate for cmd descriptors pool */
+	ctrl->dma_cmd_pool = dma_pool_create("qspi cmd desc pool",
+		ctrl->dev, sizeof(struct qspi_cmd_desc), 0, 0);
+	if (!ctrl->dma_cmd_pool) {
+		dev_err(ctrl->dev, "Could not create dma pool for cmd_desc\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * allocate for data descriptors pool as per alignment
+	 * and boundary requirements
+	 */
+	ctrl->dma_data_pool = dma_pool_create("qspi data desc pool",
+		ctrl->dev, QSPI_ALIGN_REQ, QSPI_ALIGN_REQ, QSPI_BOUNDARY_REQ);
+	if (!ctrl->dma_data_pool) {
+		dev_err(ctrl->dev, "Could not create dma pool for data desc\n");
+		dma_pool_destroy(ctrl->dma_cmd_pool);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void qcom_qspi_free_dma(struct qcom_qspi *ctrl)
+{
+	/* free pool buffers */
+	dma_pool_destroy(ctrl->dma_data_pool);
+
+	/* free pool */
+	dma_pool_destroy(ctrl->dma_cmd_pool);
+}
+
 static irqreturn_t pio_read(struct qcom_qspi *ctrl)
 {
 	u32 rd_fifo_status;
@@ -426,27 +743,58 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
 	int_status = readl(ctrl->base + MSTR_INT_STATUS);
 	writel(int_status, ctrl->base + MSTR_INT_STATUS);
 
-	if (ctrl->xfer.dir == QSPI_WRITE) {
-		if (int_status & WR_FIFO_EMPTY)
-			ret = pio_write(ctrl);
-	} else {
-		if (int_status & RESP_FIFO_RDY)
-			ret = pio_read(ctrl);
-	}
-
-	if (int_status & QSPI_ERR_IRQS) {
-		if (int_status & RESP_FIFO_UNDERRUN)
-			dev_err(ctrl->dev, "IRQ error: FIFO underrun\n");
-		if (int_status & WR_FIFO_OVERRUN)
-			dev_err(ctrl->dev, "IRQ error: FIFO overrun\n");
-		if (int_status & HRESP_FROM_NOC_ERR)
-			dev_err(ctrl->dev, "IRQ error: NOC response error\n");
-		ret = IRQ_HANDLED;
-	}
-
-	if (!ctrl->xfer.rem_bytes) {
-		writel(0, ctrl->base + MSTR_INT_EN);
-		spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
+	if (ctrl->xfer_mode == QSPI_FIFO) {
+		if (ctrl->xfer.dir == QSPI_WRITE) {
+			if (int_status & WR_FIFO_EMPTY)
+				ret = pio_write(ctrl);
+		} else {
+			if (int_status & RESP_FIFO_RDY)
+				ret = pio_read(ctrl);
+		}
+
+		if (int_status & QSPI_ERR_IRQS) {
+			if (int_status & RESP_FIFO_UNDERRUN)
+				dev_err(ctrl->dev, "IRQ error: FIFO underrun\n");
+			if (int_status & WR_FIFO_OVERRUN)
+				dev_err(ctrl->dev, "IRQ error: FIFO overrun\n");
+			if (int_status & HRESP_FROM_NOC_ERR)
+				dev_err(ctrl->dev, "IRQ error: NOC response error\n");
+			ret = IRQ_HANDLED;
+		}
+
+		if (!ctrl->xfer.rem_bytes) {
+			writel(0, ctrl->base + MSTR_INT_EN);
+			spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
+		}
+	} else if (ctrl->xfer_mode == QSPI_DMA) {
+		if (int_status & DMA_CHAIN_DONE) {
+			int ii;
+
+			writel(0, ctrl->base + MSTR_INT_EN);
+
+			if (ctrl->xfer.dir == QSPI_READ) {
+				struct qspi_cmd_desc *cmd_desc;
+
+				for (ii = 0; ii < ctrl->n_cmd_desc; ii++) {
+					cmd_desc = (struct qspi_cmd_desc *)ctrl->virt_cmd_desc[ii];
+					memcpy(cmd_desc->bounce_dst,
+						cmd_desc->bounce_src, cmd_desc->bounce_length);
+				}
+			}
+
+			for (ii = 0; ii < ctrl->n_data_desc; ii++)
+				dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[ii],
+						  ctrl->dma_data_desc[ii]);
+			ctrl->n_data_desc = 0;
+
+			for (ii = 0; ii < ctrl->n_cmd_desc; ii++)
+				dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[ii],
+						  ctrl->dma_cmd_desc[ii]);
+			ctrl->n_cmd_desc = 0;
+
+			ret = IRQ_HANDLED;
+			spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
+		}
 	}
 
 	spin_unlock(&ctrl->lock);
@@ -487,6 +835,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* set default mode to FIFO */
+	ctrl->xfer_mode = QSPI_FIFO;
+
 	ctrl->icc_path_cpu_to_qspi = devm_of_icc_get(dev, "qspi-config");
 	if (IS_ERR(ctrl->icc_path_cpu_to_qspi))
 		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
@@ -517,7 +868,12 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret, "could not set DMA mask\n");
+
 	master->max_speed_hz = 300000000;
+	master->max_dma_len = 65536; /* as per HPG */
 	master->num_chipselect = QSPI_NUM_CS;
 	master->bus_num = -1;
 	master->dev.of_node = pdev->dev.of_node;
@@ -528,6 +884,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->prepare_message = qcom_qspi_prepare_message;
 	master->transfer_one = qcom_qspi_transfer_one;
 	master->handle_err = qcom_qspi_handle_err;
+	master->can_dma = qcom_qspi_can_dma;
 	master->auto_runtime_pm = true;
 
 	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
@@ -540,6 +897,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* allocate for DMA descriptor pools */
+	ret = qcom_qspi_alloc_dma(ctrl);
+	if (ret)
+		return ret;
+
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 250);
 	pm_runtime_enable(dev);
@@ -556,10 +918,15 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 static void qcom_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
+	struct qcom_qspi *ctrl;
+
+	ctrl = spi_master_get_devdata(master);
 
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_master(master);
 
+	qcom_qspi_free_dma(ctrl);
+
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

