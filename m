Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7C625703
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiKKJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiKKJkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:40:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7617369DC8;
        Fri, 11 Nov 2022 01:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 496B1CE2645;
        Fri, 11 Nov 2022 09:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA4CC43470;
        Fri, 11 Nov 2022 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668159611;
        bh=fzA0ymuZns87NaioE1ixSH2KZM29mzl1IX77mtV6cDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sitkBlKVGgtIsJNR1lyHOGvIiRMCRneIiBjq71QH/svgEk9wzwfJX49pFi3ONegHF
         9cLBb04tqhtFpOVEiaFdTOWGDChiHi5UtG1hC6sigLi/p/MS0aE4BwPTejibCoQss4
         dJRLoZQJ46A1jnBhJepK3e808i0WDXj1WvgpHd9BJV3jfeSe2KZ6iqDOOQ9erv1M33
         dAJ/YRet+GZHf6DzkxA298YqlzUfRaVBvraodJwfNgym3ng9uaCLEab58s6KGjsdld
         KitCxZbUFXQ2ITVRvLjfWUSXQH6uDhPxj9U4q4cnLpxwAXfRn2UOhiEnOVd9F62e28
         e82mYSSJ2897g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQVj-0002xj-A5; Fri, 11 Nov 2022 10:39:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/3] phy: qcom-qmp-usb: drop sc8280xp reference-clock source
Date:   Fri, 11 Nov 2022 10:38:56 +0100
Message-Id: <20221111093857.11360-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111093857.11360-1-johan+linaro@kernel.org>
References: <20221111093857.11360-1-johan+linaro@kernel.org>
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

The source clock for the reference clock is not used by the PHY directly
and should not be described by the devicetree (instead this relationship
should be modelled in the clock driver).

Drop the driver management of the reference-clock source for SC8280XP.

Once the other clock drivers have been updated, the corresponding change
can be done also for the other QMP v4 platforms.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 372f9853c749..9b1f8c9d0eb8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1523,6 +1523,10 @@ static const char * const qmp_v3_phy_clk_l[] = {
 };
 
 static const char * const qmp_v4_phy_clk_l[] = {
+	"aux", "ref", "com_aux",
+};
+
+static const char * const qmp_v4_ref_phy_clk_l[] = {
 	"aux", "ref_clk_src", "ref", "com_aux",
 };
 
@@ -1729,8 +1733,8 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8150_usb3_pcs_tbl),
 	.pcs_usb_tbl		= sm8150_usb3_pcs_usb_tbl,
 	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8150_usb3_pcs_usb_tbl),
-	.clk_list		= qmp_v4_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.clk_list		= qmp_v4_ref_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -1755,8 +1759,8 @@ static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_tbl),
 	.pcs_usb_tbl		= sm8150_usb3_uniphy_pcs_usb_tbl,
 	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_usb_tbl),
-	.clk_list		= qmp_v4_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.clk_list		= qmp_v4_ref_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -1806,8 +1810,8 @@ static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_tbl),
 	.pcs_usb_tbl		= sm8250_usb3_uniphy_pcs_usb_tbl,
 	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_usb_tbl),
-	.clk_list		= qmp_v4_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.clk_list		= qmp_v4_ref_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
@@ -1907,8 +1911,8 @@ static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
 	.pcs_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_tbl),
 	.pcs_usb_tbl		= sm8350_usb3_uniphy_pcs_usb_tbl,
 	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_usb_tbl),
-	.clk_list		= qmp_v4_phy_clk_l,
-	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
+	.clk_list		= qmp_v4_ref_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(qmp_v4_ref_phy_clk_l),
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
-- 
2.37.4

