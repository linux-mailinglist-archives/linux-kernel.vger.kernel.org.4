Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBC6B2A64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjCIQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjCIQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77733F7EDF;
        Thu,  9 Mar 2023 08:02:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C832E20194;
        Thu,  9 Mar 2023 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NH6+VMOHM5Bo+HTdsXwHkuMcnMRmvfOynxZTybH+bo=;
        b=go1Eo7rsPRB5BTU6t1uZeaY1P9a+UShfP9tySZW6muM3zfoSxWuJ0JgsuNBQ23dT9Avu82
        vMyTTtUhQoqe513nmX0H/WS6nKOdeXIx4OFmD+UGQZXCL1l+oY4OiLIrWOtouY02A85513
        GEPk0Gg699Q4RykUQPURPtRxv2Nhs38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377751;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NH6+VMOHM5Bo+HTdsXwHkuMcnMRmvfOynxZTybH+bo=;
        b=E2S+X322wx/wHA2eX9UG4JiDR8pRg9/T2WXFXdRMBwmB1EvU4abjgoqd+RB6MO/AftXP+T
        XJzzO7fUrj/3LeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EE4A13A73;
        Thu,  9 Mar 2023 16:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iNk9GhcDCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:31 +0000
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
Subject: [PATCH v2 068/101] fbdev/s3fb: Duplicate video-mode option string
Date:   Thu,  9 Mar 2023 17:01:28 +0100
Message-Id: <20230309160201.5163-69-tzimmermann@suse.de>
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
and hence duplicate the option string for the video mode. Allocate the
copy's memory with kstrdup() and free it in the module's exit function.

Done in preparation of switching the driver to struct option_iter and
constifying the option string.

v2:
	* replace static memory with kstrdup()/kfree() (Geert)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/s3fb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 7d257489edcc..6bcedcde8aad 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -150,6 +150,7 @@ static const struct svga_timing_regs s3_timing_regs     = {
 /* Module parameters */
 
 
+static char *mode_option_buf;
 static char *mode_option;
 static int mtrr = 1;
 static int fasttext = 1;
@@ -1535,8 +1536,11 @@ static int  __init s3fb_setup(char *options)
 			mtrr = simple_strtoul(opt + 5, NULL, 0);
 		else if (!strncmp(opt, "fasttext:", 9))
 			fasttext = simple_strtoul(opt + 9, NULL, 0);
-		else
-			mode_option = opt;
+		else {
+			kfree(mode_option_buf);
+			mode_option_buf = kstrdup(opt, GFP_KERNEL); // ignore errors
+			mode_option = mode_option_buf;
+		}
 	}
 
 	return 0;
@@ -1549,6 +1553,7 @@ static void __exit s3fb_cleanup(void)
 {
 	pr_debug("s3fb: cleaning up\n");
 	pci_unregister_driver(&s3fb_pci_driver);
+	kfree(mode_option_buf);
 }
 
 /* Driver Initialisation */
-- 
2.39.2

