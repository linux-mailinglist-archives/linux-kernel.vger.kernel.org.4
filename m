Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7C6B2A91
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjCIQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjCIQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:03:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE631F8F0B;
        Thu,  9 Mar 2023 08:02:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 577792019D;
        Thu,  9 Mar 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhLabhC1FIHHBl6vHn75Sdi6c+0lehlO1hOW2wnnzIk=;
        b=nLLiHnJyAkWEMzDS6gjlT7FAdHKqeDNCtYCIowjWNGDofjK1AIIxp8zGGtJcR/KkquSxDT
        PVrA32O9RAps2X653Z/8p6kX3gRKcE67DEmuX4qka13Y+AmhcKSVcHi/p1ACdn2OXJN8x/
        DTPilzT4nPENL7eMgxCCo7c4CL9/Pj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhLabhC1FIHHBl6vHn75Sdi6c+0lehlO1hOW2wnnzIk=;
        b=KoO3w/NPCYL06ZUt0wLOVphV7yy1GS9O2qp8D5I5nJAWbw9LROqi6LRRuxmQXywwjAWvyJ
        xXny5w07zN9e80Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA5F81391B;
        Thu,  9 Mar 2023 16:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4M1LOCMDCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:43 +0000
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
Subject: [PATCH v2 098/101] staging/sm750fb: Release g_settings in module-exit function
Date:   Thu,  9 Mar 2023 17:01:58 +0100
Message-Id: <20230309160201.5163-99-tzimmermann@suse.de>
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

Free g_settings in module-exit function for symmetry with its
allocation in module-init function. Fixes a possible undefined
dereference of the pointer.

The string g_settings is initialized ifrom within the module-init
function lynxfb_init() and used from within the PCI probe function.
It is later freed in the PCI device's remove function. Probing another
PCI device afterwards accesses g_settings in an undefined state.

Fix this by freeing g_settings in lynxfb_exit(). Also streamline the
code that creates g_settings in the first place.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/staging/sm750fb/sm750.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index effc7fcc3703..fa8ae20bb688 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1093,13 +1093,12 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 
 	iounmap(sm750_dev->pvReg);
 	iounmap(sm750_dev->pvMem);
-	kfree(g_settings);
 }
 
 static int __init lynxfb_setup(char *options)
 {
-	int len;
-	char *opt, *tmp;
+	size_t len;
+	char *opt, *outbuf;
 
 	if (!options || !*options) {
 		pr_warn("no options.\n");
@@ -1109,11 +1108,10 @@ static int __init lynxfb_setup(char *options)
 	pr_info("options:%s\n", options);
 
 	len = strlen(options) + 1;
-	g_settings = kzalloc(len, GFP_KERNEL);
-	if (!g_settings)
+	outbuf = kzalloc(len, GFP_KERNEL);
+	if (!outbuf)
 		return -ENOMEM;
-
-	tmp = g_settings;
+	g_settings = outbuf;
 
 	/*
 	 * Notes:
@@ -1133,12 +1131,11 @@ static int __init lynxfb_setup(char *options)
 		} else if (!strncmp(opt, "dual", strlen("dual"))) {
 			g_dualview = 1;
 		} else {
-			strcat(tmp, opt);
-			tmp += strlen(opt);
-			if (options)
-				*tmp++ = ':';
-			else
-				*tmp++ = 0;
+			if (outbuf != g_settings)
+				*outbuf++ = ':'; // add separator
+			len = strlen(opt);
+			memcpy(outbuf, opt, len);
+			outbuf += len;
 		}
 	}
 
@@ -1186,6 +1183,7 @@ module_init(lynxfb_init);
 static void __exit lynxfb_exit(void)
 {
 	pci_unregister_driver(&lynxfb_driver);
+	kfree(g_settings);
 }
 module_exit(lynxfb_exit);
 
-- 
2.39.2

