Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399B16AC6C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCFQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCFQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7A28879;
        Mon,  6 Mar 2023 08:00:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E68A1FDEB;
        Mon,  6 Mar 2023 16:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rlw6Y9HytpkB3h8X3sYp9Q/5dj2jl9fyg6laIqBFHmA=;
        b=UA0AU+8JNLwhTqGrlpZIn9kcDz7Pgg2tC5sBRfYuOum/1ZRLNPGUgOobCxgPjF/b49X92m
        X6VesbrhU3/K1VgbkEemX3jDIq9pyokGPfsW+8+AmMpIowBtz9z2WUGydPYIgwFjEXX6hx
        QryOCn3keLR0ITMjl5mQKPsguZo2B4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rlw6Y9HytpkB3h8X3sYp9Q/5dj2jl9fyg6laIqBFHmA=;
        b=b8tJbPSYaNtJ/8Uk5mCRRx6gPRMZLLKvfcW2ZfPdtD11XP/hPD5110toEAPpfNQjnjhchb
        JJZWioCGPKdTbxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E36AC13513;
        Mon,  6 Mar 2023 16:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EKPFNiAOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:32 +0000
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
Subject: [PATCH 24/99] fbdev/gbefb: Duplicate video-mode option string
Date:   Mon,  6 Mar 2023 16:59:01 +0100
Message-Id: <20230306160016.4459-25-tzimmermann@suse.de>
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

Assume that the driver does not own the option string or its substrings
and hence duplicate the option string for the video mode. Allocate the
copy's memory with devm_kstrdup(), as the driver parses the option string
once per probed device. Linux will automatically free the memory upon
releasing the device.

Done in preparation of switching the driver to struct option_iter and
constifying the option string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/gbefb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 000b4aa44241..5330aa6029ca 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1083,7 +1083,7 @@ ATTRIBUTE_GROUPS(gbefb);
  * Initialization
  */
 
-static int gbefb_setup(char *options)
+static int gbefb_setup(char *options, struct device *dev)
 {
 	char *this_opt;
 
@@ -1108,8 +1108,9 @@ static int gbefb_setup(char *options)
 				gbe_mem_size = CONFIG_FB_GBE_MEM * 1024 * 1024;
 			if (gbe_mem_size < TILE_SIZE)
 				gbe_mem_size = TILE_SIZE;
-		} else
-			mode_option = this_opt;
+		} else {
+			mode_option = devm_kstrdup(dev, this_opt, GFP_KERNEL);
+		}
 	}
 	return 0;
 }
@@ -1132,7 +1133,7 @@ static int gbefb_probe(struct platform_device *p_dev)
 		ret = -ENODEV;
 		goto out_release_framebuffer;
 	}
-	gbefb_setup(options);
+	gbefb_setup(options, &p_dev->dev);
 #endif
 
 	if (!request_mem_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
-- 
2.39.2

