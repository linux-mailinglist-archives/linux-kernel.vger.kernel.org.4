Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622DB725269
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbjFGD0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjFGD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:26:33 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2655B1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:26:31 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 6joaqCNZMZvWO6joaq99Zz; Wed, 07 Jun 2023 05:26:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686108389;
        bh=HmXZpoupl67vmqpYTDqcmmy+1ehWH3IsOXimAF/m20M=;
        h=From:To:Cc:Subject:Date;
        b=HBpjQn7rxjCIpAnMpKlEwynLZeX56QyvY5X+oKLe5NGYlIg/LEPG4uxlMq24PDGjB
         dpMEdsSX6IjiGGbo9ZkB8N8YOrU8nQMp4I0AUnlOksEUVf5k2tA1CNoWxAADf3dzep
         4HwxDt9T6pOHdgqI/KTN4PPq3U0jszMJX4KQGf2YL4jzhOx7ke02wVAcRqYm0dGlqm
         qzqgnIeLK9repDagoC9d050kpt/malsw66JInq6Imk+txk9NV+kKp90m3U+DANTpSW
         vizR8fspgbNR1wVLl8eE0yg3Ah1dVMp9+NecEq8ULc/ciXHgFfs2u1PFqLATMPUad6
         LMJN5PrmJ4ntw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 07 Jun 2023 05:26:29 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dm/zone: Use the bitmap API to allocate bitmaps
Date:   Wed,  7 Jun 2023 05:26:27 +0200
Message-Id: <9014ccd13d83e9f78bfa86811a8012784333af56.1686108356.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/md/dm-zone.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 4b82b7798ce4..16776ad3794b 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -140,9 +140,9 @@ bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
 void dm_cleanup_zoned_dev(struct mapped_device *md)
 {
 	if (md->disk) {
-		kfree(md->disk->conv_zones_bitmap);
+		bitmap_free(md->disk->conv_zones_bitmap);
 		md->disk->conv_zones_bitmap = NULL;
-		kfree(md->disk->seq_zones_wlock);
+		bitmap_free(md->disk->seq_zones_wlock);
 		md->disk->seq_zones_wlock = NULL;
 	}
 
@@ -182,9 +182,8 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
 		if (!disk->conv_zones_bitmap) {
-			disk->conv_zones_bitmap =
-				kcalloc(BITS_TO_LONGS(disk->nr_zones),
-					sizeof(unsigned long), GFP_NOIO);
+			disk->conv_zones_bitmap = bitmap_zalloc(disk->nr_zones,
+								GFP_NOIO);
 			if (!disk->conv_zones_bitmap)
 				return -ENOMEM;
 		}
@@ -193,9 +192,8 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
 		if (!disk->seq_zones_wlock) {
-			disk->seq_zones_wlock =
-				kcalloc(BITS_TO_LONGS(disk->nr_zones),
-					sizeof(unsigned long), GFP_NOIO);
+			disk->seq_zones_wlock = bitmap_zalloc(disk->nr_zones,
+							      GFP_NOIO);
 			if (!disk->seq_zones_wlock)
 				return -ENOMEM;
 		}
-- 
2.34.1

