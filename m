Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451C2715AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjE3J4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjE3J4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:56:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A8C126
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:55:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso4577567e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685440548; x=1688032548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fV0A9lh1lqDIlbdillmGoiC07mhiQejFpkRc8wrmkBo=;
        b=X1jGllTD0rXkJr8JvHV5/Wa7WZbZl8pQ2KKM/ClxFhWq5Wdi8vv/pI8WxMwIZBVaCl
         knL9wVpmeGls3FR9tjZizHWswdcQ6vyMjTLjhjZMUHGEfi8tvznbiPOBFUjEPqVQhMlV
         Aqo1Sd3lAlwSFz/Fghan0mAZlKc9bfP5xpbDO9ZJaRVtvo+EavvNmzQf7797HyHA7C+q
         wS2WQmYogIbJws6dI26ZXx9V6CA0lN3mbNQBw5fzmunUGB7H3LqIkl+88zyqhVL+N9EY
         0fAhDj0zRMm1GBXmlWc/TlxLSDq/MsRkrEmDcHmgdtL0dHbLv10t/OXtalqd3cAS9uMR
         CKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440548; x=1688032548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fV0A9lh1lqDIlbdillmGoiC07mhiQejFpkRc8wrmkBo=;
        b=OcCcKCVSETB6r5AhnTCaC6iK08ZgkSlxkbGpdHGTDtLuJn8DQDSiHqVFpM6P54QnaF
         8xBeFSNGATuC+0teC1gmUGU5Ys1fDhXYpGp4jsKDlf9wVU2EIgrai+FEE9QKRRe6bDKf
         sTp3pqYAnZ0mKbxwNjwU1NbXuzhMFuLPFZiV97vZcde72/kO6VWrvbVseucxh3KGlJBh
         zuSKOCcHk4VeuKPhgxyCJnfzueMMtTzL0/dTzga+dER8w1jop7+QqzTaUOVtotXhQG92
         7/A5WKMDTZSiOgc2B0nmusRZkCS3S/frCJHWboyuor5tUIKyAJ0qrxGO4QrV7vypcldQ
         TfFA==
X-Gm-Message-State: AC+VfDyiunAGaelG/mTwAQ5BP+K7CVsdFDtu5vzkb8IWqSfB//LXipdl
        8/DeFbQ5cxepqJNrlY3dbpSy/Q==
X-Google-Smtp-Source: ACHHUZ740qedWBuyEGK8mzdvZtJt6JQ5S/1PcHOCvgFR5t2BGLsVlByelp1mqEzCOksVeqG2W2EfFQ==
X-Received: by 2002:a05:6512:21aa:b0:4f3:8223:eb81 with SMTP id c10-20020a05651221aa00b004f38223eb81mr487631lft.6.1685440548632;
        Tue, 30 May 2023 02:55:48 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25e83000000b004f377f317d4sm282857lfq.285.2023.05.30.02.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 02:55:48 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: domains: Move the verification of in-params from genpd_add_device()
Date:   Tue, 30 May 2023 11:55:36 +0200
Message-Id: <20230530095536.61907-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f38d1a6d0025 ("PM: domains: Allocate governor data dynamically
based on a genpd governor") started to use the in-parameters in
genpd_add_device(), without first doing a verification of them.

This isn't really a big problem, as most callers do a verification already.
Therefore, let's drop the verification from genpd_add_device() and make
sure all the callers take care of it instead.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: f38d1a6d0025 ("PM: domains: Allocate governor data dynamically based on a genpd governor")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 51b9d4eaab5e..5cb2023581d4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1632,9 +1632,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
-		return -EINVAL;
-
 	gpd_data = genpd_alloc_dev_data(dev, gd);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
@@ -1676,6 +1673,9 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 {
 	int ret;
 
+	if (!genpd || !dev)
+		return -EINVAL;
+
 	mutex_lock(&gpd_list_lock);
 	ret = genpd_add_device(genpd, dev, dev);
 	mutex_unlock(&gpd_list_lock);
@@ -2523,6 +2523,9 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
 	struct generic_pm_domain *genpd;
 	int ret;
 
+	if (!dev)
+		return -EINVAL;
+
 	mutex_lock(&gpd_list_lock);
 
 	genpd = genpd_get_from_provider(genpdspec);
-- 
2.34.1

