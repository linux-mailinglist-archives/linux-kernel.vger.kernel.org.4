Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA60C6B2A58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjCIQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjCIQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6DF7EE0;
        Thu,  9 Mar 2023 08:02:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EAF752215C;
        Thu,  9 Mar 2023 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AEmjb0U5MuWqCkAOg6DDslP0tiDJ52eRVcjJgkB7ll8=;
        b=JMxEG6FCTf6enGWwT1TPrS4+ts8GsZgGOwWGh3JfpppPZ80S9Fgn2+LA7srFwU2uDJhyl4
        dMRgs6qUYLCMg1NwjmfVCNpm6dQi/pAMPk/8TAz8m8H0i+Np3Yj1eLXt/nx+jyZvoPFTfm
        MxlO4bIxQXfd3eWsvyp/9a8Lfbw9B84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377744;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AEmjb0U5MuWqCkAOg6DDslP0tiDJ52eRVcjJgkB7ll8=;
        b=2upOe/xQ6PSzZfw4H5ESkUIDirwNOxL9JcIZRVLqsPWEO2dzYBBo0U8F7h7EySBb1iLg+4
        Gu3a2LXpv0460BDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FA691391B;
        Thu,  9 Mar 2023 16:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Mo9IhADCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:24 +0000
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
Subject: [PATCH v2 050/101] fbdev/nvidiafb: Duplicate video-mode option string
Date:   Thu,  9 Mar 2023 17:01:10 +0100
Message-Id: <20230309160201.5163-51-tzimmermann@suse.de>
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
 drivers/video/fbdev/nvidia/nvidia.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index e60a276b4855..8ad4bcff84df 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -77,6 +77,7 @@ static int reverse_i2c;
 static bool nomtrr = false;
 static int backlight = IS_BUILTIN(CONFIG_PMAC_BACKLIGHT);
 
+static char *mode_option_buf;
 static char *mode_option = NULL;
 
 static struct fb_fix_screeninfo nvidiafb_fix = {
@@ -1498,8 +1499,11 @@ static int nvidiafb_setup(char *options)
 			fpdither = simple_strtol(this_opt+9, NULL, 0);
 		} else if (!strncmp(this_opt, "bpp:", 4)) {
 			bpp = simple_strtoul(this_opt+4, NULL, 0);
-		} else
-			mode_option = this_opt;
+		} else {
+			kfree(mode_option_buf);
+			mode_option_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
+			mode_option = mode_option_buf;
+		}
 	}
 	NVTRACE_LEAVE();
 	return 0;
@@ -1542,6 +1546,7 @@ module_init(nvidiafb_init);
 static void __exit nvidiafb_exit(void)
 {
 	pci_unregister_driver(&nvidiafb_driver);
+	kfree(mode_option_buf);
 }
 
 module_exit(nvidiafb_exit);
-- 
2.39.2

