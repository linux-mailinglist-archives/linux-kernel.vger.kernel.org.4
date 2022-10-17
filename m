Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E160123E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiJQPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJQO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B9696D4;
        Mon, 17 Oct 2022 07:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31A4FB81901;
        Mon, 17 Oct 2022 14:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE985C433D7;
        Mon, 17 Oct 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018478;
        bh=uUpAhLHLLsqhHmSEEexr+AOFrWCWnZ7FhJh+GvHGDVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gf1e18cZXHTce/M3WMeNgU+RwOGYuaCnaFB0iQEQzAN4OLpl2sLosVi6B6ZilL+Sw
         3MFwzxOE/cLi3b1FlAWwDu1dPcosBoG+IJeqKXXzsSaa96YemRbD00dKA21DHLIE+s
         5zSJYACB3AOw025et8AjhS/zFQ+yO7DfLrPyWE+T/sA5Y//lUkpmXCN1zwqXyorzX7
         L7qJ9Y+TLpLW0iRquiyk5cxJfnQIySzgBtlOqC+XyowftjRQdxVfUtt5ZzJbqv9tkN
         k/HudRjG2zoH78Dndi1iZKvWiJNHfiM7IB/SWtZisYFZuRzvtd28sJt+DaoT/8H8+B
         rzWGG2zAYzP/g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okRVd-0005mD-26; Mon, 17 Oct 2022 16:54:29 +0200
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
Subject: [PATCH 07/15] phy: qcom-qmp-pcie: clean up PHY lane init
Date:   Mon, 17 Oct 2022 16:53:20 +0200
Message-Id: <20221017145328.22090-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017145328.22090-1-johan+linaro@kernel.org>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
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

Clean up the PHY lane initialisation somewhat by adding further
temporary variables and programming both tx and rx for the second lane
after the first lane.

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

