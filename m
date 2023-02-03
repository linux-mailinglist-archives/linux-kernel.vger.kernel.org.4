Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A768A627
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjBCW0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjBCW02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:26:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0096921AC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:26:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so6265603pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 14:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KePV/9Oxn0f9htud4yGfd4rggKhHt9AicxQ1AYSJFwo=;
        b=ZHWC20inawdmelGm4NlDtU399ZfvbXefioQhUrWd5Q+qfVPIQUKtvgnrrfxLg879+P
         8il8E/HB+5LeP4sKZIt2LXRo25mlB5XBwcIJ/ODUR6/r7CvuxhhTGwvpoUjy03ve5C2g
         MxfDWziaIi/xtAjkJktzmbMcGtXO62+2W0hSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KePV/9Oxn0f9htud4yGfd4rggKhHt9AicxQ1AYSJFwo=;
        b=YS3x4Fk7VPZkbTGM7h4GBp9lwxiWzxh/WMHA4mQwJs2EboPUw0opW37OjEe2j8q6tn
         jwya1fk3SjiDiCR1/+Pld8n9xzxmG7T2cr+occxyoK2n2LeMqeVrGQ0LgNojJQh+Irv/
         gaeErQ+vrVKdIaqYJFG8OfstqLeEHjFv4KOpBbM7dP36pRmTnfNx2Fi3QXmUtpbZjIYg
         TwcTfhUD6pgDWNpRio5CMudp3/og20RKKJAxb620/orMnz+rWVxbvLA1lDWI+CDe70KT
         sT9yx2sfDBZAtHq/3yn7kiw3hgu64q+e+mbdvmDrgeXEDUIYyvDlz8bO1GhKoZW/Fnbl
         fTwg==
X-Gm-Message-State: AO0yUKWjLTNxQ0CPysFil4c7QtiR1kivPzvzlwFhCby8GKGcdGWHsDQ9
        OCm15QjF6nalde9DdK5QYYD28g==
X-Google-Smtp-Source: AK7set9T4bFRy1d8Z5JNN3pXQdT9Rrj/0PYJ44cwkNDUGsof+Ui9Dt3kOILGULjF3EUuVAF0BrJC7w==
X-Received: by 2002:a17:903:2285:b0:194:3dc2:5c29 with SMTP id b5-20020a170903228500b001943dc25c29mr14158082plh.38.1675463186341;
        Fri, 03 Feb 2023 14:26:26 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:44f:ac27:361d:7805])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b0019602263feesm2095071pla.90.2023.02.03.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:26:25 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15.y v3 5/5] phy: qcom-qmp-combo: fix runtime suspend
Date:   Fri,  3 Feb 2023 14:26:16 -0800
Message-Id: <20230203222616.2935268-6-swboyd@chromium.org>
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

commit c7b98de745cffdceefc077ad5cf9cda032ef8959 upstream.

Drop the confused runtime-suspend type check which effectively broke
runtime PM if the DP child node happens to be parsed before the USB
child node during probe (e.g. due to order of child nodes in the
devicetree).

Instead use the new driver data USB PHY pointer to access the USB
configuration and resources.

Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20221114081346.5116-6-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[swboyd@chromium.org: Backport to pre-split driver. Note that the
condition is kept so that ufs and pcie don't do anything as before]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index b8646eaf1767..eef863108bfe 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -4985,7 +4985,7 @@ static void qcom_qmp_phy_disable_autonomous_mode(struct qmp_phy *qphy)
 static int __maybe_unused qcom_qmp_phy_runtime_suspend(struct device *dev)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
-	struct qmp_phy *qphy = qmp->phys[0];
+	struct qmp_phy *qphy = qmp->usb_phy;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qphy->mode);
@@ -5010,7 +5010,7 @@ static int __maybe_unused qcom_qmp_phy_runtime_suspend(struct device *dev)
 static int __maybe_unused qcom_qmp_phy_runtime_resume(struct device *dev)
 {
 	struct qcom_qmp *qmp = dev_get_drvdata(dev);
-	struct qmp_phy *qphy = qmp->phys[0];
+	struct qmp_phy *qphy = qmp->usb_phy;
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	int ret = 0;
 
-- 
https://chromeos.dev

