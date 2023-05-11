Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594F06FF225
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjEKNIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjEKNIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:08:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8AF5BA6;
        Thu, 11 May 2023 06:08:02 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BAJCLb020252;
        Thu, 11 May 2023 13:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=9PeeTgq03vVFK969qWl3xs+1WsXoKKbi0gI2EhENzdA=;
 b=Q5iaTwASZQ9SQIbA9I+r0F/iJZ/2gLaRBIL/WME7yQWo71TAgVBxgHGgavh7WxSA2x+I
 slwBr/ZeYLOssz3piNfgY7JkkVhni4Iv7Fme+NtwXeYtJtvGIpPsazKGmNW818m/UCDq
 N1GT7vTAORZH8Wui+CBDWsTpJm9XYNlzZ57rXpG8OhVHIyFTjsgKsyysTlSnbtVRQLYL
 7P/TR9q5l3TRwMRjA6X67Ir9HQdypyZxVLuzd0HtvukI0Rb5lGpnTA5JoqjUo+ENRMAG
 mL7zcOW5zQu62+3R6gsXIMv0uBmfA81E5bOAMCfER9v2OA9pBCH3UStR0hqSNwc8tWpR CA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgm5m1ntp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 13:07:39 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34BD7ZEX013394;
        Thu, 11 May 2023 13:07:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qdy5bq6qy-1;
        Thu, 11 May 2023 13:07:35 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BD7YBC013387;
        Thu, 11 May 2023 13:07:34 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34BD7Yt6013386;
        Thu, 11 May 2023 13:07:34 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id BB29612010C1; Thu, 11 May 2023 18:37:33 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        0000-cover-letter.patch@qualcomm.com
Subject: [PATCH 1/5] mtd: rawnand: qcom: Implement exec_op()
Date:   Thu, 11 May 2023 18:37:26 +0530
Message-Id: <20230511130730.28689-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jCDqJlVfqWgBPE5pvVWn4K_YETHJxzK8
X-Proofpoint-ORIG-GUID: jCDqJlVfqWgBPE5pvVWn4K_YETHJxzK8
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

Implement exec_op() so we can later get rid of the legacy interface
implementation.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 214 +++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 72d6168d8a1b..dae460e2aa0b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -157,6 +157,7 @@
 #define	OP_PAGE_PROGRAM_WITH_ECC	0x7
 #define	OP_PROGRAM_PAGE_SPARE		0x9
 #define	OP_BLOCK_ERASE			0xa
+#define	OP_CHECK_STATUS			0xc
 #define	OP_FETCH_ID			0xb
 #define	OP_RESET_DEVICE			0xd
 
@@ -235,6 +236,7 @@ nandc_set_reg(chip, reg,			\
  */
 #define NAND_ERASED_CW_SET		BIT(4)
 
+#define MAX_ADDRESS_CYCLE		5
 /*
  * This data type corresponds to the BAM transaction which will be used for all
  * NAND transfers.
@@ -447,6 +449,29 @@ struct qcom_nand_boot_partition {
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
@@ -1517,7 +1542,8 @@ static void pre_command(struct qcom_nand_host *host, int command)
 	clear_read_regs(nandc);
 
 	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
-	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
+	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1 ||
+	    command == NAND_CMD_STATUS)
 		clear_bam_transaction(nandc);
 }
 
@@ -2867,8 +2893,194 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	return 0;
 }
 
+static int qcom_op_cmd_mapping(struct qcom_nand_controller *nandc, u8 cmd,
+			       struct qcom_op *q_op)
+{
+	int ret = 0;
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
+			for (i = 0; i < min(5U, naddrs); i++) {
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
+static int qcom_read_status_exec(struct nand_chip *chip,
+				 const struct nand_subop *subop)
+{
+	return 0;
+}
+
+static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
+	return 0;
+}
+
+static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_subop *subop)
+{
+	return 0;
+}
+
+static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
+	return 0;
+}
+
+static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
+	return 0;
+}
+
+static int qcom_data_read_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
+	/* currently read_exec_op() return 0 , and all the read operation handle in
+	 * actual API itself
+	 */
+	return 0;
+}
+
+static int qcom_data_write_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
+	/* currently write_exec_op() return 0, and all the write operation handle in
+	 * actual API itself
+	 */
+	struct qcom_op q_op;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	return 0;
+}
+
+static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
+		NAND_OP_PARSER_PATTERN(
+			qcom_misc_cmd_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_read_id_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_param_page_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_read_status_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_erase_cmd_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_data_read_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_data_write_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(true),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(true, MAX_ADDRESS_CYCLE)),
+		);
+
+static int qcom_nand_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			bool check_only)
+{
+	if (check_only)
+		return 0;
+
+	return nand_op_parser_exec_op(chip, &qcom_op_parser,
+			op, check_only);
+}
+
 static const struct nand_controller_ops qcom_nandc_ops = {
 	.attach_chip = qcom_nand_attach_chip,
+	.exec_op = qcom_nand_exec_op,
 };
 
 static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
-- 
2.17.1

