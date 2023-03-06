Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3A6AC722
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCFQEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCFQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18062FCF9;
        Mon,  6 Mar 2023 08:00:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84D802240C;
        Mon,  6 Mar 2023 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yPnSkbz5tA4uAxISnCkR1RSi8OF61H7RsXEqS6C5Nk=;
        b=w+n+ch+QtZ/PrnUkjqkuUkxbbK4eWiCtDZ1wwhbOhcw/lecYrodPTBgW7kprX3fl9w7gqK
        V6WByqkcEfh1aYAT2LWCRovEHtzzp/c71upUeUG4gBOzSZ2C5FTzDvZxuH2sUzDnqc1n5d
        7vtIHZuwTeZjhAHQiyp9wJ3l03/5zts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yPnSkbz5tA4uAxISnCkR1RSi8OF61H7RsXEqS6C5Nk=;
        b=AkGWwV+A7HRbMxnQAQxcJsFEy1RoWlLDfYJASmlbsqLlTzVl+9PsMt7D1AaoKTwf7WSrA1
        3YjAu9z42XtbYVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2718C13A6A;
        Mon,  6 Mar 2023 16:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6K5vCC8OBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:47 +0000
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
Subject: [PATCH 60/99] fbdev/pm3fb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:59:37 +0100
Message-Id: <20230306160016.4459-61-tzimmermann@suse.de>
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
 drivers/video/fbdev/pm3fb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index d0a2cf623c60..4eec0ad1e984 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -1509,18 +1510,16 @@ MODULE_DEVICE_TABLE(pci, pm3fb_id_table);
  * Only necessary if your driver takes special options,
  * otherwise we fall back on the generic fb_setup().
  */
-static int __init pm3fb_setup(char *options)
+static int __init pm3fb_setup(const char *options)
 {
-	char *this_opt;
+	struct option_iter iter;
+	const char *this_opt;
 
 	/* Parse user specified options (`video=pm3fb:') */
-	if (!options || !*options)
-		return 0;
+	option_iter_init(&iter, options);
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt)
-			continue;
-		else if (!strncmp(this_opt, "noaccel", 7))
+	while (option_iter_next(&iter, this_opt)) {
+		if (!strncmp(this_opt, "noaccel", 7))
 			noaccel = 1;
 		else if (!strncmp(this_opt, "hwcursor=", 9))
 			hwcursor = simple_strtoul(this_opt + 9, NULL, 0);
@@ -1538,6 +1537,9 @@ static int __init pm3fb_setup(char *options)
 			mode_option = mode_option_buf;
 		}
 	}
+
+	option_iter_release(&iter);
+
 	return 0;
 }
 #endif /* MODULE */
-- 
2.39.2

