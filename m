Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C068A621
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjBCW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjBCW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:26:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924258C1C9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:26:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l4-20020a17090a850400b0023013402671so10111191pjn.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EKfzPUpjx2o77cFgSD1szOPFx9p7F1YloFu6dux5jE=;
        b=Gw4s+m/hA1DCZPPOM3c5DEIsbg9ROhFB5dhZFbbcZ83eB1WBANExxiUq67Hya+PC8b
         5GiHX1VtVrhbz9Sq6u+TPRBaGvO6at/8XOSPJ/vv/MQ5j+vEJir8wYrEqKqM2yh1cjQv
         wTJJxFJ74NevdJItmXV5LMKWkLYi7eSF0+3FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EKfzPUpjx2o77cFgSD1szOPFx9p7F1YloFu6dux5jE=;
        b=WfumU6NivGMgQUiFDXT3sgYcriv0QX7LGKPaNDEFOxIHDJ5bUPTtQ6npmV8vSG5PFs
         xz9EKJKQgBP7TCCMS00SPOoVRRHsDiNJPVXlYOLuqzO/RW87iGrW4y0HATGFa45p3F1k
         P2veNZJG8+GfXvCrLz+dJ8CCkrZLd/U/GSFMDuCreptXu2jI7J/uB5YGxrwnURWbfXhh
         rzt+BeV/tF040HjIrWreRdL1RYdjYE2vsX9ShHDkLxZ6xiEwi599PnTtxpsmrq4cJ/of
         mMEaVSGv+WbwnZJ1twHBQNdlxC7ue59QU3xggsBivJFZbw8K81Bx5bsbIiP5J+dQ4zHC
         5w3A==
X-Gm-Message-State: AO0yUKXLbvtRnARqDFIFTL4rqQkp63XAqJ4ZMtESeurOpXEG9grn3vug
        Dnt1P2UkpBpneteift81Y7e1kA==
X-Google-Smtp-Source: AK7set8JTT/1gTBVqucSjjVolyn7f7i8Pz2ho8QrjzsVT2mYw7fW7YPdQqgQl5bw4mmjzAbYYzKp7w==
X-Received: by 2002:a17:903:1246:b0:196:19af:a7f3 with SMTP id u6-20020a170903124600b0019619afa7f3mr13917540plh.39.1675463182237;
        Fri, 03 Feb 2023 14:26:22 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:44f:ac27:361d:7805])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b0019602263feesm2095071pla.90.2023.02.03.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:26:21 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15.y v3 2/5] phy: qcom-qmp-combo: fix memleak on probe deferral
Date:   Fri,  3 Feb 2023 14:26:13 -0800
Message-Id: <20230203222616.2935268-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230203222616.2935268-1-swboyd@chromium.org>
References: <20230203222616.2935268-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit 2de8a325b1084330ae500380cc27edc39f488c30 upstream.

Switch to using the device-managed of_iomap helper to avoid leaking
memory on probe deferral and driver unbind.

Note that this helper checks for already reserved regions and may fail
if there are multiple devices claiming the same memory.

Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20220916102340.11520-5-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 32 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 7b7557c35af6..c6f860ce3d99 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -5410,17 +5410,17 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
 	 */
-	qphy->tx = of_iomap(np, 0);
-	if (!qphy->tx)
-		return -ENOMEM;
+	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(qphy->tx))
+		return PTR_ERR(qphy->tx);
 
-	qphy->rx = of_iomap(np, 1);
-	if (!qphy->rx)
-		return -ENOMEM;
+	qphy->rx = devm_of_iomap(dev, np, 1, NULL);
+	if (IS_ERR(qphy->rx))
+		return PTR_ERR(qphy->rx);
 
-	qphy->pcs = of_iomap(np, 2);
-	if (!qphy->pcs)
-		return -ENOMEM;
+	qphy->pcs = devm_of_iomap(dev, np, 2, NULL);
+	if (IS_ERR(qphy->pcs))
+		return PTR_ERR(qphy->pcs);
 
 	/*
 	 * If this is a dual-lane PHY, then there should be registers for the
@@ -5429,9 +5429,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
 	 * offset from the first lane.
 	 */
 	if (cfg->is_dual_lane_phy) {
-		qphy->tx2 = of_iomap(np, 3);
-		qphy->rx2 = of_iomap(np, 4);
-		if (!qphy->tx2 || !qphy->rx2) {
+		qphy->tx2 = devm_of_iomap(dev, np, 3, NULL);
+		qphy->rx2 = devm_of_iomap(dev, np, 4, NULL);
+		if (IS_ERR(qphy->tx2) || IS_ERR(qphy->rx2)) {
 			dev_warn(dev,
 				 "Underspecified device tree, falling back to legacy register regions\n");
 
@@ -5441,15 +5441,17 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id,
 			qphy->rx2 = qphy->rx + QMP_PHY_LEGACY_LANE_STRIDE;
 
 		} else {
-			qphy->pcs_misc = of_iomap(np, 5);
+			qphy->pcs_misc = devm_of_iomap(dev, np, 5, NULL);
 		}
 
 	} else {
-		qphy->pcs_misc = of_iomap(np, 3);
+		qphy->pcs_misc = devm_of_iomap(dev, np, 3, NULL);
 	}
 
-	if (!qphy->pcs_misc)
+	if (IS_ERR(qphy->pcs_misc)) {
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
+		qphy->pcs_misc = NULL;
+	}
 
 	/*
 	 * Get PHY's Pipe clock, if any. USB3 and PCIe are PIPE3
-- 
https://chromeos.dev

