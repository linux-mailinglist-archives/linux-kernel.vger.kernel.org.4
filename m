Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09365613D02
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJaSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJaSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:04:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0C13E85
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:03:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso16605022pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgs3s1G1jssoUlSih9AtMddjkl0seI8sJyhiWnXePTs=;
        b=RiMBlIfBxKxj/vF3QFlsYOxRi2XIPOj3IMWWD9vv2naL21WUp4sKZ3OztkVTwLLCr/
         QPNdn7tlw4ZYdM4zQ3+HyQUm0LthXMLietdOGhgiRCktIWfWFN5/kkeewGNCMSqDt7tz
         60bJcLOsbHR6Hr4YzspMCFETPIF5+BQqGjGgVz5mfIxv4T2zobZmTixyMmJDkJXAxVng
         8rreuhH+ONHBFHt83roOzU9NAaBJgpkHFCLJDR1Wa2OusEgTDduDXnhL6GQlm92Xwybu
         ioNCunM/pOvrD0cZntcmURaYPTMZasNitoJsNGsdCJ6blXxY8sBd/7/JqB+cY02+e1e4
         Onvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgs3s1G1jssoUlSih9AtMddjkl0seI8sJyhiWnXePTs=;
        b=xJmWBOrvTf9ZXOKf5ohClJJu0H0itaORpvQ6JuTZm/y69JTGIiwT3r7YEA9PAi7TzZ
         WVyvCkUjKRX3v1ro0nhKA0Mr1SGS8o/TbJRk6hgX/ilxxmNUw+t7dsFdHGp3Pid9kkyr
         6cmohWrR3ZrcbDE4A2+Yr1Zm+/sGMApaBz6BMznzPaZwJUGTHedRwgVrn1AO/NcQ1uqV
         EnxcDcJ+E/f8npoXscVaiKZ8FoSTaw8t/M4W4dSKI8CK26hUA+yE1lX78ba2T+Pefw9R
         bSLptcDfyLzajxpS5Jut2DTTFHBL6my4Wq/OBUx+WpnvpPk6rkHrcS9z2IziBkbT4Kq8
         eNiw==
X-Gm-Message-State: ACrzQf0vVQXGbnVYZ7m4ZhWY0CUth7EHwWpZ6Rt8vd5EiF/ypF8XPwFr
        I/qBUQJ87grad6RO/KekoW0l
X-Google-Smtp-Source: AMsMyM495tr25vJwGEz9GOee1VIPewD2W376fjW8553Y2MxpPs1TKs+xC9JTbyDrYeD0c1kFS3ZDwQ==
X-Received: by 2002:a17:90a:72cb:b0:213:fbf0:f5f1 with SMTP id l11-20020a17090a72cb00b00213fbf0f5f1mr2657622pjk.107.1667239430062;
        Mon, 31 Oct 2022 11:03:50 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:03:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 10/15] scsi: ufs: ufs-qcom: Use bitfields where appropriate
Date:   Mon, 31 Oct 2022 23:32:12 +0530
Message-Id: <20221031180217.32512-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitfield macros where appropriate to simplify the driver.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.h | 61 +++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 44466a395bb5..9d96ac71b27f 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -17,12 +17,9 @@
 #define DEFAULT_CLK_RATE_HZ     1000000
 #define BUS_VECTOR_NAME_LEN     32
 
-#define UFS_HW_VER_MAJOR_SHFT	(28)
-#define UFS_HW_VER_MAJOR_MASK	(0x000F << UFS_HW_VER_MAJOR_SHFT)
-#define UFS_HW_VER_MINOR_SHFT	(16)
-#define UFS_HW_VER_MINOR_MASK	(0x0FFF << UFS_HW_VER_MINOR_SHFT)
-#define UFS_HW_VER_STEP_SHFT	(0)
-#define UFS_HW_VER_STEP_MASK	(0xFFFF << UFS_HW_VER_STEP_SHFT)
+#define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
+#define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
+#define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
 
 /* vendor specific pre-defined parameters */
 #define SLOW 1
@@ -76,24 +73,28 @@ enum {
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
 
 /* bit definitions for REG_UFS_CFG1 register */
-#define QUNIPRO_SEL		0x1
-#define UTP_DBG_RAMS_EN		0x20000
+#define QUNIPRO_SEL		BIT(0)
+#define UFS_PHY_SOFT_RESET	BIT(1)
+#define UTP_DBG_RAMS_EN		BIT(17)
 #define TEST_BUS_EN		BIT(18)
 #define TEST_BUS_SEL		GENMASK(22, 19)
 #define UFS_REG_TEST_BUS_EN	BIT(30)
 
+#define UFS_PHY_RESET_ENABLE	1
+#define UFS_PHY_RESET_DISABLE	0
+
 /* bit definitions for REG_UFS_CFG2 register */
-#define UAWM_HW_CGC_EN		(1 << 0)
-#define UARM_HW_CGC_EN		(1 << 1)
-#define TXUC_HW_CGC_EN		(1 << 2)
-#define RXUC_HW_CGC_EN		(1 << 3)
-#define DFC_HW_CGC_EN		(1 << 4)
-#define TRLUT_HW_CGC_EN		(1 << 5)
-#define TMRLUT_HW_CGC_EN	(1 << 6)
-#define OCSC_HW_CGC_EN		(1 << 7)
+#define UAWM_HW_CGC_EN		BIT(0)
+#define UARM_HW_CGC_EN		BIT(1)
+#define TXUC_HW_CGC_EN		BIT(2)
+#define RXUC_HW_CGC_EN		BIT(3)
+#define DFC_HW_CGC_EN		BIT(4)
+#define TRLUT_HW_CGC_EN		BIT(5)
+#define TMRLUT_HW_CGC_EN	BIT(6)
+#define OCSC_HW_CGC_EN		BIT(7)
 
 /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
-#define TEST_BUS_SUB_SEL_MASK	0x1F  /* All XXX_SEL fields are 5 bits wide */
+#define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
 
 #define REG_UFS_CFG2_CGC_EN_ALL (UAWM_HW_CGC_EN | UARM_HW_CGC_EN |\
 				 TXUC_HW_CGC_EN | RXUC_HW_CGC_EN |\
@@ -101,17 +102,11 @@ enum {
 				 TMRLUT_HW_CGC_EN | OCSC_HW_CGC_EN)
 
 /* bit offset */
-enum {
-	OFFSET_UFS_PHY_SOFT_RESET           = 1,
-	OFFSET_CLK_NS_REG                   = 10,
-};
+#define OFFSET_CLK_NS_REG		0xa
 
 /* bit masks */
-enum {
-	MASK_UFS_PHY_SOFT_RESET             = 0x2,
-	MASK_TX_SYMBOL_CLK_1US_REG          = 0x3FF,
-	MASK_CLK_NS_REG                     = 0xFFFC00,
-};
+#define MASK_TX_SYMBOL_CLK_1US_REG	GENMASK(9, 0)
+#define MASK_CLK_NS_REG			GENMASK(23, 10)
 
 /* QCOM UFS debug print bit mask */
 #define UFS_QCOM_DBG_PRINT_REGS_EN	BIT(0)
@@ -135,15 +130,15 @@ ufs_qcom_get_controller_revision(struct ufs_hba *hba,
 {
 	u32 ver = ufshcd_readl(hba, REG_UFS_HW_VERSION);
 
-	*major = (ver & UFS_HW_VER_MAJOR_MASK) >> UFS_HW_VER_MAJOR_SHFT;
-	*minor = (ver & UFS_HW_VER_MINOR_MASK) >> UFS_HW_VER_MINOR_SHFT;
-	*step = (ver & UFS_HW_VER_STEP_MASK) >> UFS_HW_VER_STEP_SHFT;
+	*major = FIELD_GET(UFS_HW_VER_MAJOR_MASK, ver);
+	*minor = FIELD_GET(UFS_HW_VER_MINOR_MASK, ver);
+	*step = FIELD_GET(UFS_HW_VER_STEP_MASK, ver);
 };
 
 static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
 {
-	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
-			1 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
+	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_ENABLE),
+		    REG_UFS_CFG1);
 
 	/*
 	 * Make sure assertion of ufs phy reset is written to
@@ -154,8 +149,8 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
 
 static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
 {
-	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
-			0 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
+	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_DISABLE),
+		    REG_UFS_CFG1);
 
 	/*
 	 * Make sure de-assertion of ufs phy reset is written to
-- 
2.25.1

