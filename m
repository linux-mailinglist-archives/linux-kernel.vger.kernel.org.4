Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F316AC6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCFQCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCFQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C12E0FB;
        Mon,  6 Mar 2023 08:00:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9BCE223B8;
        Mon,  6 Mar 2023 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEiS628a+gvdqwiq6tmn4mXS8MTIkCO8G82VtcnGElY=;
        b=dX8GA3Zmo6YD1+zNtueih3J4rETzzjRTqyuUkOb20PDnlUGLN4RJ/+tZwKpMK95QRQE4j+
        NXO6UypxHvk7HsFEzmEOSbs5j24wY63bfvLbAt9GcjpqN5Qgf/aQhDDe+v2o6SQ68xQib8
        shvm9dSkb3Hr8vyE9WpCjeKjFRZRZ+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEiS628a+gvdqwiq6tmn4mXS8MTIkCO8G82VtcnGElY=;
        b=E5EiM8xHnCfGfy0KnDuv0lmlhGhpYGyaq8BYXqQSyMOwo1p3meL38IVFDFCSGpg934Mac0
        kUw28k6uge0wrmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 797E313A6A;
        Mon,  6 Mar 2023 16:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IHHeHB8OBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:31 +0000
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
Subject: [PATCH 20/99] fbdev/efifb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:58:57 +0100
Message-Id: <20230306160016.4459-21-tzimmermann@suse.de>
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
 drivers/video/fbdev/efifb.c | 46 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index a5779fb453a2..1ae7574aaa82 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/efi-bgrt.h>
@@ -284,31 +285,32 @@ static const struct fb_ops efifb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static int efifb_setup(char *options)
+static int efifb_setup(const char *options)
 {
-	char *this_opt;
-
-	if (options && *options) {
-		while ((this_opt = strsep(&options, ",")) != NULL) {
-			if (!*this_opt) continue;
-
-			efifb_setup_from_dmi(&screen_info, this_opt);
-
-			if (!strncmp(this_opt, "base:", 5))
-				screen_info.lfb_base = simple_strtoul(this_opt+5, NULL, 0);
-			else if (!strncmp(this_opt, "stride:", 7))
-				screen_info.lfb_linelength = simple_strtoul(this_opt+7, NULL, 0) * 4;
-			else if (!strncmp(this_opt, "height:", 7))
-				screen_info.lfb_height = simple_strtoul(this_opt+7, NULL, 0);
-			else if (!strncmp(this_opt, "width:", 6))
-				screen_info.lfb_width = simple_strtoul(this_opt+6, NULL, 0);
-			else if (!strcmp(this_opt, "nowc"))
-				mem_flags &= ~EFI_MEMORY_WC;
-			else if (!strcmp(this_opt, "nobgrt"))
-				use_bgrt = false;
-		}
+	struct option_iter iter;
+	const char *this_opt;
+
+	option_iter_init(&iter, options);
+
+	while (option_iter_next(&iter, this_opt)) {
+		efifb_setup_from_dmi(&screen_info, this_opt);
+
+		if (!strncmp(this_opt, "base:", 5))
+			screen_info.lfb_base = simple_strtoul(this_opt+5, NULL, 0);
+		else if (!strncmp(this_opt, "stride:", 7))
+			screen_info.lfb_linelength = simple_strtoul(this_opt+7, NULL, 0) * 4;
+		else if (!strncmp(this_opt, "height:", 7))
+			screen_info.lfb_height = simple_strtoul(this_opt+7, NULL, 0);
+		else if (!strncmp(this_opt, "width:", 6))
+			screen_info.lfb_width = simple_strtoul(this_opt+6, NULL, 0);
+		else if (!strcmp(this_opt, "nowc"))
+			mem_flags &= ~EFI_MEMORY_WC;
+		else if (!strcmp(this_opt, "nobgrt"))
+			use_bgrt = false;
 	}
 
+	option_iter_release(&iter);
+
 	return 0;
 }
 
-- 
2.39.2

