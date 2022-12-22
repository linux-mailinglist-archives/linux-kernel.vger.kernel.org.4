Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4852B654281
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiLVONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiLVOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:12:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB545286CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:11:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so2015008pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X1A4TMvEV2bS5ohL9A0SpECVAvBKwWjyx8LJOjuk7U=;
        b=BxWVBMysDolWbx+Cppe3zn3m/KFARMGNqquNzCFgm75WofleLqYgk94x2rBFTc9Tvl
         MZBxo2wNJc4SWqNe81JTB57k0Z9JvK4i7vYyp8pREFAEhZvECn0YN+yQpOEEQoAdW96g
         Ncxo0MsLT3eNWetF7L6BRXvxqUXOLujvVgRPGzz+TfrkDHDGn6HL+Ao4kbaTlgGUaK6I
         8s7CDXnQPue+wbvAJXkvx3PqI8LwdJGqisMXJTTxK2jM1BQq3MM2uv7nVXM2+FVDYmWb
         ELL6DrURh9fTN/RBhRYcl7VaLD2A3s5w4uUj9klBISsKgTNuMTAhE7ydRglDOnG30Hx8
         sX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X1A4TMvEV2bS5ohL9A0SpECVAvBKwWjyx8LJOjuk7U=;
        b=CPWLpz9PVRtr9Xj2GnbT0bJwgc+LuCiWef0ZX01fBV2DFrksjIR8ade+dCEXS76qnK
         GgIR4MtU9tnpFobTDFhNEVYw7/yXrAinQWan0LDI7pDPH4Dgr5vvt/veWGrrrMBe0rGe
         3dlCpwjciz8irTi5kAUuC9WeFcEya0BuVO/K9MSJVOiWOgKs64OCTrVx0B3gufuGB20d
         C0Z48yeiqAAUze4aeHCIGvCjx0cPnwJh28ln41Chl55BA+NAc/h1VGFsbEENZe8JW04e
         oI+mP6a18pYpg0n080CHpeVGSONGuB2XTjVDZICJCfo+ameOj3pPf8V2e++oQRXA6fUp
         TBwQ==
X-Gm-Message-State: AFqh2krqvIRgmJJm8ZgVM1Zteb09+VwoeM4kcP6H8uwgt4OqlZT9ZhuE
        7/gvvix6b6PnW3D5xcvi2f/l
X-Google-Smtp-Source: AMrXdXuZk/NEnRPNupNCna4VffVs4EjjF+9WNS/4kFEQ/Zy/NZFN/ZFkZIxohRNAc1flJSboQdPzHg==
X-Received: by 2002:a05:6a20:d80a:b0:ad:f82d:78ad with SMTP id iv10-20020a056a20d80a00b000adf82d78admr7597717pzb.46.1671718291165;
        Thu, 22 Dec 2022 06:11:31 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:11:30 -0800 (PST)
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
Subject: [PATCH v5 11/23] phy: qcom-qmp-ufs: Add HS G4 mode support to SM8450 SoC
Date:   Thu, 22 Dec 2022 19:39:49 +0530
Message-Id: <20221222141001.54849-12-manivannan.sadhasivam@linaro.org>
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

UFS PHY in SM8450 SoC is capable of operating at HS G4 mode and the init
sequence is compatible with SM8350. Hence, add the tbls_hs_g4 instance
reusing the G4 init sequence of SM8350.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 75e55c4181c9..96e03d4249da 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -935,6 +935,14 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
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
 	.clk_list		= sm8450_ufs_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(sm8450_ufs_phy_clk_l),
 	.vreg_list		= qmp_phy_vreg_l,
-- 
2.25.1

