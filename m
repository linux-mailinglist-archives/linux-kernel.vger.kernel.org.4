Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778E56AC691
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCFQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCFQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B560728879;
        Mon,  6 Mar 2023 08:00:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7515C223B5;
        Mon,  6 Mar 2023 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Maka02GpjBPu0U5NCBjoSssgaATU0MBLIYe2pP3DK5E=;
        b=Q61VwCzNyrn+qGYMP0+l+bsNoqXWXFAjijkCeqXJH+UtFBh5a2z2vFY3Bbw0558Qrorcev
        GWAF/0Kl5vmydFmQzb3ohGQX16qUH/UXXWsHLZ8zS8FDLbE5+Cy6lZiUOTd3rfpL92cifD
        4ggP7sccGpFAk9OFQmdQ260I4MWMjzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Maka02GpjBPu0U5NCBjoSssgaATU0MBLIYe2pP3DK5E=;
        b=CnNrnz6CzTUIsFppWTdn4lA6p5yBImUwgrHMKjHqNWv8/0nXDqPQH6l/fTtC+bzkuwD1BC
        JXcnfnYoS2EPMkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 223B813513;
        Mon,  6 Mar 2023 16:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0EdyBx8OBmQ/PwAAMHmgww
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
Subject: [PATCH 19/99] fbdev/cyber2000fb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:58:56 +0100
Message-Id: <20230306160016.4459-20-tzimmermann@suse.de>
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
 drivers/video/fbdev/cyber2000fb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 38c0a6866d76..939dde664b53 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -34,6 +34,7 @@
  * entering standby mode.)
  */
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -1486,17 +1487,14 @@ static void cyberpro_free_fb_info(struct cfb_info *cfb)
  *  video=cyber2000:font:fontname
  */
 #ifndef MODULE
-static int cyber2000fb_setup(char *options)
+static int cyber2000fb_setup(const char *options)
 {
-	char *opt;
+	struct option_iter iter;
+	const char *opt;
 
-	if (!options || !*options)
-		return 0;
-
-	while ((opt = strsep(&options, ",")) != NULL) {
-		if (!*opt)
-			continue;
+	option_iter_init(&iter, options);
 
+	while (option_iter_next(&iter, opt)) {
 		if (strncmp(opt, "font:", 5) == 0) {
 			static char default_font_storage[40];
 
@@ -1508,6 +1506,9 @@ static int cyber2000fb_setup(char *options)
 
 		printk(KERN_ERR "CyberPro20x0: unknown parameter: %s\n", opt);
 	}
+
+	option_iter_release(&iter);
+
 	return 0;
 }
 #endif  /*  MODULE  */
-- 
2.39.2

