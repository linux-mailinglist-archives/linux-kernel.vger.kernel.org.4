Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDCA629C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiKOOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiKOOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5B1FCDC;
        Tue, 15 Nov 2022 06:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48DF6B8198D;
        Tue, 15 Nov 2022 14:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7393AC43157;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523252;
        bh=WfOHBJjixJuQ4FLUSSwYNB6T5TOaxLa26wr1JxeAHYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hauROZjV+aqnSa14og8RbAK/+bbgEzh1yaVnYpQ3ARkPzatWPOYoj1RKt9HUUKIlR
         /J9GfCuBg9Ku3L/wzNGeI/E2aEY8y5MnGU7v4sQUaIvafmH8OoF3XAjoGkonnuRdjf
         ckxbaN8pMAQXw1J0D4pXqhs/hZ/mecZ5L0jKaR1qWEV+dm2M6CSC5I9iwVzVYa/t7y
         aeqSNLcbrgbwI3lV++6H6R/BhqoBA6O6RnueaniMLcv6gtKGRoB1oU2tHICbmPClkA
         QHeeTRcuIZaHF4W8Xv41jaTqp3hBeiJIsySMb7luKjeZUSGajXl5XqD0gpD0co2IYa
         0LR3g0BhXl71w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6t-0000fa-1o; Tue, 15 Nov 2022 15:40:23 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 07/15] phy: qcom-qmp-combo: drop redundant clock allocation
Date:   Tue, 15 Nov 2022 15:39:57 +0100
Message-Id: <20221115144005.2478-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221115144005.2478-1-johan+linaro@kernel.org>
References: <20221115144005.2478-1-johan+linaro@kernel.org>
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

Since the QMP driver split, there is no reason to allocate the
fixed-rate pipe clock structure separately from the driver data.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index ebfefecffd86..9b945a72ae9b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -895,6 +895,7 @@ struct qmp_combo {
 	unsigned int dp_aux_cfg;
 	struct phy_configure_opts_dp dp_opts;
 
+	struct clk_fixed_rate pipe_clk_fixed;
 	struct clk_hw dp_link_hw;
 	struct clk_hw dp_pixel_hw;
 };
@@ -2239,15 +2240,11 @@ static void phy_clk_release_provider(void *res)
  */
 static int phy_pipe_clk_register(struct qmp_combo *qmp, struct device_node *np)
 {
-	struct clk_fixed_rate *fixed;
+	struct clk_fixed_rate *fixed = &qmp->pipe_clk_fixed;
 	struct clk_init_data init = { };
 	char name[64];
 	int ret;
 
-	fixed = devm_kzalloc(qmp->dev, sizeof(*fixed), GFP_KERNEL);
-	if (!fixed)
-		return -ENOMEM;
-
 	snprintf(name, sizeof(name), "%s::pipe_clk", dev_name(qmp->dev));
 	init.name = name;
 	init.ops = &clk_fixed_rate_ops;
-- 
2.37.4

