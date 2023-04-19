Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395596E7674
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjDSJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjDSJhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:37:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96248BBBC;
        Wed, 19 Apr 2023 02:37:00 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33J9W0Md031622;
        Wed, 19 Apr 2023 09:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=4IZWpHIu6w8sk5LAcuZiX4Td9u8WN637k6ErzHkWxtQ=;
 b=nmdpWb6+ht7kGQp1ZIXEklBHfDXwLZvvVRFbyv13g/tMNAgkPCE7DaBtui6lVTHGyrdC
 BHDS1Y1GdK8bPoPNvAGC7e0ZhnfCi7pWHjPmHc0B+Uc7CGxjBmV+DjAfV2QKxh8jEg6o
 OSLOO0o+AEHOuYzlB8P8ilDLwaCYxc2ziD+r/aWBwDHPuSqEpt4GL5N+S03KoiYT2GFx
 mPLkf5S1+Vk/v14CgDIv6Lkhen+ghDe8B2dyI+53RmQL00WwxjMbZrTvJrZBOQ62iccg
 vWBDAmQeFdcx1M/IpOXQ6NfXv+XR2Lzz2kj3HKjRVSJCS84/BK2QU3H6X8R7h6cn08dO LQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q292h8ju3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 09:36:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33J9aRNL030809;
        Wed, 19 Apr 2023 09:36:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3pyn0keyuj-1;
        Wed, 19 Apr 2023 09:36:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33J9aRxM030712;
        Wed, 19 Apr 2023 09:36:27 GMT
Received: from mdalam-linux.qualcomm.com (mdalam-linux.qualcomm.com [10.201.2.71])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33J9aQIZ030711;
        Wed, 19 Apr 2023 09:36:27 +0000
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id BD5811200C2F; Wed, 19 Apr 2023 15:06:25 +0530 (IST)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     mani@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_mdalam@quicinc.com
Subject: [PATCH V2] mtd: rawnand: qcom: Implement exec_op()
Date:   Wed, 19 Apr 2023 15:06:17 +0530
Message-Id: <20230419093617.27134-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wn4t7bxtlYzROlhYfTpN2uxg_b6noF9d
X-Proofpoint-GUID: wn4t7bxtlYzROlhYfTpN2uxg_b6noF9d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_05,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190086
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

Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [V2]

* Address all Miquel comments from V1, regarding exec_ops design

* Redesign qpic nand driver with exec_ops using exec_ops parser, to 
  fit in exec_ops framework 

 drivers/mtd/nand/raw/qcom_nandc.c | 869 ++++++++++++++++++------------
 1 file changed, 520 insertions(+), 349 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 72d6168d8a1b..17279890454d 100644
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
@@ -432,6 +434,7 @@ struct qcom_nand_controller {
 	int reg_read_pos;
 
 	u32 cmd1, vld;
+	bool exec_opwrite;
 };
 
 /*
@@ -447,6 +450,37 @@ struct qcom_nand_boot_partition {
 	u32 page_size;
 };
 
+/*
+ * QCOM op for each exec_op transfer
+ *
+ * @addr1_reg:			Address1 register value
+ *
+ * @addr2_reg:			Address2 register value
+ *
+ * @cmd_reg:			CMD register value
+ *
+ * @rdy_timeout_ms:		wait ready timeout in ms
+ *
+ * @rdy_delay_ns:		Additional delay in ns
+ *
+ * @data_instr_idx:		data instruction index
+ *
+ * @data_instr:			data instruction pointer
+ *
+ * @flag:			flag for misc instruction
+ *
+ */
+struct qcom_op {
+	u32 addr1_reg;
+	u32 addr2_reg;
+	u32 cmd_reg;
+	unsigned int rdy_timeout_ms;
+	unsigned int rdy_delay_ns;
+	unsigned int data_instr_idx;
+	const struct nand_op_instr *data_instr;
+	u8 flag;
+};
+
 /*
  * NAND chip structure
  *
@@ -765,7 +799,6 @@ static void set_address(struct qcom_nand_host *host, u16 column, int page)
 
 	if (chip->options & NAND_BUSWIDTH_16)
 		column >>= 1;
-
 	nandc_set_reg(chip, NAND_ADDR0, page << 16 | column);
 	nandc_set_reg(chip, NAND_ADDR1, page >> 16 & 0xff);
 }
@@ -1273,155 +1306,6 @@ static void config_nand_cw_write(struct nand_chip *chip)
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
@@ -1517,139 +1401,11 @@ static void pre_command(struct qcom_nand_host *host, int command)
 	clear_read_regs(nandc);
 
 	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
-	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
+	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1 ||
+	    command == NAND_CMD_STATUS)
 		clear_bam_transaction(nandc);
 }
 
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
@@ -1735,7 +1491,8 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
 	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
 	int raw_cw = cw;
 
-	nand_read_page_op(chip, page, 0, NULL, 0);
+	chip->cont_read.ongoing = false;
+	nand_read_page_op(chip, page, 0, data_buf, 2048);
 	host->use_ecc = false;
 
 	if (nandc->props->qpic_v2)
@@ -2047,7 +1804,9 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		return ret;
 	}
 
-	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
+	ret = parse_read_errors(host, data_buf_start, oob_buf_start, page);
+
+	return ret;
 }
 
 /*
@@ -2154,12 +1913,25 @@ static int qcom_nandc_read_page(struct nand_chip *chip, uint8_t *buf,
 {
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *data_buf, *oob_buf = NULL;
+	int ret = 0;
 
 	if (host->nr_boot_partitions)
 		qcom_nandc_codeword_fixup(host, page);
 
-	nand_read_page_op(chip, page, 0, NULL, 0);
+	chip->cont_read.ongoing = false;
+	ret = nand_read_page_op(chip, page, 0, buf, 2048);
+	if (ret)
+		return ret;
+
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+	host->use_ecc = true;
+	clear_read_regs(nandc);
+	set_address(host, 0, page);
+	update_rw_regs(host, ecc->steps, true, 0);
+
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
 
@@ -2229,6 +2001,10 @@ static int qcom_nandc_write_page(struct nand_chip *chip, const uint8_t *buf,
 
 	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
 
+	set_address(host, 0, page);
+	nandc->buf_count = 0;
+	nandc->buf_start = 0;
+
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
@@ -2494,64 +2270,6 @@ static int qcom_nandc_block_markbad(struct nand_chip *chip, loff_t ofs)
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
@@ -2867,8 +2585,469 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
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
+		q_op->flag = NAND_CMD_PAGEPROG;
+		nandc->exec_opwrite = true;
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
+	pre_command(host, NAND_CMD_PARAM);
+	/*
+	 * NAND_CMD_PARAM is called before we know much about the FLASH chip
+	 * in use. we configure the controller to perform a raw read of 512
+	 * bytes to read onfi params
+	 */
+	if (nandc->props->qpic_v2)
+		nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
+	else
+		nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
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
+	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
+
+	if (!nandc->props->qpic_v2) {
+		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
+		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
+	}
+
+	nandc->buf_count = 512;
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
+	if (ret)
+		dev_err(nandc->dev, "failure in sbumitting param page descriptor\n");
+
+	free_descs(nandc);
+
+	ret = qcom_wait_rdy_poll(chip, q_op.rdy_timeout_ms);
+
+	instr = q_op.data_instr;
+	op_id = q_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+	memcpy(instr->ctx.data.buf.in, nandc->data_buffer, len);
+
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
@@ -3135,14 +3314,6 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
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

