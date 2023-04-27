Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E026F06B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbjD0NeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243615AbjD0Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F731B8;
        Thu, 27 Apr 2023 06:33:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0099A1FE31;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66U18+mtQGCyxXC0M1Viz0RN7ENmrIwJoeJCXyBN1ds=;
        b=NmejHtbin+lt361qaGQBDureWP0SETBpWpDhTqTc9Y3QRGtPbcvm1Jio13dAjE+KK0DAUQ
        0KjV/tLxF5PFRj0jORn7gPVcZALgcLmGAa3SiZ9G6aTu0oxh97D7muMS8eFdDGGoGhFCHw
        ZE4eKXOKjF9E5RBgjD/xj5p8qbt/uT0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABCC2138F9;
        Thu, 27 Apr 2023 13:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EkMKMJ5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:54 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4/8] pcwd_usb: do not leave a freed URB active
Date:   Thu, 27 Apr 2023 15:33:46 +0200
Message-Id: <20230427133350.31064-5-oneukum@suse.com>
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

Fix disconnect so that the URB is killed.
Not doing so leaves this to error handling
in the case of physical disconnect.
This fixes the case of a soft disconnect
and prevents multiple accesses to freed
memory.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index ed3be8926a15..fe58ec84ce8c 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -815,6 +815,7 @@ static void usb_pcwd_disconnect(struct usb_interface *interface)
 
 	/* We should now stop communicating with the USB PCWD device */
 	usb_pcwd->exists = 0;
+	usb_kill_urb(usb_pcwd->intr_urb);
 
 	/* Deregister */
 	misc_deregister(&usb_pcwd_miscdev);
-- 
2.40.0

