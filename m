Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEB647576
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLHSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLHSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:21:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2B82FB1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:21:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m19so1756829wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU7sDwiy4wxWca9BJshy+agHeUQnApN7sCu5RKlRtdM=;
        b=8UM+pbjMpETB90wu45EF3ihvSslam6jlpCpLiiQLoa4ie9sjNA6/kPSs3MzGaApTcR
         57qno27Gk5K0Mt6ydm1La+UeVEu625oQnBPyimKQSdoxSCPj+vlIV1J41z0UgeHoa7TF
         iwvR0xX/qwiW19yb4g1dKRx6N4XG5FLUSItj/FayjqeNV0K+lt6iDiRTqYmDxyOjBXeO
         4a76t7bqLAfA5n42/dSqF2ZvXiE6fjnw7n1vTeHhbY+M9c5F2SbFcs0Ta2dDjSAgktvV
         IbgTTA4yuA+z8f/7iQ208QhJFQbnqujkIKWepHJLijznsuaewDn4w7EiTZ8JhLd7NF6g
         l+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU7sDwiy4wxWca9BJshy+agHeUQnApN7sCu5RKlRtdM=;
        b=mdzqiePtiQIvDrBcmjUc7FCCBU+OZb0peWhrlz4FmRvx6GcORt4Bpnz0TEN5pNt+B3
         d8r6QEDFBbEHUUO3OpBc4br7UOgRjGUYLZXgzeq2TftDvkrvBMlD3VxlbXiq03Fi9nR9
         7XvaKX4DUyRRuIjMevckaMObTGnPu4nMd0ARYw6d3H17Vm+lkxWQtotmpUlGBXjakL4d
         NFUVqZJnfYowfQe9FjP6Xoxuqtqkn1yfPj9ib/SpgEHUoVSk2qvWjG68xYy54dbmSMgL
         9vgLNNPEz2GRt+RuJeUeEAPEj/2Oz3F/6opshB/OZiTW45ehRFhcRj3sT/cugd7X70hu
         1C6g==
X-Gm-Message-State: ANoB5pkZLqSH+KoQHLytS72WeCPPB2G0UkjjnmRI7If1w2KsHZ+RvtXR
        xsxJqrs+qYounT7D4+lw/tBQNQ==
X-Google-Smtp-Source: AA0mqf7H3Z1an7Fld/V1D58g9oVT66aqGmDpiYZmOOhZyBuq0Iyg7YuVFk97M5Uc8kGtKWNGdC5SYw==
X-Received: by 2002:a1c:7303:0:b0:3cf:a258:971 with SMTP id d3-20020a1c7303000000b003cfa2580971mr3111650wmb.41.1670523706972;
        Thu, 08 Dec 2022 10:21:46 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1fd:11b0:f877:1d6c])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bc8da000000b003cfd4e6400csm5770338wml.19.2022.12.08.10.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 10:21:46 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] i2c: dev: fix notifier return values
Date:   Thu,  8 Dec 2022 19:21:41 +0100
Message-Id: <20221208182142.250084-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208182142.250084-1-brgl@bgdev.pl>
References: <20221208182142.250084-1-brgl@bgdev.pl>
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

