Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AC74CC58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGJFpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGJFpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:45:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93921E3;
        Sun,  9 Jul 2023 22:45:06 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A5VELb000618;
        Mon, 10 Jul 2023 05:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=73VMwD7/lZdjbElZTY1Us+dyCatU/2AtOjVuw+oUu7I=;
 b=LUWjTtio9VbMhc2yw476+nerOWL5zCiy81ls4WsBY0ZWaweLuuVGJtBg/EJBy4MSuNLU
 SW1aqCLGlPNGCkSGF7boM7aQTv2CQzWUZNlGlegN1kQKDrerZYKTRdFTnVbfzVaN3cn5
 5qqauHDKXyfXMWaVhUPB5Qkgw0C1CoCL1ta56P/J4IsRPv3PBNcSyw/cU3qLbaj67U0F
 8UcxV0Xy+zxgO7Zb6vsULgIPsADoyfMx5E7rYFZGS9u98ZIf5gSMRitO7s+BRZbX8tsY
 S3WTdTcBmvOq8eszoOh6/F/limCJEXUQtRDyi76ZB6Fp9hy1QUUJm7Cv7VYvaml2Hxfe Jw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rq06d2jgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 05:44:48 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36A5ijVo013325;
        Mon, 10 Jul 2023 05:44:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rq0vkcgdc-1;
        Mon, 10 Jul 2023 05:44:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36A5ijkq013318;
        Mon, 10 Jul 2023 05:44:45 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36A5ii1f013317;
        Mon, 10 Jul 2023 05:44:45 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 3FC2312010C1; Mon, 10 Jul 2023 11:14:44 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH v5 2/2] mtd: rawnand: qcom: Remove legacy interface
Date:   Mon, 10 Jul 2023 11:14:40 +0530
Message-Id: <20230710054440.23297-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230710054440.23297-1-quic_mdalam@quicinc.com>
References: <20230710054440.23297-1-quic_mdalam@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M_yAhJ3IYXsctNCnQKg_YyR0UXpfbaBf
X-Proofpoint-GUID: M_yAhJ3IYXsctNCnQKg_YyR0UXpfbaBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100052
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove legacy interface implementation

Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v5]

* No change in v5

Change in [v4]

* Updated commit message

Change in [v3]

* Removed pre_command() API definition completely.

Change in [v2]

* Missed to post Cover-letter, so posting v2 patch with cover-letter

Change in [v1]

* Added initial support for exec_ops.

 drivers/mtd/nand/raw/qcom_nandc.c | 359 ------------------------------
 1 file changed, 359 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 852c6a203c78..b1e69d634d4a 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1303,155 +1303,6 @@ static void config_nand_cw_write(struct nand_chip *chip)
 	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
 }
 
-/*
- * the following functions are used within chip->legacy.cmdfunc() to
- * perform different NAND_CMD_* commands
- */
-
-/* sets up descriptors for NAND_CMD_PARAM */
-static int nandc_param(struct qcom_nand_host *host)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	/*
-	 * NAND_CMD_PARAM is called before we know much about the FLASH chip
-	 * in use. we configure the controller to perform a raw read of 512
-	 * bytes to read onfi params
-	 */
-	if (nandc->props->qpic_v2)
-		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ_ONFI_READ |
-			      PAGE_ACC | LAST_PAGE);
-	else
-		nandc_set_reg(chip, NAND_FLASH_CMD, OP_PAGE_READ |
-			      PAGE_ACC | LAST_PAGE);
-
-	nandc_set_reg(chip, NAND_ADDR0, 0);
-	nandc_set_reg(chip, NAND_ADDR1, 0);
-	nandc_set_reg(chip, NAND_DEV0_CFG0, 0 << CW_PER_PAGE
-					| 512 << UD_SIZE_BYTES
-					| 5 << NUM_ADDR_CYCLES
-					| 0 << SPARE_SIZE_BYTES);
-	nandc_set_reg(chip, NAND_DEV0_CFG1, 7 << NAND_RECOVERY_CYCLES
-					| 0 << CS_ACTIVE_BSY
-					| 17 << BAD_BLOCK_BYTE_NUM
-					| 1 << BAD_BLOCK_IN_SPARE_AREA
-					| 2 << WR_RD_BSY_GAP
-					| 0 << WIDE_FLASH
-					| 1 << DEV0_CFG1_ECC_DISABLE);
-	if (!nandc->props->qpic_v2)
-		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
-
-	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
-	if (!nandc->props->qpic_v2) {
-		nandc_set_reg(chip, NAND_DEV_CMD_VLD,
-			      (nandc->vld & ~READ_START_VLD));
-		nandc_set_reg(chip, NAND_DEV_CMD1,
-			      (nandc->cmd1 & ~(0xFF << READ_ADDR))
-			      | NAND_CMD_PARAM << READ_ADDR);
-	}
-
-	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
-
-	if (!nandc->props->qpic_v2) {
-		nandc_set_reg(chip, NAND_DEV_CMD1_RESTORE, nandc->cmd1);
-		nandc_set_reg(chip, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
-	}
-
-	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
-
-	if (!nandc->props->qpic_v2) {
-		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
-		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
-	}
-
-	nandc->buf_count = 512;
-	memset(nandc->data_buffer, 0xff, nandc->buf_count);
-
-	config_nand_single_cw_page_read(chip, false, 0);
-
-	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
-		      nandc->buf_count, 0);
-
-	/* restore CMD1 and VLD regs */
-	if (!nandc->props->qpic_v2) {
-		write_reg_dma(nandc, NAND_DEV_CMD1_RESTORE, 1, 0);
-		write_reg_dma(nandc, NAND_DEV_CMD_VLD_RESTORE, 1, NAND_BAM_NEXT_SGL);
-	}
-
-	return 0;
-}
-
-/* sets up descriptors for NAND_CMD_ERASE1 */
-static int erase_block(struct qcom_nand_host *host, int page_addr)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	nandc_set_reg(chip, NAND_FLASH_CMD,
-		      OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
-	nandc_set_reg(chip, NAND_ADDR0, page_addr);
-	nandc_set_reg(chip, NAND_ADDR1, 0);
-	nandc_set_reg(chip, NAND_DEV0_CFG0,
-		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
-	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
-	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
-	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
-	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
-
-	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
-
-	write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
-	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
-
-	return 0;
-}
-
-/* sets up descriptors for NAND_CMD_READID */
-static int read_id(struct qcom_nand_host *host, int column)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	if (column == -1)
-		return 0;
-
-	nandc_set_reg(chip, NAND_FLASH_CMD, OP_FETCH_ID);
-	nandc_set_reg(chip, NAND_ADDR0, column);
-	nandc_set_reg(chip, NAND_ADDR1, 0);
-	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
-		      nandc->props->is_bam ? 0 : DM_EN);
-	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
-
-	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-
-	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
-
-	return 0;
-}
-
-/* sets up descriptors for NAND_CMD_RESET */
-static int reset(struct qcom_nand_host *host)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	nandc_set_reg(chip, NAND_FLASH_CMD, OP_RESET_DEVICE);
-	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
-
-	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
-
-	return 0;
-}
-
 /* helpers to submit/free our list of dma descriptors */
 static int submit_descs(struct qcom_nand_controller *nandc)
 {
@@ -1534,150 +1385,6 @@ static void clear_read_regs(struct qcom_nand_controller *nandc)
 	nandc_read_buffer_sync(nandc, false);
 }
 
-static void pre_command(struct qcom_nand_host *host, int command)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	nandc->buf_count = 0;
-	nandc->buf_start = 0;
-	host->use_ecc = false;
-	host->last_command = command;
-
-	clear_read_regs(nandc);
-
-	clear_bam_transaction(nandc);
-}
-
-/*
- * this is called after NAND_CMD_PAGEPROG and NAND_CMD_ERASE1 to set our
- * privately maintained status byte, this status byte can be read after
- * NAND_CMD_STATUS is called
- */
-static void parse_erase_write_errors(struct qcom_nand_host *host, int command)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int num_cw;
-	int i;
-
-	num_cw = command == NAND_CMD_PAGEPROG ? ecc->steps : 1;
-	nandc_read_buffer_sync(nandc, true);
-
-	for (i = 0; i < num_cw; i++) {
-		u32 flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
-
-		if (flash_status & FS_MPU_ERR)
-			host->status &= ~NAND_STATUS_WP;
-
-		if (flash_status & FS_OP_ERR || (i == (num_cw - 1) &&
-						 (flash_status &
-						  FS_DEVICE_STS_ERR)))
-			host->status |= NAND_STATUS_FAIL;
-	}
-}
-
-static void post_command(struct qcom_nand_host *host, int command)
-{
-	struct nand_chip *chip = &host->chip;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	switch (command) {
-	case NAND_CMD_READID:
-		nandc_read_buffer_sync(nandc, true);
-		memcpy(nandc->data_buffer, nandc->reg_read_buf,
-		       nandc->buf_count);
-		break;
-	case NAND_CMD_PAGEPROG:
-	case NAND_CMD_ERASE1:
-		parse_erase_write_errors(host, command);
-		break;
-	default:
-		break;
-	}
-}
-
-/*
- * Implements chip->legacy.cmdfunc. It's  only used for a limited set of
- * commands. The rest of the commands wouldn't be called by upper layers.
- * For example, NAND_CMD_READOOB would never be called because we have our own
- * versions of read_oob ops for nand_ecc_ctrl.
- */
-static void qcom_nandc_command(struct nand_chip *chip, unsigned int command,
-			       int column, int page_addr)
-{
-	struct qcom_nand_host *host = to_qcom_nand_host(chip);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	bool wait = false;
-	int ret = 0;
-
-	pre_command(host, command);
-
-	switch (command) {
-	case NAND_CMD_RESET:
-		ret = reset(host);
-		wait = true;
-		break;
-
-	case NAND_CMD_READID:
-		nandc->buf_count = 4;
-		ret = read_id(host, column);
-		wait = true;
-		break;
-
-	case NAND_CMD_PARAM:
-		ret = nandc_param(host);
-		wait = true;
-		break;
-
-	case NAND_CMD_ERASE1:
-		ret = erase_block(host, page_addr);
-		wait = true;
-		break;
-
-	case NAND_CMD_READ0:
-		/* we read the entire page for now */
-		WARN_ON(column != 0);
-
-		host->use_ecc = true;
-		set_address(host, 0, page_addr);
-		update_rw_regs(host, ecc->steps, true, 0);
-		break;
-
-	case NAND_CMD_SEQIN:
-		WARN_ON(column != 0);
-		set_address(host, 0, page_addr);
-		break;
-
-	case NAND_CMD_PAGEPROG:
-	case NAND_CMD_STATUS:
-	case NAND_CMD_NONE:
-	default:
-		break;
-	}
-
-	if (ret) {
-		dev_err(nandc->dev, "failure executing command %d\n",
-			command);
-		free_descs(nandc);
-		return;
-	}
-
-	if (wait) {
-		ret = submit_descs(nandc);
-		if (ret)
-			dev_err(nandc->dev,
-				"failure submitting descs for command %d\n",
-				command);
-	}
-
-	free_descs(nandc);
-
-	post_command(host, command);
-}
-
 /*
  * when using BCH ECC, the HW flags an error in NAND_FLASH_STATUS if it read
  * an erased CW, and reports an erased CW in NAND_ERASED_CW_DETECT_STATUS.
@@ -2533,64 +2240,6 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
 	return nand_prog_page_end_op(chip);
 }
 
-/*
- * the three functions below implement chip->legacy.read_byte(),
- * chip->legacy.read_buf() and chip->legacy.write_buf() respectively. these
- * aren't used for reading/writing page data, they are used for smaller data
- * like reading	id, status etc
- */
-static uint8_t qcom_nandc_read_byte(struct nand_chip *chip)
-{
-	struct qcom_nand_host *host = to_qcom_nand_host(chip);
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	u8 *buf = nandc->data_buffer;
-	u8 ret = 0x0;
-
-	if (host->last_command == NAND_CMD_STATUS) {
-		ret = host->status;
-
-		host->status = NAND_STATUS_READY | NAND_STATUS_WP;
-
-		return ret;
-	}
-
-	if (nandc->buf_start < nandc->buf_count)
-		ret = buf[nandc->buf_start++];
-
-	return ret;
-}
-
-static void qcom_nandc_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
-{
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
-
-	memcpy(buf, nandc->data_buffer + nandc->buf_start, real_len);
-	nandc->buf_start += real_len;
-}
-
-static void qcom_nandc_write_buf(struct nand_chip *chip, const uint8_t *buf,
-				 int len)
-{
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	int real_len = min_t(size_t, len, nandc->buf_count - nandc->buf_start);
-
-	memcpy(nandc->data_buffer + nandc->buf_start, buf, real_len);
-
-	nandc->buf_start += real_len;
-}
-
-/* we support only one external chip for now */
-static void qcom_nandc_select_chip(struct nand_chip *chip, int chipnr)
-{
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-
-	if (chipnr <= 0)
-		return;
-
-	dev_warn(nandc->dev, "invalid chip select\n");
-}
-
 /*
  * NAND controller page layout info
  *
@@ -3663,14 +3312,6 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	mtd->owner = THIS_MODULE;
 	mtd->dev.parent = dev;
 
-	chip->legacy.cmdfunc	= qcom_nandc_command;
-	chip->legacy.select_chip	= qcom_nandc_select_chip;
-	chip->legacy.read_byte	= qcom_nandc_read_byte;
-	chip->legacy.read_buf	= qcom_nandc_read_buf;
-	chip->legacy.write_buf	= qcom_nandc_write_buf;
-	chip->legacy.set_features	= nand_get_set_features_notsupp;
-	chip->legacy.get_features	= nand_get_set_features_notsupp;
-
 	/*
 	 * the bad block marker is readable only when we read the last codeword
 	 * of a page with ECC disabled. currently, the nand_base and nand_bbt
-- 
2.17.1

