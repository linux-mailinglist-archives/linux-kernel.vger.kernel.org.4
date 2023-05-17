Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D0706016
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjEQG3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjEQG3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:29:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809B3A80
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:29:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96aa0cab88dso47104766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684304965; x=1686896965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr3Z2HuLErfgvDvYIaThPE6mAu2oHLow0uk4ZIO//KA=;
        b=a5IzuBnu3V+ZtQsLO07ip2AI14UIlM7Iu43+JENmpeFfFxntktrUphtNxWsFzEU4+q
         R3x/meocFXpDqvwxkTVXlybUAcETSTBEKuEwXXMixv/b9tfw061KIy7ZQEMh9TgvdZ0s
         YXrdvYGN0IjJhCPTvnZpX7RlOwJTdw+3igs6ksU3kyeHSnEveyXT46Q6GRn3mUdOk05S
         hb24K/Ln32E5K6m3sqZPLcmwqQpHQMf01RPxB6QQDd9LrpinRRSzBlyg8lxXNnu0YZGp
         j/71rGXH8EhVrBkz9Blq2PHk3Atx+J+3IA6VBEjH9mrChHhesaoZos6T3HceUn8mvJan
         UzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304965; x=1686896965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr3Z2HuLErfgvDvYIaThPE6mAu2oHLow0uk4ZIO//KA=;
        b=gFHFila8PTui1Jxd/MBA5vXCRkqtS95UyBeFF2FaLPOfaCr5IEkdBsaykQNW8YPBmL
         IcjVWvrgng7HAtpfc/D9TMT5auYTmVF32774vjSHbRz+6/OsK6ljJMZJVo+w4X/JwnHd
         XS8RLYrPYdP7RLkCb7H98LB6Iv0wvJjnL7eXYOzDqAmQe98ohXqc6vApOyHRjh9I92U2
         naoafQwWZFUF/CvaNAtcHbTcdD41SWXJkIM7nFBkTq54+LjyeolXhma6NY7xWZZFFvaj
         gz9ZpZoFbqiRD+S1qiRmtPOcpCKb3C1nLD9mV3fHPCH4xiYvgMiKEMkzfAo8E+aMyx3Q
         1pBQ==
X-Gm-Message-State: AC+VfDzzffGd78Zm9cmnknNsMXLs0EAnLDoXF3UnVEAoCZAPLfXvSX6Y
        5+H+JNrVjbmQGgNZm1XHlzB8
X-Google-Smtp-Source: ACHHUZ7/4O3pFSWfi3Kt7wcanZNHO10WUoPwmPrlwSzhGlVjSq3h/o4UqZDUfj4RIVDzEvPcl1LFOQ==
X-Received: by 2002:a17:907:9488:b0:96a:a0fd:d43e with SMTP id dm8-20020a170907948800b0096aa0fdd43emr16500756ejc.49.1684304965216;
        Tue, 16 May 2023 23:29:25 -0700 (PDT)
Received: from localhost.localdomain ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906648900b0094f3d700868sm11859273ejm.80.2023.05.16.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:29:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [RESEND PATCH v7 2/2] EDAC/qcom: Get rid of hardcoded register offsets
Date:   Wed, 17 May 2023 11:58:59 +0530
Message-Id: <20230517062859.57371-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517062859.57371-1-manivannan.sadhasivam@linaro.org>
References: <20230517062859.57371-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLCC EDAC register offsets varies between each SoC. Hardcoding the
register offsets won't work and will often result in crash due to
accessing the wrong locations.

Hence, get the register offsets from the LLCC driver matching the
individual SoCs.

Cc: <stable@vger.kernel.org> # 6.0: 5365cea199c7 ("soc: qcom: llcc: Rename reg_offset structs to reflect LLCC version")
Cc: <stable@vger.kernel.org> # 6.0: c13d7d261e36 ("soc: qcom: llcc: Pass LLCC version based register offsets to EDAC driver")
Cc: <stable@vger.kernel.org> # 6.0
Fixes: a6e9d7ef252c ("soc: qcom: llcc: Add configuration data for SM8450 SoC")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/edac/qcom_edac.c           | 116 ++++++++++++++---------------
 include/linux/soc/qcom/llcc-qcom.h |   6 --
 2 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 53d666ffcb1f..1b5abc0d2d17 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -21,30 +21,9 @@
 #define TRP_SYN_REG_CNT                 6
 #define DRP_SYN_REG_CNT                 8
 
-#define LLCC_COMMON_STATUS0             0x0003000c
 #define LLCC_LB_CNT_MASK                GENMASK(31, 28)
 #define LLCC_LB_CNT_SHIFT               28
 
-/* Single & double bit syndrome register offsets */
-#define TRP_ECC_SB_ERR_SYN0             0x0002304c
-#define TRP_ECC_DB_ERR_SYN0             0x00020370
-#define DRP_ECC_SB_ERR_SYN0             0x0004204c
-#define DRP_ECC_DB_ERR_SYN0             0x00042070
-
-/* Error register offsets */
-#define TRP_ECC_ERROR_STATUS1           0x00020348
-#define TRP_ECC_ERROR_STATUS0           0x00020344
-#define DRP_ECC_ERROR_STATUS1           0x00042048
-#define DRP_ECC_ERROR_STATUS0           0x00042044
-
-/* TRP, DRP interrupt register offsets */
-#define DRP_INTERRUPT_STATUS            0x00041000
-#define TRP_INTERRUPT_0_STATUS          0x00020480
-#define DRP_INTERRUPT_CLEAR             0x00041008
-#define DRP_ECC_ERROR_CNTR_CLEAR        0x00040004
-#define TRP_INTERRUPT_0_CLEAR           0x00020484
-#define TRP_ECC_ERROR_CNTR_CLEAR        0x00020440
-
 /* Mask and shift macros */
 #define ECC_DB_ERR_COUNT_MASK           GENMASK(4, 0)
 #define ECC_DB_ERR_WAYS_MASK            GENMASK(31, 16)
@@ -60,15 +39,6 @@
 #define DRP_TRP_INT_CLEAR               GENMASK(1, 0)
 #define DRP_TRP_CNT_CLEAR               GENMASK(1, 0)
 
-/* Config registers offsets*/
-#define DRP_ECC_ERROR_CFG               0x00040000
-
-/* Tag RAM, Data RAM interrupt register offsets */
-#define CMN_INTERRUPT_0_ENABLE          0x0003001c
-#define CMN_INTERRUPT_2_ENABLE          0x0003003c
-#define TRP_INTERRUPT_0_ENABLE          0x00020488
-#define DRP_INTERRUPT_ENABLE            0x0004100c
-
 #define SB_ERROR_THRESHOLD              0x1
 #define SB_ERROR_THRESHOLD_SHIFT        24
 #define SB_DB_TRP_INTERRUPT_ENABLE      0x3
@@ -88,9 +58,6 @@ enum {
 static const struct llcc_edac_reg_data edac_reg_data[] = {
 	[LLCC_DRAM_CE] = {
 		.name = "DRAM Single-bit",
-		.synd_reg = DRP_ECC_SB_ERR_SYN0,
-		.count_status_reg = DRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
 		.reg_cnt = DRP_SYN_REG_CNT,
 		.count_mask = ECC_SB_ERR_COUNT_MASK,
 		.ways_mask = ECC_SB_ERR_WAYS_MASK,
@@ -98,9 +65,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_DRAM_UE] = {
 		.name = "DRAM Double-bit",
-		.synd_reg = DRP_ECC_DB_ERR_SYN0,
-		.count_status_reg = DRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = DRP_ECC_ERROR_STATUS0,
 		.reg_cnt = DRP_SYN_REG_CNT,
 		.count_mask = ECC_DB_ERR_COUNT_MASK,
 		.ways_mask = ECC_DB_ERR_WAYS_MASK,
@@ -108,9 +72,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_TRAM_CE] = {
 		.name = "TRAM Single-bit",
-		.synd_reg = TRP_ECC_SB_ERR_SYN0,
-		.count_status_reg = TRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
 		.reg_cnt = TRP_SYN_REG_CNT,
 		.count_mask = ECC_SB_ERR_COUNT_MASK,
 		.ways_mask = ECC_SB_ERR_WAYS_MASK,
@@ -118,9 +79,6 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 	[LLCC_TRAM_UE] = {
 		.name = "TRAM Double-bit",
-		.synd_reg = TRP_ECC_DB_ERR_SYN0,
-		.count_status_reg = TRP_ECC_ERROR_STATUS1,
-		.ways_status_reg = TRP_ECC_ERROR_STATUS0,
 		.reg_cnt = TRP_SYN_REG_CNT,
 		.count_mask = ECC_DB_ERR_COUNT_MASK,
 		.ways_mask = ECC_DB_ERR_WAYS_MASK,
@@ -128,7 +86,7 @@ static const struct llcc_edac_reg_data edac_reg_data[] = {
 	},
 };
 
-static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
+static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_bcast_regmap)
 {
 	u32 sb_err_threshold;
 	int ret;
@@ -137,31 +95,31 @@ static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
 	 * Configure interrupt enable registers such that Tag, Data RAM related
 	 * interrupts are propagated to interrupt controller for servicing
 	 */
-	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
 				 TRP0_INTERRUPT_ENABLE,
 				 TRP0_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->trp_interrupt_0_enable,
 				 SB_DB_TRP_INTERRUPT_ENABLE,
 				 SB_DB_TRP_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
 	sb_err_threshold = (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SHIFT);
-	ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
+	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg_offset->drp_ecc_error_cfg,
 			   sb_err_threshold);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
 				 DRP0_INTERRUPT_ENABLE,
 				 DRP0_INTERRUPT_ENABLE);
 	if (ret)
 		return ret;
 
-	ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
+	ret = regmap_write(llcc_bcast_regmap, drv->edac_reg_offset->drp_interrupt_enable,
 			   SB_DB_DRP_INTERRUPT_ENABLE);
 	return ret;
 }
@@ -175,24 +133,28 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 	switch (err_type) {
 	case LLCC_DRAM_CE:
 	case LLCC_DRAM_UE:
-		ret = regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->drp_interrupt_clear,
 				   DRP_TRP_INT_CLEAR);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNTR_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->drp_ecc_error_cntr_clear,
 				   DRP_TRP_CNT_CLEAR);
 		if (ret)
 			return ret;
 		break;
 	case LLCC_TRAM_CE:
 	case LLCC_TRAM_UE:
-		ret = regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->trp_interrupt_0_clear,
 				   DRP_TRP_INT_CLEAR);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNTR_CLEAR,
+		ret = regmap_write(drv->bcast_regmap,
+				   drv->edac_reg_offset->trp_ecc_error_cntr_clear,
 				   DRP_TRP_CNT_CLEAR);
 		if (ret)
 			return ret;
@@ -204,16 +166,54 @@ qcom_llcc_clear_error_status(int err_type, struct llcc_drv_data *drv)
 	return ret;
 }
 
+struct qcom_llcc_syn_regs {
+	u32 synd_reg;
+	u32 count_status_reg;
+	u32 ways_status_reg;
+};
+
+static void get_reg_offsets(struct llcc_drv_data *drv, int err_type,
+			    struct qcom_llcc_syn_regs *syn_regs)
+{
+	const struct llcc_edac_reg_offset *edac_reg_offset = drv->edac_reg_offset;
+
+	switch (err_type) {
+	case LLCC_DRAM_CE:
+		syn_regs->synd_reg = edac_reg_offset->drp_ecc_sb_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->drp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->drp_ecc_error_status0;
+		break;
+	case LLCC_DRAM_UE:
+		syn_regs->synd_reg = edac_reg_offset->drp_ecc_db_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->drp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->drp_ecc_error_status0;
+		break;
+	case LLCC_TRAM_CE:
+		syn_regs->synd_reg = edac_reg_offset->trp_ecc_sb_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->trp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->trp_ecc_error_status0;
+		break;
+	case LLCC_TRAM_UE:
+		syn_regs->synd_reg = edac_reg_offset->trp_ecc_db_err_syn0;
+		syn_regs->count_status_reg = edac_reg_offset->trp_ecc_error_status1;
+		syn_regs->ways_status_reg = edac_reg_offset->trp_ecc_error_status0;
+		break;
+	}
+}
+
 /* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
 static int
 dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 {
 	struct llcc_edac_reg_data reg_data = edac_reg_data[err_type];
+	struct qcom_llcc_syn_regs regs = { };
 	int err_cnt, err_ways, ret, i;
 	u32 synd_reg, synd_val;
 
+	get_reg_offsets(drv, err_type, &regs);
+
 	for (i = 0; i < reg_data.reg_cnt; i++) {
-		synd_reg = reg_data.synd_reg + (i * 4);
+		synd_reg = regs.synd_reg + (i * 4);
 		ret = regmap_read(drv->regmaps[bank], synd_reg,
 				  &synd_val);
 		if (ret)
@@ -223,7 +223,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 			    reg_data.name, i, synd_val);
 	}
 
-	ret = regmap_read(drv->regmaps[bank], reg_data.count_status_reg,
+	ret = regmap_read(drv->regmaps[bank], regs.count_status_reg,
 			  &err_cnt);
 	if (ret)
 		goto clear;
@@ -233,7 +233,7 @@ dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
 	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: Error count: 0x%4x\n",
 		    reg_data.name, err_cnt);
 
-	ret = regmap_read(drv->regmaps[bank], reg_data.ways_status_reg,
+	ret = regmap_read(drv->regmaps[bank], regs.ways_status_reg,
 			  &err_ways);
 	if (ret)
 		goto clear;
@@ -294,7 +294,7 @@ static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 
 	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
 	for (i = 0; i < drv->num_banks; i++) {
-		ret = regmap_read(drv->regmaps[i], DRP_INTERRUPT_STATUS,
+		ret = regmap_read(drv->regmaps[i], drv->edac_reg_offset->drp_interrupt_status,
 				  &drp_error);
 
 		if (!ret && (drp_error & SB_ECC_ERROR)) {
@@ -309,7 +309,7 @@ static irqreturn_t llcc_ecc_irq_handler(int irq, void *edev_ctl)
 		if (!ret)
 			irq_rc = IRQ_HANDLED;
 
-		ret = regmap_read(drv->regmaps[i], TRP_INTERRUPT_0_STATUS,
+		ret = regmap_read(drv->regmaps[i], drv->edac_reg_offset->trp_interrupt_0_status,
 				  &trp_error);
 
 		if (!ret && (trp_error & SB_ECC_ERROR)) {
@@ -341,7 +341,7 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
 	int ecc_irq;
 	int rc;
 
-	rc = qcom_llcc_core_setup(llcc_driv_data->bcast_regmap);
+	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
 	if (rc)
 		return rc;
 
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 423220e66026..93417ba1ead4 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -69,9 +69,6 @@ struct llcc_slice_desc {
 /**
  * struct llcc_edac_reg_data - llcc edac registers data for each error type
  * @name: Name of the error
- * @synd_reg: Syndrome register address
- * @count_status_reg: Status register address to read the error count
- * @ways_status_reg: Status register address to read the error ways
  * @reg_cnt: Number of registers
  * @count_mask: Mask value to get the error count
  * @ways_mask: Mask value to get the error ways
@@ -80,9 +77,6 @@ struct llcc_slice_desc {
  */
 struct llcc_edac_reg_data {
 	char *name;
-	u64 synd_reg;
-	u64 count_status_reg;
-	u64 ways_status_reg;
 	u32 reg_cnt;
 	u32 count_mask;
 	u32 ways_mask;
-- 
2.25.1

