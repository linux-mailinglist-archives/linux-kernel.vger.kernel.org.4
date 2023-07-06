Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4740C749C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGFMrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGFMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:47:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA61FF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:47:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e97fcc60so522714b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688647636; x=1691239636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oz3eFvCoH8VMOdDsuRaaEYtU3Bx4lHQ1ug4lyEzFPEw=;
        b=he4hjKQjYDtk50xePCiH1Ss+IYmU1WredzipkMpOaQuXWkuasuL5cU/UifneRnf62w
         yR+/ixt6R4ESh2taNjWKC2JYz6DtokxL4qXPHDYcAX17PP8Uq8rBc9V0mGT+oWX0Y5Ad
         HxZwTPL+OhyGDugSaHl9LDSiKAWTT/jCmw9HDwJ/uS01hFXqopOg+PSv8pGlzJd00SBG
         +TedV4g39Lnptc8H5kGcrCjsybdSf3El1oJCJHfEtJiH+awHxSe8fmw+F920lribxFYy
         /KmLdrV6Rez2dZNfb+uQz0UNWhXB7iYJM0PY4quVDjIBMOtvn0nRd8/jP5uZGHTdGtLk
         Tguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647636; x=1691239636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oz3eFvCoH8VMOdDsuRaaEYtU3Bx4lHQ1ug4lyEzFPEw=;
        b=ZTc2rsChMKxFfmwzXuyXm8dN8VS6EnqEiSkQYjNW1kbWbpU7Pp0KShETTScf8NLghm
         TI3y+3HfVmITetQsZj9678nm/JquGheg82KhqWBe3YPScKQ12lbgyU11dX1466k1ENFT
         lvPcsRxQolHnyBTxA4JkuwVwaDpOFf1TozsMOsfI3TeW+LX1dIuqg5f9qwKBBuy/DGhM
         GOhFjYjiFHU3WBMMMBevCfVHs6XKLtIKSPdHhViT4RnIffWOQj9WNH853dQ1DYnJeA6i
         FA2S2Rg/EsA1HG7IrrhPd/4xKoGWhe6t+ynk5QbWorM/L2n6RPDApXlG3XQPfM7w49cK
         08mg==
X-Gm-Message-State: ABy/qLaBEdr9P/YxmdyN3VIHzt6rNpCKD/Z/10kcT3CafgfNSeH7VV2t
        HNBKgk+DQ0XyagSa3yS3QV9o
X-Google-Smtp-Source: APBJJlG7Z3x52Kkhx6a2YCvXWlkBD0byz59sKqA41aeJvXP2WI89Sh2NDFoHMcklC1pDEyShwf+bOg==
X-Received: by 2002:a05:6a00:1912:b0:682:57f0:7c00 with SMTP id y18-20020a056a00191200b0068257f07c00mr1482885pfi.3.1688647635979;
        Thu, 06 Jul 2023 05:47:15 -0700 (PDT)
Received: from localhost.localdomain ([117.216.120.100])
        by smtp.gmail.com with ESMTPSA id t21-20020a62ea15000000b00666e649ca46sm1227066pfh.101.2023.07.06.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:47:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] Revert "clk: gcc-sc8280xp: keep PCIe power-domains always-on"
Date:   Thu,  6 Jul 2023 18:17:00 +0530
Message-Id: <20230706124700.12447-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 12d2a4769380f0dc9ba6f827839869db2b81ef00.

With the minimal system suspend support in place for the PCIe driver that
keeps the interconnect path active, the ALWAYS_ON flags can now be dropped.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 04a99dbaa57e..07eb6110442c 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -6774,10 +6774,6 @@ static struct gdsc pcie_1_tunnel_gdsc = {
 	.flags = VOTABLE,
 };
 
-/*
- * The Qualcomm PCIe driver does not yet implement suspend so to keep the
- * PCIe power domains always-on for now.
- */
 static struct gdsc pcie_2a_gdsc = {
 	.gdscr = 0x9d004,
 	.collapse_ctrl = 0x52128,
@@ -6786,7 +6782,7 @@ static struct gdsc pcie_2a_gdsc = {
 		.name = "pcie_2a_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_2b_gdsc = {
@@ -6797,7 +6793,7 @@ static struct gdsc pcie_2b_gdsc = {
 		.name = "pcie_2b_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_3a_gdsc = {
@@ -6808,7 +6804,7 @@ static struct gdsc pcie_3a_gdsc = {
 		.name = "pcie_3a_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_3b_gdsc = {
@@ -6819,7 +6815,7 @@ static struct gdsc pcie_3b_gdsc = {
 		.name = "pcie_3b_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc pcie_4_gdsc = {
@@ -6830,7 +6826,7 @@ static struct gdsc pcie_4_gdsc = {
 		.name = "pcie_4_gdsc",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = VOTABLE | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct gdsc ufs_card_gdsc = {
-- 
2.25.1

