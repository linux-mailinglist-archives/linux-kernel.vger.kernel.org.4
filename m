Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0024A6FF2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbjEKNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbjEKNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:31:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38121100EA;
        Thu, 11 May 2023 06:30:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B9L7Xj029935;
        Thu, 11 May 2023 13:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=2nwZloAPONHGg9zNs50n0kaQS9sy3eXZLg1kt9nZNpA=;
 b=ou3Z4iIiCAqYqdP48Y7vl6U4d3rh5JKwDy9Yoo8DbETjduB2BWaVhkp1LVALwDvj/gz/
 0R0MihtO6VeRrn3uzLxlmXYB6T4FwuDT6RXXqLJpY7JFOsjkgi69YjO7vWB13FvSVz10
 vqFwbRf5ChkHWrCLaHgtJUqlq/1cI/dKyYEb9yOgiMlLEvUg7FeWzWPiiYkoxtKd4EQN
 lvmid+5WQxpioJLJb6cRrWObRg3LhzmdJuHqnP/LZaItZdz4FrWQgkMlDQW6WWCpSjQ6
 H3vKue6cgCQRXQ2wG4XPEvkuJcm9FGXrFauRs/EjA3iGfPZlkryE85DTVgcwou3dhzWo 4g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgpfk1h4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 13:30:27 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34BDUOEZ001584;
        Thu, 11 May 2023 13:30:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qdy5bq8mc-1;
        Thu, 11 May 2023 13:30:24 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BDUMMH001557;
        Thu, 11 May 2023 13:30:24 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34BDUMQZ001555;
        Thu, 11 May 2023 13:30:24 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 1204112010C1; Thu, 11 May 2023 19:00:23 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH v2 4/5] mtd: rawnand: qcom: Add support for read, write, erase exec_ops
Date:   Thu, 11 May 2023 19:00:16 +0530
Message-Id: <20230511133017.6307-5-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511133017.6307-1-quic_mdalam@quicinc.com>
References: <20230511133017.6307-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dmdnmvTNmgNV2epHNftCvRpxAP5JemU2
X-Proofpoint-GUID: dmdnmvTNmgNV2epHNftCvRpxAP5JemU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110116
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Change in [v2]

* Missed to post Cover-letter, so posting v2 patch with cover-letter

 drivers/mtd/nand/raw/qcom_nandc.c | 52 +++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 8717d5086f80..14ab21a4771b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1765,7 +1765,8 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
 	int raw_cw = cw;
 
-	nand_read_page_op(chip, page, 0, NULL, 0);
+	chip->cont_read.ongoing = false;
+	nand_read_page_op(chip, page, 0, data_buf, mtd->writesize);
 	host->use_ecc = false;
 
 	if (nandc->props->qpic_v2)
@@ -2182,14 +2183,24 @@ static void qcom_nandc_codeword_fixup(struct qcom_nand_host *host, int page)
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
+	chip->cont_read.ongoing = false;
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
 
@@ -2259,6 +2270,10 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
+	set_address(host, 0, page);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
@@ -3081,7 +3096,38 @@ static int qcom_read_status_exec(struct nand_chip *chip,
 
 static int qcom_erase_cmd_type_exec(struct nand_chip *chip, const struct nand_subop *subop)
 {
-	return 0;
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct qcom_op q_op;
+	int ret = 0;
+
+	qcom_parse_instructions(chip, subop, &q_op);
+
+	q_op.cmd_reg |= PAGE_ACC | LAST_PAGE;
+
+	pre_command(host, NAND_CMD_ERASE1);
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
+	if (ret)
+		dev_err(nandc->dev, "failure in sbumitting reset descriptor\n");
+
+	free_descs(nandc);
+
+	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
+
+	return ret;
 }
 
 static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_subop *subop)
-- 
2.17.1

