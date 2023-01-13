Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8A66A456
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjAMUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAMUpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:45:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAE288A37
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:45:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id c6so24619112pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PobSF2/MDkJrX0shmq4Y9cOMyGXHMWsuX8BGemf4VBw=;
        b=Bk0IWpPecl/O/TDwZ0QOdESqr6Zk5qYmXoE7OVj3ynKjewF1Rg1fDbPfzyFRa8K40U
         LJfzekoRATjBbgAaGvkiEYTL3P+XjjkE7mOLJvku9+zQHQugdRsZgyeYnGTohCTmT93o
         b4FfVO+qDuxe4DlkcKogEN727pajt14vxaH1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PobSF2/MDkJrX0shmq4Y9cOMyGXHMWsuX8BGemf4VBw=;
        b=r8WPJY+xFwGlaTN0r7lUyTUjLR+00O9fMkpwLULyBGPiZn8XnkPWZ1VZNqYem572Ng
         vzxblkeKXIYRuyz95+JDnEuM5AKiFftCHOoGVyLO7TEKiLvTCEi88p0nN96hplETzK1x
         jQLkNec7fsGrrvSfAjFe0lIknWFNdimUUPxFZCeoZIq4jJp3NRIKJOE/iOz8+aaw1DIu
         F/9Sz08ZXmfQijh/KC8HFEpVEKd0N4t/0OYOVk6JJOiCbo0zCDPLur5AdpKpK2WYe8L1
         wpcq8XmWMUVZEHxCxVbqq/eBn4e6boXZ7pniD3XRBk9hm9W8IBSqofZxpcGQ6oBHopVB
         d83w==
X-Gm-Message-State: AFqh2koJapdTFrpQBvCQbfFT8HmYGDZjVgetvctX8m/jWo+Amdm0HgMp
        jbuDHnRyQUB8Ip0uWcuCtLHanw==
X-Google-Smtp-Source: AMrXdXvjFDqqv5LXuw9EMZqIQeligGqs3tcgL4coCCLoaghRb4BWIhdTQPe9rtpQbAoKrG+r1WTY/w==
X-Received: by 2002:a17:903:1355:b0:193:3a92:f4bd with SMTP id jl21-20020a170903135500b001933a92f4bdmr12657981plb.47.1673642753165;
        Fri, 13 Jan 2023 12:45:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:4652:3752:b9b7:29f9])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001945b984341sm4010081plb.100.2023.01.13.12.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:45:52 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15.y v2 1/5] phy: qcom-qmp-combo: disable runtime PM on unbind
Date:   Fri, 13 Jan 2023 12:45:44 -0800
Message-Id: <20230113204548.578798-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230113204548.578798-1-swboyd@chromium.org>
References: <20230113204548.578798-1-swboyd@chromium.org>
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

commit 4382d518d1887e62234560ea08a0203d11d28cc1 upstream.

Make sure to disable runtime PM also on driver unbind.

Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM").
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220907110728.19092-2-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index a9687e040960..7b7557c35af6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -5740,7 +5740,9 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 	/*
 	 * Prevent runtime pm from being ON by default. Users can enable
 	 * it using power/control in sysfs.
@@ -5790,13 +5792,10 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (!IS_ERR(phy_provider))
 		dev_info(dev, "Registered Qcom-QMP phy\n");
-	else
-		pm_runtime_disable(dev);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 
 err_node_put:
-	pm_runtime_disable(dev);
 	of_node_put(child);
 	return ret;
 }
-- 
https://chromeos.dev

