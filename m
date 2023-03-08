Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6CF6AFEFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 07:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCHGgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 01:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCHGgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:36:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B6A028D;
        Tue,  7 Mar 2023 22:36:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A06F41FE35;
        Wed,  8 Mar 2023 06:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678257395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3h4YnW3SI7kDxrFZgy/I5e5nc2hFg1fRCOVnjuFOR5s=;
        b=fPX9DEKvn90FUOVp/Nv3gfbbh9B0O41ZMRb4O3Fv4ncTlmPR7N6fR52LcDXL5UzEw8FCw+
        ZxvkABlDnarvk1eb7sucVSPkIAnd2If61vC8AYCQW6N9GnvFDYfjouDA7zv17THJImep25
        AzaiG/xDCfvhVrtefyhH8j+MS3auWJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678257395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3h4YnW3SI7kDxrFZgy/I5e5nc2hFg1fRCOVnjuFOR5s=;
        b=+TNtLndF9vaeJXeXb0MPUjA9YGoTL4KAFoltv1+Za7Mws6lphC72cM7RAphviMU1t6S83B
        iVC4m3m8XBB+uMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 754621348D;
        Wed,  8 Mar 2023 06:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wsflG/MsCGS/WgAAMHmgww
        (envelope-from <tiwai@suse.de>); Wed, 08 Mar 2023 06:36:35 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Patrik Jakobsson <pjakobsson@suse.de>,
        Helge Deller <deller@gmx.de>,
        Miko Larsson <mikoxyzzz@gmail.com>
Subject: [PATCH] fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()
Date:   Wed,  8 Mar 2023 07:36:28 +0100
Message-Id: <20230308063628.15233-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fix for the deferred I/O by the commit
  3efc61d95259 ("fbdev: Fix invalid page access after closing deferred I/O devices")
caused a regression when the same fb device is opened/closed while
it's being used.  It resulted in a frozen screen even if something
is redrawn there after the close.  The breakage is because the patch
was made under a wrong assumption of a single open; in the current
code, fb_deferred_io_release() cleans up the page mapping of the
pageref list and it calls cancel_delayed_work_sync() unconditionally,
where both are no correct behavior for multiple opens.

This patch adds a refcount for the opens of the device, and applies
the cleanup only when all files get closed.

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferred I/O devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/video/fbdev/core/fb_defio.c | 16 +++++++++++++---
 include/linux/fb.h                  |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index aa5f059d0222..9dcec9e020b6 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -305,17 +305,19 @@ void fb_deferred_io_open(struct fb_info *info,
 			 struct inode *inode,
 			 struct file *file)
 {
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
 	file->f_mapping->a_ops = &fb_deferred_io_aops;
+	fbdefio->opens++;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_open);
 
-void fb_deferred_io_release(struct fb_info *info)
+static void fb_deferred_io_release_internal(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct page *page;
 	int i;
 
-	BUG_ON(!fbdefio);
 	cancel_delayed_work_sync(&info->deferred_work);
 
 	/* clear out the mapping that we setup */
@@ -324,13 +326,21 @@ void fb_deferred_io_release(struct fb_info *info)
 		page->mapping = NULL;
 	}
 }
+
+void fb_deferred_io_release(struct fb_info *info)
+{
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
+	if (!--fbdefio->opens)
+		fb_deferred_io_release_internal(info);
+}
 EXPORT_SYMBOL_GPL(fb_deferred_io_release);
 
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 
-	fb_deferred_io_release(info);
+	fb_deferred_io_release_internal(info);
 
 	kvfree(info->pagerefs);
 	mutex_destroy(&fbdefio->lock);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index d8d20514ea05..29674a29d1c4 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -212,6 +212,7 @@ struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
 	unsigned long delay;
 	bool sort_pagereflist; /* sort pagelist by offset */
+	int opens; /* number of opened files */
 	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
-- 
2.35.3

