Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3140B62EDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiKRGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbiKRGxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18162769DA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j15so7145485wrq.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcxcNwG4CIp43+Un82OMj6Qhb16MFgP7WdOSz1SQ42M=;
        b=gnpZTPY7Qlbm0lgnwQBecyO3WrhkjCMhB5plVtRMIOdZ2Bo+CIZXTt9O1TxZvqe7nt
         lAbc9FcZ8mWR1Y1OvPWgK8cuG3Cs2YNCvibxNFIH+44v8YYS+60z2mUMxBWdPJob4amg
         MSSuzMY1Sete3K2inI4qXAXzTjRgcY/IyanP3HM3L0h9/xudEWdsANA7Yml4PXLQD07i
         O8VUJx4DwcgXndwwHlAyglXvYERg7H0cq9lxMfvlvrKvh6mmzX8DQkPhcNxTqMGc9tpI
         5YqZ178J7/RpTlW/doMRodRt2UQScOwWt50mxuKcnUcoZHTtAuVSAdVnBdr6eLVPdBlv
         oJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcxcNwG4CIp43+Un82OMj6Qhb16MFgP7WdOSz1SQ42M=;
        b=iwwUzbmE5ApORmPHeiOq7/DrHNMnX9g5lF6/TRCzZk1F6MN4scJiYkoMX4m8Niw2y0
         WNcH0Shyh4LHpHeOgKwSamxy2cYoDCWmzhcvo/6/g6TnO0ptk9UjU1rYYkBH3VeelAaX
         rahN+vK9sgn9IrByOSBl6wvLhuvzuY8BTpNPUhfOWnneIC6fPSLnsYy3Q9n7UZeo8TMb
         Dd9uWLUfB8kSj0RLfX+Xnbm9cnHadKYJ50Mt9H3BVz6uh5WpJcwXWzWH3pu/hVARFmeM
         Q6KrAzo3FZ3LSFeCmXIkLJjRuW6A58Kah4b1GHHqFtNFoZB/0KBYr+ggM+zQCrN4vAFH
         KqrA==
X-Gm-Message-State: ANoB5pnKKXUIqRT6Q3Uk3jRf4UyafVfSMKY/OO1LUEeg8Bw0qPjB5gmB
        zm1gAQCKEdJeuX8ItdYIAnFbpjYUYpMwPQ==
X-Google-Smtp-Source: AA0mqf7LsuAgQ0qhDWeGL0m4FZb1JgSM702svJ4XDWA6yr7hOStV22BsmXHLi3JZRqDZ3VabN4fWvw==
X-Received: by 2002:adf:d085:0:b0:241:b3d6:d6a0 with SMTP id y5-20020adfd085000000b00241b3d6d6a0mr3452360wrh.617.1668754382647;
        Thu, 17 Nov 2022 22:53:02 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:53:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/12] slimbus: qcom-ctrl: drop unneeded qcom,apq8064-slim compatible
Date:   Fri, 18 Nov 2022 06:52:40 +0000
Message-Id: <20221118065246.6835-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
References: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bindings require usage of fallback "qcom,slim" compatible, so
"qcom,apq8064-slim" is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index c0c4f895d76e..bb106eab8ae2 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -718,7 +718,6 @@ static const struct dev_pm_ops qcom_slim_dev_pm_ops = {
 
 static const struct of_device_id qcom_slim_dt_match[] = {
 	{ .compatible = "qcom,slim", },
-	{ .compatible = "qcom,apq8064-slim", },
 	{}
 };
 
-- 
2.25.1

