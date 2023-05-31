Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6671813A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbjEaNQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbjEaNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:16:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74773B2;
        Wed, 31 May 2023 06:16:08 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V6sI2F005249;
        Wed, 31 May 2023 12:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=mDNAvRXyyVsyHzROMwIT72j+peOPpcPUotIbFGJAOPg=;
 b=VgG+rlbFhYR6rRKXFiObb5Zw/neISidSw4m/1b4TXBYpZOzcaYWe4yI/Oc7p9mE7evHc
 ApfsiBzQhPN4d1VqRE5vw/VaD6a5V4fD/W6aXIMUx7cNGvCfu/T4edsM0AmBjjYXKS5g
 8IcjuCz0RzfftcOuWWr4ZCVsbh1ct+HD6l0BWPY49iuhaybgLiKzb+BqGjNMpaFOeRy4
 Lb/KnrzpzY6SzuR+loPkf8NAIBo60QQiSE0GfyYQeQaKUdEcR8X1olJuXjc4PNgjHOQc
 x87chv1/mPepLsP3/7lgqyaR63IlgyGmUZAeapCG/sIoL9dpT2KWFvufKQ/ybupEkqLh 7w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwwbth80f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 12:50:02 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34VCnw1j021025;
        Wed, 31 May 2023 12:49:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3quaxkdvyu-1;
        Wed, 31 May 2023 12:49:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VCnweE021019;
        Wed, 31 May 2023 12:49:58 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34VCnvIg021018;
        Wed, 31 May 2023 12:49:57 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id BA6BB12010C1; Wed, 31 May 2023 18:19:56 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH v3 1/5] mtd: rawnand: qcom: Implement exec_op()
Date:   Wed, 31 May 2023 18:19:49 +0530
Message-Id: <20230531124953.21007-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b-N6cMDx__Mz5iYGZBEBiIu6h-TJJ9bn
X-Proofpoint-ORIG-GUID: b-N6cMDx__Mz5iYGZBEBiIu6h-TJJ9bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_07,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310109
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement exec_op() so we can later get rid of the legacy interface
implementation.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v3]

* Removed NAND_CMD_STATUS check in pre_command and move
  it to status exec_op.

* Removed min() , since this check not needed

* Removed all the dummy APIs of exec_ops, and added it
  into same patch where its getting added.

* Added qcom_check_op() API to check for unsupported feature
  by controller in check_only path.

Change in [v2]

* Missed to post Cover-letter, so posting v2 patch with cover-letter

Change in [v1]

* Added initial support for exec_ops.
   
 drivers/mtd/nand/raw/qcom_nandc.c | 159 ++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 72d6168d8a1b..d9c4c9fe2fe8 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -157,6 +157,7 @@
 #define	OP_PAGE_PROGRAM_WITH_ECC	0x7
 #define	OP_PROGRAM_PAGE_SPARE		0x9
 #define	OP_BLOCK_ERASE			0xa
+#define	OP_CHECK_STATUS			0xc
 #define	OP_FETCH_ID			0xb
 #define	OP_RESET_DEVICE			0xd
 
@@ -235,6 +236,8 @@ nandc_set_reg(chip, reg,			\
  */
 #define NAND_ERASED_CW_SET		BIT(4)
 
+#define MAX_ADDRESS_CYCLE		5
+#define MAX_CHUNK_SIZE			SZ_8K
 /*
  * This data type corresponds to the BAM transaction which will be used for all
  * NAND transfers.
@@ -447,6 +450,29 @@ struct qcom_nand_boot_partition {
 	u32 page_size;
 };
 
+/*
+ * Qcom op for each exec_op transfer
+ *
+ * @data_instr:			data instruction pointer
+ * @data_instr_idx:		data instruction index
+ * @rdy_timeout_ms:		wait ready timeout in ms
+ * @rdy_delay_ns:		Additional delay in ns
+ * @addr1_reg:			Address1 register value
+ * @addr2_reg:			Address2 register value
+ * @cmd_reg:			CMD register value
+ * @flag:			flag for misc instruction
+ */
+struct qcom_op {
+	const struct nand_op_instr *data_instr;
+	unsigned int data_instr_idx;
+	unsigned int rdy_timeout_ms;
+	unsigned int rdy_delay_ns;
+	u32 addr1_reg;
+	u32 addr2_reg;
+	u32 cmd_reg;
+	u8 flag;
+};
+
 /*
  * NAND chip structure
  *
@@ -2867,8 +2893,141 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	return 0;
 }
 
+static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
+			       struct qcom_op *q_op)
+{
+	int ret;
+
+	switch (cmd) {
+	case NAND_CMD_RESET:
+		ret = OP_RESET_DEVICE;
+		break;
+	case NAND_CMD_READID:
+		ret = OP_FETCH_ID;
+		break;
+	case NAND_CMD_PARAM:
+		if (nandc->props->qpic_v2)
+			ret = OP_PAGE_READ_ONFI_READ;
+		else
+			ret = OP_PAGE_READ;
+		break;
+	case NAND_CMD_ERASE1:
+	case NAND_CMD_ERASE2:
+		ret = OP_BLOCK_ERASE;
+		break;
+	case NAND_CMD_STATUS:
+		ret = OP_CHECK_STATUS;
+		break;
+	case NAND_CMD_PAGEPROG:
+		ret = OP_PROGRAM_PAGE;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/* NAND framework ->exec_op() hooks and related helpers */
+static void qcom_parse_instructions(struct nand_chip *chip,
+				    const struct nand_subop *subop,
+					struct qcom_op *q_op)
+{
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id;
+	int i;
+
+	memset(q_op, 0, sizeof(*q_op));
+
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		unsigned int offset, naddrs;
+		const u8 *addrs;
+
+		instr = &subop->instrs[op_id];
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			q_op->cmd_reg = qcom_op_cmd_mapping(nandc, instr->ctx.cmd.opcode, q_op);
+			q_op->rdy_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			offset = nand_subop_get_addr_start_off(subop, op_id);
+			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+			addrs = &instr->ctx.addr.addrs[offset];
+			for (i = 0; i < MAX_ADDRESS_CYCLE; i++) {
+				if (i < 4)
+					q_op->addr1_reg |= (u32)addrs[i] << i * 8;
+				else
+					q_op->addr2_reg |= addrs[i];
+			}
+			q_op->rdy_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			q_op->data_instr = instr;
+			q_op->data_instr_idx = op_id;
+			q_op->rdy_delay_ns = instr->delay_ns;
+			fallthrough;
+		case NAND_OP_DATA_OUT_INSTR:
+			q_op->rdy_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			q_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
+			q_op->rdy_delay_ns = instr->delay_ns;
+			break;
+		}
+	}
+}
+
+static int qcom_check_op(struct nand_chip *chip,
+			 const struct nand_operation *op)
+{
+	const struct nand_op_instr *instr;
+	int op_id;
+
+	for (op_id = 0; op_id < op->ninstrs; op_id++) {
+		instr = &op->instrs[op_id];
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			if (instr->ctx.cmd.opcode == NAND_CMD_READCACHESEQ ||
+			    instr->ctx.cmd.opcode == NAND_CMD_READCACHEEND)
+				return -ENOTSUPP;
+			break;
+		case NAND_OP_ADDR_INSTR:
+			if (instr->ctx.addr.naddrs > MAX_ADDRESS_CYCLE)
+				return -ENOTSUPP;
+
+			break;
+		case NAND_OP_DATA_IN_INSTR:
+		case NAND_OP_DATA_OUT_INSTR:
+			if (instr->ctx.data.len > MAX_CHUNK_SIZE)
+				return -ENOTSUPP;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_nand_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			bool check_only)
+{
+	if (check_only)
+		return qcom_check_op(chip, op);
+
+	return 0;
+}
+
 static const struct nand_controller_ops qcom_nandc_ops = {
 	.attach_chip = qcom_nand_attach_chip,
+	.exec_op = qcom_nand_exec_op,
 };
 
 static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
-- 
2.17.1

