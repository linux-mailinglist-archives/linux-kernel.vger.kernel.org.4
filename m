Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4BE66A9D3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjANHLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjANHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:10:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9517A90
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y1so25575129plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDYubuABKCYBwbQruwwUwFz0u7uXQ46CcuCTpTGxi38=;
        b=pf6fAs3hb1DmPckJunY12j7JyQ1tkBXB9r/624sMaGryu1J9p/Nyx3CGXo0ivMZrV4
         UWmb9AqkVKx3T5ygadLTeWUZapzbDHyMOfkzUz/OlWQxpKDpS0UaQe4JWBIZw6D95nb2
         GLlcega7Q359rj8EBe245NVjZrbgPCeNzdhDzqiHeHsu5mDK/NkdXinVcAFUv72Ihigg
         9JLpzCQ0eXCNovdxZCHkvLMZ+1PGr/iQ6tW5mAGh6tHZEfR0tu8cM2WySPks5yaoiQ7r
         SDc4lSWfsA95DJszAQpmBzTXxRsRAqqlnKPMAAJR2c/SCIp0Tn2FYME+Ec4pXrQZFKq5
         U2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDYubuABKCYBwbQruwwUwFz0u7uXQ46CcuCTpTGxi38=;
        b=Vuy7qZ3dy1wKQmDS9YUthnLodYSnwJMz3HRTgPUvKyXR+evlpqy0StzZpISO8Y1r/U
         d9ZTYLfM/ZzJYpNrTJfllSYCoo8axA7yArxk7vWxnymtxafR0OGUd3t5IbmnfxiM5q1V
         qCeu45qlKOzp4LAREFlvnlmtdUb9NhgbB6paLuqAUEwS3rkdunSpuTeuoorzGrClJmfw
         ZzrXnxtEq3sC+OWDYgAOdEv5liKRiH88RSkEcxn/ABYSfDYwDxRmMxCEMCT8/pZOQ2QB
         mastvw1gNtpf54CXarBuIgHW6/ewA6AXiRTx878uS3O6X/U//CzZ+PSgOZCVDSZpR7WR
         1XXg==
X-Gm-Message-State: AFqh2kqpdXYz0rhvSr3JWjQBE4McHJf//eKYs3hu+sMnG0Ox25XggiyB
        6aXknAD1Ea99blB6aDP+dgR5otqhBsu4r/w=
X-Google-Smtp-Source: AMrXdXtPHSVEtucBA9uruPWUmhEAljkUs2peq8cKbos/vokW4WzkwZsgC3cWiLGEZBwca0twpfXN/w==
X-Received: by 2002:a17:902:9695:b0:193:3314:540d with SMTP id n21-20020a170902969500b001933314540dmr19681376plp.51.1673680232559;
        Fri, 13 Jan 2023 23:10:32 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm15225358plc.295.2023.01.13.23.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:10:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 04/12] phy: qcom-qmp-ufs: Add support for configuring PHY in HS Series B mode
Date:   Sat, 14 Jan 2023 12:40:01 +0530
Message-Id: <20230114071009.88102-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
References: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
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
index 90d644fb321b..91285ddd663e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -552,6 +552,8 @@ struct qmp_phy_cfg {
 
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_cfg_tbls tbls;
+	/* Additional sequence for HS Series B */
+	const struct qmp_phy_cfg_tbls tbls_hs_b;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -585,6 +587,7 @@ struct qmp_ufs {
 	struct reset_control *ufs_reset;
 
 	struct phy *phy;
+	u32 mode;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -848,6 +851,8 @@ static void qmp_ufs_pcs_init(struct qmp_ufs *qmp, const struct qmp_phy_cfg_tbls
 static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg *cfg)
 {
 	qmp_ufs_serdes_init(qmp, &cfg->tbls);
+	if (qmp->mode == PHY_MODE_UFS_HS_B)
+		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
 	qmp_ufs_lanes_init(qmp, &cfg->tbls);
 	qmp_ufs_pcs_init(qmp, &cfg->tbls);
 }
@@ -1018,9 +1023,19 @@ static int qmp_ufs_disable(struct phy *phy)
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

