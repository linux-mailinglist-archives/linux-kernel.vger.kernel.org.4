Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C556B2A78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjCIQJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjCIQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA4AF5AAA;
        Thu,  9 Mar 2023 08:02:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7991422169;
        Thu,  9 Mar 2023 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEolRl7Gtp6eBSHcZORJIpDzJ5v2DCmOHbu1CyAwA3Y=;
        b=AV+21/bVPDGAbr8VTqIZjqTw5fFW2X2dMnMFickwpWVWfsJ9W8Czdelk58P8hclKTQVsfr
        nQtXNuzPZMcOVkff5HAhRAKW13TtjUx2gWAlEdFIJPNKlML5K3rUCf+JCm/WnntJNAnVsy
        tXGGZbT+tlwCGTUDcrs5rPfR9acPHnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OEolRl7Gtp6eBSHcZORJIpDzJ5v2DCmOHbu1CyAwA3Y=;
        b=MyGRnIxwQ5h/MHRygWADLYZfzgeWe1uSumvb2FyfsdkD+JY8UL/Rx7c6nweT1Tq2/NcUh1
        CqvYKFVmvLEjr9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E5CB1391B;
        Thu,  9 Mar 2023 16:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gJZ0Bh4DCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:38 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert+renesas@glider.be, timur@kernel.org,
        rdunlap@infradead.org, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, adaplas@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, mbroemme@libmpq.org,
        thomas@winischhofer.net, James.Bottomley@HansenPartnership.com,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 084/101] fbdev/tmiofb: Remove unused option string
Date:   Thu,  9 Mar 2023 17:01:44 +0100
Message-Id: <20230309160201.5163-85-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309160201.5163-1-tzimmermann@suse.de>
References: <20230309160201.5163-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option string is unused. Remove the variable and a related
helper function. No functional change.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/tmiofb.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
index 50111966c981..8920cee52d7f 100644
--- a/drivers/video/fbdev/tmiofb.c
+++ b/drivers/video/fbdev/tmiofb.c
@@ -11,6 +11,7 @@
  *	code written by Sharp/Lineo for 2.4 kernels
  */
 
+#include <linux/cmdline.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -997,32 +998,11 @@ static struct platform_driver tmiofb_driver = {
 
 /*--------------------------------------------------------------------------*/
 
-#ifndef MODULE
-static void __init tmiofb_setup(char *options)
-{
-	char *this_opt;
-
-	if (!options || !*options)
-		return;
-
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt)
-			continue;
-		/*
-		 * FIXME
-		 */
-	}
-}
-#endif
-
 static int __init tmiofb_init(void)
 {
 #ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("tmiofb", &option))
+	if (fb_get_options("tmiofb", NULL))
 		return -ENODEV;
-	tmiofb_setup(option);
 #endif
 	return platform_driver_register(&tmiofb_driver);
 }
-- 
2.39.2

