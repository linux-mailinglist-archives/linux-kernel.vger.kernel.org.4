Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8A6AC6FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjCFQC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjCFQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23082ED7E;
        Mon,  6 Mar 2023 08:00:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9702F1FE12;
        Mon,  6 Mar 2023 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4+KAj7O++Yi5vpFwEv8UDUdYndu+GaxZcmBs3XLVsE=;
        b=MrrOCooNoOqiaDI3UBCDwQqRxu3KrZ8Xsu4FCuqHqFzGzItpU9rPmy5vAqKreZ94PyobG8
        9JISjYQgvab3QMCF23iM2n03F+YpGq50XYQVx+cySGutUKX9YhXW/7Hb8GUw5KuDKGAaZO
        ufQ8j2kDuJMP9TciQE3jZPSoAOTnTpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118437;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4+KAj7O++Yi5vpFwEv8UDUdYndu+GaxZcmBs3XLVsE=;
        b=6B4wSnDCF8D3W0DJ/OHeovnr378np44tRR49XRk1NaRoCsVMj9txmnXfuy1IThDxLyCHSF
        ozR+mQmTatZbKwDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D96913513;
        Mon,  6 Mar 2023 16:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2DUvDiUOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:37 +0000
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
Subject: [PATCH 35/99] fbdev/i810: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:59:12 +0100
Message-Id: <20230306160016.4459-36-tzimmermann@suse.de>
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
 drivers/video/fbdev/i810/i810_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index 66f94dfaef16..3e624522fe7a 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -29,6 +29,7 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -1958,14 +1959,15 @@ static void i810fb_find_init_mode(struct fb_info *info)
 }
 
 #ifndef MODULE
-static int i810fb_setup(char *options)
+static int i810fb_setup(const char *options)
 {
-	char *this_opt, *suffix = NULL;
+	char *suffix = NULL;
+	struct option_iter iter;
+	const char *this_opt;
 
-	if (!options || !*options)
-		return 0;
+	option_iter_init(&iter, options);
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
+	while (option_iter_next(&iter, this_opt)) {
 		if (!strncmp(this_opt, "mtrr", 4))
 			mtrr = true;
 		else if (!strncmp(this_opt, "accel", 5))
@@ -2014,6 +2016,9 @@ static int i810fb_setup(char *options)
 			mode_option = mode_option_buf;
 		}
 	}
+
+	option_iter_release(&iter);
+
 	return 0;
 }
 #endif
-- 
2.39.2

