Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40C6F06AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbjD0NeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjD0Nd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC0C18C;
        Thu, 27 Apr 2023 06:33:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4618921B3F;
        Thu, 27 Apr 2023 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wd+p9adp/HcJc7Th+S4UjCWxhF9jWQwIyXD1bb94NMQ=;
        b=AUJ1nVH4EOHXydXh/4AKbyc0BIWTEHLyZn9UrXn55dRnYE47NbYsflM0l2laC2wzXzsGUV
        sUhG5YzbfNBIo3CEx8HVgSw5Zqw1WFe+DArS7i+h5kaR/66D8dzUNtpSMur3RNjZ30l+3A
        7cPnR9bOr8KUt6uidQN1noEaY1HDGwg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00092138F9;
        Thu, 27 Apr 2023 13:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yF7wOMF5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:53 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 2/8] pcwd_usb: stop open race disconnect
Date:   Thu, 27 Apr 2023 15:33:44 +0200
Message-Id: <20230427133350.31064-3-oneukum@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427133350.31064-1-oneukum@suse.com>
References: <20230427133350.31064-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a mutex already taken in disconnect.
And it even has the correct comment.
It just has to be taken in open and disconnect, too,
to prevent the race.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 3a22291d633b..d5d68a529620 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -476,14 +476,21 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 
 static int usb_pcwd_open(struct inode *inode, struct file *file)
 {
+	int retval = -EBUSY;
+
+	mutex_lock(&disconnect_mutex);
 	/* /dev/watchdog can only be opened once */
 	if (test_and_set_bit(0, &is_active))
-		return -EBUSY;
+		goto error;
 
 	/* Activate */
 	usb_pcwd_start(usb_pcwd_device);
 	usb_pcwd_keepalive(usb_pcwd_device);
-	return stream_open(inode, file);
+	retval = stream_open(inode, file);
+
+error:
+	mutex_unlock(&disconnect_mutex);
+	return retval;
 }
 
 static int usb_pcwd_release(struct inode *inode, struct file *file)
@@ -522,7 +529,13 @@ static ssize_t usb_pcwd_temperature_read(struct file *file, char __user *data,
 
 static int usb_pcwd_temperature_open(struct inode *inode, struct file *file)
 {
-	return stream_open(inode, file);
+	int retval;
+
+	mutex_lock(&disconnect_mutex);
+	retval = stream_open(inode, file);
+	mutex_unlock(&disconnect_mutex);
+
+	return retval;
 }
 
 static int usb_pcwd_temperature_release(struct inode *inode, struct file *file)
-- 
2.40.0

