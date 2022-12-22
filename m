Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84265426B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiLVOK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiLVOKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:10:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C42B604
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:10:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f3so1407192pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p+KNgANSr5uBHeX1FzcIMoLA4Ae3aZ8ABPlQd95kGE=;
        b=kwcMnFApASjLH34+IJRVUZAoeKisxzikTzT6bazUX+C3HMpTaJJoeRjhc83tn1EMlq
         C9+SN6eWRfRl1vrEDeFbF4HTvJ0PJF5Vx9l5EKv5PxF01+4rQ669wCD7I0Ok1kgVuuqk
         kWZl9pC28EbwyYF6KKy7k7fzRUQJbLFEJccsF9n6VDX6Hz/RfxpdMJmJ8v3u5+XbSC0R
         NhJ+8aDU4yOLhEnjlGQgmFpn02msqiWdhqz9pQFRtxgC3YjQjd98gUPdMSIPbwnaL8Lh
         RUfZM9cyPeL8ucQ4ILThSKAvvEPwtzrK8iLwYlg/7QCM8fBtnwCVNUKTn/6B/K0e4PxZ
         TIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p+KNgANSr5uBHeX1FzcIMoLA4Ae3aZ8ABPlQd95kGE=;
        b=U+5QzpT9gap/KseP5BYrgdHZ+VYrmZGYqXxj2AJLjSVsuSyaHuMdFLS7SsFzPJF7Hz
         rGBUhw7aQFRQsEwv0c6I+VLHatvHNiR6Jf/7iPGPxIyaGwAnYR+3IVNpBUcGPnoptnHB
         HsPXAF7HfS50lZ54o61C2ZADKPe1x6TriEsmYVk4BcmhIPX9vqZbUvnCOU6K4TGTgwwg
         fAjJB0t4TKzTTNiHNw0DyZbeMagH1mSiTLvzNY4AAeYNPgw1SwZ11k4gp1A4fW5l3SEF
         r/3lZykTA1MQO0mDk2Y4G9UMs87pZD/H4m2VKmxLN2rMhF/A6Hm3CzrALsu6UKwvbl03
         8p3A==
X-Gm-Message-State: AFqh2krGDlY3dyvZco9Kye5P2qA31JllgSr6wW02cGJdsh2c4t/LoUMI
        HfurZ4FclhtT2kxs7SwCLHur
X-Google-Smtp-Source: AMrXdXvgrVn02a7jIirzsbGlIVgIxpWXsY5Kg7ocqVjDd6dguplca9rtJdReeG9FNTfJ9ppDQhCxDA==
X-Received: by 2002:aa7:9f07:0:b0:575:cce2:cd83 with SMTP id g7-20020aa79f07000000b00575cce2cd83mr6116962pfr.5.1671718238959;
        Thu, 22 Dec 2022 06:10:38 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:10:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 04/23] phy: qcom-qmp-ufs: Add support for configuring PHY in HS Series B mode
Date:   Thu, 22 Dec 2022 19:39:42 +0530
Message-Id: <20221222141001.54849-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
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

Add separate tables_hs_b instance to allow the PHY driver to configure the
PHY in HS Series B mode. The individual SoC configs need to supply the
serdes register setting in tables_hs_b and the UFS driver can request the
Series B mode by calling phy_set_mode() with mode set to PHY_MODE_UFS_HS_B.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 516027e356f0..2d5dd336aeb2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -547,6 +547,8 @@ struct qmp_phy_cfg {
 
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_cfg_tbls tbls;
+	/* Additional sequence for HS Series B */
+	const struct qmp_phy_cfg_tbls tbls_hs_b;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -580,6 +582,7 @@ struct qmp_ufs {
 	struct reset_control *ufs_reset;
 
 	struct phy *phy;
+	u32 mode;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -841,6 +844,8 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
 static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
 {
 	qmp_ufs_serdes_init(qmp, &cfg->tbls);
+	if (qmp->mode == PHY_MODE_UFS_HS_B)
+		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
 	qmp_ufs_lanes_init(qmp, &cfg->tbls);
 	qmp_ufs_pcs_init(qmp, &cfg->tbls);
 }
@@ -1011,9 +1016,19 @@ static int qmp_ufs_disable(struct phy *phy)
 	return qmp_ufs_exit(phy);
 }
 
+static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct qmp_ufs *qmp = phy_get_drvdata(phy);
+
+	qmp->mode = mode;
+
+	return 0;
+}
+
 static const struct phy_ops qcom_qmp_ufs_phy_ops = {
 	.power_on	= qmp_ufs_enable,
 	.power_off	= qmp_ufs_disable,
+	.set_mode	= qmp_ufs_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.25.1

