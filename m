Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B026B29BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjCIQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCIQCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99FF7ECC;
        Thu,  9 Mar 2023 08:02:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F0662017C;
        Thu,  9 Mar 2023 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ym5HuZho+njp3rS/G6tDZ4qDsVBX7VtriAnydblKDT0=;
        b=vf4a2GRs3xu4nDAXLU3y7QYwgfM4JjVf7Pi0P34wctrW7I/0ISZotE4hqOazqxK8OOSKKa
        GPGQOMfoMDk3jLHzl4ft5p/GoDD7xhUX7yxzUQfyQHDeBcMXbZmhPJZ5iYm7Y5H0ub34ir
        FSOL0DYmJPxbsN+u7df3vD3kmLswLmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377729;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ym5HuZho+njp3rS/G6tDZ4qDsVBX7VtriAnydblKDT0=;
        b=R1sHxZf+v8isa6e5JoALDT9zwUOlMSuZCg9Iuc5fbLpMMJcoKCnxwZrNtJMB9Ri99eLxLA
        dvX1y91zRr0zv8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A374A13A73;
        Thu,  9 Mar 2023 16:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eO36JgADCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:08 +0000
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
Subject: [PATCH v2 011/101] fbdev/aty: Duplicate video-mode option string
Date:   Thu,  9 Mar 2023 17:00:31 +0100
Message-Id: <20230309160201.5163-12-tzimmermann@suse.de>
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

Assume that the drivers do not own the option string or its substrings
and hence duplicate the option string for the video mode. Allocate the
copy's memory with kstrdup() and free it in each module's exit function.

Done in preparation of switching the driver to struct option_iter and
constifying the option string.

v2:
	* replace static memory with kstrdup()/kfree() (Geert)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/aty/aty128fb.c    | 8 +++++++-
 drivers/video/fbdev/aty/atyfb_base.c  | 9 +++++++--
 drivers/video/fbdev/aty/radeon_base.c | 9 +++++++--
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 36a9ac05a340..0e725a6eb40b 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -383,6 +383,7 @@ static const struct fb_fix_screeninfo aty128fb_fix = {
 	.accel		= FB_ACCEL_ATI_RAGE128,
 };
 
+static char *mode_option_buf;
 static char *mode_option = NULL;
 
 #ifdef CONFIG_PPC_PMAC
@@ -1723,7 +1724,11 @@ static int aty128fb_setup(char *options)
 			continue;
 		}
 #endif /* CONFIG_PPC_PMAC */
-		mode_option = this_opt;
+		{
+			kfree(mode_option_buf);
+			mode_option_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
+			mode_option = mode_option_buf;
+		}
 	}
 	return 0;
 }
@@ -2518,6 +2523,7 @@ static int aty128fb_init(void)
 static void __exit aty128fb_exit(void)
 {
 	pci_unregister_driver(&aty128fb_driver);
+	kfree(mode_option_buf);
 }
 
 module_init(aty128fb_init);
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index b02e4e645035..d83b3dae795b 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -326,6 +326,7 @@ static int pll;
 static int mclk;
 static int xclk;
 static int comp_sync = -1;
+static char *mode_buf;
 static char *mode;
 static int backlight = IS_BUILTIN(CONFIG_PMAC_BACKLIGHT);
 
@@ -3896,8 +3897,11 @@ static int __init atyfb_setup(char *options)
 			}
 		}
 #endif
-		else
-			mode = this_opt;
+		else {
+			kfree(mode_buf);
+			mode_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
+			mode = mode_buf;
+		}
 	}
 	return 0;
 }
@@ -3995,6 +3999,7 @@ static void __exit atyfb_exit(void)
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&atyfb_driver);
 #endif
+	kfree(mode_buf);
 }
 
 module_init(atyfb_init);
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 657064227de8..dc2657ae96f2 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -257,6 +257,7 @@ static reg_val common_regs[] = {
  * globals
  */
 
+static char *mode_option_buf;
 static char *mode_option;
 static char *monitor_layout;
 static bool noaccel = 0;
@@ -2596,8 +2597,11 @@ static int __init radeonfb_setup (char *options)
 		} else if (!strncmp(this_opt, "ignore_devlist", 14)) {
 			ignore_devlist = 1;
 #endif
-		} else
-			mode_option = this_opt;
+		} else {
+			kfree(mode_option_buf);
+			mode_option_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
+			mode_option = mode_option_buf;
+		}
 	}
 	return 0;
 }
@@ -2624,6 +2628,7 @@ static int __init radeonfb_init (void)
 static void __exit radeonfb_exit (void)
 {
 	pci_unregister_driver (&radeonfb_driver);
+	kfree(mode_option_buf);
 }
 
 module_init(radeonfb_init);
-- 
2.39.2

