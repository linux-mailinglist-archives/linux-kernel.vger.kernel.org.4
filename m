Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B146F06B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbjD0NeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243618AbjD0Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F7E48;
        Thu, 27 Apr 2023 06:33:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CB0521B40;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rGz1l1uLq4Eq57pl2TyE1vJ2RUc3Gpmtm+3jwEAOK8=;
        b=uruuRKW4koGd2EIxG245KlByD6Z0p4TOVjH06eIK/3BFSDlMs3qxZN4henqSYK1V1ZWSLw
        PIKqzimQrPYWRnJHsY4z0PPAm3ASCqYxm5uktpUfu8poVS/FUULiBdCjazz9s8umGD3nIJ
        oc3iVuYN7KWsyBZlMcvwzqUQ/QRPTJo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09E93138F9;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yCO+AMN5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:55 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 5/8] pcwd_usb: usb_pcwd_ioctl: return IO errors
Date:   Thu, 27 Apr 2023 15:33:47 +0200
Message-Id: <20230427133350.31064-6-oneukum@suse.com>
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

Reporting back to user space that a watchdog
is disabled although it is not due to an IO error
is evil. Pass through errors.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index fe58ec84ce8c..b99b8fee2873 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -420,22 +420,30 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
 
 	case WDIOC_SETOPTIONS:
 	{
-		int new_options, retval = -EINVAL;
+		int new_options, retval = 0;
+		int r;
+		bool specified_something = false;
 
 		if (get_user(new_options, p))
 			return -EFAULT;
 
 		if (new_options & WDIOS_DISABLECARD) {
-			usb_pcwd_stop(usb_pcwd_device);
-			retval = 0;
+			r = usb_pcwd_stop(usb_pcwd_device);
+			retval = r < 0 ? -EIO : 0;
+			specified_something = true;
 		}
 
+		/*
+		 * technically both options are combinable
+		 * that makes error reporting tricky
+		 */
 		if (new_options & WDIOS_ENABLECARD) {
-			usb_pcwd_start(usb_pcwd_device);
-			retval = 0;
+			r = usb_pcwd_start(usb_pcwd_device);
+			retval = retval < 0 ? retval : (r < 0 ? -EIO : 0);
+			specified_something = true;
 		}
 
-		return retval;
+		return specified_something ? retval : -EINVAL;
 	}
 
 	case WDIOC_KEEPALIVE:
-- 
2.40.0

