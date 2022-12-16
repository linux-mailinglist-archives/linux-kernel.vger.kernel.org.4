Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E964ED47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiLPO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiLPO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:58:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280546036B;
        Fri, 16 Dec 2022 06:58:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4D0734319;
        Fri, 16 Dec 2022 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671202716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x36AuY9fdrueTpOox7l4aH9J7+eTrfGAHM9OlY2CQHU=;
        b=SpGCTUY9+p3OSfiSSP0kSXj9iihsB9mtnEn6ajE8dHqS/FXFp5u52Ir2MnnMN0A0cCXhCR
        /nXL0RpYDQ5qQuU2FRxvLaqebBWdRkl6u08yKZs+ggqLcW7K2N/SgFEgEOusM82T6Xk9rN
        7dJmWlPYvDa0JU/uSa6/ZfB3W7Wi8OE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93C0B138FD;
        Fri, 16 Dec 2022 14:58:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ccTCIpyHnGPPeAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 16 Dec 2022 14:58:36 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH 3/4] xen/blkback: simplify free_persistent_gnts() interface
Date:   Fri, 16 Dec 2022 15:58:15 +0100
Message-Id: <20221216145816.27374-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216145816.27374-1-jgross@suse.com>
References: <20221216145816.27374-1-jgross@suse.com>
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

The interface of free_persistent_gnts() can be simplified, as there is
only a single caller of free_persistent_gnts() and the 2nd and 3rd
parameters are easily obtainable via the ring pointer, which is passed
as the first parameter anyway.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkback/blkback.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 6e2163aaf362..243712b59a05 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -239,9 +239,9 @@ static void put_persistent_gnt(struct xen_blkif_ring *ring,
 	atomic_dec(&ring->persistent_gnt_in_use);
 }
 
-static void free_persistent_gnts(struct xen_blkif_ring *ring, struct rb_root *root,
-                                 unsigned int num)
+static void free_persistent_gnts(struct xen_blkif_ring *ring)
 {
+	struct rb_root *root = &ring->persistent_gnts;
 	struct gnttab_unmap_grant_ref unmap[BLKIF_MAX_SEGMENTS_PER_REQUEST];
 	struct page *pages[BLKIF_MAX_SEGMENTS_PER_REQUEST];
 	struct persistent_gnt *persistent_gnt;
@@ -249,6 +249,9 @@ static void free_persistent_gnts(struct xen_blkif_ring *ring, struct rb_root *ro
 	int segs_to_unmap = 0;
 	struct gntab_unmap_queue_data unmap_data;
 
+	if (RB_EMPTY_ROOT(root))
+		return;
+
 	unmap_data.pages = pages;
 	unmap_data.unmap_ops = unmap;
 	unmap_data.kunmap_ops = NULL;
@@ -277,9 +280,11 @@ static void free_persistent_gnts(struct xen_blkif_ring *ring, struct rb_root *ro
 
 		rb_erase(&persistent_gnt->node, root);
 		kfree(persistent_gnt);
-		num--;
+		ring->persistent_gnt_c--;
 	}
-	BUG_ON(num != 0);
+
+	BUG_ON(!RB_EMPTY_ROOT(&ring->persistent_gnts));
+	BUG_ON(ring->persistent_gnt_c != 0);
 }
 
 void xen_blkbk_unmap_purged_grants(struct work_struct *work)
@@ -631,12 +636,7 @@ int xen_blkif_schedule(void *arg)
 void xen_blkbk_free_caches(struct xen_blkif_ring *ring)
 {
 	/* Free all persistent grant pages */
-	if (!RB_EMPTY_ROOT(&ring->persistent_gnts))
-		free_persistent_gnts(ring, &ring->persistent_gnts,
-			ring->persistent_gnt_c);
-
-	BUG_ON(!RB_EMPTY_ROOT(&ring->persistent_gnts));
-	ring->persistent_gnt_c = 0;
+	free_persistent_gnts(ring);
 
 	/* Since we are shutting down remove all pages from the buffer */
 	gnttab_page_cache_shrink(&ring->free_pages, 0 /* All */);
-- 
2.35.3

