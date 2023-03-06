Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20B26AC752
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjCFQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCFQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:01:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14242410D;
        Mon,  6 Mar 2023 08:01:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8513B22464;
        Mon,  6 Mar 2023 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yTAZ+fWm46H8QqfoRrnwlZTk5mIqjHDcgi+SJhTWtw=;
        b=Br3YluVLuR6Ry7K8JR11i7Y6BwJ19Dy/SS6WvZZAGFao7VqxeQstljX9BKQYatqUH2U3rH
        axSSd2rIfWBlmyfaMa12nNRbc/B5dJqqSdy25DF0nC1nEAOXc9jMTwPnxZ1BSMYnR/T49x
        CPQiy+jEp9/hwLaVA9unYphnWPW5HHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yTAZ+fWm46H8QqfoRrnwlZTk5mIqjHDcgi+SJhTWtw=;
        b=MLgmOCvBzQ+4wPhXhi5GV8EsH1wxUxxiGUfGTH6NUSq1yo7nucXwNLckj5yvLlXfHg6gu2
        1YwmvZcohBoEQVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C7AE13A6A;
        Mon,  6 Mar 2023 16:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uHMGCj4OBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:01:02 +0000
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
Subject: [PATCH 98/99] staging/sm750fb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 17:00:15 +0100
Message-Id: <20230306160016.4459-99-tzimmermann@suse.de>
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
 drivers/staging/sm750fb/sm750.c | 43 +++++++++++++++++----------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index effc7fcc3703..2eb223f0631e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -867,9 +868,10 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 }
 
 /*	chip specific g_option configuration routine */
-static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
+static void sm750fb_setup(struct sm750_dev *sm750_dev, const char *src)
 {
-	char *opt;
+	struct option_iter iter;
+	const char *opt;
 	int swap;
 
 	swap = 0;
@@ -889,9 +891,12 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		goto NO_PARAM;
 	}
 
-	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
+	dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
+
+	option_iter_init(&iter, src);
+
+	while (option_iter_next(&iter, opt)) {
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
-		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
 		if (!strncmp(opt, "swap", strlen("swap"))) {
 			swap = 1;
@@ -924,6 +929,8 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		}
 	}
 
+	option_iter_release(&iter);
+
 NO_PARAM:
 	if (sm750_dev->revid != SM750LE_REVISION_ID) {
 		if (sm750_dev->fb_count > 1) {
@@ -1096,10 +1103,12 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	kfree(g_settings);
 }
 
-static int __init lynxfb_setup(char *options)
+static int __init lynxfb_setup(const char *options)
 {
+	struct option_iter iter;
+	const char *opt;
 	int len;
-	char *opt, *tmp;
+	char *tmp;
 
 	if (!options || !*options) {
 		pr_warn("no options.\n");
@@ -1112,19 +1121,11 @@ static int __init lynxfb_setup(char *options)
 	g_settings = kzalloc(len, GFP_KERNEL);
 	if (!g_settings)
 		return -ENOMEM;
-
 	tmp = g_settings;
 
-	/*
-	 * Notes:
-	 * char * strsep(char **s,const char * ct);
-	 * @s: the string to be searched
-	 * @ct :the characters to search for
-	 *
-	 * strsep() updates @options to pointer after the first found token
-	 * it also returns the pointer ahead the token.
-	 */
-	while ((opt = strsep(&options, ":")) != NULL) {
+	option_iter_init(&iter, options);
+
+	while (option_iter_next(&iter, opt)) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
 			g_noaccel = 1;
@@ -1133,15 +1134,15 @@ static int __init lynxfb_setup(char *options)
 		} else if (!strncmp(opt, "dual", strlen("dual"))) {
 			g_dualview = 1;
 		} else {
+			if (tmp != g_settings)
+				*tmp++ = ':'; // add separator
 			strcat(tmp, opt);
 			tmp += strlen(opt);
-			if (options)
-				*tmp++ = ':';
-			else
-				*tmp++ = 0;
 		}
 	}
 
+	option_iter_release(&iter);
+
 	/* misc g_settings are transport to chip specific routines */
 	pr_info("parameter left for chip specific analysis:%s\n", g_settings);
 	return 0;
-- 
2.39.2

