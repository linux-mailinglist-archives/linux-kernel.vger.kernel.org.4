Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562CB6AC650
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjCFQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjCFQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE12E0D3;
        Mon,  6 Mar 2023 08:00:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2149C22384;
        Mon,  6 Mar 2023 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vW0Ol4SV/VF9Oy6zvE1dkGppBSF1ye6q+ZpyZhscWGg=;
        b=s2t6HZxNp2vyhC92hpPPuy5KnMNHVjZUkvHxsdoE9ro2sw1Jt+S4kGZPAZDGYA2+P8ZG/3
        We+YjqMKQydkpiwakk7or+c9HgB6BfqI3jiAGBh7DXSL0/apIIw1mN/0YUQaRqnPg0y7Mb
        yQrB5SUrakfUCCHEZCDLufdlaD2eKYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vW0Ol4SV/VF9Oy6zvE1dkGppBSF1ye6q+ZpyZhscWGg=;
        b=IJz+A+PqwW/VxnAl/Xw9sr3jtwXAyRnqxXipfpVfJp1kPa3tUf0/XrKlu3ZctUZe0jOvfH
        YpWKCZ6hV7jeO0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC84613A6A;
        Mon,  6 Mar 2023 16:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iAsXLRsOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:27 +0000
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
Subject: [PATCH 10/99] fbdev/atafb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:58:47 +0100
Message-Id: <20230306160016.4459-11-tzimmermann@suse.de>
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

Use struct option_iter to walk over the individual options in the
driver's option string. Replaces the hand-written strsep() loop with
a clean interface. The helpers for struct option_iter handle empty
option strings and empty options transparently. The struct's _init
and _release functions duplicate and release the option string's
memory buffer as needed.

Done in preparation of constifying the option string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/atafb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 331e72096ebb..82d5567f2ffb 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -47,6 +47,7 @@
 #define ATAFB_EXT
 #define ATAFB_FALCON
 
+#include <linux/cmdline.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -2934,17 +2935,16 @@ static void __init atafb_setup_user(char *spec)
 	}
 }
 
-static int __init atafb_setup(char *options)
+static int __init atafb_setup(const char *options)
 {
-	char *this_opt;
+	struct option_iter iter;
+	const char *this_opt;
 	int temp;
 
 	if (!options || !*options)
 		return 0;
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt)
-			continue;
+	while (option_iter_next(&iter, this_opt)) {
 		if ((temp = get_video_mode(this_opt))) {
 			static char mode_option_buf[256];
 			int ret;
@@ -2988,6 +2988,9 @@ static int __init atafb_setup(char *options)
 		else if (!strncmp(this_opt, "R", 1))
 			atafb_setup_user(this_opt + 1);
 	}
+
+	option_iter_release(&iter);
+
 	return 0;
 }
 
-- 
2.39.2

