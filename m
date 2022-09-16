Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B485BAB70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiIPKnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIPKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:42:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5164FD;
        Fri, 16 Sep 2022 03:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 596E4B825B9;
        Fri, 16 Sep 2022 10:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15342C433C1;
        Fri, 16 Sep 2022 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663323825;
        bh=Hb9JLjm8cd73SOsI1gSnaACdnG7qUL5WFVhEQ95tCuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSL6vj+66ibnjceLFkO4huAGlZdMYhRdi+fozM/Cd91p6ETR/E2kVyRIr5P1L/h8p
         T3YErxtJqXNJiZEuRMV6gBWdFQctCzQmu4AWMLysbo7iwBNRMRwCsknjWMk7/yzIOv
         RYLJW5hILxMZ/p6hE9slDGIkaE+xp6iBaGs/J2HCNj5Kxr1VlHhUSGW4lilKtgm1yY
         O85hrPWc4AGa1cIY0t2N8ECGt4aE3Z0OioGDvZ2bh+LY1QH2EV3F9KCQkEFn4Hm3Cq
         5YqbijVm4DWMrLj4K4PNs7h5ULOCgHH2pcDCulg70InN6Cordi+mrEpJTTrhjhIRc+
         MP+Btf7I8zw9g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oZ8Vi-00030R-Eh; Fri, 16 Sep 2022 12:23:50 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 03/11] phy: qcom-qmp-pcie-msm8996: fix memleak on probe deferral
Date:   Fri, 16 Sep 2022 12:23:32 +0200
Message-Id: <20220916102340.11520-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916102340.11520-1-johan+linaro@kernel.org>
References: <20220916102340.11520-1-johan+linaro@kernel.org>
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

Switch to using the device-managed of_iomap helper to avoid leaking
memory on probe deferral and driver unbind.

Note that this helper checks for already reserved regions and may fail
if there are multiple devices claiming the same memory.

Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 2a5eef6b12f5..6664d84bb599 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -796,21 +796,20 @@ static int qmp_pcie_msm8996_create(struct device *dev, struct device_node *np, i
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
 	 */
-	qphy->tx = of_iomap(np, 0);
-	if (!qphy->tx)
-		return -ENOMEM;
-
-	qphy->rx = of_iomap(np, 1);
-	if (!qphy->rx)
-		return -ENOMEM;
+	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(qphy->tx))
+		return PTR_ERR(qphy->tx);
 
-	qphy->pcs = of_iomap(np, 2);
-	if (!qphy->pcs)
-		return -ENOMEM;
+	qphy->rx = devm_of_iomap(dev, np, 1, NULL);
+	if (IS_ERR(qphy->rx))
+		return PTR_ERR(qphy->rx);
 
-	qphy->pcs_misc = of_iomap(np, 3);
+	qphy->pcs = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qphy->pcs))
+		return PTR_ERR(qphy->pcs);
 
-	if (!qphy->pcs_misc)
+	qphy->pcs_misc = devm_of_iomap(dev, np, 3, NULL);
+	if (IS_ERR(qphy->pcs_misc))
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
 	qphy->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
-- 
2.35.1

