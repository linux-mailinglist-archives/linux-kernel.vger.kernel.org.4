Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7656B2A66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCIQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjCIQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B2F63A3;
        Thu,  9 Mar 2023 08:02:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D940A2018F;
        Thu,  9 Mar 2023 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjJ38kmNT4VpiL0XGaIUsP41fKqpOphAgyzqkf5KhKA=;
        b=JLe11LJEmiD4nLl8O7epakDml/E/WNFxS8XYIxOcUyoCg3JN580rEa+XFFqIuJ01mwt/pq
        jbY9KoIsTr78epKZ8bw0X6sdPaS16SEqEvp4pJ/00qWTCkD7INw9UYOQuzLeNO5g8zYHhG
        4Qi/RVEwLUZBux2CjvrnfsbBZkhS+yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjJ38kmNT4VpiL0XGaIUsP41fKqpOphAgyzqkf5KhKA=;
        b=bz5poN1CD5ySwXlFVjpP3CyHkn8fTspT1RxOz5lCIW1I2NIbHe6SrgZ8As5oiHQSjSsubf
        MF73NTrD34lgu6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 825E01391B;
        Thu,  9 Mar 2023 16:02:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sGn5HhUDCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:29 +0000
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
Subject: [PATCH v2 063/101] fbdev/pvr2fb: Duplicate video-mode option string
Date:   Thu,  9 Mar 2023 17:01:23 +0100
Message-Id: <20230309160201.5163-64-tzimmermann@suse.de>
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
copy's memory with kstrdup() and free it in the module's exit function,
as well as the init function's error handling.

Done in preparation of switching the driver to struct option_iter and
constifying the option string.

v2:
	* replace static memory with kstrdup()/kfree() (Geert)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/pvr2fb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 6888127a5eb8..f6be2649840d 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -225,6 +225,7 @@ static struct fb_videomode pvr2_modedb[] = {
 #define DEFMODE_VGA	2
 
 static int defmode = DEFMODE_NTSC;
+static char *mode_option_buf;
 static char *mode_option = NULL;
 
 static inline void pvr2fb_set_pal_type(unsigned int type)
@@ -1049,7 +1050,9 @@ static int __init pvr2fb_setup(char *options)
 		} else if (!strncmp(this_opt, "nowrap", 6)) {
 			nowrap = 1;
 		} else {
-			mode_option = this_opt;
+			kfree(mode_option_buf);
+			mode_option_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
+			mode_option = mode_option_buf;
 		}
 	}
 
@@ -1094,8 +1097,11 @@ static int __init pvr2fb_init(void)
 #endif
 
 	fb_info = framebuffer_alloc(sizeof(struct pvr2fb_par), NULL);
-	if (!fb_info)
+	if (!fb_info) {
+		kfree(mode_option_buf);
+		mode_option_buf = NULL;
 		return -ENOMEM;
+	}
 
 	currentpar = fb_info->par;
 
@@ -1111,6 +1117,8 @@ static int __init pvr2fb_init(void)
 			printk(KERN_ERR "pvr2fb: Failed init of %s device\n",
 				pvr_board->name);
 			framebuffer_release(fb_info);
+			kfree(mode_option_buf);
+			mode_option_buf = NULL;
 			break;
 		}
 	}
@@ -1135,6 +1143,7 @@ static void __exit pvr2fb_exit(void)
 
 	unregister_framebuffer(fb_info);
 	framebuffer_release(fb_info);
+	kfree(mode_option_buf);
 }
 
 module_init(pvr2fb_init);
-- 
2.39.2

