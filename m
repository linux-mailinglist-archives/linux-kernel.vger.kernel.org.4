Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE166A9E2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 08:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjANHMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 02:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjANHL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 02:11:26 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F08270C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:11:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bj3so21288621pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 23:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PwdjXA5SmlO8nYbrDvRgCYSmaJnFGUQlCDqC6dIODM=;
        b=U0mpAizT5O6VluAg7cfuMxsdtV7F6Sbr6BVaoGSaA0lTUUrRh47eyP3zOR5fr3c+mm
         zW4nIZfztgutfOWLgjmRRd6+vq2b0yt7ryGui1McJEdx7R2wmbtwNUMgL9pSYndlvP6w
         GRCflJvRrE1CJ6PRdiHYlHaLHfEN2oCaW6H9pa6eekOLMu+by3bUMOoVC1D0obAy4ZYV
         24cpNBRGlFTG/4E1w/pvcr98udx88FWfm9ZlznhsL7vFMEhzKiicxGfwzxz3tc/cXC67
         JD9XIdJCyYW0T0UcpoYCrP4IuHwGARE1+n0WrjEk8BZxbS//TG55fBlmV88vkEd0P5+N
         A0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PwdjXA5SmlO8nYbrDvRgCYSmaJnFGUQlCDqC6dIODM=;
        b=4i/lcflIgXX0zEdmjEb89UVcfvxgGolDtU5PynRgtj5IIJ5vgaM/xKu6mRRLhVcSJ1
         nxbvMtDXKeBSNgdtPc4pdZwL5epLzZdoAwMHAPopd3TEaVDPlbbVmiW1shg7wQkfXy7T
         z9jNU3pJoqFAqSwGxispGGvvge420Rxf8gfJf//F+K+t6ykxt8P1a/y67iD3z6xvf/tR
         aw3Km9Q7XFxncY1bksAn4TSwtgy4OJpSCm79xlQE2XmrbkmrxZsutaJOmEqHWkFHvjEA
         RzTvx96/9JMDuQ4TKQubwdmlztkru3u3QVF5nDpxx8iHwcOMVMeqNBwyY/i/NeW8MYyX
         0FGw==
X-Gm-Message-State: AFqh2kqbzfeaLOnrwGdLmgay4YBG2vehLs8ibMw+w0pR3OLG+7kim+xR
        tkqXF+F12HdwJZ2BuqGN/HY0
X-Google-Smtp-Source: AMrXdXvl2hpvC3tR63eDAw+p8gHxgqEOR5I6HiLJpseb35C+a/q5zx4NosHnS75WoQjhn3noR4sxsw==
X-Received: by 2002:a17:902:8686:b0:194:3fd8:f56a with SMTP id g6-20020a170902868600b001943fd8f56amr15571964plo.55.1673680261313;
        Fri, 13 Jan 2023 23:11:01 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.156])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm15225358plc.295.2023.01.13.23.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 23:11:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 11/12] phy: qcom-qmp-ufs: Add HS G4 mode support to SM8450 SoC
Date:   Sat, 14 Jan 2023 12:40:08 +0530
Message-Id: <20230114071009.88102-12-manivannan.sadhasivam@linaro.org>
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
index b784eed2eb1f..5cdac38c5fdc 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -942,6 +942,14 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
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

