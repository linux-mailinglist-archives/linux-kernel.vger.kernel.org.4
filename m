Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46505EE060
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiI1P27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiI1P2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B104647C4;
        Wed, 28 Sep 2022 08:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9865761F03;
        Wed, 28 Sep 2022 15:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77D0C43140;
        Wed, 28 Sep 2022 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664378916;
        bh=eQzKq/JPEfw2X1Sdx9ak4sUQJdquDr6vcVCbsZTFJ9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtJTvgev4jgCkemzBTZrtmCD3kjIODHSGH35FGUHHntNizfguReY0BVRqY40Co/TL
         Zcr0Z+nqL/xHvcAZRaqAImJOMiQ4pqZo7e6rwd0A07iX9SqU5adI/s9/mehbsflYr2
         dawC7NVcZhVd25n+joVRS3le9q6aZbv0DHyLwZLSXXWSNVzesLnbHYgyw4h+Ry8MJq
         ZWCSI0EQ6/RJO6njrm1SuVkU1nXAT2Og4ySSjKtrtgodQPNgghIUFbSIsaDDq84It8
         GP8F/gmYaJRwgiaGUTaRMja+Fz6L7fkID7xiFkCNIVObiqywDiC/XZEetz8IkZZCos
         Qm2r83DWypu/Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odYzK-0007zt-Ty; Wed, 28 Sep 2022 17:28:42 +0200
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
Subject: [PATCH 08/13] phy: qcom-qmp-pcie: move power-down update
Date:   Wed, 28 Sep 2022 17:28:17 +0200
Message-Id: <20220928152822.30687-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928152822.30687-1-johan+linaro@kernel.org>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 47cdb9ed80cd..150dc58147ce 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1848,7 +1848,6 @@ static int qmp_pcie_init(struct phy *phy)
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	struct qcom_qmp *qmp = qphy->qmp;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
-	void __iomem *pcs = qphy->pcs;
 	int ret;
 
 	/* turn on regulator supplies */
@@ -1874,9 +1873,6 @@ static int qmp_pcie_init(struct phy *phy)
 	if (ret)
 		goto err_assert_reset;
 
-	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
-			cfg->pwrdn_ctrl);
-
 	return 0;
 
 err_assert_reset:
@@ -1915,6 +1911,9 @@ static int qmp_pcie_power_on(struct phy *phy)
 	unsigned int mask, val, ready;
 	int ret;
 
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			cfg->pwrdn_ctrl);
+
 	qmp_pcie_serdes_init(qphy);
 
 	ret = clk_prepare_enable(qphy->pipe_clk);
-- 
2.35.1

