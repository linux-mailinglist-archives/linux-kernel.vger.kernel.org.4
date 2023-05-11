Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC356FF222
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjEKNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbjEKNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:08:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC13C23;
        Thu, 11 May 2023 06:08:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BBZwAC018411;
        Thu, 11 May 2023 13:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=3IcP6A3mNQLGkEjlvAYCnSeUmP/5QEqTIFvl2GxZxu8=;
 b=N9zus8AjoW9oD6Vr2Vb+klmyvWigJbaKMlayF2TRC5V2U+lC3Am4Hy/cNaTYHLZvFqru
 wJ/rus6N1Ann7zxzcyYkBZaRik4PSk3fqYQe1oABn/EDDVnF0JQrpAsGwSjKjihOD768
 uKB7uT0imINNEkc399Vw3X7BkEXtSSwij3PgyE7LqiRoPo2XF54/ybA83lm8/C7jo/lJ
 qxgNHuQZQ5bFkMJ18StuJfj7kCCcrtH0s9WUhFOqwUsGHVIejOMEmb8GoL2hDVnNmYC4
 iSaHugrsEGPFzYSGstltOfp01a8dhD6Gx5qqijDaur9QUnR2eaEw0SeKSP5+IYgrDkFY 1g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgm5m1ntq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 13:07:39 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34BD7a0B013416;
        Thu, 11 May 2023 13:07:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qdy5bq6r6-1;
        Thu, 11 May 2023 13:07:36 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BD7aJg013404;
        Thu, 11 May 2023 13:07:36 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34BD7axR013403;
        Thu, 11 May 2023 13:07:36 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 879ED12010C1; Thu, 11 May 2023 18:37:35 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        0000-cover-letter.patch@qualcomm.com
Subject: [PATCH 2/5] mtd: rawnand: qcom: Add support for reset, readid, status exec_op
Date:   Thu, 11 May 2023 18:37:27 +0530
Message-Id: <20230511130730.28689-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511130730.28689-1-quic_mdalam@quicinc.com>
References: <20230511130730.28689-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pkMECg8ZAN4XkxzgiiZP3XXA4wvuI5D1
X-Proofpoint-ORIG-GUID: pkMECg8ZAN4XkxzgiiZP3XXA4wvuI5D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110113
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will add exec_ops support for RESET , READ_ID, STATUS
command.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 166 +++++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index dae460e2aa0b..d2f2a8971907 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -384,6 +384,9 @@ struct nandc_regs {
  * @reg_read_pos:		marker for data read in reg_read_buf
  *
  * @cmd1/vld:			some fixed controller register values
+ *
+ * @exec_opwrite:		flag to select correct number of code word
+ *				while reading status
  */
 struct qcom_nand_controller {
 	struct device *dev;
@@ -434,6 +437,7 @@ struct qcom_nand_controller {
 	int reg_read_pos;
 
 	u32 cmd1, vld;
+	bool exec_opwrite;
 };
 
 /*
@@ -2920,6 +2924,8 @@ static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
 		break;
 	case NAND_CMD_PAGEPROG:
 		ret = OP_PROGRAM_PAGE;
+		q_op->flag = NAND_CMD_PAGEPROG;
+		nandc->exec_opwrite = true;
 		break;
 	default:
 		break;
@@ -2982,10 +2988,95 @@ static void qcom_parse_instructions(struct nand_chip *chip,
 	}
 }
 
+static void qcom_delay_ns(unsigned int ns)
+{
+	if (!ns)
+		return;
+
+	if (ns < 10000)
+		ndelay(ns);
+	else
+		udelay(DIV_ROUND_UP(ns, 1000));
+}
+
+static int qcom_wait_rdy_poll(struct nand_chip *chip, unsigned int time_ms)
+{
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	unsigned long start = jiffies + msecs_to_jiffies(time_ms);
+	u32 flash;
+
+	nandc_read_buffer_sync(nandc, true);
+
+	do {
+		flash = le32_to_cpu(nandc->reg_read_buf[0]);
+		if (flash & FS_READY_BSY_N)
+			return 0;
+		cpu_relax();
+	} while (time_after(start, jiffies));
+
+	dev_err(nandc->dev, "Timeout waiting for device to be ready:0x%08x\n", flash);
+
+	return -ETIMEDOUT;
+}
+
 static int qcom_read_status_exec(struct nand_chip *chip,
 				 const struct nand_subop *subop)
 {
-	return 0;
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct qcom_op q_op;
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id = 0;
+	unsigned int len = 0;
+	int ret = 0, num_cw = 1, i;
+	u32 flash_status;
+
+	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	if (nandc->exec_opwrite) {
+		num_cw = ecc->steps;
+		nandc->exec_opwrite = false;
+	}
+
+	pre_command(host, NAND_CMD_STATUS);
+
+	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
+
+	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+
+	ret = submit_descs(nandc);
+	if (ret)
+		dev_err(nandc->dev, "failure in sbumitting status descriptor\n");
+
+	free_descs(nandc);
+
+	nandc_read_buffer_sync(nandc, true);
+	for (i = 0; i < num_cw; i++) {
+		flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
+
+	if (flash_status & FS_MPU_ERR)
+		host->status &= ~NAND_STATUS_WP;
+
+	if (flash_status & FS_OP_ERR || (i == (num_cw - 1) &&
+					 (flash_status & FS_DEVICE_STS_ERR)))
+		host->status |= NAND_STATUS_FAIL;
+	}
+
+	flash_status = host->status;
+
+	instr = q_op.data_instr;
+	op_id = q_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+	memcpy(instr->ctx.data.buf.in, &flash_status, len);
+
+	return ret;
 }
 
 static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
@@ -3000,12 +3091,81 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 
 static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
 {
-	return 0;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_op q_op;
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id = 0;
+	unsigned int len = 0;
+	int ret = 0;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	pre_command(host, NAND_CMD_READID);
+
+	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
+	nandc_set_reg(chip, NAND_ADDR0, q_op.addr1_reg);
+	nandc_set_reg(chip, NAND_ADDR1, q_op.addr2_reg);
+	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
+		      nandc->props->is_bam ? 0 : DM_EN);
+
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
+
+	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
+	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
+
+	ret = submit_descs(nandc);
+	if (ret)
+		dev_err(nandc->dev, "failure in sbumitting read id descriptor\n");
+
+	free_descs(nandc);
+
+	instr = q_op.data_instr;
+	op_id = q_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+
+	nandc_read_buffer_sync(nandc, true);
+	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
+
+	return ret;
 }
 
 static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
 {
-	return 0;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_op q_op;
+	int ret = 0;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	if (q_op.flag == NAND_CMD_PAGEPROG)
+		goto wait_rdy;
+
+	pre_command(host, NAND_CMD_RESET);
+
+	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
+
+	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+
+	ret = submit_descs(nandc);
+	if (ret)
+		dev_err(nandc->dev, "failure in sbumitting misc descriptor\n");
+
+	free_descs(nandc);
+
+wait_rdy:
+	qcom_delay_ns(q_op.rdy_delay_ns);
+
+	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
+
+	return ret;
 }
 
 static int qcom_data_read_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
-- 
2.17.1

