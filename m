Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516F6B2A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjCIQLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjCIQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:03:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20889F8F12;
        Thu,  9 Mar 2023 08:02:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD68421CCF;
        Thu,  9 Mar 2023 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g10CyGX8LN7jmhoB07O8PTYOwqUFbPdF+9x3En0LlPQ=;
        b=qVY89Ub6EbFQOTKqDemyKSPew7jktkhiNjNPqV6mSd1tpTxpCzi6NY/O2SVA2FQQ1jjcem
        BjcyTzaawenSa7gVGO8Uh//B/B5zelqoylpQSZfwWTUGlgzYmtB9kp9HEfBcBTe2WtNEXv
        0DKXom4/6+gpTGMkZMuDwcOBugxSWvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g10CyGX8LN7jmhoB07O8PTYOwqUFbPdF+9x3En0LlPQ=;
        b=cLgZD6S21fT2maB/cW7YcTSSRfcn0OAQtMslOudmC3yWf0xgrJaMhlEI4LRnMeFFSe5Kai
        q391y6SEol87MVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B64B13A73;
        Thu,  9 Mar 2023 16:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKdXFSQDCmQHbgAAMHmgww
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
Subject: [PATCH v2 099/101] staging/sm750fb: Duplicate video-mode option string
Date:   Thu,  9 Mar 2023 17:01:59 +0100
Message-Id: <20230309160201.5163-100-tzimmermann@suse.de>
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

Assume that the driver does not own the option string or its substrings
and hence duplicate the option stringis for the video mode. Allocate each
copy's memory with kstrdup() and free it in the module's exit function.

Done in preparation of switching the driver to struct option_iter and
constifying the option string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/staging/sm750fb/sm750.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fa8ae20bb688..f0dbf7535ca8 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -911,11 +911,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 			g_hwcursor = 0;
 		} else {
 			if (!g_fbmode[0]) {
-				g_fbmode[0] = opt;
+				g_fbmode[0] = kstrdup(opt, GFP_KERNEL); // ignore errors
 				dev_info(&sm750_dev->pdev->dev,
 					 "find fbmode0 : %s\n", g_fbmode[0]);
 			} else if (!g_fbmode[1]) {
-				g_fbmode[1] = opt;
+				g_fbmode[1] = kstrdup(opt, GFP_KERNEL); // ignore errors
 				dev_info(&sm750_dev->pdev->dev,
 					 "find fbmode1 : %s\n", g_fbmode[1]);
 			} else {
@@ -1182,7 +1182,14 @@ module_init(lynxfb_init);
 
 static void __exit lynxfb_exit(void)
 {
+	size_t i = ARRAY_SIZE(g_fbmode);
+
 	pci_unregister_driver(&lynxfb_driver);
+
+	while (i) {
+		--i;
+		kfree(g_fbmode[i]);
+	}
 	kfree(g_settings);
 }
 module_exit(lynxfb_exit);
-- 
2.39.2

