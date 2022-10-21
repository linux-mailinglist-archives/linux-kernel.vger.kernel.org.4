Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB8D6075CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJULLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJULKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03818B0AA;
        Fri, 21 Oct 2022 04:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5551AB82A2F;
        Fri, 21 Oct 2022 11:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0DAC43146;
        Fri, 21 Oct 2022 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666350643;
        bh=kHWHx6aJI0QiHRqoX6LC3zrlO/UEm3YyvB3PCvEOuoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iy3IdCpca4xb8uSbyz/8ENyN7twAvC/0b8/YfkD2BTGsoysk+Uszq3bQxJ7YYu3a/
         gppvb+AV+InS1s8ZNIR0mrO4SfgMu6sFWmOJRcCYZsc0AX9MWz7bE5vroZYU+r/HAv
         WUx+9wxDdxMtNFBjIsIgrvkOGltLGdLuFTiCoqXysoZ+qkfyzotcBryO71a0Gvgh7f
         2zmxA7ul4rF496FsHddmlTxfjLUHpxx/JXZXqX8UkmhoCltq5LiYDcCFpPG3dtuRKX
         cm3c//c+WUhy54iYmSyu7xeShSyjKG/4BT5EEs2Qp6G58QmAG7jGe93gLdYda6pS3K
         sn6i3clXH9azg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1olpv4-0007Kj-UR; Fri, 21 Oct 2022 13:10:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 07/15] phy: qcom-qmp-pcie: clean up PHY lane init
Date:   Fri, 21 Oct 2022 13:09:39 +0200
Message-Id: <20221021110947.28103-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021110947.28103-1-johan+linaro@kernel.org>
References: <20221021110947.28103-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the PHY lane initialisation somewhat by adding further
temporary variables and programming both tx and rx for the second lane
after the first lane.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index bd946438e3c3..dd7e72424fc0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1835,18 +1835,19 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *tx = qmp->tx;
 	void __iomem *rx = qmp->rx;
+	void __iomem *tx2 = qmp->tx2;
+	void __iomem *rx2 = qmp->rx2;
 
 	if (!tables)
 		return;
 
 	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
-
-	if (cfg->lanes >= 2)
-		qmp_pcie_configure_lane(qmp->tx2, tables->tx, tables->tx_num, 2);
-
 	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
-	if (cfg->lanes >= 2)
-		qmp_pcie_configure_lane(qmp->rx2, tables->rx, tables->rx_num, 2);
+
+	if (cfg->lanes >= 2) {
+		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
+		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
+	}
 }
 
 static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
-- 
2.37.3

