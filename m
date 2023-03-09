Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA30E6B2A62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjCIQIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjCIQC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:02:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82377F7EEA;
        Thu,  9 Mar 2023 08:02:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 209942018A;
        Thu,  9 Mar 2023 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qu+C7a1d7Q6FMdCh/jaUiqGd0/V74XGNJzxH1lrkhI=;
        b=I3LLaTHcoFcV15bZl8c57EAjhZqy+fwPXsIZ/Uc6at1tyf+QWfUvdEjQPUA2tISrUnUrFB
        LRlxxoHBUxgfijNG3Rb/178vAQgR7aNZk5DWUiHm6u5jXYGoetob27gG9cs+nnUfUfP7nW
        Lvjbwz11PXtm2qLQNLN6JEMGR0MZn1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qu+C7a1d7Q6FMdCh/jaUiqGd0/V74XGNJzxH1lrkhI=;
        b=oBd+AsXDparAk0XMGi3Y6EPLeIeP1ZOz2A+oRaJ1Z7LvPFow8UCpPjMLjnWzNN8yQydqSg
        v/BsrO+rKo4QnCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCA4C1391B;
        Thu,  9 Mar 2023 16:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0LEjLREDCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:25 +0000
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
Subject: [PATCH v2 053/101] fbdev/ocfb: Parse option string with struct option_iter
Date:   Thu,  9 Mar 2023 17:01:13 +0100
Message-Id: <20230309160201.5163-54-tzimmermann@suse.de>
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
 drivers/video/fbdev/ocfb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index 9786c3641448..fa15b932b323 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <linux/cmdline.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
@@ -68,22 +69,21 @@ struct ocfb_dev {
 };
 
 #ifndef MODULE
-static int __init ocfb_setup(char *options)
+static int __init ocfb_setup(const char *options)
 {
+	struct option_iter iter;
 	char *curr_opt;
 
-	if (!options || !*options)
-		return 0;
-
-	while ((curr_opt = strsep(&options, ",")) != NULL) {
-		if (!*curr_opt)
-			continue;
+	option_iter_init(&iter, options);
 
+	while (option_iter_next(&iter, &curr_opt)) {
 		kfree(mode_option_buf);
 		mode_option_buf = kstrdup(curr_opt, GFP_KERNEL); // ignore errors
 		mode_option = mode_option_buf;
 	}
 
+	option_iter_release(&iter);
+
 	return 0;
 }
 #endif
-- 
2.39.2

