Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225596AC678
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCFQBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCFQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D72E813;
        Mon,  6 Mar 2023 08:00:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E8131FDF6;
        Mon,  6 Mar 2023 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uk7crcnOtaYz5lnPu5nHcEno5CdLWKHT+UBXQhxUl8A=;
        b=GZXdKU6aEL7CBeCsklgVkmVkIEMmxg5dvY4rPpZZXFYp5mNWFe6RiZvl5BDYpi9UN0DtI5
        qIpUhIkwDwylSmmVcPaCadPGfdUOkn6ll8RQNrWmsRbDF7PD9OcGXq9lrwoh5b9/9ROyIa
        rtiCyUhaVcaIId6N1XHJOnubTk2Uzfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uk7crcnOtaYz5lnPu5nHcEno5CdLWKHT+UBXQhxUl8A=;
        b=Mc7IPHSQBqfzl2cZHYrUjQsreYZzMHsizsnW9xXH+s5PvhaOf8ELhUtJec5g5JKlJ0vnXg
        7t9+6B2a9vT14HBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB6DA13513;
        Mon,  6 Mar 2023 16:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uB6MOBwOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:28 +0000
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
Subject: [PATCH 13/99] fbdev/au1100fb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:58:50 +0100
Message-Id: <20230306160016.4459-14-tzimmermann@suse.de>
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
 drivers/video/fbdev/au1100fb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 519313b8bb00..17dae92ac53f 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -42,6 +42,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/clk.h>
+#include <linux/cmdline.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -365,7 +366,9 @@ static const struct fb_ops au1100fb_ops =
 
 static int au1100fb_setup(struct au1100fb_device *fbdev)
 {
-	char *this_opt, *options;
+	char *options;
+	struct option_iter iter;
+	const char *this_opt;
 	int num_panels = ARRAY_SIZE(known_lcd_panels);
 
 	if (num_panels <= 0) {
@@ -375,10 +378,10 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
 
 	if (fb_get_options(DRIVER_NAME, &options))
 		return -ENODEV;
-	if (!options)
-		return -ENODEV;
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
+	option_iter_init(&iter, options);
+
+	while (option_iter_next(&iter, this_opt)) {
 		/* Panel option */
 		if (!strncmp(this_opt, "panel:", 6)) {
 			int i;
@@ -401,6 +404,8 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
 			print_warn("Unsupported option \"%s\"", this_opt);
 	}
 
+	option_iter_release(&iter);
+
 	print_info("Panel=%s", fbdev->panel->name);
 
 	return 0;
-- 
2.39.2

