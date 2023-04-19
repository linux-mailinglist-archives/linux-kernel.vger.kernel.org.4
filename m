Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2A6E8313
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjDSVIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjDSVI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:08:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5A7685;
        Wed, 19 Apr 2023 14:08:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id gw13so306195wmb.3;
        Wed, 19 Apr 2023 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681938500; x=1684530500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+oYU3lOVwUqdc9f48/HeSPXnQKzJbbtYLzabFYj4Ws=;
        b=BuDSRqMaEJTl61ZYicLdsY4+v9WOMRr+MgGP9ia9GWl1BAycE7/qeanWqp+FhEhrYV
         PE5ksBPFnV5X/w7cJD8dd90m1ruEa0uXUzI/INH5poc3ZtuTv+wHT3K9w4TM+i0vP44r
         rEvaIWWBZrLTlatRkRWhe/FEOCEjNL96GDSGxom2bTr3afkXavy98r0eTpT9fZgdey8Q
         ktipViLPk4HDt3+pK1FZ32FM+O7jsbLfMAfjahn1nVZ87j5UNKr+evYcTbq7yhG4hmB/
         BCg33CYFJ8u9OD0DmpiIui+JovZfZlpv4tWCbkLCZ5aRhW76WhFCMiOYYGzBAfyrAh/A
         DOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938500; x=1684530500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+oYU3lOVwUqdc9f48/HeSPXnQKzJbbtYLzabFYj4Ws=;
        b=hENbgPUJxmKOlmRT/Kytp7kq5Ygrb4D36Y9G9dPIXU2Y0wteKqvfYwakoY29Hmz1IU
         VuVOTvteMCCkPE4K2HnpEURX5WEsoTNqoYRmxWIy0ulaXEvCBgrLXhCwP+hhbBX4E4yv
         PNrnbIDHCFLQJ7QYiEMc+xpDQSv1f5NYCWR1UROzgM2vzqO2HExV4XjbRjinKVoccV63
         nwCZBkcR+XMwDIhpBOinG6poGmIJjG6Q9e4CZfdLD5A+9eJL3q5TEmswzPOhs5xOJaZT
         gKMvQIeVV6Dt2C9qqOGA9ZKaGKApmoD72AD2j84bVE3TbGMabcNGgyOqPIDyabD6lIkr
         +Jtw==
X-Gm-Message-State: AAQBX9cY004eZ0/bMWpKvGc7xHkPab1UNHlIi8/+Cp7VE+h5ND3B1Jat
        EedJu4Ukfy/HNrpovqg1MDQ=
X-Google-Smtp-Source: AKy350a6wDsjwvOxSC8Zyndl1DXpPFa7gsGtGhdwyXRUSws8LefGRWW/fboA5OgAt4Wr+w2CXAh7vw==
X-Received: by 2002:a1c:7c05:0:b0:3f1:6eb5:6e6a with SMTP id x5-20020a1c7c05000000b003f16eb56e6amr11421930wmc.28.1681938499918;
        Wed, 19 Apr 2023 14:08:19 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id g3-20020a5d5543000000b002fe254f6c33sm81295wrw.92.2023.04.19.14.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:08:19 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 5/5] leds: trigger: netdev: use mutex instead of spinlocks
Date:   Wed, 19 Apr 2023 23:07:43 +0200
Message-Id: <20230419210743.3594-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419210743.3594-1-ansuelsmth@gmail.com>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LEDs may require to sleep while doing some operation like setting
brightness and other cleanup.

For this reason, using a spinlock will cause a sleep under spinlock
warning.

It should be safe to convert this to a sleepable lock since:
- sysfs read/write can sleep
- netdev_trig_work is a work queue and can sleep
- netdev _trig_notify can sleep

The spinlock was used when brightness didn't support sleeping, but this
changed and now it supported with brightness_set_blocking().

Convert to mutex lock to permit sleeping using brightness_set_blocking().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 5a47913c813c..115f2bae9eee 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -20,7 +20,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/timer.h>
 #include "../leds.h"
 
@@ -37,7 +37,7 @@
  */
 
 struct led_netdev_data {
-	spinlock_t lock;
+	struct mutex lock;
 
 	struct delayed_work work;
 	struct notifier_block notifier;
@@ -97,9 +97,9 @@ static ssize_t device_name_show(struct device *dev,
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	ssize_t len;
 
-	spin_lock_bh(&trigger_data->lock);
+	mutex_lock(&trigger_data->lock);
 	len = sprintf(buf, "%s\n", trigger_data->device_name);
-	spin_unlock_bh(&trigger_data->lock);
+	mutex_unlock(&trigger_data->lock);
 
 	return len;
 }
@@ -115,7 +115,7 @@ static ssize_t device_name_store(struct device *dev,
 
 	cancel_delayed_work_sync(&trigger_data->work);
 
-	spin_lock_bh(&trigger_data->lock);
+	mutex_lock(&trigger_data->lock);
 
 	if (trigger_data->net_dev) {
 		dev_put(trigger_data->net_dev);
@@ -138,7 +138,7 @@ static ssize_t device_name_store(struct device *dev,
 	trigger_data->last_activity = 0;
 
 	set_baseline_state(trigger_data);
-	spin_unlock_bh(&trigger_data->lock);
+	mutex_unlock(&trigger_data->lock);
 
 	return size;
 }
@@ -279,7 +279,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 
 	cancel_delayed_work_sync(&trigger_data->work);
 
-	spin_lock_bh(&trigger_data->lock);
+	mutex_lock(&trigger_data->lock);
 
 	trigger_data->carrier_link_up = false;
 	switch (evt) {
@@ -304,7 +304,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 
 	set_baseline_state(trigger_data);
 
-	spin_unlock_bh(&trigger_data->lock);
+	mutex_unlock(&trigger_data->lock);
 
 	return NOTIFY_DONE;
 }
@@ -365,7 +365,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	if (!trigger_data)
 		return -ENOMEM;
 
-	spin_lock_init(&trigger_data->lock);
+	mutex_init(&trigger_data->lock);
 
 	trigger_data->notifier.notifier_call = netdev_trig_notify;
 	trigger_data->notifier.priority = 10;
-- 
2.39.2

