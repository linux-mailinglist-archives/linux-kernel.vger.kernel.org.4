Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883676AE0D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCGNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCGNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:38:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76A31E00
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:38:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l1so12102797wry.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIQnAKa+Qd5OpVdv8Ipf7C/Ypn0D8rKAisdiD5QMAh0=;
        b=G4uhG+HEW8aKELDM9Sy8xcuArFEvPYHxeEkSAvAihRjKNrflmzusgFYLdZ6+RHVh5B
         NsN7nMiaQntRZ+1FEkyXzfHyTK8hS1ErM8pzN1kbfdkpSaDi4q6nj29PUGEPD+IPtrfs
         XIEDDn9ou1+JxDIwPIYD6WYKTwmJgij/up31knXXFZrb4YPWBMvTUBVU/UwOKtQUVfnm
         CreZ6KCGIcrnAb8Uuiop6VJzNyzydlhSZZ3Z6jHM6Di6BKWfsIs6poNUHrlABfLSUoDM
         0dQafcbtghCvErUNVZ1FA+pke96IeRx1/xbNiBSA8/FhHP9VV3fJSVmIHpYHxfLVyl1F
         4mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIQnAKa+Qd5OpVdv8Ipf7C/Ypn0D8rKAisdiD5QMAh0=;
        b=dasrvmFQdkKA5FDd9HOydWkKrETRjZTYLoJQ82QdXQCUrXWDwaEeOuYR0LccMaCA/F
         ZyBwDyjiuGm0v+0fAaXFWueCpt9fg+QAhVSa6ENOHQDbQvy1YcY0C/VPFMnmOJb0qBgW
         jXOlqk/Gw11zuJn3+OwUmBED/01riqSOjuZ9r92XRsNRmWqIFUPTixt8Doi7cbG3qQVa
         kgPwoxYsgZ0JePkcJODJ0FoJoITWpsrEvs77C1/g5F/Mnu4FTqdv5goPO/XhBWkngmCr
         QZ1kHQiZS+baWo5g7qNSTTZ6Tt2QerVK/kWg9YpXJGa5yLa6+WQBrqCU48jge+eJcS7j
         hm1Q==
X-Gm-Message-State: AO0yUKXqvaoHIn0jgWwI/CW8biQX1hg5uIFjVdiyzYgnf95RQUJsb+JC
        2A+3LVtO23dhTkoyjpucPMQk+A==
X-Google-Smtp-Source: AK7set8fFI/JB2Jnnf1mxMvT9ESytvP5zxJQvQvFS2t55nzmCv96eO4scnTxq1vQ75sdSG/Kt0TaFg==
X-Received: by 2002:a5d:4810:0:b0:2cb:c66d:6ac1 with SMTP id l16-20020a5d4810000000b002cbc66d6ac1mr8681462wrq.3.1678196282682;
        Tue, 07 Mar 2023 05:38:02 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:38:02 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 08/11] thermal/of: Unexport unused OF functions
Date:   Tue,  7 Mar 2023 14:37:32 +0100
Message-Id: <20230307133735.90772-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions thermal_of_zone_register() and
thermal_of_zone_unregister() are no longer needed from the drivers as
the devm_ variant is always used.

Make them static in the C file and remove their declaration from thermal.h

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c |  8 +++-----
 include/linux/thermal.h      | 17 -----------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index ff4d12ef51bc..6fb14e521197 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -439,7 +439,7 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
  *
  * @tz: a pointer to the thermal zone structure
  */
-void thermal_of_zone_unregister(struct thermal_zone_device *tz)
+static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
 	struct thermal_trip *trips = tz->trips;
 	struct thermal_zone_params *tzp = tz->tzp;
@@ -451,7 +451,6 @@ void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 	kfree(tzp);
 	kfree(ops);
 }
-EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
 
 /**
  * thermal_of_zone_register - Register a thermal zone with device node
@@ -473,8 +472,8 @@ EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
  *	- ENOMEM: if one structure can not be allocated
  *	- Other negative errors are returned by the underlying called functions
  */
-struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-						     const struct thermal_zone_device_ops *ops)
+static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+							    const struct thermal_zone_device_ops *ops)
 {
 	struct thermal_zone_device *tz;
 	struct thermal_trip *trips;
@@ -550,7 +549,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(thermal_of_zone_register);
 
 static void devm_thermal_of_zone_release(struct device *dev, void *res)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index eb80cee4f64f..8cdf94cdc5ff 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -297,25 +297,12 @@ struct thermal_zone_params {
 
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
-struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-						     const struct thermal_zone_device_ops *ops);
-
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
 							  const struct thermal_zone_device_ops *ops);
 
-void thermal_of_zone_unregister(struct thermal_zone_device *tz);
-
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
-void thermal_of_zone_unregister(struct thermal_zone_device *tz);
-
 #else
-static inline
-struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-						     const struct thermal_zone_device_ops *ops)
-{
-	return ERR_PTR(-ENOTSUPP);
-}
 
 static inline
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
@@ -324,10 +311,6 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static inline void thermal_of_zone_unregister(struct thermal_zone_device *tz)
-{
-}
-
 static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
-- 
2.34.1

