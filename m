Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69437310C4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbjFOHdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244923AbjFOHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:32:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F22726;
        Thu, 15 Jun 2023 00:32:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F2lIYO011855;
        Thu, 15 Jun 2023 07:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=yPrHxrlN0WJa/QTWfkGJdzP9ggTFaM8STVYRrYoTEAw=;
 b=AZCgXpPWK5q4U9eKrY3rTUb23kaoG2+p66xL7OTFrK2jkbfmjFOHB4JCcfDP7DUgzbg1
 PyljL0Bq3lu2rh2tjkThiYQFyE7hqGuH5/PaCp1BE0R6mu3cpYRZZcrnM2mOxk+PotbO
 9MgcI79MFQhQ06wgpdSZ44oi1hDGXXKDqphs10TJnYS4hAFNKOepEq3JCwzgseYp4RDm
 RfwXnau62wc7ILUu8sD4ViObkBmaiJ5GfmD6MjV+0OibJtmlWQK1EqDjmKoZVQBj1Ltk
 4be5M2cP7s7d7fM3gVY83R/CxX8en5FHGGrqrzjqXANohk8kanPkiQgutl6llxzuok1A +g== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7ecehvhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 07:32:05 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35F7R5TX015935;
        Thu, 15 Jun 2023 07:32:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 3r7g60gdgk-1;
        Thu, 15 Jun 2023 07:32:04 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F7W4Ij025205;
        Thu, 15 Jun 2023 07:32:04 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 35F7W3Yx025187;
        Thu, 15 Jun 2023 07:32:04 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 1CBB01200C5D; Thu, 15 Jun 2023 13:01:51 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH v4 4/5] mtd: rawnand: qcom: Add support for erase exec_ops
Date:   Thu, 15 Jun 2023 13:01:42 +0530
Message-Id: <20230615073143.25079-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230615073143.25079-1-quic_mdalam@quicinc.com>
References: <20230615073143.25079-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7v_-AuXM2_lYM-wK7gKGTWPA03np3PRe
X-Proofpoint-ORIG-GUID: 7v_-AuXM2_lYM-wK7gKGTWPA03np3PRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306150062
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ERASE exec_ops.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v4]

* Updated commit message

* Fix spelling mistake of sbumitting to submitting

* Remove Dummy function qcom_data_read_type_exec() and
  qcom_data_write_type_exec() and corresponding exec_ops
  pattern.

Change in [v3]

* Removed chip->cont_read.ongoing flag.

* Removed pre_command from erase_etype_exec_ops.

Change in [v2]

* Missed to post Cover-letter, so posting v2 patch with cover-letter.

Change in [v1]

* Added initial support for exec_ops.

 drivers/mtd/nand/raw/qcom_nandc.c | 65 ++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 7b42b1e3cf33..2afac4bca8b5 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1546,8 +1546,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
 
 	clear_read_regs(nandc);
 
-	if (command == NAND_CMD_ERASE1)
-		clear_bam_transaction(nandc);
+	clear_bam_transaction(nandc);
 }
 
 /*
@@ -2183,12 +2182,20 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
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
 
@@ -2258,6 +2265,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
+	set_address(host, 0, page);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
@@ -3274,6 +3284,51 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
 	return ret;
 }
 
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
 static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
 		NAND_OP_PARSER_PATTERN(
 			qcom_misc_cmd_type_exec,
@@ -3294,6 +3349,12 @@ static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
 			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
 			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
 			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
+		NAND_OP_PARSER_PATTERN(
+			qcom_erase_cmd_type_exec,
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
+			NAND_OP_PARSER_PAT_CMD_ELEM(false),
+			NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
 		);
 
 static int qcom_check_op(struct nand_chip *chip,
-- 
2.17.1

