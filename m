Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3186AC74C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCFQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjCFQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:01:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C0E33463;
        Mon,  6 Mar 2023 08:01:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66A7B1FEFF;
        Mon,  6 Mar 2023 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCuFu5SU57CJHGfgdFQfRit83nbssA/Udz2hcttdwvo=;
        b=W1nzjeHYtW6hzk14lqyszCbBcEyq+8sp1neVZkcFBMWzDWHpoD8hvd9fJ3XnrradACZnRR
        V76iuXULIzy+1BbZuk5joOrpdRBBC4XeTuNp/6Oli/pO5cyLRKWRInJPHx7z8l5wz2cdNC
        BHDp6sWJypFqjb5/34UCDmkWLRk1b/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCuFu5SU57CJHGfgdFQfRit83nbssA/Udz2hcttdwvo=;
        b=P1f84vfZfPvK+9BrjhaXylpZL4FXUF/HeEJ+a5miwhRpk/t6QiJVhJ316MSaNST23ETt/X
        OFH2X0fV9excSxDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A93113A6A;
        Mon,  6 Mar 2023 16:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDilATsOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:59 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@HansenPartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 90/99] fbdev/valkyriefb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 17:00:07 +0100
Message-Id: <20230306160016.4459-91-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306160016.4459-1-tzimmermann@suse.de>
References: <20230306160016.4459-1-tzimmermann@suse.de>
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
 drivers/video/fbdev/valkyriefb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index b166b7cfe0e5..a787b0142d00 100644
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
-	char *this_opt;
+	struct option_iter iter;
+	const char *this_opt;
 
-	if (!options || !*options)
-		return 0;
+	option_iter_init(&iter, options);
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
+	while (option_iter_next(&iter, this_opt)) {
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

