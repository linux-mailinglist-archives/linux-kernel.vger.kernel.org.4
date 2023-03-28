Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9494C6CB9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjC1IqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjC1IqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:46:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC455A1;
        Tue, 28 Mar 2023 01:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2E521FDA1;
        Tue, 28 Mar 2023 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679993165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XkRrVX8XzPB5UHUjHXjJ+xWWlRyOClSfTOm/ZrUGMDw=;
        b=BXUn2XOtBlkO6BfqJ9xz1Y8JkP8uIsgjzDECMGZ0Jh/UurP91nuLzaw9ZDMKbiiO4tpgKn
        48XtNjyA4FGeWwJDGjFzuzqKiaGnm/Xh/6L5tLJypGtfmM2kE3IixxVyNd5tURiLH/24Hi
        XN7f7GP61eB39zwsjvWYRnfODaJQtPY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC5A91390D;
        Tue, 28 Mar 2023 08:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X72GKEypImQKLwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 28 Mar 2023 08:46:04 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] xen/scsiback: don't call scsiback_free_translation_entry() under lock
Date:   Tue, 28 Mar 2023 10:46:02 +0200
Message-Id: <20230328084602.20729-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scsiback_free_translation_entry() shouldn't be called under spinlock,
as it can sleep.

This requires to split removing a translation entry from the v2p list
from actually calling kref_put() for the entry.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/lkml/Y+JUIl64UDmdkboh@kadam/
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xen-scsiback.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 954188b0b858..294f29cdc7aa 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -1010,12 +1010,6 @@ static int scsiback_add_translation_entry(struct vscsibk_info *info,
 	return err;
 }
 
-static void __scsiback_del_translation_entry(struct v2p_entry *entry)
-{
-	list_del(&entry->l);
-	kref_put(&entry->kref, scsiback_free_translation_entry);
-}
-
 /*
   Delete the translation entry specified
 */
@@ -1024,18 +1018,20 @@ static int scsiback_del_translation_entry(struct vscsibk_info *info,
 {
 	struct v2p_entry *entry;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&info->v2p_lock, flags);
 	/* Find out the translation entry specified */
 	entry = scsiback_chk_translation_entry(info, v);
 	if (entry)
-		__scsiback_del_translation_entry(entry);
-	else
-		ret = -ENOENT;
+		list_del(&entry->l);
 
 	spin_unlock_irqrestore(&info->v2p_lock, flags);
-	return ret;
+
+	if (!entry)
+		return -ENOENT;
+
+	kref_put(&entry->kref, scsiback_free_translation_entry);
+	return 0;
 }
 
 static void scsiback_do_add_lun(struct vscsibk_info *info, const char *state,
@@ -1239,14 +1235,19 @@ static void scsiback_release_translation_entry(struct vscsibk_info *info)
 {
 	struct v2p_entry *entry, *tmp;
 	struct list_head *head = &(info->v2p_entry_lists);
+	struct list_head tmp_list;
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->v2p_lock, flags);
 
-	list_for_each_entry_safe(entry, tmp, head, l)
-		__scsiback_del_translation_entry(entry);
+	list_cut_before(&tmp_list, head, head);
 
 	spin_unlock_irqrestore(&info->v2p_lock, flags);
+
+	list_for_each_entry_safe(entry, tmp, &tmp_list, l) {
+		list_del(&entry->l);
+		kref_put(&entry->kref, scsiback_free_translation_entry);
+	}
 }
 
 static void scsiback_remove(struct xenbus_device *dev)
-- 
2.35.3

