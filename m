Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D6674EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjATH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjATH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:56:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2587641
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:56:55 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so5265650wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmrO048R9niCXK/5eimwZ8B+pWaKXobeemlvwUnYMX0=;
        b=SPff/Rh67EDcHWGB8DX7eO7X5ZG66F+HNdtyESx2N0PR0fowXMhuL60JHzlKB4lVMj
         J0vlD2Gw4BklzZhzzm8Pk8qPwlzG0/RJk6hZ/9tL/8d9H5nVSmNob9Ig76DJIXDjgOEw
         FWYqN9z0iAgj2oU9U/68f7avtRoFDTLFDmZUbmS/GBmTW8I6l8F5tSw8kELZwriniffD
         qJ/oMiWBuajHSWPDfAomYohzATd91WCGzx+om/haocOV04UMpfKHAV+3EtTR9255a5Jh
         zDMCAYM+T0zDMSLXYGFhzF6yOH/0tI1JrUl2r/Q54RZynAmfr6H698nd1ZgyC4pG6SjE
         gIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmrO048R9niCXK/5eimwZ8B+pWaKXobeemlvwUnYMX0=;
        b=vfzhphm+FK6nH6rKZRXXxCRlDpcFYeFpNhCPKY3bl7+Uzjzvy1cSf2ARtdJR6GLbLp
         avs0ZnhXCnPlIDJ7CGnNcE8weBYPUWaGLCqAxsDCb0r8VzTojeO6FkGNPUE8iFRMMOrk
         k1JjsQJ26q7sv8Blu1Ww9HpxJQp2K5SBj7Ztonrdh3he78XLl4nGnmrEt/5hXc7Mp8Fy
         KZPM7mp52Snu+HDbOKVQwrbKVlr99xrtA8FB/s/Rf3fpWgJNrgSFEFOsW2NfTcYo2kOU
         PKHnPs6Xor+XE+2wheFurP5bbAX4mnj2dY/OSlNIJzGGQDvvigl/7KHvgCzG8FaDM64v
         6CdQ==
X-Gm-Message-State: AFqh2kpr1R2tY8sw3lQLCfDphmqPiHFZ/p/8j5tC/Xh58QCtdgsufVuU
        B0Hho7lPN03STn/aRFEoj8ccQA==
X-Google-Smtp-Source: AMrXdXs7qBDLmimxwI0JUiJqdz4L3wkMmnNmwFiMmVN8PAQUL89GSNf1W++Fe+OZ7vV0/3A9Lg+KVw==
X-Received: by 2002:a05:600c:198e:b0:3db:1d7e:c429 with SMTP id t14-20020a05600c198e00b003db1d7ec429mr5936155wmq.40.1674201414529;
        Thu, 19 Jan 2023 23:56:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003d9b89a39b2sm1455840wmb.10.2023.01.19.23.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:56:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: spidev: order compatibles alphabetically
Date:   Fri, 20 Jan 2023 08:56:51 +0100
Message-Id: <20230120075651.153763-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bring some order to reduce possibilities of conflicts.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spidev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 8143f8ffecb0..f836567c631b 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -733,14 +733,14 @@ static int spidev_of_check(struct device *dev)
 }
 
 static const struct of_device_id spidev_dt_ids[] = {
-	{ .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
+	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
+	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
-	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
-	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
+	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
 	{ .compatible = "silabs,si3210", .data = &spidev_of_check },
 	{},
-- 
2.34.1

