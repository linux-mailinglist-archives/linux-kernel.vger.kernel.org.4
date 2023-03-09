Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16366B2A04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCIQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjCIQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BFDF7EF8;
        Thu,  9 Mar 2023 08:02:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF52F20185;
        Thu,  9 Mar 2023 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLAbF/IxrYzQxfqgNl+fEpo2kh27uLHCXxP09jiRWPw=;
        b=kj2x0IHOwQcNEXkOXVMEVAYq0EewgaGYxEERzn/eUbv3dzSYiIwsdTCp8d3VJPgZrl7NNB
        Qw/yTygda3ZtiOgJ+5cD/md3t5yrORSJ2RH03DZaphZ9rWEPO2Tyff73AvkubvHTUITkC1
        TVfM6Kf1/lomVGt9sGU8Q/UCRmzXfUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377734;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLAbF/IxrYzQxfqgNl+fEpo2kh27uLHCXxP09jiRWPw=;
        b=e2yv93PwS/2CiePmwpZz9ZSeF+8FyK/MqZwOhx/1thcc4CLcKfEXMIIF7PZqCAAHSRtMqB
        H6wSXe69c+C35SBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E2CF1391B;
        Thu,  9 Mar 2023 16:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8GzaHQYDCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:14 +0000
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
Subject: [PATCH v2 025/101] fbdev/gbefb: Parse option string with struct option_iter
Date:   Thu,  9 Mar 2023 17:00:45 +0100
Message-Id: <20230309160201.5163-26-tzimmermann@suse.de>
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

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/gbefb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 6afccd4ef0a8..d20ef48263f3 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -9,6 +9,7 @@
  *  more details.
  */
 
+#include <linux/cmdline.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
@@ -1083,14 +1084,14 @@ ATTRIBUTE_GROUPS(gbefb);
  * Initialization
  */
 
-static int gbefb_setup(char *options, struct device *dev)
+static int gbefb_setup(const char *options, struct device *dev)
 {
+	struct option_iter iter;
 	char *this_opt;
 
-	if (!options || !*options)
-		return 0;
+	option_iter_init(&iter, options);
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
+	while (option_iter_next(&iter, &this_opt)) {
 		if (!strncmp(this_opt, "monitor:", 8)) {
 			if (!strncmp(this_opt + 8, "crt", 3)) {
 				flat_panel_enabled = 0;
@@ -1103,7 +1104,7 @@ static int gbefb_setup(char *options, struct device *dev)
 				default_mode = &default_mode_LCD;
 			}
 		} else if (!strncmp(this_opt, "mem:", 4)) {
-			gbe_mem_size = memparse(this_opt + 4, &this_opt);
+			gbe_mem_size = memparse(this_opt + 4, NULL);
 			if (gbe_mem_size > CONFIG_FB_GBE_MEM * 1024 * 1024)
 				gbe_mem_size = CONFIG_FB_GBE_MEM * 1024 * 1024;
 			if (gbe_mem_size < TILE_SIZE)
@@ -1112,6 +1113,9 @@ static int gbefb_setup(char *options, struct device *dev)
 			mode_option = devm_kstrdup(dev, this_opt, GFP_KERNEL); // ignore errors
 		}
 	}
+
+	option_iter_release(&iter);
+
 	return 0;
 }
 
-- 
2.39.2

