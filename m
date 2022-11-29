Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B210C63C83E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiK2TWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiK2TW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:22:26 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D1E711AE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749597; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8pAyOlP7Xx5OwjiRIaFlkfD4bNit3L8bl0IUhfSO6I=;
        b=fBnZhqyRpBU0wllYHNSxdl3O5ZI0Y8RmJc/WgRR3TJiIjMleyPmacJVGAA+C32Hi1UTzUv
        lLHfzqJToeqJ7N5yMQR4iBDjyYcOhepFOfhsaNDHLtSZC79paUVnsanZbtfQeeMYsmiBNF
        aSIRdqRZRokfvdL0NWxwQmnhdMCPY1c=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 18/26] drm: rockchip: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:19:34 +0000
Message-Id: <20221129191942.138244-5-paul@crapouillou.net>
In-Reply-To: <20221129191942.138244-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
 <20221129191942.138244-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pm_sleep_ptr() macros to handle the .suspend_late /
.resume_early callbacks.

This macro allows the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index ad2d3ae7e621..0df0fa540d7e 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -429,7 +429,6 @@ static int rockchip_dp_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rockchip_dp_suspend(struct device *dev)
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
@@ -449,13 +448,10 @@ static int rockchip_dp_resume(struct device *dev)
 
 	return analogix_dp_resume(dp->adp);
 }
-#endif
 
 static const struct dev_pm_ops rockchip_dp_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
 	.suspend_late = rockchip_dp_suspend,
 	.resume_early = rockchip_dp_resume,
-#endif
 };
 
 static const struct rockchip_dp_chip_data rk3399_edp = {
@@ -484,7 +480,7 @@ struct platform_driver rockchip_dp_driver = {
 	.remove = rockchip_dp_remove,
 	.driver = {
 		   .name = "rockchip-dp",
-		   .pm = &rockchip_dp_pm_ops,
+		   .pm = pm_sleep_ptr(&rockchip_dp_pm_ops),
 		   .of_match_table = rockchip_dp_dt_ids,
 	},
 };
-- 
2.35.1

