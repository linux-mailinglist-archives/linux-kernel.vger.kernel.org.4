Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27116B2A48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjCIQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjCIQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09DF7EC9;
        Thu,  9 Mar 2023 08:02:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 41F5722156;
        Thu,  9 Mar 2023 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUhTX6veO6KsY0Dpn+In+/O3oAyGJ8vyl1FETD8qkzA=;
        b=idWhZvv1OFds5xjRkPCJSk7FUrp/5Q+5yONgyOkRk74bgyQR6l2Hu1Ldh9Czwafi2kvpb6
        JDE3IVHFJZrlPfSrHcLWwMYl8CDKEspqus0mb+eN629cWYmF0Zk+nIGUN/tliQTK7hS+di
        ivOD/T7z7BxIyuDXhRtIuPEYTj0nTmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377740;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUhTX6veO6KsY0Dpn+In+/O3oAyGJ8vyl1FETD8qkzA=;
        b=VW4393UvuEQyXD1vy0JgI3/62OjzOgpoo3xaehvYjXVrFZMzeUR8iwtJTX7uevpydCf5bf
        +ZIXjKbN08MUscCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7A931391B;
        Thu,  9 Mar 2023 16:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qITRMwsDCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:19 +0000
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
Subject: [PATCH v2 038/101] fbdev/intelfb: Parse option string with struct option_iter
Date:   Thu,  9 Mar 2023 17:00:58 +0100
Message-Id: <20230309160201.5163-39-tzimmermann@suse.de>
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
 drivers/video/fbdev/intelfb/intelfbdrv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index 8368c3601cdb..43d677897392 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -108,6 +108,7 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -324,8 +325,9 @@ static __inline__ int get_opt_bool(const char *this_opt, const char *name,
 	return 1;
 }
 
-static int __init intelfb_setup(char *options)
+static int __init intelfb_setup(const char *options)
 {
+	struct option_iter iter;
 	char *this_opt;
 
 	DBG_MSG("intelfb_setup\n");
@@ -349,9 +351,9 @@ static int __init intelfb_setup(char *options)
 	 *    video=intelfb:1024x768-16@75,accel=0
 	 */
 
-	while ((this_opt = strsep(&options, ","))) {
-		if (!*this_opt)
-			continue;
+	option_iter_init(&iter, options);
+
+	while (option_iter_next(&iter, &this_opt)) {
 		if (get_opt_bool(this_opt, "accel", &accel))
 			;
 		else if (get_opt_int(this_opt, "vram", &vram))
@@ -373,6 +375,8 @@ static int __init intelfb_setup(char *options)
 		}
 	}
 
+	option_iter_release(&iter);
+
 	return 0;
 }
 
-- 
2.39.2

