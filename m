Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC34D671776
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjARJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjARJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:20:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10FC7572A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:38:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x4so21452041pfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id0JR6OCkU6vLjgrNgRIuw5EcxaUhOjb9e6uHVbO4ng=;
        b=w6Obwzd3CGGBvdmAWvcE8LFRen+uO0H92gJZLVS6ZqKIa06i2L4mg/83y+oTpIP9sV
         woX+pSIKfzgtRr2jj2eDz/bTS6yVX1HxRVvVnfbUZHHpoTxmTAWoucMRg7h9SuIg/hv8
         An2ZMUJ7HC0Ha1SHW1/tKC5nwI1BEVfDNNfQU1mK+JYQIUp1Xv8I9dFuKgYjOvxN06Jq
         w9tWMN3Uzd8Eq0aW6Iq854BYR12pMSDZgAO28gFPgZrdI+XwetDFnLDVlfel6We/UR1S
         NiUPPa0YHthXx5UlaPzu5CnlXhBM/P8RK3Zdse6gB0ltxlvZdxvMfavGxDhX3/K0vvjj
         +Rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id0JR6OCkU6vLjgrNgRIuw5EcxaUhOjb9e6uHVbO4ng=;
        b=Rh+hHgh7NHZ/DwjzE8Js5zj8/Nu4oqzqibakmq2BiQ+jkoLZIgFKgc7eHWdxMXD6BB
         /1oi9CVMhrvf7LfJTftcdHSEg89oyDs7DSGHVW7whgKTGmhMnDcmBEZ8grVMx29mrVyE
         GxkL0bm9XvB+tUhG+WD8kU/LMqPov0WZ62VO+xZGGhvV52uyyMsQoNJQAnwCHH/rixT7
         laB5kSnhRAKfLG92a33jcoVIX6LSKVZWcuT0uY40kDs7jZqfLTwOHXcROMSf2bK5BGKi
         LcXcB/U3WYg0jjuj5/Qnw8lFstHY/ztlzW/V23yeCW179giFSQc9eFad/z8KMo46nbST
         wsJg==
X-Gm-Message-State: AFqh2kpUs63Wn9JEvzaZ7H2CaomyOwTh7EbCZeV5yQlU9Qzj9o8ywedG
        kgmIg/tUPQltdnCUAGN3dZGeBg==
X-Google-Smtp-Source: AMrXdXsaR0p9XFpJdxoiAqHT2u53w+g7DgHhCblPR0lWQS5kewzQSvMuA5WNmvvwWNF6y845T0pSlg==
X-Received: by 2002:a05:6a00:26cc:b0:589:62bd:14d with SMTP id p12-20020a056a0026cc00b0058962bd014dmr5988623pfw.1.1674031118270;
        Wed, 18 Jan 2023 00:38:38 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id i70-20020a628749000000b005815837164fsm6044666pfe.59.2023.01.18.00.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:38:37 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] thermal: core: Move cdev cleanup to thermal_release()
Date:   Wed, 18 Jan 2023 14:08:25 +0530
Message-Id: <d043f685320f4c5956293aff139b07034f24f0a5.1674030722.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1674030722.git.viresh.kumar@linaro.org>
References: <cover.1674030722.git.viresh.kumar@linaro.org>
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

thermal_release() already frees cdev, let it do rest of the cleanup as
well in order to simplify the error paths in
__thermal_cooling_device_register().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/thermal_core.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 77bd47d976a2..1fb109a97ff6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -774,6 +774,9 @@ static void thermal_release(struct device *dev)
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
 		cdev = to_cooling_device(dev);
+		thermal_cooling_device_destroy_sysfs(cdev);
+		kfree(cdev->type);
+		ida_free(&thermal_cdev_ida, cdev->id);
 		kfree(cdev);
 	}
 }
@@ -909,23 +912,21 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->devdata = devdata;
 
 	ret = cdev->ops->get_max_state(cdev, &cdev->max_state);
-	if (ret) {
-		kfree(cdev->type);
-		goto out_ida_remove;
-	}
+	if (ret)
+		goto out_cdev_type;
 
 	thermal_cooling_device_setup_sysfs(cdev);
 
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-	if (ret) {
-		kfree(cdev->type);
-		thermal_cooling_device_destroy_sysfs(cdev);
-		goto out_ida_remove;
-	}
+	if (ret)
+		goto out_cooling_dev;
 
 	ret = device_register(&cdev->device);
-	if (ret)
-		goto out_kfree_type;
+	if (ret) {
+		/* thermal_release() handles rest of the cleanup */
+		put_device(&cdev->device);
+		return ERR_PTR(ret);
+	}
 
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
@@ -944,13 +945,10 @@ __thermal_cooling_device_register(struct device_node *np,
 
 	return cdev;
 
-out_kfree_type:
+out_cooling_dev:
 	thermal_cooling_device_destroy_sysfs(cdev);
+out_cdev_type:
 	kfree(cdev->type);
-	put_device(&cdev->device);
-
-	/* thermal_release() takes care of the rest */
-	cdev = NULL;
 out_ida_remove:
 	ida_free(&thermal_cdev_ida, id);
 out_kfree_cdev:
@@ -1111,10 +1109,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
-	ida_free(&thermal_cdev_ida, cdev->id);
 	device_del(&cdev->device);
-	thermal_cooling_device_destroy_sysfs(cdev);
-	kfree(cdev->type);
 	put_device(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
-- 
2.31.1.272.g89b43f80a514

