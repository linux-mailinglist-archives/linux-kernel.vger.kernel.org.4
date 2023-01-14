Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62E466A9E3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjANHMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjANHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:11:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272DE358D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:11:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id bj3so21288707pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrkQ9WSsGQbF4BcRajMW7kD5vzHIY33MCkjUr8TDVpY=;
        b=VL92hbwn5A4Ok8rWrnpvYu7rtsSghIgsZdlnq1gYZZAR7/lL3+dF2mCfmZWmklSDt+
         brR7rLEu1ZtcSv9Hme0ZNsKhrzPg+1SGsapTBpEC3gWq23NpuMhTPjIsZ3UVXKYuroiX
         ie/YQ4s/Lj97ppJOT/Cb4LFAIbN5AsmUKjY9u52x8q//co1wzsUUoDgyVmp2Tu9d1i1c
         OOt573ShATOyuOjghyyZVW1cQLbHsC8T3oMXsyJFD6gXzAcBEugbAIm3qQiP9DxXeInJ
         /rRvkdgTUVz3Eegm+atXJ9imwCQIN07xQgyn9WUlWIybYZ1YqbkxWKkLt7ci5ItRaMEX
         PqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrkQ9WSsGQbF4BcRajMW7kD5vzHIY33MCkjUr8TDVpY=;
        b=K2o3f9o1U/1Fz8qa+uT8BlVTeX1kImlNwEHeWru7U0k0RUymJPrPCRA5+fikQohNjp
         xLPLSGRvwNKKN986aYjcyP1iySXanf8ZcCDmm3blCv+uLHHMj9zWpw6u20wR7dcv0Cwa
         YJ0NX8ADZ+IUct1X1nIs+fOgVf46bDofpjHuE6XwaNHLHVkJe50JO95DspBoEIjVejBu
         RV48GJ7Z25C/OLPEzK06CCSwg+FhccbRytmjdsQwtWkoHm7fCUbYPlGdjwbErLk7WZWH
         yFSDJV7oefJwisfkd4igD2858e/nkRkibrd39Bih0zNb3cLSndLnOtPRKS3OXuMCQh2x
         Rr+w==
X-Gm-Message-State: AFqh2kqGRbwMd3fVi5MOpgRjSJJmjFxJpFoQESE/f/S8SP5SPV3/8jn3
        jm6UKXOrlbXV8DJUNrTIA9iX
X-Google-Smtp-Source: AMrXdXtoJu1I8bodRntcZZ+E141pki5zk8mww8k8+rbUfQcXcxDbyOBZt9WXtMYsV+DUq/OveKTRKg==
X-Received: by 2002:a17:902:b413:b0:189:6ab3:9e64 with SMTP id x19-20020a170902b41300b001896ab39e64mr80347671plr.34.1673680265605;
        Fri, 13 Jan 2023 23:11:05 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm15225358plc.295.2023.01.13.23.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:11:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 12/12] phy: qcom-qmp-ufs: Add HS G4 mode support to SC8280XP SoC
Date:   Sat, 14 Jan 2023 12:40:09 +0530
Message-Id: <20230114071009.88102-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
References: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
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

UFS PHY in SC8280XP SoC is capable of operating at HS G4 mode and the init
sequence is compatible with SM8350. Hence, add the tbls_hs_g4 instance
reusing the G4 init sequence of SM8350.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 5cdac38c5fdc..110d8fb9309f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -768,6 +768,14 @@ static const struct qmp_phy_cfg sc8280xp_ufsphy_cfg = {
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

