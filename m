Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2756960DD97
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiJZI45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiJZI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:56:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DC9AFEA;
        Wed, 26 Oct 2022 01:56:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x2so13090902edd.2;
        Wed, 26 Oct 2022 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UBZ8NLkBDI2XVTa9V4vyCdw25d2Kk0os+ZjuC1ZrDI=;
        b=oW8273P9wDNYNiOGTCIO9lDwzHl/P8l9uzEU9Ri4rzmadiEpJePX4UTqrq1X2PEIRN
         e7hDzTeoTUckQZIfYYzVHuPmzWb8QLJazgZrJ9aKzadwhAKBYU49G2adJnHdNF/rYbAj
         qnxLi2TKBPUbfg1/Hu0IgK5x2SJquwffTrURO1vZ4+dQVtBY3ThXoVuvLfxkHUxIWOf8
         EKISI7EcTm79UaIEgrHZKPtKTl68B3Vly5D74t3AYWfYqnrOvrVJEDk8YnlfvmLVhmX6
         aD0bcviLd0x/tzkiq+h1rXaeUggXH1ba56IRQaAsPcg9h2h4kmC/SewXc5QIyMyWDPse
         TewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UBZ8NLkBDI2XVTa9V4vyCdw25d2Kk0os+ZjuC1ZrDI=;
        b=rgNcj/UAJNQD4tPSeeQowtPMaKIJz3PFNJ6J4FcouqoX5fOzNrRMB95zMTkdGGb6Ae
         YqEPxlf7/KWjlw/Mq5L1JnmQ9beYnvDZTMEhtd5Ut43BYntGOesRVCfGb5hees+Ozo0t
         64d+muRTN0PYZhL75/NrenedEEmbyOfRX8KbGgzrt+2X9mpABXhTqSKBb6tmxHayHbMf
         Xj9lc0/XdPtb7l4RxI27fh9It+JbVCjBqi7QqQQU/2nG+Pcsm/ajfCvS5OZhHE6rIa0A
         12WOAcmXxGgmH/Fio3ahksGwIU6k/K2TlKaRlL56liJ5NyL8losGXworkMNDQZs2tEdq
         268Q==
X-Gm-Message-State: ACrzQf0OBPLUYlk9FktOewpEHv0zt4qkYKFmlwmEQuAjDaQPqxpHq5t+
        PbZ7UyXE/Jddn8p9ZGqaPGyOW49ypcbg+A==
X-Google-Smtp-Source: AMsMyM6Pg1bqz5Ig11BPL77vhPGN7MK4dtBet+gBOLkmng/wH7AF2djMsSylP1cjGeK69jhkYOiUCQ==
X-Received: by 2002:a05:6402:496:b0:443:a5f5:d3b with SMTP id k22-20020a056402049600b00443a5f50d3bmr40993468edv.331.1666774612776;
        Wed, 26 Oct 2022 01:56:52 -0700 (PDT)
Received: from [109.186.183.118] (109-186-183-118.bb.netvision.net.il. [109.186.183.118])
        by smtp.gmail.com with ESMTPSA id y21-20020aa7d515000000b00461aebb2fe2sm3085125edq.54.2022.10.26.01.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 01:56:52 -0700 (PDT)
Message-ID: <2e5cbdfe-f6cd-d24f-9785-55176af6c975@gmail.com>
Date:   Wed, 26 Oct 2022 11:52:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH] char: xillybus: Prevent use-after-free due to race condition
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imv4bel@gmail.com,
        Eli Billauer <eli.billauer@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xillybus_find_inode() is called by xillybus_open() and xillyusb_open()
to translate the inode's major and minor into a pointer to a relevant
data structure and an index.

But with xillyusb_open(), the data structure can be freed by
xillyusb_disconnect() during an unintentional time gap between the
release of the mutex that is taken by xillybus_find_inode() and the
mutex that is subsequently taken by xillyusb_open().

To fix this, xillybus_find_inode() supplies the pointer to the mutex that
it has locked (when returning success), so xillyusb_open() releases this
mutex only after obtaining the mutex that is specific to a device file.
This ensures that xillyusb_disconnect() won't release anything that is in
use.

This manipulation of mutexes poses no risk for a deadlock, because in
all usage scenarios, @unit_mutex (which is locked by xillybus_find_inode)
is always taken when no other mutex is locked. Hence a consistent locking
order is guaranteed.

xillybus_open() unlocks this mutex immediately, as this driver doesn't
support hot unplugging anyhow.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 drivers/char/xillybus/xillybus_class.c | 8 +++++---
 drivers/char/xillybus/xillybus_class.h | 2 ++
 drivers/char/xillybus/xillybus_core.c  | 6 +++++-
 drivers/char/xillybus/xillyusb.c       | 4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index 0f238648dcfe..c846dc3ed225 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -211,6 +211,7 @@ void xillybus_cleanup_chrdev(void *private_data,
 EXPORT_SYMBOL(xillybus_cleanup_chrdev);
 
 int xillybus_find_inode(struct inode *inode,
+			struct mutex **to_unlock,
 			void **private_data, int *index)
 {
 	int minor = iminor(inode);
@@ -227,13 +228,14 @@ int xillybus_find_inode(struct inode *inode,
 			break;
 		}
 
-	mutex_unlock(&unit_mutex);
-
-	if (!unit)
+	if (!unit) {
+		mutex_unlock(&unit_mutex);
 		return -ENODEV;
+	}
 
 	*private_data = unit->private_data;
 	*index = minor - unit->lowest_minor;
+	*to_unlock = &unit_mutex;
 
 	return 0;
 }
diff --git a/drivers/char/xillybus/xillybus_class.h b/drivers/char/xillybus/xillybus_class.h
index 5dbfdfc95c65..7cf89ac8bb32 100644
--- a/drivers/char/xillybus/xillybus_class.h
+++ b/drivers/char/xillybus/xillybus_class.h
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 
 int xillybus_init_chrdev(struct device *dev,
 			 const struct file_operations *fops,
@@ -25,6 +26,7 @@ void xillybus_cleanup_chrdev(void *private_data,
 			     struct device *dev);
 
 int xillybus_find_inode(struct inode *inode,
+			struct mutex **to_unlock, /* Mutex to release */
 			void **private_data, int *index);
 
 #endif /* __XILLYBUS_CLASS_H */
diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index 11b7c4749274..7fd35f055310 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -1431,11 +1431,15 @@ static int xillybus_open(struct inode *inode, struct file *filp)
 	struct xilly_endpoint *endpoint;
 	struct xilly_channel *channel;
 	int index;
+	struct mutex *to_unlock; /* Mutex locked by xillybus_find_inode() */
 
-	rc = xillybus_find_inode(inode, (void **)&endpoint, &index);
+	rc = xillybus_find_inode(inode, &to_unlock,
+				 (void **)&endpoint, &index);
 	if (rc)
 		return rc;
 
+	mutex_unlock(to_unlock);
+
 	if (endpoint->fatal_error)
 		return -EIO;
 
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 39bcbfd908b4..63e94d935067 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -1236,8 +1236,9 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	struct xillyusb_endpoint *out_ep = NULL;
 	int rc;
 	int index;
+	struct mutex *to_unlock; /* Mutex locked by xillybus_find_inode() */
 
-	rc = xillybus_find_inode(inode, (void **)&xdev, &index);
+	rc = xillybus_find_inode(inode, &to_unlock, (void **)&xdev, &index);
 	if (rc)
 		return rc;
 
@@ -1245,6 +1246,7 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	filp->private_data = chan;
 
 	mutex_lock(&chan->lock);
+	mutex_unlock(to_unlock);
 
 	rc = -ENODEV;
 
-- 
2.17.1

