Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322F26B2A72
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjCIQJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjCIQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A677F4B7A;
        Thu,  9 Mar 2023 08:02:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1943222168;
        Thu,  9 Mar 2023 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWxZWY+4j2LC2Hx/5MOho9tKeaDUwd+4OyC3KjTGJWQ=;
        b=zd7cerjvtXSD5/ZFuxef9nGjxgvuTB582pMlonjx0j51ZWbIoghzyETfnBO1ogCSBHS+wF
        pm1m+RHKt5wLvznwnAxxdzXSslaqlGdNPM3JVLwcNZTk8QkCG+Twrifylhhs9YB9ESyzmb
        SnFqVtPrZfWNHQ4rLuWfMLE0Y/b6sag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWxZWY+4j2LC2Hx/5MOho9tKeaDUwd+4OyC3KjTGJWQ=;
        b=fqQaqd2BL8XzkymFmmW3qiWauivlafHo91dkqosAWz6s2bUBUVfZRkPtfULXf4jQdZUdCt
        px33SMNQ8sEdt7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF17513A73;
        Thu,  9 Mar 2023 16:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMTAKR0DCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:37 +0000
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
Subject: [PATCH v2 083/101] fbdev/tgafb: Parse option string with struct option_iter
Date:   Thu,  9 Mar 2023 17:01:43 +0100
Message-Id: <20230309160201.5163-84-tzimmermann@suse.de>
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
 drivers/video/fbdev/tgafb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index cf00b8a91bfb..0862d9a54aef 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -14,6 +14,7 @@
 
 #include <linux/aperture.h>
 #include <linux/bitrev.h>
+#include <linux/cmdline.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -1573,25 +1574,24 @@ static void tgafb_exit(void)
 }
 
 #ifndef MODULE
-static int tgafb_setup(char *arg)
+static int tgafb_setup(const char *arg)
 {
+	struct option_iter iter;
 	char *this_opt;
 
-	if (arg && *arg) {
-		while ((this_opt = strsep(&arg, ","))) {
-			if (!*this_opt)
-				continue;
-			if (!strncmp(this_opt, "mode:", 5)) {
-				kfree(mode_option_buf);
-				mode_option_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
-				mode_option = mode_option_buf;
-			} else
-				printk(KERN_ERR
-				       "tgafb: unknown parameter %s\n",
-				       this_opt);
-		}
+	option_iter_init(&iter, arg);
+
+	while (option_iter_next(&iter, &this_opt)) {
+		if (!strncmp(this_opt, "mode:", 5)) {
+			kfree(mode_option_buf);
+			mode_option_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
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

