Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3F5641EEA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiLDSfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiLDSfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:35:00 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EBBE0E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:34:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g7so15380632lfv.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXDIa9UwvSD086fb2VJXxmq1AAaUlSCfibRS/MrNCTA=;
        b=RVCxVJ/WfAGpijugf/2vENKLmV3+cAqHJAJFJV2gz7ZfmFlahpjgmZuB1Ado17KzwQ
         XnZ+liQ9ysrI/UErelM8Nt+gRq+zDDh0wkake5dJCg9ouDmHz9DRPThRbBlgQt8vzi6O
         3wLgPWVvOzpVVt4fcWdu2v1AkFRKno+fdaIhoamT61piYLu2r8W+EeWb+8t7qFSNXS6B
         udionCKJCsrHoKR7wcuJ63nsyDXr75b4t7DMk/SxXAScvUdgLzWbmh4QSNO2ysIOveuI
         c899lTcbrNDCAi6VZFbYqPb3+98UR+HQvZNZTFGbXcBTI0OnXO3e4jlu9MkJaOs9BS5+
         t8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXDIa9UwvSD086fb2VJXxmq1AAaUlSCfibRS/MrNCTA=;
        b=XivFl0nhy6jSXoOCrAT1BCuEPU0se863YFM5H/S5l2nYx762viPHgM0x5XCz0ioVfg
         oaLhw4X+J6G8jbSRr/TGB85bKNYR/qc89dtnOb2Ug1FwskDk38GoyCWEYZaPb+P7NcgA
         YjmDa/iAI+qHT/WJw543KKeE5YfnaP/toHL1+X8ed7kEXMSBpRQsfaTUFXKXvouuLVI2
         d4mAu+Zeyzsz0LnGUPF2P9HNlTRQBdRDkmq5lYrtNdpeyqdFn7xzCLd1+eJ7GeJwBaab
         Z04lt/kRROgxekKk/ERLeVAEngSj0CXrA0G4oIXvaDta2vlwPEfMKzjKfF1FK96Ff+th
         Xs4Q==
X-Gm-Message-State: ANoB5pn6uWIghTbR/Y5vfCIsNsjfTxNSxZylZWZBi5irHPRg59swyw11
        D/LIUsjrPf4tRCseZR3ysQM77Q==
X-Google-Smtp-Source: AA0mqf7/2oiaAA24E++y7ORCv8tDZhvGJ2X1DsTKc1u/CeUCOOUSgVvSg0TOI49fHgC4WxlRzC5X/Q==
X-Received: by 2002:a05:6512:33ce:b0:4b5:ff:4050 with SMTP id d14-20020a05651233ce00b004b500ff4050mr15391733lfg.476.1670178897416;
        Sun, 04 Dec 2022 10:34:57 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f14-20020a05651c03ce00b0027998486803sm1183079ljp.130.2022.12.04.10.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 10:34:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: exynos4-is: drop unused pctrl field and headers
Date:   Sun,  4 Dec 2022 19:34:55 +0100
Message-Id: <20221204183455.140337-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field 'pctrl' in 'struct fimc_is' is not used, just like
linux/pinctrl/consumer.h headers in the headers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/media/platform/samsung/exynos4-is/fimc-is.h   | 3 ---
 drivers/media/platform/samsung/exynos4-is/media-dev.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is.h b/drivers/media/platform/samsung/exynos4-is/fimc-is.h
index 06586e455b1d..c126b779aafc 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is.h
@@ -14,7 +14,6 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/spinlock.h>
@@ -231,7 +230,6 @@ struct chain_config {
 /**
  * struct fimc_is - fimc-is data structure
  * @pdev: pointer to FIMC-IS platform device
- * @pctrl: pointer to pinctrl structure for this device
  * @v4l2_dev: pointer to the top level v4l2_device
  * @fw: data structure describing the FIMC-IS firmware binary
  * @memory: memory region assigned for the FIMC-IS (firmware)
@@ -262,7 +260,6 @@ struct chain_config {
  */
 struct fimc_is {
 	struct platform_device		*pdev;
-	struct pinctrl			*pctrl;
 	struct v4l2_device		*v4l2_dev;
 
 	struct fimc_is_firmware		fw;
diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.h b/drivers/media/platform/samsung/exynos4-is/media-dev.h
index 62ad5d7e035a..079105d88bab 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.h
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.h
@@ -11,7 +11,6 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/pinctrl/consumer.h>
 #include <media/media-device.h>
 #include <media/media-entity.h>
 #include <media/v4l2-device.h>
-- 
2.34.1

