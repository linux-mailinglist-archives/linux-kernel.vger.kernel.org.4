Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A515BDE75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiITHjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiITHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85DF606B5;
        Tue, 20 Sep 2022 00:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B9CEB8255A;
        Tue, 20 Sep 2022 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E79EC43470;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=n72F8o2KwLcj1vOM/W+l4qLOjRSW0ZN4tYLuk89/RhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f6wvWUNyYmNeiWcQ3UN3a0JAWOyO1OXSUM09pd3k+1/3pB3hBSc29jIN5VJ2xxNfW
         mxMxqWLGENPbjIqY4c/px/hx86FfecmXsES0lt+p7MU1jvBcNveR8AqTaoncxrd51R
         SuX41rDFNKi8+yaUu2i3T9KOHJH0KhA2zUliA82QfXuOAHq5DIa72mjfUORTEpOSsF
         bfdlZ7+hLpTgd22U6cnpGWsDHqJChdDbFMAqlUYfSZyXld4Ii6n4d8gSmq0NK8B/dk
         TmckJJFJno1rgYIP6vvwxV9d7NDON3oX/PJujLGU2zu8qNkJkAhwQu5otyCHOPKur5
         RHZxV/F6n5WNw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqP-0005Qk-Jr; Tue, 20 Sep 2022 09:39:01 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 04/17] phy: qcom-qmp-usb: drop unused type from config
Date:   Tue, 20 Sep 2022 09:38:13 +0200
Message-Id: <20220920073826.20811-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920073826.20811-1-johan+linaro@kernel.org>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration PHY type is no longer needed since the QMP driver
split so drop it from the configuration and suspend callbacks.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 26 -------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 93994f1a46e2..03481b6f1c35 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1431,8 +1431,6 @@ struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
-	/* phy-type - PCIE/UFS/USB */
-	unsigned int type;
 	/* number of lanes provided by phy */
 	int nlanes;
 
@@ -1609,7 +1607,6 @@ static const char * const qmp_phy_vreg_l[] = {
 };
 
 static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
@@ -1634,7 +1631,6 @@ static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= msm8996_usb3_serdes_tbl,
@@ -1659,7 +1655,6 @@ static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
@@ -1691,7 +1686,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= qmp_v3_usb3_serdes_tbl,
@@ -1723,7 +1717,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
@@ -1752,7 +1745,6 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= qmp_v3_usb3_uniphy_serdes_tbl,
@@ -1781,7 +1773,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
-	.type                   = PHY_TYPE_USB3,
 	.nlanes                 = 1,
 
 	.serdes_tbl             = msm8998_usb3_serdes_tbl,
@@ -1808,7 +1799,6 @@ static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
@@ -1844,7 +1834,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
@@ -1876,7 +1865,6 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
@@ -1911,7 +1899,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
@@ -1943,7 +1930,6 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
@@ -1975,7 +1961,6 @@ static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
@@ -2007,7 +1992,6 @@ static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_serdes_tbl,
@@ -2042,7 +2026,6 @@ static const struct qmp_phy_cfg sm8350_usb3phy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
@@ -2074,7 +2057,6 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
 };
 
 static const struct qmp_phy_cfg qcm2290_usb3phy_cfg = {
-	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
 
 	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
@@ -2432,10 +2414,6 @@ static int __maybe_unused qmp_usb_runtime_suspend(struct device *dev)
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qphy->mode);
 
-	/* Supported only for USB3 PHY and luckily USB3 is the first phy */
-	if (cfg->type != PHY_TYPE_USB3)
-		return 0;
-
 	if (!qphy->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
@@ -2458,10 +2436,6 @@ static int __maybe_unused qmp_usb_runtime_resume(struct device *dev)
 
 	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qphy->mode);
 
-	/* Supported only for USB3 PHY and luckily USB3 is the first phy */
-	if (cfg->type != PHY_TYPE_USB3)
-		return 0;
-
 	if (!qphy->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
-- 
2.35.1

