Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B46B2A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjCIQLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjCIQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:03:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA282F7EDF;
        Thu,  9 Mar 2023 08:02:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3014E21CF8;
        Thu,  9 Mar 2023 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALsO4IX+lXOr2/9jJ7xM7oWEJtpk0lY0JvNUM21acD0=;
        b=ibeXiYlRwFX3kYpd0p9A7lMTdVMC9Fwe5CosSJaVaakK7R2YBZ3fXTlozkbl/UiL5jTS8y
        xXFPFpQgBHAUE6pmwaV+xKG4iGnskk7Y/bPBzSTtL3W77qowzQ6ugXnIq17I+ZiAI5CtbK
        U2JPW0KhaLVuLn52/QgPlViOuwijmU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALsO4IX+lXOr2/9jJ7xM7oWEJtpk0lY0JvNUM21acD0=;
        b=LWt569FfZOyzTosHPQg/ga7WhTjnw20OX+GhU9e53/rp4wj+b9RmbVDPnRjtEZlMaiCGP9
        F9Wa7b7tLTzP6RAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C26901391B;
        Thu,  9 Mar 2023 16:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EDJ2LiQDCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:44 +0000
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
Subject: [PATCH v2 100/101] staging/sm750fb: Parse option string with struct option_iter
Date:   Thu,  9 Mar 2023 17:02:00 +0100
Message-Id: <20230309160201.5163-101-tzimmermann@suse.de>
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

v2:
	* move string handling into separate patches

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/staging/sm750fb/sm750.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index f0dbf7535ca8..0e3712fcf0e0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -867,8 +868,9 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 }
 
 /*	chip specific g_option configuration routine */
-static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
+static void sm750fb_setup(struct sm750_dev *sm750_dev, const char *src)
 {
+	struct option_iter iter;
 	char *opt;
 	int swap;
 
@@ -889,7 +891,9 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		goto NO_PARAM;
 	}
 
-	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
+	option_iter_init(&iter, src);
+
+	while (option_iter_next(&iter, &opt)) {
 		dev_info(&sm750_dev->pdev->dev, "opt=%s\n", opt);
 		dev_info(&sm750_dev->pdev->dev, "src=%s\n", src);
 
@@ -924,6 +928,8 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 		}
 	}
 
+	option_iter_release(&iter);
+
 NO_PARAM:
 	if (sm750_dev->revid != SM750LE_REVISION_ID) {
 		if (sm750_dev->fb_count > 1) {
@@ -1095,9 +1101,10 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	iounmap(sm750_dev->pvMem);
 }
 
-static int __init lynxfb_setup(char *options)
+static int __init lynxfb_setup(const char *options)
 {
 	size_t len;
+	struct option_iter iter;
 	char *opt, *outbuf;
 
 	if (!options || !*options) {
@@ -1113,16 +1120,9 @@ static int __init lynxfb_setup(char *options)
 		return -ENOMEM;
 	g_settings = outbuf;
 
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
+	while (option_iter_next(&iter, &opt)) {
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel"))) {
 			g_noaccel = 1;
@@ -1139,6 +1139,8 @@ static int __init lynxfb_setup(char *options)
 		}
 	}
 
+	option_iter_release(&iter);
+
 	/* misc g_settings are transport to chip specific routines */
 	pr_info("parameter left for chip specific analysis:%s\n", g_settings);
 	return 0;
-- 
2.39.2

