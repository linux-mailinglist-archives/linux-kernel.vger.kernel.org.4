Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4D63F68E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiLARqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLARpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:45:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5580B9572
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:45:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d3so2312120plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+yU2PJqff6HfxgfUe/14S1MmfILPlp3TneaSoyB8Rk=;
        b=sEKTEWor//XX9CNzxptWM0Mo/cKJyH2gerDuz2RxLVjhZ8YWVP06Jd59QJmMEVv444
         46wR3D+yUqZNMuoJmddiYWAAZJFQTBWMFRNDscVmo8NJYIIGL3HbxUanHl00GdFjGQTW
         lnrv7dRZrL/jG49nJcU+7tWYLtFrKdgjrt9dDBT2XCHLugsdFjH3D3JvfGJMOH2Nsi53
         hTw52lbl+CgOtSUVMnpdvSv8btjrwSCARToMdMOpcAktPNaqb1qCGhw/hvXJRnWcV7g1
         2AJ2iWImbu0USd6w+3ihsrIHB4MLYVtbZyY58dqu/1UcFKqQEknJbBzI+zYPjsHDfkRN
         Khww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+yU2PJqff6HfxgfUe/14S1MmfILPlp3TneaSoyB8Rk=;
        b=jLiQkI4uQO5dn+wrxuVgzqJjsTWYHxa/O24Lo9lYruNtVxgLqPad059DDT2E2zJ2sp
         KovHvwkfyXBJwTjYhXQ0RrASUSkibbPnL/pRHJIVEzH+e5i5/lgZgWRzcyYKmpR5/vO2
         jM5IDkMHrQFnxA14sDP7xQNpRqXiyoYVrLmYYva8UUaB2IN9bMPxMJcCfsP1r5x/y214
         vhqykl5op19+O2Zc5aWdMPl5KmM7xIIzksU71ycF7NacShjlZ9TIS6TNBMh12Ow+DsCJ
         RWw6nQ3tWwJH6drkOeVyGSqJS3UGtSXIw/SobADFntU/Yop+x0zsoFo2KXzpy2fx/av/
         gZlw==
X-Gm-Message-State: ANoB5pnYFjYB4SX5AoLwNLLiMFZ0oeNrUBgMhCi5c8k3+3C7iqHh8fjl
        01dhmpXqU/pm9nVf+iY0CXmS
X-Google-Smtp-Source: AA0mqf6uYy4xVgPng+hE048oDwzDISVi85FyfyOjY1+PAxX0iUnnssKYNkPj/txIBloDjOhTxOb1pQ==
X-Received: by 2002:a17:902:f2c5:b0:189:1cc3:802a with SMTP id h5-20020a170902f2c500b001891cc3802amr49657068plc.56.1669916704143;
        Thu, 01 Dec 2022 09:45:04 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:45:03 -0800 (PST)
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
Subject: [PATCH v4 12/23] phy: qcom-qmp-ufs: Add HS G4 mode support to SC8280XP SoC
Date:   Thu,  1 Dec 2022 23:13:17 +0530
Message-Id: <20221201174328.870152-13-manivannan.sadhasivam@linaro.org>
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

UFS PHY in SC8280XP SoC is capable of operating at HS G4 mode and the init
sequence is compatible with SM8350. Hence, add the tbls_hs_g4 instance
reusing the G4 init sequence of SM8350.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 96e03d4249da..9f5526758985 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -763,6 +763,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
 		.serdes		= sm8350_ufsphy_hs_b_serdes,
 		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
 	},
+	.tbls_hs_g4 = {
+		.tx		= sm8350_ufsphy_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
+		.rx		= sm8350_ufsphy_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
+		.pcs		= sm8350_ufsphy_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
+	},
 	.clk_list		= sdm845_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
-- 
2.25.1

