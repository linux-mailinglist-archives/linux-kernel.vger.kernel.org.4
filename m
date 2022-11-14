Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB5627B89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiKNLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiKNLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C4D2099D;
        Mon, 14 Nov 2022 03:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6331161010;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D92C433B5;
        Mon, 14 Nov 2022 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424033;
        bh=PtQoJaOR3Mf5cDZQQve7VwAUA5KUND9BYF4wcr4Tzj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GeyuQk1FrSHN98Ybm7q3LyoIz8XO5svq0D1Al7KrYYs8LliXNvWFUCXTojo4xEWf5
         tX0iAd2Ol0HvLMvw9ZJ7VVAzVlZgfZkd/VEZ8YgQF8RNKvImYUa8djKnvJVM43fEi9
         ykQR6M6OQGQjpl5FujEnxH+ylJzqBbWt/D9EjfBnrvIcsMX+7wre7qP2t0SB32ve1e
         1kcTUCpP20GiovYgGBwWPDANcwg5WuFqw3EMzZ4lbhYP+5+G+lXUj2L9tr6ms5q6hw
         xRUAW7u/cLgOsote2S5hyBromMQhVXZR19BlshCqhJ7Rwn8FQCG4j4bSlE42cfsPIj
         ROLsblBB1qK7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIY-0001EV-0i; Mon, 14 Nov 2022 12:06:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 03/22] phy: qcom-qmp-combo: move pm ops
Date:   Mon, 14 Nov 2022 12:06:02 +0100
Message-Id: <20221114110621.4639-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114110621.4639-1-johan+linaro@kernel.org>
References: <20221114110621.4639-1-johan+linaro@kernel.org>
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

Move the PM ops structure next to the implementation to keep the driver
callbacks grouped.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index e7c8c4417142..2ac29b71d3b7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2216,6 +2216,11 @@ static int __maybe_unused qmp_combo_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static const struct dev_pm_ops qmp_combo_pm_ops = {
+	SET_RUNTIME_PM_OPS(qmp_combo_runtime_suspend,
+			   qmp_combo_runtime_resume, NULL)
+};
+
 static int qmp_combo_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
@@ -2646,11 +2651,6 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 	return 0;
 }
 
-static const struct dev_pm_ops qmp_combo_pm_ops = {
-	SET_RUNTIME_PM_OPS(qmp_combo_runtime_suspend,
-			   qmp_combo_runtime_resume, NULL)
-};
-
 static int qmp_combo_probe(struct platform_device *pdev)
 {
 	struct qcom_qmp *qmp;
-- 
2.37.4

