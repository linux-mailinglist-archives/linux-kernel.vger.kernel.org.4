Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3D66A9D5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjANHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjANHKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:10:52 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FD7AA5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b17so18057971pld.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6UnC1hlB+v3q7qNl2UemN8iZ10TjdJQ4rcW+wGUH18=;
        b=p1sC9W/bZo/ItmyrTIHt2xlM6iwiYlknA+/cMq7ZU7odrL229sHachfoLeG7s7Fzgp
         RNi5j2zJgxM26lTWW8h5pNHH3cHGrJsT7TGo0mbr/5euin0VEvUnAM4kZUMKWYugbLSW
         Q9Un7615SFMEm5jMG8DexEY/wLIbFbXT61F6rJEbEPCF4O666JIIMIyDCt8mQE6MpVtU
         7+XFGv733tlgswRD5DcVSpVF024Pxvj77NsZiVxmUemSysPfj/paLpxKJKGglPbFbwGq
         HCpdT0pnPRXfnV7aWI4OL8QWDXU0YN+W+5hv6VMhR1yMZuuGc23gT7aUOf+bIjNiq0vB
         ql/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6UnC1hlB+v3q7qNl2UemN8iZ10TjdJQ4rcW+wGUH18=;
        b=1MNmXaGyINRWjQWm7WvGvLSD5WpohUiXmfl55yF3IAwyLZvhbFfl9WR3OhApWmXJE8
         CoIy5oKQL3zgYYwiOu3wFqUMPKThj756qvBiTJG1uWs/PfBRHReBMfvnV3id+gFXkEkR
         K7MhSFSdk5MVB+eTOhN7k7Q+zN/878TYVGI3UhtmCBbUO0Mx6Jf9q2iu2WSi4VBVScaK
         fttFnpEi0UrBW8ePdqRGKe7bg3Fvu/PH7QIglpl5BZKXtXSFMBCSyU3/DqLk8Ds++OpI
         RxLuHvmlyZbzuvIXD7hEnXIz36iLdEuGxY8jHUuA/lVRRtOU/6fpBFf0JCyQO2lbeWXr
         PYRg==
X-Gm-Message-State: AFqh2koWjvoiUSYg1QXEGgNyAPvYCatcv41J0p3lTM394HKoU6lZDoGj
        sEuWZYx3JM715DybtyiblpQi
X-Google-Smtp-Source: AMrXdXsAonETMWZspOAImOrnqq8pa2oFU10LwA0EwUsLfh0qVXklogWGUjPTaTStC1hrg+3pUS3JvA==
X-Received: by 2002:a17:902:b10d:b0:194:4339:112e with SMTP id q13-20020a170902b10d00b001944339112emr15728704plr.60.1673680236797;
        Fri, 13 Jan 2023 23:10:36 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm15225358plc.295.2023.01.13.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:10:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 05/12] phy: qcom-qmp-ufs: Add support for configuring PHY in HS G4 mode
Date:   Sat, 14 Jan 2023 12:40:02 +0530
Message-Id: <20230114071009.88102-6-manivannan.sadhasivam@linaro.org>
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

Add separate tables_hs_g4 instance to allow the PHY driver to configure the
PHY in HS G4 mode. The individual SoC configs need to supply the Rx, Tx and
PCS register setting in tables_hs_g4 and the UFS driver can request the
Hs G4 mode by calling phy_set_mode_ext() with submode set to UFS_HS_G4.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 91285ddd663e..bb329cfbb96d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -20,6 +20,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
+#include <ufs/unipro.h>
 #include "phy-qcom-qmp.h"
 #include "phy-qcom-qmp-pcs-ufs-v2.h"
 #include "phy-qcom-qmp-pcs-ufs-v3.h"
@@ -554,6 +555,8 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_cfg_tbls tbls;
 	/* Additional sequence for HS Series B */
 	const struct qmp_phy_cfg_tbls tbls_hs_b;
+	/* Additional sequence for HS G4 */
+	const struct qmp_phy_cfg_tbls tbls_hs_g4;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -588,6 +591,7 @@ struct qmp_ufs {
 
 	struct phy *phy;
 	u32 mode;
+	u32 submode;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -854,7 +858,11 @@ static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg
 	if (qmp->mode == PHY_MODE_UFS_HS_B)
 		qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
 	qmp_ufs_lanes_init(qmp, &cfg->tbls);
+	if (qmp->submode == UFS_HS_G4)
+		qmp_ufs_lanes_init(qmp, &cfg->tbls_hs_g4);
 	qmp_ufs_pcs_init(qmp, &cfg->tbls);
+	if (qmp->submode == UFS_HS_G4)
+		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
 }
 
 static int qmp_ufs_com_init(struct qmp_ufs *qmp)
@@ -1028,6 +1036,7 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	struct qmp_ufs *qmp = phy_get_drvdata(phy);
 
 	qmp->mode = mode;
+	qmp->submode = submode;
 
 	return 0;
 }
-- 
2.25.1

