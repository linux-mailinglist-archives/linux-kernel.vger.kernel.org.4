Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5458D6B04FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCHKuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjCHKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:50:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34827AFBA1;
        Wed,  8 Mar 2023 02:50:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD22C1F383;
        Wed,  8 Mar 2023 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678272614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2GKjvL4PQIy1GppZpfJGaCUWdO9wqTIKFREqa/GK/B8=;
        b=Q6qgl3gFnc+Hf7h10S1aP6tXZGb0f3+eh4+UejbNnJuN549hmvkC3a1b5kw1Ui94bSn6ut
        gtF8WeqrMavzoF7J8v83n1PcRFS4VhflWckcJwJo2NtjVDZwGzSaUdToxIwAo8QG/E54P1
        04BobeOFrP/CyZEx6UMJghB88t78obY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678272614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2GKjvL4PQIy1GppZpfJGaCUWdO9wqTIKFREqa/GK/B8=;
        b=pwFM4uIoQvZpxJKjV37bZY3AXR+FojnNqV2X6HFCiIBvSo1Wbk8H2ECJ0JF6u4qlNsOUDw
        sQdeEwuU9wWkIfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA8EF1348D;
        Wed,  8 Mar 2023 10:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NC8aMWZoCGTuaQAAMHmgww
        (envelope-from <tiwai@suse.de>); Wed, 08 Mar 2023 10:50:14 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Patrik Jakobsson <pjakobsson@suse.de>,
        Helge Deller <deller@gmx.de>,
        Miko Larsson <mikoxyzzz@gmail.com>
Subject: [PATCH v2] fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()
Date:   Wed,  8 Mar 2023 11:50:12 +0100
Message-Id: <20230308105012.1845-1-tiwai@suse.de>
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

As both fb_deferred_io_open() and _close() are called always in the
fb_info lock (mutex), it's safe to use the normal int for the
refcounting.

Also, a useless BUG_ON() is dropped.

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferred I/O devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2:
* Rename to fb_deferred_io_lastclose()
* Rename the new field from opens to open_count
* Removed unused variable
* More comments about fb_info locking

 drivers/video/fbdev/core/fb_defio.c | 17 +++++++++++++----
 include/linux/fb.h                  |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index aa5f059d0222..274f5d0fa247 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -305,17 +305,18 @@ void fb_deferred_io_open(struct fb_info *info,
 			 struct inode *inode,
 			 struct file *file)
 {
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
 	file->f_mapping->a_ops = &fb_deferred_io_aops;
+	fbdefio->open_count++;
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_open);
 
-void fb_deferred_io_release(struct fb_info *info)
+static void fb_deferred_io_lastclose(struct fb_info *info)
 {
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct page *page;
 	int i;
 
-	BUG_ON(!fbdefio);
 	cancel_delayed_work_sync(&info->deferred_work);
 
 	/* clear out the mapping that we setup */
@@ -324,13 +325,21 @@ void fb_deferred_io_release(struct fb_info *info)
 		page->mapping = NULL;
 	}
 }
+
+void fb_deferred_io_release(struct fb_info *info)
+{
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
+	if (!--fbdefio->open_count)
+		fb_deferred_io_lastclose(info);
+}
 EXPORT_SYMBOL_GPL(fb_deferred_io_release);
 
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 
-	fb_deferred_io_release(info);
+	fb_deferred_io_lastclose(info);
 
 	kvfree(info->pagerefs);
 	mutex_destroy(&fbdefio->lock);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index d8d20514ea05..02d09cb57f6c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -212,6 +212,7 @@ struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
 	unsigned long delay;
 	bool sort_pagereflist; /* sort pagelist by offset */
+	int open_count; /* number of opened files; protected by fb_info lock */
 	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
-- 
2.35.3

