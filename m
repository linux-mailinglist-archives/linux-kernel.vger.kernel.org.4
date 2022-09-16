Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47A05BAB85
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiIPKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIPKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E28A832B;
        Fri, 16 Sep 2022 03:24:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF3362A97;
        Fri, 16 Sep 2022 10:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B45C43160;
        Fri, 16 Sep 2022 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663323825;
        bh=paVqUMRBQw9kTTDsBjch9ckYDPbckCXhP60LUyZoBiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbt5qrJsNaMxjj76auHwYjtGB4UboPNfT478sSRb8D+DoEBoU1R7PvplU818kUnSO
         mcW8QYq4iPx/R4mg6foRsOodkS8T9+Wj/jzaibV1yRHFKNVJu/wGh9aVxMQwsmIPYe
         0UNvCT5Kxx3/xHSbdRR1xHwPpAVQFLcyh2WTr5LboLptAEhyAoy36Y5NcdpAKP7Ghe
         pcqzLztVJVILMZoGUB7YQtqF7UbgJ4ZGlJN9b+iqqeUtUdtrfKBlvA96WIE4y3MCVt
         J9inhrpTZ5D1PY0rTfVvVut/aI0BZ3MeCgJmSiWvxJflnQ4XdCeQUbw4F8HWEMeV4Y
         BYu7D/sLwqJeQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oZ8Vi-00030g-T7; Fri, 16 Sep 2022 12:23:50 +0200
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
Subject: [PATCH v2 08/11] phy: qcom-qmp-pcie: drop unused legacy DT workaround
Date:   Fri, 16 Sep 2022 12:23:37 +0200
Message-Id: <20220916102340.11520-9-johan+linaro@kernel.org>
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

Commit 5e17b95d9893 ("phy: qcom-qmp: Utilize fully-specified DT
registers") added a workaround for legacy devicetrees which did not
specify register regions for the second lane of some dual-lane PHYs.

At the time, the only two dual-lane PHYs supported by mainline were
"qcom,sdm845-qmp-usb3-phy" and "qcom,sdm845-qmp-ufs-phy", neither
of which is a PCIe PHY.

Drop the workaround for malformed devicetrees, which should no longer be
needed since the QMP driver split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 27 ++++++------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index e6636700871c..4939edcd8cb1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -38,9 +38,6 @@
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 
-/* Define the assumed distance between lanes for underspecified device trees. */
-#define QMP_PHY_LEGACY_LANE_STRIDE		0x400
-
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
@@ -2270,28 +2267,16 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	if (IS_ERR(qphy->pcs))
 		return PTR_ERR(qphy->pcs);
 
-	/*
-	 * If this is a dual-lane PHY, then there should be registers for the
-	 * second lane. Some old device trees did not specify this, so fall
-	 * back to old legacy behavior of assuming they can be reached at an
-	 * offset from the first lane.
-	 */
 	if (cfg->is_dual_lane_phy) {
 		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
-		qphy->rx2 = devm_of_iomap(dev, np, 4, NULL);
-		if (IS_ERR(qphy->tx2) || IS_ERR(qphy->rx2)) {
-			dev_warn(dev,
-				 "Underspecified device tree, falling back to legacy register regions\n");
+		if (IS_ERR(qphy->tx2))
+			return PTR_ERR(qphy->tx2);
 
-			/* In the old version, pcs_misc is at index 3. */
-			qphy->pcs_misc = qphy->tx2;
-			qphy->tx2 = qphy->tx + QMP_PHY_LEGACY_LANE_STRIDE;
-			qphy->rx2 = qphy->rx + QMP_PHY_LEGACY_LANE_STRIDE;
-
-		} else {
-			qphy->pcs_misc = devm_of_iomap(dev, np, 5, NULL);
-		}
+		qphy->rx2 = devm_of_iomap(dev, np, 4, NULL);
+		if (IS_ERR(qphy->rx2))
+			return PTR_ERR(qphy->rx2);
 
+		qphy->pcs_misc = devm_of_iomap(dev, np, 5, NULL);
 	} else {
 		qphy->pcs_misc = devm_of_iomap(dev, np, 3, NULL);
 	}
-- 
2.35.1

