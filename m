Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C379613CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJaSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJaSC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:02:59 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790013DD3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:02:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 78so11333535pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az+mbqwaQdajMORJaiUBcviJsUOKBXycrYz2HKA47/E=;
        b=VFf52+bdqzJyslIQpm0rjtPL6FEnpZk//tWUJACHX+iQh6ZYzfBI7nGthmgkuNkJNG
         GJJt855vPoU25lQgPO4nEWh8k8IYoVEGLdc7AC+pbFzSJmxVQ9aMzEHWZMdhFkAY2abv
         OsFxoKHKjLDCiEAgzMNW//J7UBiwO+tgmxpIALqhGPLkCdLTgZG7DStlekRcQwP6Rpr1
         kr/qff3pwKEB66zk3RO1OY5ChCxrvvo6qCeaINOKySCLbY8CkB60887ggnUOGwOeJyr5
         shvTtNXAoEpqnJnnnapy1ngK/JT5p/o2GkZZvGWUJW2+R33dxX4kVtKswFWo+2AZJvmf
         px2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az+mbqwaQdajMORJaiUBcviJsUOKBXycrYz2HKA47/E=;
        b=Fs5PjgjyVu88QLziBTX/LPeCdcmm/CNSFhAtNbtWZIVy6jt8R6L16HiEb+amGCdkoN
         0orf8uxx8+T1x6UWzHpc99vNfCIl8zMNco6obo+fEa0egkUw600I6fTGWaOuFMN8WjNr
         Ooyk6bCrzK/7Fq1o/JlJLVP0QKLARTC3kZA1gAKWMpssRXMzFD7K+KaO86vBTchr4JNb
         TOxYaaNzxg7VwSXgQuY5rOqqc+0ihkeltLOoUjfUPRUAbI8vwgfuwybNfNb5EMuduHL4
         +nZLBSTfult5p2HqQp5bGuja7ZXxQOsk42Z27QpdzvnO0d9DtCn0yXh31DMMZ3c3lqPh
         MSyA==
X-Gm-Message-State: ACrzQf0QxDfUKeb4uokdOMFzlvVIz7eFJ/hOJ5T4r869fP8lig2oIp/q
        ZGP8uBAE4eKHmIHv27xaH/mR
X-Google-Smtp-Source: AMsMyM6qb3bnXQ6wtLizQA/BewtZqvsGYBB5m0B22PSvF3DZDL342VIwvxVKXlCprfdLvEQKU+F+0g==
X-Received: by 2002:a05:6a00:1152:b0:56c:dd9c:da94 with SMTP id b18-20020a056a00115200b0056cdd9cda94mr15578291pfm.66.1667239377356;
        Mon, 31 Oct 2022 11:02:57 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:02:55 -0700 (PDT)
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
Subject: [PATCH v2 03/15] phy: qcom-qmp-ufs: Add support for configuring PHY in HS G4 mode
Date:   Mon, 31 Oct 2022 23:32:05 +0530
Message-Id: <20221031180217.32512-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add separate tables_hs_g4 instance to allow the PHY driver to configure the
PHY in HS G4 mode. The individual SoC configs need to supply the Rx, Tx and
PCS register setting in tables_hs_g4 and the UFS driver can request the
Hs G4 mode by calling phy_set_mode_ext() with submode set to UFS_HS_G4.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 4c6a2b5afc9a..5f2a012707b7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -553,6 +553,8 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_cfg_tables tables;
 	/* Additional sequence for HS Series B */
 	const struct qmp_phy_cfg_tables tables_hs_b;
+	/* Additional sequence for HS G4 */
+	const struct qmp_phy_cfg_tables tables_hs_g4;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -587,6 +589,7 @@ struct qmp_phy_cfg {
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @qmp: QMP phy to which this lane belongs
  * @mode: PHY mode configured by the UFS driver
+ * @submode: PHY submode configured by the UFS driver
  */
 struct qmp_phy {
 	struct phy *phy;
@@ -600,6 +603,7 @@ struct qmp_phy {
 	void __iomem *pcs_misc;
 	struct qcom_qmp *qmp;
 	u32 mode;
+	u32 submode;
 };
 
 /**
@@ -993,8 +997,12 @@ static int qmp_ufs_power_on(struct phy *phy)
 		qmp_ufs_serdes_init(qphy, &cfg->tables_hs_b);
 
 	qmp_ufs_lanes_init(qphy, &cfg->tables);
+	if (qphy->submode == UFS_HS_G4)
+		qmp_ufs_lanes_init(qphy, &cfg->tables_hs_g4);
 
 	qmp_ufs_pcs_init(qphy, &cfg->tables);
+	if (qphy->submode == UFS_HS_G4)
+		qmp_ufs_pcs_init(qphy, &cfg->tables_hs_g4);
 
 	ret = reset_control_deassert(qmp->ufs_reset);
 	if (ret)
@@ -1083,6 +1091,7 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 
 	qphy->mode = mode;
+	qphy->submode = submode;
 
 	return 0;
 }
-- 
2.25.1

