Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104766AC716
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCFQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCFQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FCF34F7E;
        Mon,  6 Mar 2023 08:00:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 338261FE82;
        Mon,  6 Mar 2023 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGLBLBg3pdJVJ0Ef7zMg0fUWatn8Nn9plsu006L4xGY=;
        b=rGbS6q1dbhX3Pk7dNvUjpg8lilOZjgiJHNpUw5nxdDRrKvdHY+/1hEn/lLOTcJ6k5cF4v2
        1QgMMBPb3bfiOLBqVpLPk9Ln3fenHy2+Vcv9IcDgd0730zb6rUqU5gQRsbWMoKq+Anxajh
        gig1RRPHv+C7TEa8m2U4BfSYTfIPZzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGLBLBg3pdJVJ0Ef7zMg0fUWatn8Nn9plsu006L4xGY=;
        b=tImxUNXWmu7wTyC7umHvV5pt6XrboNN+O93DgzWYN/JyZLxSNY1wixlU1hhBMVcr+jm1/R
        8Jg2dPER5jD8+MDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD79113A6A;
        Mon,  6 Mar 2023 16:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDtAMSgOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:40 +0000
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
Subject: [PATCH 44/99] fbdev/macfb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:59:21 +0100
Message-Id: <20230306160016.4459-45-tzimmermann@suse.de>
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
 drivers/video/fbdev/macfb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 44ff860a3f37..a72edb98b170 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -20,6 +20,7 @@
  * http://rajsky.psych.nyu.edu/Tips/VideoBugs.html
  */
 
+#include <linux/cmdline.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -504,23 +505,22 @@ static const struct fb_ops macfb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-static void __init macfb_setup(char *options)
+static void __init macfb_setup(const char *options)
 {
-	char *this_opt;
+	struct option_iter iter;
+	const char *this_opt;
 
-	if (!options || !*options)
-		return;
-
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt)
-			continue;
+	option_iter_init(&iter, options);
 
+	while (option_iter_next(&iter, this_opt)) {
 		if (!strcmp(this_opt, "inverse"))
 			fb_invert_cmaps();
 		else
 			if (!strcmp(this_opt, "vidtest"))
 				vidtest = 1; /* enable experimental CLUT code */
 	}
+
+	option_iter_release(&iter);
 }
 
 static void __init iounmap_macfb(void)
-- 
2.39.2

