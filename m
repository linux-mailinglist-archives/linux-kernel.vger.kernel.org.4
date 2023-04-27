Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800296F06B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbjD0NeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243468AbjD0Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF261B6;
        Thu, 27 Apr 2023 06:33:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CDDC1FE30;
        Thu, 27 Apr 2023 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRTL1UYeG/HJ79maMI4g+9suosfMF/LSWnK6uB4WtfE=;
        b=d/3a0Oukan4rztYhRdqMyyGVTNpRNILrs1urUQIbNYvRpQuwN+C/OELKIISyYEJONEpobn
        4mbLLOePgMOH735dCfuAS5I/DAMfiAATTAIsIhswe1/l/6LlfDPM016gqYaLkwghuGTgaT
        XAdRbXOVk36XN2GFZp3YDmLaDUECmtQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 533AC138F9;
        Thu, 27 Apr 2023 13:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IK4BEsJ5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:54 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 3/8] pcwd_usb: usb_pcwd_open handle and return errors
Date:   Thu, 27 Apr 2023 15:33:45 +0200
Message-Id: <20230427133350.31064-4-oneukum@suse.com>
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

Operations on the bus can suffer an IO error.
Handle it undoing partial operations and return
it to user space

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index d5d68a529620..ed3be8926a15 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -273,7 +273,7 @@ static int usb_pcwd_start(struct usb_pcwd_private *usb_pcwd)
 
 	if ((retval == 0) || (lsb == 0)) {
 		pr_err("Card did not acknowledge enable attempt\n");
-		return -1;
+		return -EIO;
 	}
 
 	return 0;
@@ -484,10 +484,22 @@ static int usb_pcwd_open(struct inode *inode, struct file *file)
 		goto error;
 
 	/* Activate */
-	usb_pcwd_start(usb_pcwd_device);
-	usb_pcwd_keepalive(usb_pcwd_device);
+	retval = usb_pcwd_start(usb_pcwd_device);
+	if (retval < 0)
+		goto err_bail;
+	retval = usb_pcwd_keepalive(usb_pcwd_device);
+	if (retval < 0)
+		goto err_bail_and_stop;
 	retval = stream_open(inode, file);
+	if (retval < 0)
+		goto err_bail_and_stop;
+	mutex_unlock(&disconnect_mutex);
+	return retval;
 
+err_bail_and_stop:
+	usb_pcwd_stop(usb_pcwd_device);
+err_bail:
+	clear_bit(0, &is_active);
 error:
 	mutex_unlock(&disconnect_mutex);
 	return retval;
-- 
2.40.0

