Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBC6DFA21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjDLPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjDLPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:30:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B5900E;
        Wed, 12 Apr 2023 08:30:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CEmXG0003749;
        Wed, 12 Apr 2023 15:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=uR7GxkthQYKOzPjZR55reU+IY6kdeyBGUUprzyaMRn4=;
 b=WJVWqiHRD6smKo1uy7BHEwj4vQBNaFjdUvGLbHtSNBHq+mqRk91j29MJO5D29eOmvAf1
 lY2WQ3m3dA9by1psuc/ldc3pU5B14BEhM8obnfFciDf0a4Dq2Z/gN9Ncqa+xUJnmybBQ
 UUxy2h3DoF7M/Sm7EHdZfSuxUDg5UPvfb/jr/T3mSajUuo3W1jInHDmfcHTnXX3BxOVi
 AQZnaFSfvrlmlpzVhggvIM+lBhqPpgJrjLNhRdXEfEIEktggIzkgnS5Rv56Q1CVXxNBS
 UBLoFDnPa7VsKsLNRtCb8vxms0ZEzdTujSSs+2JT1NHgrXUpnv5hwYQiR4jravCTJ7pN Yw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwwdp8ajx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:29:57 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33CFTsaA027932;
        Wed, 12 Apr 2023 15:29:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3pu1bksuh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Apr 2023 15:29:54 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33CFTrKK027922;
        Wed, 12 Apr 2023 15:29:53 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 33CFTrKv027921;
        Wed, 12 Apr 2023 15:29:53 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 108E5453F; Wed, 12 Apr 2023 20:59:53 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V2 3/3] spi: spi-qcom-qspi: Add DMA mode support
Date:   Wed, 12 Apr 2023 20:59:47 +0530
Message-Id: <1681313387-8376-4-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1681313387-8376-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1681313387-8376-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PJ37HsXeIzc5fcBCiomYFdiWqEom_msz
X-Proofpoint-ORIG-GUID: PJ37HsXeIzc5fcBCiomYFdiWqEom_msz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120136
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver supports only PIO mode.

HW supports DMA, so add DMA mode support to the driver
for better performance for larger xfers.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304050512.MN2oNY9Z-lkp@intel.com/
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
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
---
 drivers/spi/spi-qcom-qspi.c | 434 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 403 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index fab1553..1b53480 100644
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
@@ -14,7 +16,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
-
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
@@ -120,6 +126,27 @@ enum qspi_dir {
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
+	/*
+	 * This marks end of HW cmd descriptor
+	 * Fields down below are for SW usage to
+	 * copy data from DMA buffer to rx buffer
+	 */
+	u8 *bounce_src;
+	u8 *bounce_dst;
+	u32 bounce_length;
+};
+
+#define QSPI_MAX_NUM_DESC 5
+
 struct qspi_xfer {
 	union {
 		const void *tx_buf;
@@ -137,11 +164,36 @@ enum qspi_clocks {
 	QSPI_NUM_CLKS
 };
 
+enum qspi_xfer_mode {
+	QSPI_INVALID,
+	QSPI_FIFO,
+	QSPI_DMA
+};
+
+/* number of entries in sgt returned from spi framework that we can support */
+#define QSPI_MAX_SG 5
+
+/* 3 descriptors for head, aligned part and tail */
+#define QSPI_NUM_CMD_DESC 3
+
+/* 2 descriptors for head, tail */
+#define QSPI_NUM_DAT_DESC 2
+
 struct qcom_qspi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk_bulk_data *clks;
 	struct qspi_xfer xfer;
+	struct dma_pool *dma_cmd_pool;
+	struct dma_pool *dma_data_pool;
+	dma_addr_t dma_cmd_desc[QSPI_NUM_CMD_DESC*QSPI_MAX_SG];
+	dma_addr_t dma_data_desc[QSPI_NUM_DAT_DESC*QSPI_MAX_SG];
+	void *virt_cmd_desc[QSPI_NUM_CMD_DESC*QSPI_MAX_SG];
+	void *virt_data_desc[QSPI_NUM_DAT_DESC*QSPI_MAX_SG];
+	unsigned int n_cmd_desc;
+	unsigned int n_data_desc;
+	int xfer_mode;
+	u32 iomode;
 	struct icc_path *icc_path_cpu_to_qspi;
 	unsigned long last_speed;
 	/* Lock to protect data accessed by IRQs */
@@ -151,18 +203,25 @@ struct qcom_qspi {
 static u32 qspi_buswidth_to_iomode(struct qcom_qspi *ctrl,
 				   unsigned int buswidth)
 {
+	u32 ret;
+
+	/* for DMA we don't write to PIO_XFER_CFG register, so don't shift */
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
@@ -223,6 +282,21 @@ static void qcom_qspi_handle_err(struct spi_master *master,
 	spin_lock_irqsave(&ctrl->lock, flags);
 	writel(0, ctrl->base + MSTR_INT_EN);
 	ctrl->xfer.rem_bytes = 0;
+
+	if (ctrl->xfer_mode == QSPI_DMA) {
+		int i;
+
+		/* free cmd and data descriptors */
+		for (i = 0; i < ctrl->n_data_desc; i++)
+			dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[i],
+					  ctrl->dma_data_desc[i]);
+		ctrl->n_data_desc = 0;
+
+		for (i = 0; i < ctrl->n_cmd_desc; i++)
+			dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
+					  ctrl->dma_cmd_desc[i]);
+		ctrl->n_cmd_desc = 0;
+	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 }
 
@@ -230,6 +304,7 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 {
 	int ret;
 	unsigned int avg_bw_cpu;
+	unsigned int peak_bw_cpu;
 
 	if (speed_hz == ctrl->last_speed)
 		return 0;
@@ -241,12 +316,16 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
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
@@ -258,6 +337,190 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
 	return 0;
 }
 
+/* aligned to 32 bytes, not to cross 1KB boundary */
+#define QSPI_ALIGN_REQ		32
+#define QSPI_BOUNDARY_REQ	1024
+
+static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
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
+	virt_cmd_desc->data_address = dma_data_desc;
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
+	dma_addr_t aligned_addr;
+	int i;
+	uint8_t *byte_ptr;
+
+	if (ctrl->n_cmd_desc || ctrl->n_data_desc) {
+		dev_err(ctrl->dev, "Remnant dma buffers cmd-%d, data-%d\n",
+			ctrl->n_cmd_desc, ctrl->n_data_desc);
+		return -EIO;
+	}
+
+	sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
+	if (!sgt->nents || sgt->nents > QSPI_MAX_SG) {
+		dev_err(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < sgt->nents; i++)
+		sg_total_len += sg_dma_len(sgt->sgl + i);
+	if (sg_total_len != xfer->len) {
+		dev_err(ctrl->dev, "Data lengths mismatch\n");
+		return -EINVAL;
+	}
+
+	if (ctrl->xfer.dir == QSPI_READ)
+		byte_ptr = xfer->rx_buf;
+	else
+		byte_ptr = (uint8_t *)xfer->tx_buf;
+
+	for (i = 0; i < sgt->nents; i++) {
+		dma_ptr_sg = sg_dma_address(sgt->sgl + i);
+		dma_len_sg = sg_dma_len(sgt->sgl + i);
+
+		aligned_addr = PTR_ALIGN(dma_ptr_sg, QSPI_ALIGN_REQ);
+
+		prolog_bytes = min(dma_len_sg, (unsigned int)(aligned_addr - dma_ptr_sg));
+		if (prolog_bytes) {
+			ret = qcom_qspi_alloc_desc(ctrl, byte_ptr, 0, prolog_bytes);
+			if (ret)
+				goto cleanup;
+			byte_ptr += prolog_bytes;
+		}
+
+		aligned_bytes = PTR_ALIGN_DOWN(dma_len_sg - prolog_bytes, QSPI_ALIGN_REQ);
+		if (aligned_bytes) {
+			ret = qcom_qspi_alloc_desc(ctrl, 0, aligned_addr, aligned_bytes);
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
+	for (i = 0; i < ctrl->n_data_desc; i++)
+		dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[i],
+				  ctrl->dma_data_desc[i]);
+	ctrl->n_data_desc = 0;
+
+	for (i = 0; i < ctrl->n_cmd_desc; i++)
+		dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
+				  ctrl->dma_cmd_desc[i]);
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
+
+static bool qcom_qspi_can_dma(struct spi_controller *ctlr,
+			 struct spi_device *slv, struct spi_transfer *xfer)
+{
+	return xfer->len > QSPI_MAX_BYTES_FIFO ? true : false;
+}
+
 static int qcom_qspi_transfer_one(struct spi_master *master,
 				  struct spi_device *slv,
 				  struct spi_transfer *xfer)
@@ -266,6 +529,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	int ret;
 	unsigned long speed_hz;
 	unsigned long flags;
+	u32 mstr_cfg;
 
 	speed_hz = slv->max_speed_hz;
 	if (xfer->speed_hz)
@@ -276,6 +540,7 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 		return ret;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
+	mstr_cfg = readl(ctrl->base + MSTR_CONFIG);
 
 	/* We are half duplex, so either rx or tx will be set */
 	if (xfer->rx_buf) {
@@ -290,7 +555,25 @@ static int qcom_qspi_transfer_one(struct spi_master *master,
 	ctrl->xfer.is_last = list_is_last(&xfer->transfer_list,
 					  &master->cur_msg->transfers);
 	ctrl->xfer.rem_bytes = xfer->len;
-	qcom_qspi_pio_xfer(ctrl);
+
+	if (qcom_qspi_can_dma(master, slv, xfer)) {
+		ctrl->xfer_mode = QSPI_DMA;
+		ctrl->iomode = qspi_buswidth_to_iomode(ctrl, ctrl->xfer.buswidth);
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
+		writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
+		qcom_qspi_pio_xfer(ctrl);
+	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
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
@@ -426,27 +743,63 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
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
+	switch (ctrl->xfer_mode) {
+	case QSPI_FIFO:
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
+		break;
+	case QSPI_DMA:
+		if (int_status & DMA_CHAIN_DONE) {
+			int i;
+
+			writel(0, ctrl->base + MSTR_INT_EN);
+
+			if (ctrl->xfer.dir == QSPI_READ) {
+				struct qspi_cmd_desc *cmd_desc;
+
+				for (i = 0; i < ctrl->n_cmd_desc; i++) {
+					cmd_desc = (struct qspi_cmd_desc *)ctrl->virt_cmd_desc[i];
+					memcpy(cmd_desc->bounce_dst,
+						cmd_desc->bounce_src, cmd_desc->bounce_length);
+				}
+			}
+
+			for (i = 0; i < ctrl->n_data_desc; i++)
+				dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[i],
+						  ctrl->dma_data_desc[i]);
+			ctrl->n_data_desc = 0;
+
+			for (i = 0; i < ctrl->n_cmd_desc; i++)
+				dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
+						  ctrl->dma_cmd_desc[i]);
+			ctrl->n_cmd_desc = 0;
+
+			ret = IRQ_HANDLED;
+			spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
+		}
+		break;
+	default:
+		dev_err(ctrl->dev, "Unknown xfer mode:%d", ctrl->xfer_mode);
 	}
 
 	spin_unlock(&ctrl->lock);
@@ -487,6 +840,9 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* set default mode to FIFO */
+	ctrl->xfer_mode = QSPI_FIFO;
+
 	ctrl->icc_path_cpu_to_qspi = devm_of_icc_get(dev, "qspi-config");
 	if (IS_ERR(ctrl->icc_path_cpu_to_qspi))
 		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
@@ -517,7 +873,12 @@ static int qcom_qspi_probe(struct platform_device *pdev)
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
@@ -528,6 +889,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	master->prepare_message = qcom_qspi_prepare_message;
 	master->transfer_one = qcom_qspi_transfer_one;
 	master->handle_err = qcom_qspi_handle_err;
+	master->can_dma = qcom_qspi_can_dma;
 	master->auto_runtime_pm = true;
 
 	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
@@ -540,6 +902,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
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
@@ -556,10 +923,15 @@ static int qcom_qspi_probe(struct platform_device *pdev)
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

