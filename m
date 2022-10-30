Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A97612991
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJ3Jm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3Jmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:42:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6816BCBC;
        Sun, 30 Oct 2022 02:42:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so6408253wmb.0;
        Sun, 30 Oct 2022 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzD1cCzWs9VPUJh096MAEgvDhKt7t9nN1p2Sdoa1ilI=;
        b=cfoycT0IdA5TciqQvzjiUL622pOMdylg7z6mLK5Oz8nkfn9D5qUENwZGc0eFzYcJPl
         Z+esyH7UVSwdz7iglvUBEiemU9ZjDrd+jlkFI+4Zp2idwxLGs69AoB2lTOE9oI3B8h+T
         C/c8ASSRSoGZTfAfZxfZ36+IlZQe1LdJlTKcNJLXBshHpxGUBBsErqTo29Jz6uty9KBT
         A0XmHlT4EXh6zOLGGuf9QeYaDvp9AV4zNNZrmUC8TW4am3YIEYR4BXTdxaFWaCwW6l95
         8ThBkD6vhtjT+3LbY4qU0uHDo/KTmj+HyUBtaZ90oB3C4DcABjoHU791w+9Ydc1Tkpy9
         2xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzD1cCzWs9VPUJh096MAEgvDhKt7t9nN1p2Sdoa1ilI=;
        b=cK2sn1Ev09Rl5S1I/yVyrKXSmFBTGbl9MzMtIVX03jTS/5QhNYVkFkxoQmdLZ1X+Y4
         P2L7taITSK++2jvNPmyA9Sg/6cByt0OKGJjUjbHfDmMsMH5o4PKKKH+eKUHzhVkykCSm
         apREBaBM2TV1fW3KMWnzl0KBqxs1dGPYrQOf6HvoldxBxfsycr9OhIyH+RI0KNN9gdVB
         IGc3u7pmmuO/5iVyZDo/OzRL5x9Q7wAq5K1p24v3YIv3o06DOzoRL0NhxpdG0eR5fsbs
         hegNFCMQmr8xFq7B82VsVPyXWYNtBVPuMI0QmXhyztMemle2VlM0o0JgtU06LzSEE7kD
         FfZg==
X-Gm-Message-State: ACrzQf2w5rtPybA+GgASACXmSJFDPCUNi6UQFBi4Nqx2hzgbq03SkWVH
        as5fJhrCK5SbJDEWwKTa7gUldmiDJTVe0g==
X-Google-Smtp-Source: AMsMyM5KWoA7PzXAdmqjFnVHt9pS+9mhCvj5GTYzWhrOcwa4hxYZ/ktn/7Nx6jJ4lodVlmqfEz/zkw==
X-Received: by 2002:a05:600c:4e0e:b0:3c6:fbc5:e2c3 with SMTP id b14-20020a05600c4e0e00b003c6fbc5e2c3mr14641096wmq.120.1667122968064;
        Sun, 30 Oct 2022 02:42:48 -0700 (PDT)
Received: from localhost (109-186-183-118.bb.netvision.net.il. [109.186.183.118])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5547000000b00228daaa84aesm3685905wrw.25.2022.10.30.02.42.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Oct 2022 02:42:47 -0700 (PDT)
From:   Eli Billauer <eli.billauer@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imv4bel@gmail.com,
        stern@rowland.harvard.edu, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH v2] char: xillybus: Prevent use-after-free due to race condition
Date:   Sun, 30 Oct 2022 11:42:09 +0200
Message-Id: <20221030094209.65916-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for XillyUSB devices maintains a kref reference count on each
xillyusb_dev structure, which represents a physical device. This reference
count reaches zero when the device has been disconnected and there are no
open file descriptors that are related to the device. When this occurs,
kref_put() calls cleanup_dev(), which clears up the device's data,
including the structure itself.

However, when xillyusb_open() is called, this reference count becomes
tricky: This function needs to obtain the xillyusb_dev structure that
relates to the inode's major and minor (as there can be several such).
xillybus_find_inode() (which is defined in xillybus_class.c) is called
for this purpose. xillybus_find_inode() holds a mutex that is global in
xillybus_class.c to protect the list of devices, and releases this
mutex before returning. As a result, nothing protects the xillyusb_dev's
reference counter from being decremented to zero before xillyusb_open()
increments it on its own behalf. Hence the structure can be freed
due to a rare race condition.

To solve this, a mutex is added. It is locked by xillyusb_open() before
the call to xillybus_find_inode() and is released only after the kref
counter has been incremented on behalf of the newly opened inode. This
protects the kref reference counters of all xillyusb_dev structs from
being decremented by xillyusb_disconnect() during this time segment, as
the call to kref_put() in this function is done with the same lock held.

There is no need to hold the lock on other calls to kref_put(), because
if xillybus_find_inode() finds a struct, xillyusb_disconnect() has not
made the call to remove it, and hence not made its call to kref_put(),
which takes place afterwards. Hence preventing xillyusb_disconnect's
call to kref_put() is enough to ensure that the reference doesn't reach
zero before it's incremented by xillyusb_open().

It would have been more natural to increment the reference count in
xillybus_find_inode() of course, however this function is also called by
Xillybus' driver for PCIe / OF, which registers a completely different
structure. Therefore, xillybus_find_inode() treats these structures as
void pointers, and accordingly can't make any changes.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---

Notes:
    Changelog:
    
    v2
      -- Rewrite completely: Instead of juggling with a mutex, add a new
         one.

 drivers/char/xillybus/xillyusb.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 39bcbfd908b4..5a5afa14ca8c 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -184,6 +184,14 @@ struct xillyusb_dev {
 	struct mutex process_in_mutex; /* synchronize wakeup_all() */
 };
 
+/*
+ * kref_mutex is used in xillyusb_open() to prevent the xillyusb_dev
+ * struct from being freed during the gap between being found by
+ * xillybus_find_inode() and having its reference count incremented.
+ */
+
+static DEFINE_MUTEX(kref_mutex);
+
 /* FPGA to host opcodes */
 enum {
 	OPCODE_DATA = 0,
@@ -1237,9 +1245,16 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	int rc;
 	int index;
 
+	mutex_lock(&kref_mutex);
+
 	rc = xillybus_find_inode(inode, (void **)&xdev, &index);
-	if (rc)
+	if (rc) {
+		mutex_unlock(&kref_mutex);
 		return rc;
+	}
+
+	kref_get(&xdev->kref);
+	mutex_unlock(&kref_mutex);
 
 	chan = &xdev->channels[index];
 	filp->private_data = chan;
@@ -1275,8 +1290,6 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	    ((filp->f_mode & FMODE_WRITE) && chan->open_for_write))
 		goto unmutex_fail;
 
-	kref_get(&xdev->kref);
-
 	if (filp->f_mode & FMODE_READ)
 		chan->open_for_read = 1;
 
@@ -1413,6 +1426,7 @@ static int xillyusb_open(struct inode *inode, struct file *filp)
 	return rc;
 
 unmutex_fail:
+	kref_put(&xdev->kref, cleanup_dev);
 	mutex_unlock(&chan->lock);
 	return rc;
 }
@@ -2227,7 +2241,9 @@ static void xillyusb_disconnect(struct usb_interface *interface)
 
 	xdev->dev = NULL;
 
+	mutex_lock(&kref_mutex);
 	kref_put(&xdev->kref, cleanup_dev);
+	mutex_unlock(&kref_mutex);
 }
 
 static struct usb_driver xillyusb_driver = {
-- 
2.17.1

