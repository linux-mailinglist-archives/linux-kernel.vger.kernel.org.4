Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C261641733
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLCOIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLCOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:07:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D042A1;
        Sat,  3 Dec 2022 06:07:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCE48B80171;
        Sat,  3 Dec 2022 14:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FF0C433D6;
        Sat,  3 Dec 2022 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670076470;
        bh=vU2RIMt0NQ9fPaVqCgnRSsvOgTRXxBc1YGXBbcmUD68=;
        h=From:To:Cc:Subject:Date:From;
        b=DvawMEc+zVNJcxmPjDr8FsVB2ARFHxB00EEsRUFa38/bpP7VcQgzD3iW4mmPdxthp
         HT2zMLqznz8dqcN9bZeIy3DFqtSH2+Yww2L4mRKYCDERKb5aaMxn5XReCIOSrHJoIL
         lDnOpb9QJAgQZwSTOPg4XZM3VfadZU8kBenvm06g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] block: remove devnode callback from struct block_device_operations
Date:   Sat,  3 Dec 2022 15:07:47 +0100
Message-Id: <20221203140747.1942969-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774; i=gregkh@linuxfoundation.org; h=from:subject; bh=vU2RIMt0NQ9fPaVqCgnRSsvOgTRXxBc1YGXBbcmUD68=; b=owGbwMvMwCRo6H6F97bub03G02pJDMndEYYWDB8OMfzzs56xZLv7/fqFzOL/ZRztir4wVE1lPfh6 tadlRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExE6CLDgqYpPcry8ulrrp5//Sw1Qm GJ0dm99xkWnH2cnfK+tCCeV2LVztOSrxPOBqtfBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of the pktcdvd driver, there are no in-kernel users of
the devnode callback in struct block_device_operations, so it can be
safely removed.  If it is needed for new block drivers in the future, it
can be brought back.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/genhd.c          | 11 -----------
 include/linux/blkdev.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0f9769db2de8..1a2f3fa5678f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1193,21 +1193,10 @@ struct class block_class = {
 	.dev_uevent	= block_uevent,
 };
 
-static char *block_devnode(struct device *dev, umode_t *mode,
-			   kuid_t *uid, kgid_t *gid)
-{
-	struct gendisk *disk = dev_to_disk(dev);
-
-	if (disk->fops->devnode)
-		return disk->fops->devnode(disk, mode);
-	return NULL;
-}
-
 const struct device_type disk_type = {
 	.name		= "disk",
 	.groups		= disk_attr_groups,
 	.release	= disk_release,
-	.devnode	= block_devnode,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 891f8cbcd043..b767c6b86856 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1413,7 +1413,6 @@ struct block_device_operations {
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
-	char *(*devnode)(struct gendisk *disk, umode_t *mode);
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
-- 
2.38.1

