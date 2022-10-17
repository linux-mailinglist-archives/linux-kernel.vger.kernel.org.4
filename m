Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6920C6006E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJQGvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJQGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CD95725A;
        Sun, 16 Oct 2022 23:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37824B80F1A;
        Mon, 17 Oct 2022 06:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8553C43470;
        Mon, 17 Oct 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665989440;
        bh=kOgCXcGyHB8eids12qXfKQV+4R4gdT0Lz+7oWPyNCj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMY0/SiTcOGP860yFX29bSbsnEEwfRbS3+Z7/9tpfahBRIwQ++qrWHcrGM80elQ3X
         f0xiq1kNrnEh5JJnOFnzrIIjWwl2rHbJsukKwSzv+8t3XhHwFYTZxNgj9tsIzDxEhD
         L2vmQbVvp8LrGCYKQVLVpPg1wVPlJgYAkTaMpqJc9hXpdx6U0J5Cax3cPShaUp45XS
         zdojWp+nPCjvi/OI04FbOPYbDj5ofXrkprjk0vYQ/+tuRJh2LS46CB4iWB1atBvJH+
         BSIkr4bPEn1YBjv0ZPtsoGaGI2zyvspsfX7kIN/WnyGzwxZtLmIJSCspKujG7Gunu6
         5mIqfvvJDeR0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okJxG-00057f-If; Mon, 17 Oct 2022 08:50:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 05/11] phy: qcom-qmp-pcie: move power-down update
Date:   Mon, 17 Oct 2022 08:50:07 +0200
Message-Id: <20221017065013.19647-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017065013.19647-1-johan+linaro@kernel.org>
References: <20221017065013.19647-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the power-down-control register update that powers on the PHY to
the power-on handler so that it matches the power-off handler.

Note that the power-on handler is currently always called directly
after init.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 1105d439828c..b42c5e185228 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1976,7 +1976,6 @@ static int qmp_pcie_init(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *pcs = qphy->pcs;
 	int ret;
 
 	/* turn on regulator supplies */
@@ -2002,9 +2001,6 @@ static int qmp_pcie_init(struct phy *phy)
 	if (ret)
 		goto err_assert_reset;
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			cfg->pwrdn_ctrl);
-
 	return 0;
 
 err_assert_reset:
@@ -2041,6 +2037,9 @@ static int qmp_pcie_power_on(struct phy *phy)
 	unsigned int mask, val, ready;
 	int ret;
 
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			cfg->pwrdn_ctrl);
+
 	if (qphy->mode == PHY_MODE_PCIE_RC)
 		mode_tables = cfg->tables_rc;
 	else
-- 
2.37.3

