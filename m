Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B874CC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjGJFpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGJFpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:45:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D98EE5;
        Sun,  9 Jul 2023 22:45:06 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A5Er62002459;
        Mon, 10 Jul 2023 05:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=s0oYLEK++NyztWP7vXKPgRIObmeCiFSDyJzDgAIF+6Q=;
 b=bxkiWITelNVh282U+MdLWsVx7dAl5qlQBzn3bKTrvWgtXSnLJEP9nBFUf4ZJBzsHPZLK
 BikVOLdc8G3OszD3djwIwxrOk25aMvZVf1t93IewJe5SagkMcjLlkXHAnLqj0xnejSmM
 qUxBJZsOj/1pAmBkKYvEATPfMAiN8TbaQn5JLaeeOIC12S5w4neE66mO8okIne4EBPuk
 5SE0zbgA+5Ku9H2TRgHTtY+ZTC2E0WK1CB+IE66KPAejcn4/nDGwM8WscQDS7SKvK1j0
 u+FHoF4NmGYmPHa1ys7yb/OLH3TaZv1i89hWAu3oYLIwb2aBbh3AMznaj9Fw6wCWsr5Q 3g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpyw1tk4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 05:44:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36A5ihwG013297;
        Mon, 10 Jul 2023 05:44:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rq0vkcgd1-1;
        Mon, 10 Jul 2023 05:44:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36A5ihVJ013292;
        Mon, 10 Jul 2023 05:44:43 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36A5igJ5013291;
        Mon, 10 Jul 2023 05:44:43 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 387FD12010C1; Mon, 10 Jul 2023 11:14:42 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH v5 1/2] mtd: rawnand: qcom: Implement exec_op()
Date:   Mon, 10 Jul 2023 11:14:39 +0530
Message-Id: <20230710054440.23297-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PUglk67rg4KWE1K1W8DM9bYr-BUAAS9V
X-Proofpoint-ORIG-GUID: PUglk67rg4KWE1K1W8DM9bYr-BUAAS9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100052
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement exec_op() so we can later get rid of the legacy
interface implementation.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v5]

* Combine all the exec_op() operation in single patch.

* Added new line after MAX_ADDRESS_CYCLE.

* Removed default: condition in qcom_op_cmd_mapping()
  since its not needed at all.

* Removed no support check for command NAND_CMD_READCACHESEQ
  and NAND_CMD_READCACHEEND in qcom_check_op(), since its not 
  needed.

* Removed no support check for MAX_ADDRESS_CYCLE in 
  qcom_check_op(), since its not needed.

* Removed no support check for MAX_CHUNK_SIZE in 
  qcom_check_op(), since its not needed.

* Added no support condition for not supported command
  in qcom_check_op().
 
Change in [v4]

* No change for this patch, since this is part of exec_op
  series posting new patch.

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

 drivers/mtd/nand/raw/qcom_nandc.c | 534 +++++++++++++++++++++++++++++-
 1 file changed, 531 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 72d6168d8a1b..852c6a203c78 100644
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
+
 /*
  * This data type corresponds to the BAM transaction which will be used for all
  * NAND transfers.
@@ -382,6 +385,9 @@ struct nandc_regs {
  * @reg_read_pos:		marker for data read in reg_read_buf
  *
  * @cmd1/vld:			some fixed controller register values
+ *
+ * @exec_opwrite:		flag to select correct number of code word
+ *				while reading status
  */
 struct qcom_nand_controller {
 	struct device *dev;
@@ -432,6 +438,7 @@ struct qcom_nand_controller {
 	int reg_read_pos;
 
 	u32 cmd1, vld;
+	bool exec_opwrite;
 };
 
 /*
@@ -447,6 +454,29 @@ struct qcom_nand_boot_partition {
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
@@ -1516,9 +1546,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
 
 	clear_read_regs(nandc);
 
-	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
-	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
-		clear_bam_transaction(nandc);
+	clear_bam_transaction(nandc);
 }
 
 /*
@@ -2154,12 +2182,20 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
 {
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *data_buf, *oob_buf = NULL;
 
 	if (host->nr_boot_partitions)
 		qcom_nandc_codeword_fixup(host, page);
 
 	nand_read_page_op(chip, page, 0, NULL, 0);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = true;
+	clear_read_regs(nandc);
+	set_address(host, 0, page);
+	update_rw_regs(host, ecc->steps, true, 0);
+
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
 
@@ -2229,6 +2265,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
+	set_address(host, 0, page);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
@@ -2867,8 +2906,497 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
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
+		q_op->flag = OP_PROGRAM_PAGE;
+		nandc->exec_opwrite = true;
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
+static int qcom_read_status_exec(struct nand_chip *chip,
+				 const struct nand_subop *subop)
+{
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	struct qcom_op q_op;
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id = 0;
+	unsigned int len = 0;
+	int ret = 0, num_cw, i;
+	u32 flash_status;
+
+	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	num_cw = nandc->exec_opwrite ? ecc->steps : 1;
+	nandc->exec_opwrite = false;
+
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = false;
+
+	clear_read_regs(nandc);
+	clear_bam_transaction(nandc);
+
+	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
+
+	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
+	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+
+	ret = submit_descs(nandc);
+	if (ret) {
+		dev_err(nandc->dev, "failure in submitting status descriptor\n");
+		free_descs(nandc);
+		goto err_out;
+	}
+	free_descs(nandc);
+
+	nandc_read_buffer_sync(nandc, true);
+
+	for (i = 0; i < num_cw; i++) {
+		flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
+
+	if (flash_status & FS_MPU_ERR)
+		host->status &= ~NAND_STATUS_WP;
+
+	if (flash_status & FS_OP_ERR ||
+	 (i == (num_cw - 1) && (flash_status & FS_DEVICE_STS_ERR)))
+		host->status |= NAND_STATUS_FAIL;
+	}
+
+	flash_status = host->status;
+	instr = q_op.data_instr;
+	op_id = q_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+	memcpy(instr->ctx.data.buf.in, &flash_status, len);
+
+err_out:
+	return ret;
+}
+
+static int qcom_read_id_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
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
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = false;
+
+	clear_read_regs(nandc);
+	clear_bam_transaction(nandc);
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
+	if (ret) {
+		dev_err(nandc->dev, "failure in submitting read id descriptor\n");
+		free_descs(nandc);
+		goto err_out;
+	}
+	free_descs(nandc);
+
+	instr = q_op.data_instr;
+	op_id = q_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+
+	nandc_read_buffer_sync(nandc, true);
+	memcpy(instr->ctx.data.buf.in, nandc->reg_read_buf, len);
+
+err_out:
+	return ret;
+}
+
+static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_op q_op;
+	int ret = 0;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	if (q_op.flag == OP_PROGRAM_PAGE)
+		goto wait_rdy;
+
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = false;
+
+	clear_read_regs(nandc);
+	clear_bam_transaction(nandc);
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
+	if (ret) {
+		dev_err(nandc->dev, "failure in submitting misc descriptor\n");
+		free_descs(nandc);
+		goto err_out;
+	}
+	free_descs(nandc);
+
+wait_rdy:
+	qcom_delay_ns(q_op.rdy_delay_ns);
+	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
+
+err_out:
+	return ret;
+}
+
+static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_subop *subop)
+{
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct qcom_op q_op;
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id = 0;
+	unsigned int len = 0;
+	int ret = 0;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
+
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = false;
+	clear_read_regs(nandc);
+	clear_bam_transaction(nandc);
+
+	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
+
+	nandc_set_reg(chip, NAND_ADDR0, 0);
+	nandc_set_reg(chip, NAND_ADDR1, 0);
+	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
+					| 512 << UD_SIZE_BYTES
+					| 5 << NUM_ADDR_CYCLES
+					| 0 << SPARE_SIZE_BYTES);
+	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
+					| 0 << CS_ACTIVE_BSY
+					| 17 << BAD_BLOCK_BYTE_NUM
+					| 1 << BAD_BLOCK_IN_SPARE_AREA
+					| 2 << WR_RD_BSY_GAP
+					| 0 << WIDE_FLASH
+					| 1 << DEV0_CFG1_ECC_DISABLE);
+	if (!nandc->props->qpic_v2)
+		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
+
+	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
+	if (!nandc->props->qpic_v2) {
+		nandc_set_reg(chip, NAND_DEV_CMD_VLD,
+			      (nandc->vld & ~READ_START_VLD));
+		nandc_set_reg(chip, NAND_DEV_CMD1,
+			      (nandc->cmd1 & ~(0xFF << READ_ADDR))
+			      | NAND_CMD_PARAM << READ_ADDR);
+	}
+
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
+
+	if (!nandc->props->qpic_v2) {
+		nandc_set_reg(chip, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
+		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
+	}
+
+	instr = q_op.data_instr;
+	op_id = q_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+
+	nandc_set_read_loc(chip, 0, 0, 0, len, 1);
+
+	if (!nandc->props->qpic_v2) {
+		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
+		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
+	}
+
+	nandc->buf_count = len;
+	memset(nandc->data_buffer, 0xff, nandc->buf_count);
+
+	config_nand_single_cw_page_read(chip, false, 0);
+
+	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
+		      nandc->buf_count, 0);
+
+	/* restore CMD1 and VLD regs */
+	if (!nandc->props->qpic_v2) {
+		write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
+		write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
+	}
+
+	ret = submit_descs(nandc);
+	if (ret) {
+		dev_err(nandc->dev, "failure in submitting param page descriptor\n");
+		free_descs(nandc);
+		goto err_out;
+	}
+	free_descs(nandc);
+
+	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
+	if (ret)
+		goto err_out;
+
+	memcpy(instr->ctx.data.buf.in, nandc->data_buffer, len);
+
+err_out:
+	return ret;
+}
+
+static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
+{
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct qcom_op q_op;
+	int ret = 0;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
+
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = false;
+	clear_read_regs(nandc);
+	clear_bam_transaction(nandc);
+
+	nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
+	nandc_set_reg(chip, NAND_ADDR0, q_op.addr1_reg);
+	nandc_set_reg(chip, NAND_ADDR1, q_op.addr2_reg);
+	nandc_set_reg(chip, NAND_DEV0_CFG0,
+		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
+	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
+	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
+
+	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
+	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
+	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
+
+	ret = submit_descs(nandc);
+	if (ret) {
+		dev_err(nandc->dev, "failure in submitting erase descriptor\n");
+		free_descs(nandc);
+		goto err_out;
+	}
+	free_descs(nandc);
+
+	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
+	if (ret)
+		goto err_out;
+
+err_out:
+	return ret;
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
+			qcom_read_status_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_param_page_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_erase_cmd_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+		);
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
+			if (instr->ctx.cmd.opcode != NAND_CMD_RESET ||
+			    instr->ctx.cmd.opcode != NAND_CMD_READID ||
+			    instr->ctx.cmd.opcode != NAND_CMD_PARAM ||
+			    instr->ctx.cmd.opcode != NAND_CMD_ERASE1 ||
+			    instr->ctx.cmd.opcode != NAND_CMD_ERASE2 ||
+			    instr->ctx.cmd.opcode != NAND_CMD_STATUS ||
+			    instr->ctx.cmd.opcode != NAND_CMD_PAGEPROG)
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

