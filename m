Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A526492F3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLKGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLKGuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:50:16 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15F1FAFC
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:50:13 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 4GA4pPlLH5FWA4GA4pDe1A; Sun, 11 Dec 2022 07:50:10 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 11 Dec 2022 07:50:10 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm/hdm: Fix the error handling path of msm_hdmi_dev_probe()
Date:   Sun, 11 Dec 2022 07:50:06 +0100
Message-Id: <b3d9dac978f1e2e42a40ec61f58aa98c44c85dfd.1670741386.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful msm_hdmi_get_phy() call, it must be
undone by a corresponding msm_hdmi_put_phy(), as already done in the
remove function.

Fixes: 437365464043 ("drm/msm/hdmi: move msm_hdmi_get_phy() to msm_hdmi_dev_probe()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure if the Fixes tag is correct. At least it is when the probe needs
to be fixed but the issue was maybe there elsewhere before.
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 4d3fdc806bef..97372bb241d8 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -532,11 +532,19 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret)
-		return ret;
+		goto err_put_phy;
 
 	platform_set_drvdata(pdev, hdmi);
 
-	return component_add(&pdev->dev, &msm_hdmi_ops);
+	ret = component_add(&pdev->dev, &msm_hdmi_ops);
+	if (ret)
+		goto err_put_phy;
+
+	return 0;
+
+err_put_phy:
+	msm_hdmi_put_phy(hdmi);
+	return ret;
 }
 
 static int msm_hdmi_dev_remove(struct platform_device *pdev)
-- 
2.34.1

