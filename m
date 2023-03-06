Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B2C6AC71E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCFQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjCFQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3072125E09;
        Mon,  6 Mar 2023 08:00:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95A25223E5;
        Mon,  6 Mar 2023 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkQXjan0jowROvGRC5u3ioDg+jvgH6ZrVreFgORBrsc=;
        b=p4dSG4UN0SvOYm7f+Ini5G3JxYDXizo15S+ZES2hM8gMpQ+3h0fPW1c3+zc8LfsqJ5uOAa
        OFPVScXTSW0J1TU/x2+ApALnnvxl1elZCtpmtFZIlmXmV7n746WZB7lcdKoDAc/dsQotHo
        JYY02IhBpZi7DNJVPKZmos1RkATJ2OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZkQXjan0jowROvGRC5u3ioDg+jvgH6ZrVreFgORBrsc=;
        b=x+GPpd14JqLOBkBEeV+nlMqiuF81+O1WMnDaNkbDHairiMyBGsocqbASU5EH4OxvOuXOwO
        C+wXHNWgKrawJdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 388EA13513;
        Mon,  6 Mar 2023 16:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EDztDCkOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:41 +0000
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
Subject: [PATCH 45/99] fbdev/matroxfb: Parse option string with struct option_iter
Date:   Mon,  6 Mar 2023 16:59:22 +0100
Message-Id: <20230306160016.4459-46-tzimmermann@suse.de>
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
 drivers/video/fbdev/matrox/matroxfb_base.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index a043a737ea9f..f690ee0c9b1f 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -101,6 +101,7 @@
  */
 
 #include <linux/aperture.h>
+#include <linux/cmdline.h>
 #include <linux/version.h>
 
 #include "matroxfb_base.h"
@@ -2333,17 +2334,14 @@ static void __exit matrox_done(void) {
 
 /* ************************* init in-kernel code ************************** */
 
-static int __init matroxfb_setup(char *options) {
-	char *this_opt;
-
-	DBG(__func__)
-
-	if (!options || !*options)
-		return 0;
+static int __init matroxfb_setup(const char *options)
+{
+	struct option_iter iter;
+	const char *this_opt;
 
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt) continue;
+	option_iter_init(&iter, options);
 
+	while (option_iter_next(&iter, this_opt)) {
 		dprintk("matroxfb_setup: option %s\n", this_opt);
 
 		if (!strncmp(this_opt, "dev:", 4))
@@ -2467,6 +2465,9 @@ static int __init matroxfb_setup(char *options) {
 			}
 		}
 	}
+
+	option_iter_release(&iter);
+
 	return 0;
 }
 
-- 
2.39.2

