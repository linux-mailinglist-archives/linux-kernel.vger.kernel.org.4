Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9515B8CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiINQ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiINQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:26:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A0A7E037;
        Wed, 14 Sep 2022 09:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43EF4B8171B;
        Wed, 14 Sep 2022 16:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F08C4315F;
        Wed, 14 Sep 2022 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663172798;
        bh=paVqUMRBQw9kTTDsBjch9ckYDPbckCXhP60LUyZoBiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s52mFYDnriTA62zIeNSjL/p+m9YQAw/9vZE4YGuphHL6NP6yDaAKrOJ53dAicmj46
         pK+Y10NAiojuETsnqfUtuBZ0/KSS6B9R66Goq0k5CSwtuSqbTLKey/A68o2E/z2yd8
         y7wCnfN9vverKdJ0MSZJjTf14nPtRpoH7xqI7z0yMinuqUP3ctDZDMpAGQqUDqoAwq
         j/0OXLX00tBebvbPyz2DogdhS0sJqAqLUKMPtSzwt0Qt8ssxXVmJFyybB3ZstcqLs1
         wBq8r6JaWADW/9y9KJOl6QTYCY1r0VBCKS/KHXSNy+jQkC5/d8w2vO+yC5a3N4hGNG
         x8pcINVAV4rlg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oYVDk-0001ep-3H; Wed, 14 Sep 2022 18:26:40 +0200
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
Subject: [PATCH 08/11] phy: qcom-qmp-pcie: drop unused legacy DT workaround
Date:   Wed, 14 Sep 2022 18:25:42 +0200
Message-Id: <20220914162545.6289-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220914162545.6289-1-johan+linaro@kernel.org>
References: <20220914162545.6289-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

