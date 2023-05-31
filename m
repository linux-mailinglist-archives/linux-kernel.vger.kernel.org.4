Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F12718133
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjEaNP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjEaNPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:15:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0C123;
        Wed, 31 May 2023 06:15:23 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8Iwl9014168;
        Wed, 31 May 2023 12:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=5ZlIzAx+zOqxbshHwkBo1PbXQXpmROleP01hy/DhZtg=;
 b=FCk5nCupLN/HWzyAu75tSEgupiGOPlPbkpkli9MGMyCkeVll6EKS+ORwhRrcW+N82Kt6
 cfyeK3hiCmfHeuhNVWl3xV/WRKU9JX5oGZTDj20ywXW+TsSQ7eBqvHAExNzgzmS1KJ+J
 CBUe4oo3Wjg0Kp8mdcr9v0XY/Gg2aj+I+IBvbzQqEaof7PafQ/y7ITD7A8x2yNDiOvNy
 eK2bbCfT8mFwnMPQ80W+9+4yMyWbYzQOA/XLgnyUDde3nYHiHeb7RIiiFKQ88zVGlSvy
 FFY1PuN+xrWNo/NP1qouOfSJTol7nPpjS5SLYBkJGM6HBeWbf9thBEzWvh7l8Tz20qx5 BA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwnhf24gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 12:50:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34VCo1cq021065;
        Wed, 31 May 2023 12:50:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3quaxkdw09-1;
        Wed, 31 May 2023 12:50:01 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VCo0Q6021059;
        Wed, 31 May 2023 12:50:00 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34VCo0t0021058;
        Wed, 31 May 2023 12:50:00 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id CF3CD12010C7; Wed, 31 May 2023 18:19:59 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH v3 4/5] mtd: rawnand: qcom: Add support for read, write, erase exec_ops
Date:   Wed, 31 May 2023 18:19:52 +0530
Message-Id: <20230531124953.21007-4-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230531124953.21007-1-quic_mdalam@quicinc.com>
References: <20230531124953.21007-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gDFR53iNi5bjHdeUz9vTP3pxpXoWhzW2
X-Proofpoint-GUID: gDFR53iNi5bjHdeUz9vTP3pxpXoWhzW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310109
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will add exec_ops support for READ, WRITE, and ERASE
command.

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v3]

* Removed chip->cont_read.ongoing flag.

* Removed pre_command from erase_etype_exec_ops.

Change in [v2]

* Missed to post Cover-letter, so posting v2 patch with cover-letter.

Change in [v1]

* Added initial support for exec_ops.

 drivers/mtd/nand/raw/qcom_nandc.c | 97 +++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index b4823b72fe73..7dc769f9e797 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1546,8 +1546,7 @@ static void pre_command(struct qcom_nand_host *host, int command)
 
 	clear_read_regs(nandc);
 
-	if (command == NAND_CMD_ERASE1)
-		clear_bam_transaction(nandc);
+	clear_bam_transaction(nandc);
 }
 
 /*
@@ -1764,7 +1763,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
 	int raw_cw = cw;
 
-	nand_read_page_op(chip, page, 0, NULL, 0);
+	nand_read_page_op(chip, page, 0, data_buf, mtd->writesize);
 	host->use_ecc = false;
 
 	if (nandc->props->qpic_v2)
@@ -2181,14 +2180,23 @@ static void qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
 static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
 				int oob_required, int page)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *data_buf, *oob_buf = NULL;
 
 	if (host->nr_boot_partitions)
 		qcom_nandc_codeword_fixup(host, page);
 
-	nand_read_page_op(chip, page, 0, NULL, 0);
+	nand_read_page_op(chip, page, 0, buf, mtd->writesize);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = true;
+	clear_read_regs(nandc);
+	set_address(host, 0, page);
+	update_rw_regs(host, ecc->steps, true, 0);
+
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
 
@@ -2258,6 +2266,9 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
+	set_address(host, 0, page);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
@@ -3274,6 +3285,67 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
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
+		dev_err(nandc->dev, "failure in sbumitting erase descriptor\n");
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
+	return 0;
+}
+
 static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
 		NAND_OP_PARSER_PATTERN(
 			qcom_misc_cmd_type_exec,
@@ -3294,6 +3366,23 @@ static const struct nand_op_parser qcom_op_parser = NAND_OP_PARSER(
 			NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYCLE),
 			NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
 			NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 512)),
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
 		);
 
 static int qcom_check_op(struct nand_chip *chip,
-- 
2.17.1

