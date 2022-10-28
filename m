Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA2611314
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJ1Nht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJ1Ngx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:36:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994DC1D79B2;
        Fri, 28 Oct 2022 06:36:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42B49B82A30;
        Fri, 28 Oct 2022 13:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B11C433C1;
        Fri, 28 Oct 2022 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964208;
        bh=kHWHx6aJI0QiHRqoX6LC3zrlO/UEm3YyvB3PCvEOuoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiaWdPFE0mD+v9D+PG1hQ8efNATegjr1QYQBhZwUtWqjm7nhuTReTDxUzGpvBet7s
         nv++7gmWAG0wRmtXdcCYIS8ti0tj4awoWg622BxWt3EpBWELRpE48nzXr47cSTM4Yo
         r6Y9neMTCbdjWHMEtBuU42CxLvClBV6i0pU5nS0cZX6T+M9Yw51qWwRyGfGhYI8k1i
         C2JUU2LjzbZUTbPavm+XdtFs48AJd6RNK7eiqoGIj0+IMQazRQ8910BG9Cy0V7z5ub
         ksrcbmzWa7wpFvPr+P/4DFrFgM8WopBbGUJnMpP4NWOoTfcFRhfEoYC0DArTGYOvX4
         O0YdmhcdTZWbA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPXH-0004rA-DD; Fri, 28 Oct 2022 15:36:35 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4 07/16] phy: qcom-qmp-pcie: clean up PHY lane init
Date:   Fri, 28 Oct 2022 15:35:54 +0200
Message-Id: <20221028133603.18470-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028133603.18470-1-johan+linaro@kernel.org>
References: <20221028133603.18470-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

