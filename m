Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0F61EEED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiKGJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKGJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:26:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B6217884;
        Mon,  7 Nov 2022 01:26:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y203so10052379pfb.4;
        Mon, 07 Nov 2022 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRMJX6Xs+6P5gT0MFFl6yjITSLjz1MHRoDlRkuQ9VLY=;
        b=Y4FOXWta3MnzzK0T7UKiHh66WuhZsN/61y79PVRxiNk0Clovk3k9SCy9ykUfCpkbV7
         tsW8PVWtmz/3BN2qGHaNYKCqPjbaiVjL1hwW0de1pcI/d0q9xWKFjz2chl4rT3dgzPP0
         nOp7m0yms4k0Yz7cXAkh/Ir8t15hpEpiy4YMmk0ae3/spzMlSjFQZ5ULW3aQGMR6Y7UJ
         T6ZRlMhMU5uUyYgnXqY1kKX0K/GSJyGQ5QPEZdhBvqLzJVuwXs19MKTxXaGB4cLj5iOh
         dEWVsrskTc28fdiiFMOahL6m+Ivmda0CYOmJez5nnVNCmQTj7v/VWuO02tAWdlJE6Oum
         5AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRMJX6Xs+6P5gT0MFFl6yjITSLjz1MHRoDlRkuQ9VLY=;
        b=r6LbxhXmdgZiSh0T5u4sv6VPNvpCbg4M2iECX6FEPoTB9+eekWWHGd/+bAMWhsoTDy
         fQm9/alqmN5HlHWqgR1aUVzzhstkNhuKm0J5F9M4MuW3LjPslWwiI4ItZBSAPt4K6Wol
         dnUSisr52P5YceJTHVY+Dm0N8Yzfdzn99Xhu9Ael+3JE1oP3xvcLAv0PHEOl/894XGj7
         3OAAK154UmikED2dI1vqg0wovJRBt7ituD4Lvrpbb6PZMxe6onvmyW1ggXshMjLUrV7l
         wPvLGdGRjBmkbPithDFYyPZDQuHBRomrTR79uq0LWKTeeYXgDssPHe2UXr+B9t40gMV/
         3DYQ==
X-Gm-Message-State: ACrzQf3SG/nAuMDcaotZU6Fok/YWnMyT6qLuClxrRv+k3GVVMCK688bU
        3HTy8zl5R3CGO2sZWbt4JH0=
X-Google-Smtp-Source: AMsMyM7WCvxaYbZZWCIqjl7at01O3XeK9tiFFugFtwBjpyqx7mxgWBqDhmCv5eflpl8jqSEctDxF+g==
X-Received: by 2002:a63:1303:0:b0:46f:b44b:3519 with SMTP id i3-20020a631303000000b0046fb44b3519mr36221240pgl.278.1667813162096;
        Mon, 07 Nov 2022 01:26:02 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b00186ffe62502sm4474361plb.254.2022.11.07.01.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:26:01 -0800 (PST)
From:   zys.zljxml@gmail.com
To:     miquel.raynal@bootlin.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, michel.pollet@bp.renesas.com
Cc:     linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] rtc: rzn1: Check return value in rzn1_rtc_probe
Date:   Mon,  7 Nov 2022 17:25:44 +0800
Message-Id: <20221107092544.3721053-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

The rzn1_rtc_probe() function utilizes devm_pm_runtime_enable()
but wasn't checking the return value. Fix it by adding missing
check.

Fixes: deeb4b5393e1 ("rtc: rzn1: Add new RTC driver")

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/rtc/rtc-rzn1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index ac788799c8e3..0d36bc50197c 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -355,7 +355,9 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
 
-	devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret < 0)
+		return ret;
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
-- 
2.27.0

