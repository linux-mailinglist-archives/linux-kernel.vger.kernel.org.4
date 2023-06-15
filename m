Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F77310B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjFOHcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbjFOHcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:32:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9222121;
        Thu, 15 Jun 2023 00:32:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F3dbJ5021735;
        Thu, 15 Jun 2023 07:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ShFctnkWuT0Zs9m17wa8kiqBDz6ax8ySsoISAoj8m4g=;
 b=R23+40zmzatbo9yVJhRmAogHy8h17SRdEBCPnmTk4s+PypS7R+bd2Xp7OV9O/OKDY85P
 ICi6q2lcldpp4Ds1QfuezrZJF/AS6dl2L3Ez+MBWZJff0bzQEVZB3pqdy0rWfxPnB5Cq
 NyoIxqJF5pcRa2eD6scCHP9dJYvQvosu6uRERGVpXCkunJQqx4vaIXQm8VOpykhXhs3f
 XeYUXzw+omGemROByU9UsPF1aqEV2plWOskSG6N16reLfbOZRk5+kOnRnAhHn2NyLNNl
 SIbHH49bGxi/AxByEYBl0jikicC5BpUdMGlWFj2r1cSApYm62dzbm9GiYLZfYLJiPZyE BA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7cka24p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 07:31:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35F7VnfY012761;
        Thu, 15 Jun 2023 07:31:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3r4j8m6m6k-1;
        Thu, 15 Jun 2023 07:31:49 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F7VnX2012755;
        Thu, 15 Jun 2023 07:31:49 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35F7Vmfw012754;
        Thu, 15 Jun 2023 07:31:49 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id DBEFB12010CD; Thu, 15 Jun 2023 13:01:47 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH v4 3/5] mtd: rawnand: qcom: Add support for param_page read exec_ops
Date:   Thu, 15 Jun 2023 13:01:41 +0530
Message-Id: <20230615073143.25079-3-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615073143.25079-1-quic_mdalam@quicinc.com>
References: <20230615073143.25079-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x2M7u0WBtElj1V41igZVJmQLp3lxso8F
X-Proofpoint-ORIG-GUID: x2M7u0WBtElj1V41igZVJmQLp3lxso8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_03,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150062
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PARAM_PAGE_READ exec_ops.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v4]

* Updated commit message

* Fix spelling mistake of sbumitting to submitting  

Change in [v3]

* Removed hard coded value in param_page exec_op API, and used whatever
  passed by core.

* Removed nandc->props->qpic_v2 condition , since its not needed at all.

* Updated nandc->buf_count = len , len provided by core.

Change in [v2]

* Missed to post Cover-letter, so posting v2 patch with cover-letter

Change in [v1]

* Added initial support for exec_ops.

 drivers/mtd/nand/raw/qcom_nandc.c | 105 +++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 4d4b95117051..7b42b1e3cf33 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1546,7 +1546,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
 
 	clear_read_regs(nandc);
 
-	if (command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
+	if (command == NAND_CMD_ERASE1)
 		clear_bam_transaction(nandc);
 }
 
@@ -3177,6 +3177,103 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 	return ret;
 }
 
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
 static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
 		NAND_OP_PARSER_PATTERN(
 			qcom_misc_cmd_type_exec,
@@ -3191,6 +3288,12 @@ static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
 			qcom_read_status_exec,
 			NAND_OP_PARSER_PAT_CMD_ELEM(false),
 			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 1)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_param_page_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
 		);
 
 static int qcom_check_op(struct nand_chip *chip,
-- 
2.17.1

