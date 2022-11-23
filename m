Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D063515B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiKWHtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiKWHtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:49:09 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E65FA731
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:00 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so16078239pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17DUm1BHWO+9+pCruDSwXwFA2DWaV0LvIvFJmkLFp/8=;
        b=szHgLObizdRjU8Uhq446KGApvra49ApA5BIcru3Ey/6Do2T56DSsWvR5g9jLZHc476
         MSlgWT8MIf8p+f/sxml/uIYI/OfERwdOxx5UrTrYqsRwWRZFHtuRDyZJ5Rx4UxQu9KFi
         bHD+ee5c55d9SFNG5Pwp6XrqCpbVMI7Noo/UYKv4oy6hdO4XzjAQT10xIo8VNGpS1lk0
         Z20HdS4+82s4XqLdrE2uV7dVCOiPbh7w+y4ldF3k1iYZtAtLx40Dsl+kKesa4AdfKKoU
         pHw3S/F4iNp6nK3l1atD4eXQ9Qt72dI6wxGZlj7nTc6si+4kweYwgd/xG8XerHXUsBmF
         dhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17DUm1BHWO+9+pCruDSwXwFA2DWaV0LvIvFJmkLFp/8=;
        b=4J7Hjgsv7V/Nap/mhJRAagi1NDvQTUG2dWeQ75ychb4I0hHY04OtS9gOglIQQB8ova
         U3OFZQB3MJfXuOTOXPSNJYxLuc8qXKjjsf6ZZUzzNAZGSIBQwqYv0OMt1AO+pUIOatMa
         CAfIbg0zXnMiLSI6h4qpxYuyHfsaaq/WTOZQ2wTmP2ZWTmBwmL3tBbM2hUmMURN+9FLQ
         A1MOrx4EkfNp42ZnYSTs7XbxnOTukqo2YSju5xT3C8pawBjoUnqLPN7e7VUucP/MIFE2
         jPskaR/hBE4LkxIhVdeTT3873h+2Ipf132D1wM8VpIRoizvoNkiQE6IW2P0Kaj5DBnkv
         ZbIw==
X-Gm-Message-State: ANoB5plQb7n2tBTWBzpgSIN0ya4C5jdSaph2lHvwooAXDbBInKuePMqp
        VG+u4EKXCc8WU62o2iT7FyuZ
X-Google-Smtp-Source: AA0mqf5p/xJXOPvTRxbeUxcJCUOhwd51+9yIUCWj0RA8EwvAT98+ugBHbeaX8uInPuYuqUPJ+lVyfQ==
X-Received: by 2002:a63:5007:0:b0:45f:beda:4116 with SMTP id e7-20020a635007000000b0045fbeda4116mr8165671pgb.618.1669189739616;
        Tue, 22 Nov 2022 23:48:59 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:48:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 04/20] phy: qcom-qmp-ufs: Add support for configuring PHY in HS Series B mode
Date:   Wed, 23 Nov 2022 13:18:10 +0530
Message-Id: <20221123074826.95369-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
References: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
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
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 3b7b36e32f5d..694b1d6c1f9c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -20,6 +20,8 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
+#include <ufs/unipro.h>
+
 #include <dt-bindings/phy/phy.h>
 
 #include "phy-qcom-qmp.h"
@@ -549,6 +551,8 @@ struct qmp_phy_cfg {
 
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
 	const struct qmp_phy_cfg_tbls tbls;
+	/* Additional sequence for HS Series B */
+	const struct qmp_phy_cfg_tbls tbls_hs_b;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -582,6 +586,7 @@ struct qmp_phy_cfg {
  * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @qmp: QMP phy to which this lane belongs
+ * @mode: PHY mode configured by the UFS driver
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -594,6 +599,7 @@ struct qmp_phy {
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	struct qcom_qmp *qmp;
+	u32 mode;
 };
 
 /**
@@ -885,6 +891,8 @@ static void qmp_ufs_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tbls
 static void qmp_ufs_init_registers(struct qmp_phy *qphy, const struct qmp_phy_cfg *cfg)
 {
 	qmp_ufs_serdes_init(qphy, &cfg->tbls);
+	if (qphy->mode == PHY_MODE_UFS_HS_B)
+		qmp_ufs_serdes_init(qphy, &cfg->tbls_hs_b);
 	qmp_ufs_lanes_init(qphy, &cfg->tbls);
 	qmp_ufs_pcs_init(qphy, &cfg->tbls);
 }
@@ -1073,6 +1081,15 @@ static int qmp_ufs_disable(struct phy *phy)
 	return qmp_ufs_exit(phy);
 }
 
+static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct qmp_phy *qphy = phy_get_drvdata(phy);
+
+	qphy->mode = mode;
+
+	return 0;
+}
+
 static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -1108,6 +1125,7 @@ static int qmp_ufs_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 static const struct phy_ops qcom_qmp_ufs_ops = {
 	.power_on	= qmp_ufs_enable,
 	.power_off	= qmp_ufs_disable,
+	.set_mode	= qmp_ufs_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.25.1

