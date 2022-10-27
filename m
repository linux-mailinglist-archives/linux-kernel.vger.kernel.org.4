Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BCE60EE71
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiJ0DRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0DQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:16:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B89DD896;
        Wed, 26 Oct 2022 20:16:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q1so17045600pgl.11;
        Wed, 26 Oct 2022 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdfYL7Y9VZRkcaGm5JO6kmXdUQOSNAtEcm9KHbShwM0=;
        b=XIR6I96JOE4YdJFAGI9vkaV9ftdFHLXvgaTfH/BrmdWg9E2lioAP3gwj4j1QwOd2kg
         X+kE3+dK4thHPm6gdtYky6VrtInB+1Q1jGzVBZwg+eGWIVy8edwa/o3jOjFBZZGh3+Jn
         avgFZEtcdOQWzfLftnRYYAcVp/s5Bxbq3Yt5xcRHl7a6pW2hZ54N3drqU/cnp3KUd2s9
         waFl/lFpGUTa42N5g7fZz0MaF7hrepY/48d78ngJk4gNlWYNWURl2QoudknCUVCzYOen
         48S/4/HXTh9ZzjtopQlg7loHvqdxIZxAN2OmYYfCwiucNx58+w6gXGKor9H8EGjaTk0O
         wQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdfYL7Y9VZRkcaGm5JO6kmXdUQOSNAtEcm9KHbShwM0=;
        b=1P2R7Zn5QVL+zeH63gLYPgcSDLL1UBQAo3Nnv02pQzk3Dr4aJk6UiF01BfEhKvHonA
         c4QvsLscOlbDDEYgXu3lIOHQScISbAe2u5G9XuizpG2waqUw80AcrWjjlmI6MpEymrw0
         Cd3kg5egWYUj/YT/7dvikP9RB++OyEgdjT1K+yfPKaG12ucbQRc5AFmn5AZgN4BJ+2zq
         HcxI8yevoUPEE1K5/coM6a0w9hZL6ed06WXNzHWtu22SG7QV/pttOoQbgEe41BjULlEU
         PB5+aLXb/wuWuuJLF++y/7a/lZwGr1SGS/17RStUGvJYnAGsOrLKWzFZox31yauNPd4J
         llCw==
X-Gm-Message-State: ACrzQf2qQImFKOE4tVDyHwjAKEIKmHYbx2Zm6BKsv+74EpVQZTypAkGY
        WY8irqnl4qyigdnCbizVjGA=
X-Google-Smtp-Source: AMsMyM5+xOtqqxmysxAnn8Duv7uM/CHacx922DUA+NrlUAuR8I9zgfdwOzN/MkestWZMoGjCzSI39g==
X-Received: by 2002:a63:1b16:0:b0:46b:8e7:3e0a with SMTP id b22-20020a631b16000000b0046b08e73e0amr39509387pgb.86.1666840618217;
        Wed, 26 Oct 2022 20:16:58 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d17-20020aa797b1000000b0056bb99db338sm112636pfq.175.2022.10.26.20.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:16:57 -0700 (PDT)
From:   Qibo Huang <huangqibo.tech@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qibo Huang <huangqibo.tech@gmail.com>
Subject: [PATCH] thermal/core: cooling device duplicate creation check
Date:   Thu, 27 Oct 2022 11:16:48 +0800
Message-Id: <20221027031648.2452-1-huangqibo.tech@gmail.com>
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

Because creating a cooling device may have duplicate names.
When creating, first check thermal_cdev_list whether
there is a device with the same name. If it has the same name,
it returns a reference to the cooling device.

Signed-off-by: Qibo Huang <huangqibo.tech@gmail.com>
---
 drivers/thermal/thermal_core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 7e669b60a065..f38f9464e9f4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -844,6 +844,34 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	mutex_unlock(&thermal_list_lock);
 }
 
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
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -873,6 +901,12 @@ __thermal_cooling_device_register(struct device_node *np,
 	    !ops->set_cur_state)
 		return ERR_PTR(-EINVAL);
 
+	if (type) {
+		cdev = thermal_cdev_get_zone_by_name(type);
+		if (!IS_ERR(cdev))
+			return cdev;
+	}
+
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
-- 
2.37.1

