Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EABD6B2A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjCIQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjCIQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A913BF8A6A;
        Thu,  9 Mar 2023 08:02:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00FC72216F;
        Thu,  9 Mar 2023 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ahzg3qOQnqmKttHmLkku+DucBs/UrBngr7lLUmjxogk=;
        b=dsmfX3KGntHoLUbrAb5ZH4Y5RErDBIpwAd9ocfT3wu+mIu6MZKjjfRe8/1VtyntpFS0r3x
        Mg30vrvB/5N3vCIy5KfkrMS/3TA9fj7ISDo+mm47IwuFDor8aFMLZahcxdWhQqpijTqX1D
        ASmtqkIbvurk0UvylHMeUp9XTY1pSGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ahzg3qOQnqmKttHmLkku+DucBs/UrBngr7lLUmjxogk=;
        b=IKULeMJxZk8V041juSJKWX9+yvDz4Jltpvsy36rLCi+W8/Ps/PJD06/aKcM/yUeQoGjria
        gSXhUGqwNlmrCVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 926871391B;
        Thu,  9 Mar 2023 16:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eDLJIiADCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:40 +0000
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
Subject: [PATCH v2 090/101] fbdev/valkyriefb: Parse option string with struct option_iter
Date:   Thu,  9 Mar 2023 17:01:50 +0100
Message-Id: <20230309160201.5163-91-tzimmermann@suse.de>
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

Use struct option_iter to walk over the individual options in the
driver's option string. Replaces the hand-written strsep() loop with
a clean interface. The helpers for struct option_iter handle empty
option strings and empty options transparently. The struct's _init
and _release functions duplicate and release the option string's
memory buffer as needed.

Done in preparation of constifying the option string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/valkyriefb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index b166b7cfe0e5..3c20f392370a 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -39,6 +39,7 @@
  *  more details.
  */
 
+#include <linux/cmdline.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -90,7 +91,7 @@ struct fb_info_valkyrie {
 	u32			pseudo_palette[16];
 };
 
-static int valkyriefb_setup(char*);
+static int valkyriefb_setup(const char *options);
 
 static int valkyriefb_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info);
@@ -545,14 +546,14 @@ static int __init valkyrie_init_info(struct fb_info *info,
 /*
  * Parse user specified options (`video=valkyriefb:')
  */
-static int __init valkyriefb_setup(char *options)
+static int __init valkyriefb_setup(const char *options)
 {
+	struct option_iter iter;
 	char *this_opt;
 
-	if (!options || !*options)
-		return 0;
+	option_iter_init(&iter, options);
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
+	while (option_iter_next(&iter, &this_opt)) {
 		if (!strncmp(this_opt, "vmode:", 6)) {
 	    		int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX)
@@ -571,6 +572,9 @@ static int __init valkyriefb_setup(char *options)
 			}
 		}
 	}
+
+	option_iter_release(&iter);
+
 	return 0;
 }
 
-- 
2.39.2

