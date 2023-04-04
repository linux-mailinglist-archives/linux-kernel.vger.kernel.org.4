Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF976D6A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjDDRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjDDRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30444C31
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so133479556edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noPcVt8MFW5+Mm9H/HyU71uvDzzOIqHZ/NpeCMsQhko=;
        b=iLfxn/uxA0aYPa9LCLk2Vg6ug1TsTBWbvbl4cNXqH02+8X+95m/w83e9Ib2ruwpCGn
         cc9PUVjXKz7rfIJxhvovXLBU/9mxiS2YVIxFAMZ1pbJgVGf+/mN9MteI1M366YqZG3fx
         HvBdQEW/DRVerX+aRbMYL6SPo5B+g5iO4qoL9BLptnMT6ii3JQz3h57KofRnYwwbBO/Q
         AZTRa+41MMrSq6LAACKltVSesbODBnw2t3o85WCT9G1O9wUcCrv9KuoCH8Z0XGaBowxS
         hCGPKdpFC4J3/Bju3F20SEIo+4fMq7nDYGsc0YqS5ddItnVUEMQPxAGuk/tpp4XuLQv8
         jU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noPcVt8MFW5+Mm9H/HyU71uvDzzOIqHZ/NpeCMsQhko=;
        b=tLRRA0V0D4LZcvuJ9R8c/94cbJ1it1EqhWMLA8CDR4LZGtLgTRZ6ZztoCyVQfSEokR
         0ndqtfoE1/YO5irY09pPisou3FzpiWYoT90EF6qzevAEzv+28WAcUklbm1bFxF9f9EiF
         7oxbYAHm9yhlh5UFmqvz2P6xAeFxAbUuawINka7yM9M4ne9McoEjaTdfaEpcGPtvpWE/
         biJA2D08UloV4t3dNSsIFgm4BWSgWinlNqrCRQVIsr6vZO9YrHh547TzERsM9P1RU3fa
         QakMwBQ+T8BvYhdgDx5koSpW/GFH86g4BazejNxc1d3ajtegH8rQW5isQozGPZ2e7cei
         GMGw==
X-Gm-Message-State: AAQBX9eMdBPp10XtqP038WNhoRVi10XReUTAFQqSHRg2tYGmAdpmbESq
        juEQ2bAVRJt87yw6ii2NUHCKOA==
X-Google-Smtp-Source: AKy350aUnCsI0OW1OMpIgQDSjnqYbtKtqCZcgg9rd1TRcPNCj+b3Vy0Uk3G5nRLYrzTMgARThTuMCg==
X-Received: by 2002:a17:906:1714:b0:932:290d:12e4 with SMTP id c20-20020a170906171400b00932290d12e4mr324013eje.25.1680628958467;
        Tue, 04 Apr 2023 10:22:38 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 12/40] of: device: Kill of_device_request_module()
Date:   Tue,  4 Apr 2023 18:21:20 +0100
Message-Id: <20230404172148.82422-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

A new helper has been introduced, of_request_module(). Users have been
converted, this helper can now be deleted.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/of/device.c       | 9 ---------
 include/linux/of_device.h | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 874a2e1f6308..0f00f1b80708 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -246,15 +246,6 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
-int of_device_request_module(struct device *dev)
-{
-	if (!dev)
-		return -ENODEV;
-
-	return of_request_module(dev->of_node);
-}
-EXPORT_SYMBOL_GPL(of_device_request_module);
-
 /**
  * of_device_modalias - Fill buffer with newline terminated modalias string
  * @dev:	Calling device
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index f4b57614979d..ce20d8b00b3e 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -33,7 +33,6 @@ extern void of_device_unregister(struct platform_device *ofdev);
 extern const void *of_device_get_match_data(const struct device *dev);
 
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
-extern int of_device_request_module(struct device *dev);
 
 extern void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env);
@@ -78,11 +77,6 @@ static inline int of_device_modalias(struct device *dev,
 	return -ENODEV;
 }
 
-static inline int of_device_request_module(struct device *dev)
-{
-	return -ENODEV;
-}
-
 static inline int of_device_uevent_modalias(const struct device *dev,
 				   struct kobj_uevent_env *env)
 {
-- 
2.25.1

