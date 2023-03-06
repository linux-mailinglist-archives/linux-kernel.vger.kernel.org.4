Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB66AC740
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjCFQGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjCFQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:01:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EDF34F44;
        Mon,  6 Mar 2023 08:00:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43F5D1FEE3;
        Mon,  6 Mar 2023 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GGmlkKUitP/mPaJwo4DVCYrRiGQzK8ly7VqVkEk13o=;
        b=LHeaDUuqcFLT7mvfjL3Oe2/1UgmRJHfKInYcEKlnvYt4gTrcecvGEXnoNnAJqb35G/SlDv
        nPl1lofsiQ/GLHtiJ6rgy5havdpCwU9WJxddivM0PSECOADY2BIrzW1W45EhJu3rDUdSeL
        XkPTWdMb62Vr0KLMHhq8iLyaxGuyRzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GGmlkKUitP/mPaJwo4DVCYrRiGQzK8ly7VqVkEk13o=;
        b=CgsnbGbmnWvItotHj0adFz0sUs6nZ/rNAfneC3yL5yga7kw0lmaeTHogJ5Fs4t7PAfUWVw
        IZvSo6EYQ983jqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9EF613513;
        Mon,  6 Mar 2023 16:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cNVhMDcOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:55 +0000
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
Subject: [PATCH 83/99] fbdev/tgafb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 17:00:00 +0100
Message-Id: <20230306160016.4459-84-tzimmermann@suse.de>
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
 drivers/video/fbdev/tgafb.c | 45 +++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index a412fdddfd8c..704909edf89d 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -14,6 +14,7 @@
 
 #include <linux/aperture.h>
 #include <linux/bitrev.h>
+#include <linux/cmdline.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -1571,35 +1572,31 @@ static void tgafb_exit(void)
 }
 
 #ifndef MODULE
-static int tgafb_setup(char *arg)
+static int tgafb_setup(const char *arg)
 {
-	char *this_opt;
+	struct option_iter iter;
+	const char *this_opt;
 
-	if (arg && *arg) {
-		while ((this_opt = strsep(&arg, ","))) {
-			if (!*this_opt)
+	option_iter_init(&iter, arg);
+
+	while (option_iter_next(&iter, this_opt)) {
+		if (!strncmp(this_opt, "mode:", 5)) {
+			static char mode_option_buf[256];
+			int ret;
+
+			ret = snprintf(mode_option_buf, sizeof(mode_option_buf), "%s",
+				       this_opt + 5);
+			if (WARN(ret < 0, "tgafb: ignoring invalid option, ret=%d\n", ret))
 				continue;
-			if (!strncmp(this_opt, "mode:", 5)) {
-				static char mode_option_buf[256];
-				int ret;
-
-				ret = snprintf(mode_option_buf, sizeof(mode_option_buf), "%s",
-					       this_opt + 5);
-				if (WARN(ret < 0,
-					 "tgafb: ignoring invalid option, ret=%d\n",
-					 ret))
-					continue;
-				if (WARN(ret >= sizeof(mode_option_buf),
-					 "tgafb: option too long\n"))
-					continue;
-				mode_option = mode_option_buf;
-			} else
-				printk(KERN_ERR
-				       "tgafb: unknown parameter %s\n",
-				       this_opt);
-		}
+			if (WARN(ret >= sizeof(mode_option_buf), "tgafb: option too long\n"))
+				continue;
+			mode_option = mode_option_buf;
+		} else
+			printk(KERN_ERR "tgafb: unknown parameter %s\n", this_opt);
 	}
 
+	option_iter_release(&iter);
+
 	return 0;
 }
 #endif /* !MODULE */
-- 
2.39.2

