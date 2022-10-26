Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B94960E028
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiJZMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiJZMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:03:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB14B4BC;
        Wed, 26 Oct 2022 05:03:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p3so12878277pld.10;
        Wed, 26 Oct 2022 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeyWPYOfNLO5HnpCrV5iKgVUweZC5smkX35UuDur0+M=;
        b=M3jMZCz2f9I//6dZFQixFueDv6DvYYSZAPHVtKl+MyKAgJt6T38Gb6GzCvJeBqFFWe
         0IPEe0eefPjToxWp/R7HaW03L9zOfBHUukgzhX6wH2VLoqOP1LiSPhUW8qdlzKVa1fyn
         ynUjy1O7nL0X2uG4J6xqfMZCAWMRa/K8N2Ttl14QZGYaym4CzdqkSkNDznT6XxNUhg1A
         DGnknrKGEEZOpISRKsAuZ9K3FbMmReDddGUuhOTenZ7QTT1bXck7JGO0cAeMWvlZO7SK
         peq006gMhlFVtmMBqC0WmcoxoqEhL/vgut4uQHRWurhrmUrceuEwqtg6fro2VEvfGI8h
         c81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeyWPYOfNLO5HnpCrV5iKgVUweZC5smkX35UuDur0+M=;
        b=JZY6CnB6aNqfH6j9QSrDkbMmHYnWx7kWhRGfC0x8hNEacGQWmLQsIVeQNxQ7XLY3NZ
         sWXg013DPPIa2QrFQhmu36sptr6g3B1Sawzp1B/b4ih0GqCf3eob37s1xaREco+LnC43
         6dQE509Anqu3w1gFFw5ycA0vQ5Vqp7QyX63H5QzCX9QFh2qEjS3dZfbNmsmzVaaEkwWF
         lcTlSJSXhjdUPkz/nk81oB22O19eKz2JQhfsK2soQrhXF/A4rRmEPErHfJRNEkjhfaYf
         yEA3ADFV9QRcNAgRt5m1GOPEbGW0YDHs19dP0qNeeAdIpo1x9tA0/3YJPZB2PUXoAE38
         zjoA==
X-Gm-Message-State: ACrzQf1K+QKNAN6JOPHQVovOSHa+Ye3snKZ3XiscatQpwwVW5DVTHc3X
        MqVyuaf3vv8Rk/CfrpySFRj/Z/QqeGk=
X-Google-Smtp-Source: AMsMyM7ZsD9zd75rfP1t09/N84nyoB0b00ATY643mX5PB2nD6sq/UXCjBUsi7BIkPjosWUKH0WyEkg==
X-Received: by 2002:a17:902:ed82:b0:178:5653:ecfb with SMTP id e2-20020a170902ed8200b001785653ecfbmr43634366plj.58.1666785814222;
        Wed, 26 Oct 2022 05:03:34 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f27-20020aa7969b000000b0053e4296e1d3sm2863289pfk.198.2022.10.26.05.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:03:33 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangqibo <huangqibo@xiaomi.com>
Subject: [PATCH] thermal/core: cooling device duplicate creation check
Date:   Wed, 26 Oct 2022 20:03:21 +0800
Message-Id: <20221026120321.735-1-huangqibo.tech@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huangqibo <huangqibo@xiaomi.com>

Because creating a cooling device may have duplicate names.
When creating, first check thermal_cdev_list whether
there is a device with the same name. If it has the same name,
it returns a reference to the cooling device.

Signed-off-by: huangqibo <huangqibo@xiaomi.com>
---
 drivers/thermal/thermal_core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 117eeaf7dd24..092c7732a294 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -873,6 +873,12 @@ __thermal_cooling_device_register(struct device_node *np,
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
+	if (type)
+		cdev = thermal_cdev_get_zone_by_name(type);
+
+	if (!IS_ERR_OR_NULL(cdev))
+		return cdev;
+
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
@@ -1435,6 +1441,34 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
+struct thermal_cooling_device *thermal_cdev_get_zone_by_name(const char *name)
+{
+	struct thermal_cooling_device *pos = NULL, *ref = ERR_PTR(-EINVAL);
+	unsigned int found = 0;
+
+	if (!name)
+		goto exit;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(pos, &thermal_cdev_list, node)
+		if (!strncasecmp(name, pos->type, THERMAL_NAME_LENGTH)) {
+			found++;
+			ref = pos;
+		}
+	mutex_unlock(&thermal_list_lock);
+
+	/* nothing has been found, thus an error code for it */
+	if (found == 0)
+		ref = ERR_PTR(-ENODEV);
+	else if (found > 1)
+	/* Success only when an unique zone is found */
+		ref = ERR_PTR(-EEXIST);
+
+exit:
+	return ref;
+}
+EXPORT_SYMBOL_GPL(thermal_cdev_get_zone_by_name);
+
 static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
-- 
2.36.1

