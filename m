Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE76AC747
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCFQGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjCFQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:01:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044F42E813;
        Mon,  6 Mar 2023 08:01:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9145522285;
        Mon,  6 Mar 2023 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEhBpN6twqC93ccGiwa5lzYv6YauDqAwC362BxH6GVI=;
        b=Ut4v9Yp+wjwadONFNsyMBXo+mZuvnX1hNTwxN5+cjhS2okVvDS88iMnL9ULbLKMeJBvbqt
        9uPkKM/Pj80pMIbKiwu3v9dwwEkSx29N8JQPI+tDGeSzwzGd6BCYfpIcBn4A+tYbHFTWsL
        ai2eg21TdqQA0G3W6G7X1eyn9O4/yqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118458;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEhBpN6twqC93ccGiwa5lzYv6YauDqAwC362BxH6GVI=;
        b=YimuZxKPDn8Mnu7nQeQbXeW4UjY4rPWmFD3/5m6LKna2JANBJ2sb8WycuUXUQuRAk+NEBT
        JM1YQiGjrwFc3XDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EA8B13A6A;
        Mon,  6 Mar 2023 16:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aP94BjoOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:58 +0000
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
Subject: [PATCH 88/99] fbdev/uvesafb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 17:00:05 +0100
Message-Id: <20230306160016.4459-89-tzimmermann@suse.de>
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
 drivers/video/fbdev/uvesafb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 201f6bba0763..aada6a44380c 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cmdline.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -1808,16 +1809,14 @@ static struct platform_driver uvesafb_driver = {
 static struct platform_device *uvesafb_device;
 
 #ifndef MODULE
-static int uvesafb_setup(char *options)
+static int uvesafb_setup(const char *options)
 {
-	char *this_opt;
+	struct option_iter iter;
+	const char *this_opt;
 
-	if (!options || !*options)
-		return 0;
-
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt) continue;
+	option_iter_init(&iter, options);
 
+	while (option_iter_next(&iter, this_opt)) {
 		if (!strcmp(this_opt, "redraw"))
 			ypan = 0;
 		else if (!strcmp(this_opt, "ypan"))
@@ -1865,6 +1864,8 @@ static int uvesafb_setup(char *options)
 		}
 	}
 
+	option_iter_release(&iter);
+
 	if (mtrr != 3 && mtrr != 0)
 		pr_warn("uvesafb: mtrr should be set to 0 or 3; %d is unsupported", mtrr);
 
-- 
2.39.2

