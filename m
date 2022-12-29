Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0030B658EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiL2QA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiL2QAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:00:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D46C2A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:00:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso10342462wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU7sDwiy4wxWca9BJshy+agHeUQnApN7sCu5RKlRtdM=;
        b=QMG0v/1nbi8hZ9k+X70DoEIE//b9nhmqplfikAPHlsmTZe0xNR2l8nbm2O0DqduQEp
         d5uEnccRjQpPn3ruyZ1t7DEuKhwxuQGVmpJoUtDbHF61PKSy+MNX7c3QaSS+LmKGA9h4
         Cj7SCwh1kzAWFjTGnCER9W7spZKATQR/wfjGZu4qOTBL9sb4RSfPgcSfaqJlUmO2m/B1
         nXpNroyIn3zjqGtPwPHUuHorNkwTKe5uP1L+hCqPFNrDZcYkJY/XrIWqmJL25pad4GC/
         rW2CJyVUI4dw/irPK1J2hAwnjnc7rDGMxWBHAQ045TexoC72zdqEADUK9FdApcoCtbGO
         d5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU7sDwiy4wxWca9BJshy+agHeUQnApN7sCu5RKlRtdM=;
        b=qaAL/1MqcFNQm2Z89IsWi+Ob7YELrZxp8nCSKzinQ6r29LKiHxmDY9lDl6CblIfApY
         D3nWjAd1wxcHPmJaz/a0d/jhyhJ2ychl54cYu+cDa3sZRJiQV2tHq3e2+2ZGf2fb5eHU
         FhwpZGMXX5dPrxdwP84cLmRz9B2b8D3w6zafdbeKy4TGhUYTXHghbvjPri7uhJKBTGVL
         3qrloaJPXza0Ef6aCJ8oxuPVW4hOchHCunTCxdABX1HSVL65joJNSOtm+Htp2T0ab2p1
         pHRwKwDyRiIJTz1yXZhr1eNggEy5cLEmR7tshRXHzKytNZJV+Y7Ev75Jv/YNcDokzqP4
         T1og==
X-Gm-Message-State: AFqh2kobRPaZjtZqg4zC8ft9NWqPWJXgGuphuae1103f8gtSzh4VvMuu
        IumObFUmGyMQUYo+e5zaNnkD27RSM7s99SuX
X-Google-Smtp-Source: AMrXdXuoZ2vTu1bXeKBH+OFEFAhnLg5FXTl0GNGp1V2KuPzwTzzms+/8kk/xRMOp+MadsofE8cxzzA==
X-Received: by 2002:a05:600c:4995:b0:3d3:4f43:fbc2 with SMTP id h21-20020a05600c499500b003d34f43fbc2mr20646046wmp.41.1672329649761;
        Thu, 29 Dec 2022 08:00:49 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b003cfa3a12660sm42511593wmq.1.2022.12.29.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:00:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] i2c: dev: fix notifier return values
Date:   Thu, 29 Dec 2022 17:00:44 +0100
Message-Id: <20221229160045.535778-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229160045.535778-1-brgl@bgdev.pl>
References: <20221229160045.535778-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have a set of return values that notifier callbacks can return. They
should not return 0, error codes or anything other than those predefined
values. Make the i2c character device's callback return NOTIFY_DONE or
NOTIFY_OK depending on the situation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/i2c/i2c-dev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ab0adaa130da..107623c4cc14 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -653,12 +653,12 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 	int res;
 
 	if (dev->type != &i2c_adapter_type)
-		return 0;
+		return NOTIFY_DONE;
 	adap = to_i2c_adapter(dev);
 
 	i2c_dev = get_free_i2c_dev(adap);
 	if (IS_ERR(i2c_dev))
-		return PTR_ERR(i2c_dev);
+		return NOTIFY_DONE;
 
 	cdev_init(&i2c_dev->cdev, &i2cdev_fops);
 	i2c_dev->cdev.owner = THIS_MODULE;
@@ -678,11 +678,11 @@ static int i2cdev_attach_adapter(struct device *dev, void *dummy)
 		goto err_put_i2c_dev;
 
 	pr_debug("adapter [%s] registered as minor %d\n", adap->name, adap->nr);
-	return 0;
+	return NOTIFY_OK;
 
 err_put_i2c_dev:
 	put_i2c_dev(i2c_dev, false);
-	return res;
+	return NOTIFY_DONE;
 }
 
 static int i2cdev_detach_adapter(struct device *dev, void *dummy)
@@ -691,17 +691,17 @@ static int i2cdev_detach_adapter(struct device *dev, void *dummy)
 	struct i2c_dev *i2c_dev;
 
 	if (dev->type != &i2c_adapter_type)
-		return 0;
+		return NOTIFY_DONE;
 	adap = to_i2c_adapter(dev);
 
 	i2c_dev = i2c_dev_get_by_minor(adap->nr);
 	if (!i2c_dev) /* attach_adapter must have failed */
-		return 0;
+		return NOTIFY_DONE;
 
 	put_i2c_dev(i2c_dev, true);
 
 	pr_debug("adapter [%s] unregistered\n", adap->name);
-	return 0;
+	return NOTIFY_OK;
 }
 
 static int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
@@ -716,7 +716,7 @@ static int i2cdev_notifier_call(struct notifier_block *nb, unsigned long action,
 		return i2cdev_detach_adapter(dev, NULL);
 	}
 
-	return 0;
+	return NOTIFY_DONE;
 }
 
 static struct notifier_block i2cdev_notifier = {
-- 
2.37.2

