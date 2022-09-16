Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B105BAB83
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiIPKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiIPKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C147BA1;
        Fri, 16 Sep 2022 03:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11A09B825CC;
        Fri, 16 Sep 2022 10:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C60C43161;
        Fri, 16 Sep 2022 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663323825;
        bh=cRAr0sH1CJQ/Ys6irbpZpXb6p7rK6u+Isb1FskBrSNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWxvTuWeunzDRMc5yASfqqhL31nwGr5NwlviMaNXt23x+yANJDEe7W6uXX5Alw9Ad
         hX70pNhDwVf47054bbY4zfaW/4jQC9PCn2/72+le3jmhFwRRJiussADV87ynpDsRJq
         XfRwfHd3mtb4x2Py682PB5oQz406ULsu+ZWBx3353bK3cYgVpEDVTdfra9d2Tl7hE7
         oqqX1SQAE66R8eUJm82pORhyTwUUUBH41lbQFTmgGDqvZOiJa1pQmITanVFkRX2Wf+
         lR4oa98wBR4KADoVo1mHp3G+tev9EZ2F8yyLH86Pw3GICOoHnJ9M6BMhVi8iFz+ITw
         ITwfDUs2FgoKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oZ8Vj-00030l-1u; Fri, 16 Sep 2022 12:23:51 +0200
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
Subject: [PATCH v2 10/11] phy: qcom-qmp-ufs: drop legacy DT workaround
Date:   Fri, 16 Sep 2022 12:23:39 +0200
Message-Id: <20220916102340.11520-11-johan+linaro@kernel.org>
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
"qcom,sdm845-qmp-usb3-phy" and "qcom,sdm845-qmp-ufs-phy" and they had
been added to the binding less than six months before the binding was
fixed.

Presumably no one is using four-year old SDM845 dtbs with mainline
anymore so drop the workaround for malformed devicetrees. In the
unlikely event that anyone complains, we can consider reverting.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 27 ++++++-------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 1b1ac20cf290..7b335b50b4a1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -38,9 +38,6 @@
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 
-/* Define the assumed distance between lanes for underspecified device trees. */
-#define QMP_PHY_LEGACY_LANE_STRIDE		0x400
-
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
@@ -1137,28 +1134,16 @@ static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
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

