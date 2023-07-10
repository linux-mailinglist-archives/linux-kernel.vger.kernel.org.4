Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A758074D6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjGJNC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjGJNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:01:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1633210D;
        Mon, 10 Jul 2023 06:01:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 633351FF7F;
        Mon, 10 Jul 2023 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688994080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6ru8517klqGREviW+x/hv4zx4wIPur3uNAYN8tJAH0=;
        b=mpQ7zE3boNuzxgXmD8+YmLufhYYd6Nfi/b1CtUeVH7C8D+zhVZs1Qy96P3dyluOd/egOvR
        g2MIVfyX9Y/2jasio1RD76V51+HY0Gk0lE1hld3b33BD4hvJwhk92b3x3fIl8ipEYbNClC
        OQh+kDWDKb/JL12VDpUQm/hJXgLBlFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688994080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6ru8517klqGREviW+x/hv4zx4wIPur3uNAYN8tJAH0=;
        b=EWBKr1Z+4QVt5mOCxBoTfkQNc9Wcvlk+hs1S6tE8l36rKEOLj9nQ8WUaA7TeuDN4Yd4qnn
        LFcjRqeScP2uMXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10D9B13A05;
        Mon, 10 Jul 2023 13:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2OUqAyABrGTTFAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 10 Jul 2023 13:01:20 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, javierm@redhat.com
Cc:     linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-nvidia@lists.surfsouth.com,
        linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 13/17] fbdev: Remove flag FBINFO_FLAG_DEFAULT from fbdev drivers
Date:   Mon, 10 Jul 2023 14:50:17 +0200
Message-ID: <20230710130113.14563-14-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710130113.14563-1-tzimmermann@suse.de>
References: <20230710130113.14563-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag FBINFO_FLAG_DEFAULT is 0 and has no effect, as struct
fbinfo.flags has been allocated to zero by kzalloc(). So do not
set it.

Flags should signal differences from the default values. After cleaning
up all occurences of FBINFO_FLAG_DEFAULT, the token can be removed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/amba-clcd.c             | 1 -
 drivers/video/fbdev/matrox/matroxfb_crtc2.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index e45338227be6..24d89e6fb780 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -461,7 +461,6 @@ static int clcdfb_register(struct clcd_fb *fb)
 	}
 
 	fb->fb.fbops		= &clcdfb_ops;
-	fb->fb.flags		= FBINFO_FLAG_DEFAULT;
 	fb->fb.pseudo_palette	= fb->cmap;
 
 	strncpy(fb->fb.fix.id, clcd_name, sizeof(fb->fb.fix.id));
diff --git a/drivers/video/fbdev/matrox/matroxfb_crtc2.c b/drivers/video/fbdev/matrox/matroxfb_crtc2.c
index 7655afa3fd50..372197c124de 100644
--- a/drivers/video/fbdev/matrox/matroxfb_crtc2.c
+++ b/drivers/video/fbdev/matrox/matroxfb_crtc2.c
@@ -603,9 +603,8 @@ static int matroxfb_dh_regit(const struct matrox_fb_info *minfo,
 	void* oldcrtc2;
 
 	m2info->fbcon.fbops = &matroxfb_dh_ops;
-	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
-	m2info->fbcon.flags |= FBINFO_HWACCEL_XPAN |
-			       FBINFO_HWACCEL_YPAN;
+	m2info->fbcon.flags = FBINFO_HWACCEL_XPAN |
+			      FBINFO_HWACCEL_YPAN;
 	m2info->fbcon.pseudo_palette = m2info->cmap;
 	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
 
-- 
2.41.0

