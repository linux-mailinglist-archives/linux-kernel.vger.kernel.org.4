Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C163F673
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLARon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLARoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:44:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE7B71EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:44:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y17so2329773plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EwbwxScxAH0Ye5HC8kecov46MNjbALXnqq/6xD/uZI=;
        b=t+B+gdvWpTyroYE+SGEqX9/YuhL5Dufp6zJbMHpPHKhyaoEcktAaFKu/KlVFq2Akzm
         pW2nsD9QNakchPgTAfPcv6qm/0opGtV3Hscm7fhTCw9FwPmXqVvGXHZ93ulLzlegBNlI
         oQvRpUkMTWVh8sfqCYPG/SAd6CcqbDdRLU2nUAwwP2qb3rjSKrRmzZ8LBt53Z7Kk84bM
         62exduN0roGn38WL9Y/U2Sm7JXUPt0SMU5w51yQSxCnSXOmtEPZ2khFbr2CyV4dxlWWO
         YKdzwsXrLB/HBc3E2WQhbQwRgjwNbqk0vBscGy8L9eaNluH6S6hiJPzLCsBH8+rIBLiN
         mhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EwbwxScxAH0Ye5HC8kecov46MNjbALXnqq/6xD/uZI=;
        b=WE2r6PFjVhCSpBfIVDujeqLIJY/NM1wx3Co3krPwQopW5JQ3TTq1R1rjj0GPSfncU5
         jOia9buL6tLu7eAxoYj58AXwwxRBq+4SOBPBsdwRrOwlqaT+RlGMaJvF8GhNMOvfK0yQ
         esC3LaUckg2SVdtMjpLf/rpctXGcbPdBSwzOlmEmTJPp6NnlLhyOafyFQJxMQ3yz9KSE
         Q4Y14bxRZMOwvBi8DEC+73NoQUlwuMQYhhLPclYt9FGVFEhdWPmfJSC3qEI3GTLlFI9r
         Bfi9ewo2raTLgP2NF1oAlG6VuSudfJjmvy1qM1fE2mhe7kTU2AMgqfoEwwR1ohGFqNRY
         86kA==
X-Gm-Message-State: ANoB5plReP1ZQUsGygfWEBe9IXG3JTA2kIu91VM2WtDvE3vYdnnn942C
        MqI2j3LMl7r05aikxUdrS0M1
X-Google-Smtp-Source: AA0mqf5ydUecqFe7PW9IOZSeA7CC2Qp/29SmhDgnZCLdXfjL++61YnwIkT911+LZT8O2qDb9RPw2kw==
X-Received: by 2002:a17:902:e94e:b0:186:5613:becf with SMTP id b14-20020a170902e94e00b001865613becfmr37192236pll.46.1669916656633;
        Thu, 01 Dec 2022 09:44:16 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:44:15 -0800 (PST)
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
Subject: [PATCH v4 05/23] phy: qcom-qmp-ufs: Add support for configuring PHY in HS G4 mode
Date:   Thu,  1 Dec 2022 23:13:10 +0530
Message-Id: <20221201174328.870152-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
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
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 2d5dd336aeb2..82be9b754e8e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -20,6 +20,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
+#include <ufs/unipro.h>
 #include "phy-qcom-qmp.h"
 
 /* QPHY_SW_RESET bit */
@@ -549,6 +550,8 @@ struct qmp_phy_cfg {
 	const struct qmp_phy_cfg_tbls tbls;
 	/* Additional sequence for HS Series B */
 	const struct qmp_phy_cfg_tbls tbls_hs_b;
+	/* Additional sequence for HS G4 */
+	const struct qmp_phy_cfg_tbls tbls_hs_g4;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -583,6 +586,7 @@ struct qmp_ufs {
 
 	struct phy *phy;
 	u32 mode;
+	u32 submode;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -847,7 +851,11 @@ static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg
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
@@ -1021,6 +1029,7 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	struct qmp_ufs *qmp = phy_get_drvdata(phy);
 
 	qmp->mode = mode;
+	qmp->submode = submode;
 
 	return 0;
 }
-- 
2.25.1

