Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2106CB4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjC1Dis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjC1Diq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:38:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C9171F;
        Mon, 27 Mar 2023 20:38:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id le6so10382976plb.12;
        Mon, 27 Mar 2023 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679974725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bli4V9RIcx7UIAAcKmOg4gk20edyuK7KxYvBcBo2/s=;
        b=U/r9ZPAtmhT6KPbEZeT7y/tdL3siKa7zh/Mrny+2Byt0XZ4/fJcDP2E2+w+zcci8+K
         TZv1BQYJpBpDpfX7QgVIvkE3dzM51Z3qVRs1Ofqo6y/ZkjsUEF7XPjEzH9PxZFc2hhNQ
         HeGzJivrDKQQoYrRnGQwW9eOM5KBdMkJIV3NGEjE8kqOwqPF/4qGnA/jASBXCjtqxH/M
         kD+3f1pR5a4CJusr0IEtuVUGKOye8wzyPDMqq734YPS6c6R4FauOSSI/doueoLc+YynE
         8dqPnATOGJHuHo63kYNEJJvf0u+oRW9xHIvxdyH6IUg18cKF2WIlTFeKx9buTGuaKUQd
         miIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679974725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Bli4V9RIcx7UIAAcKmOg4gk20edyuK7KxYvBcBo2/s=;
        b=wAawpEiDoGPGp9vvQgPavvMD5QA5LiqmcIa2whqXA9WNN3+/2xlPU8FIMn8gyiWPp6
         7oIZf+cnjwl4aQREwuG23Wo3HIZesbz/1OTQHCPKHNdKRspWwRn/a6hd+qExqzRWwyhd
         oLK3ZCQAF7QF6M4douGycuJWLMRy5Be2ojVwqiGI8HkTYET52bpbYrGYpREHfsXaHWXn
         MsO4fwwp5QLSCI8gQnaOg4gX4tu9STu7u/JUCVmyWLFe796s63NiwBWHQ73zaaAABGQt
         0Ra6YvhDvgvC9lIE5FR7TuQ27tY/PkmntOcBQpOmu7+BICnBZ5UUY3ZsiIhs2DczTDw5
         JX3w==
X-Gm-Message-State: AO0yUKUtsFG0+LRIUf1e8gy2WoTPwxw8c8WqAWck71fkGlU61s46hYmZ
        w6sYiRsazkpMZ/V84p6Ai8Y=
X-Google-Smtp-Source: AK7set/aVH5S1sm1SSXyRQWuNszdlff2pAGRCKbEZk8j0f8hRpEK0LA5+g62IVfKehxoHHLZYJaxIA==
X-Received: by 2002:a05:6a20:65b:b0:da:bb5f:41ed with SMTP id 27-20020a056a20065b00b000dabb5f41edmr12120700pzm.61.1679974724468;
        Mon, 27 Mar 2023 20:38:44 -0700 (PDT)
Received: from localhost.localdomain ([210.113.67.100])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b005dd65169628sm20435648pfo.144.2023.03.27.20.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:38:44 -0700 (PDT)
From:   Jason Kim <sukbeom.kim@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Kim <sukbeom.kim@gmail.com>
Subject: [PATCH] media: mc-device: remove unnecessary __must_check
Date:   Tue, 28 Mar 2023 12:14:59 +0900
Message-Id: <20230328031459.15500-1-sukbeom.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file mc-device.c, the function
media_device_register_entity_notify() does not need to have the
__must_check attribute since it returns only a value of 0.
Therefore, we can remove this attribute and change the function's
return type.

Signed-off-by: Jason Kim <sukbeom.kim@gmail.com>
---
 drivers/media/mc/mc-device.c           | 3 +--
 drivers/media/usb/au0828/au0828-core.c | 9 ++-------
 include/media/media-device.h           | 5 ++---
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 9e56d2ad6b94..0259ffbdcbc2 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -770,13 +770,12 @@ int __must_check __media_device_register(struct media_device *mdev,
 }
 EXPORT_SYMBOL_GPL(__media_device_register);
 
-int __must_check media_device_register_entity_notify(struct media_device *mdev,
+void media_device_register_entity_notify(struct media_device *mdev,
 					struct media_entity_notify *nptr)
 {
 	mutex_lock(&mdev->graph_mutex);
 	list_add_tail(&nptr->list, &mdev->entity_notify);
 	mutex_unlock(&mdev->graph_mutex);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(media_device_register_entity_notify);
 
diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index a8a72d5fbd12..64739f403663 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -627,14 +627,9 @@ static int au0828_media_device_register(struct au0828_dev *dev,
 	/* register entity_notify callback */
 	dev->entity_notify.notify_data = (void *) dev;
 	dev->entity_notify.notify = (void *) au0828_media_graph_notify;
-	ret = media_device_register_entity_notify(dev->media_dev,
+	media_device_register_entity_notify(dev->media_dev,
 						  &dev->entity_notify);
-	if (ret) {
-		dev_err(&udev->dev,
-			"Media Device register entity_notify Error: %d\n",
-			ret);
-		return ret;
-	}
+
 	/* set enable_source */
 	mutex_lock(&dev->media_dev->graph_mutex);
 	dev->media_dev->source_priv = (void *) dev;
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 1345e6da688a..5fa89baf9666 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -373,7 +373,7 @@ void media_device_unregister_entity(struct media_entity *entity);
  *    media_entity_notify callbacks are invoked.
  */
 
-int __must_check media_device_register_entity_notify(struct media_device *mdev,
+void media_device_register_entity_notify(struct media_device *mdev,
 					struct media_entity_notify *nptr);
 
 /**
@@ -453,11 +453,10 @@ static inline int media_device_register_entity(struct media_device *mdev,
 static inline void media_device_unregister_entity(struct media_entity *entity)
 {
 }
-static inline int media_device_register_entity_notify(
+static inline void media_device_register_entity_notify(
 					struct media_device *mdev,
 					struct media_entity_notify *nptr)
 {
-	return 0;
 }
 static inline void media_device_unregister_entity_notify(
 					struct media_device *mdev,
-- 
2.34.1

