Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C08622E54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiKIOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiKIOsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:48:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFF12AFF;
        Wed,  9 Nov 2022 06:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED61617EF;
        Wed,  9 Nov 2022 14:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E4AC433D6;
        Wed,  9 Nov 2022 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668005328;
        bh=W0WuuVf8t/q9rQq3isA02nICwNHjjQivDzXXjUr4+hI=;
        h=From:To:Cc:Subject:Date:From;
        b=cEtUq/5XQkgmL1ADq2JFNbtjqCzbfmRQ5eFD5wqP1b7kTgoDvMBponlnkSf3DLTXt
         aRjd1EZICr/EAjjuulNSElaiCy32Wts4Doe2bbST5RHDTecXts8lTNBGVe8yXDzBmZ
         EtRnugnrrMFWgPXxkB2vEjU9+GjPmdF6d27H4Wyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org
Subject: [PATCH] blkdev: make struct block_device_operations.devnode() take a const *
Date:   Wed,  9 Nov 2022 15:48:43 +0100
Message-Id: <20221109144843.679668-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=gregkh@linuxfoundation.org; h=from:subject; bh=W0WuuVf8t/q9rQq3isA02nICwNHjjQivDzXXjUr4+hI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnZe0/d42C7L3vGWUFj2uZDG6OPtR+KOLwlqrXd/B1LZbvG xq4VHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARlX6G+b5R+nw/P2o+q87eynRXif N/bYOKOcNcqVTNeWtrHB0XXs/IrbFY6V2teSgTAA==
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

The devnode() callback in struct block_device_operations should not be
modifying the device that is passed into it, so mark it as a const * and
propagate the function signature changes out into the one subsystem that
actually uses this callback.

Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Jens, I have some dependent kobject/driver core changes that require
this change in the works.  Can I take this through the driver core tree
for 6.2-rc1?

 drivers/block/pktcdvd.c | 2 +-
 include/linux/blkdev.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 4cea3b08087e..8dc15be95962 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2632,7 +2632,7 @@ static unsigned int pkt_check_events(struct gendisk *disk,
 	return attached_disk->fops->check_events(attached_disk, clearing);
 }
 
-static char *pkt_devnode(struct gendisk *disk, umode_t *mode)
+static char *pkt_devnode(const struct gendisk *disk, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "pktcdvd/%s", disk->disk_name);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d98..2a455793462b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1413,7 +1413,7 @@ struct block_device_operations {
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
-	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+	char *(*devnode)(const struct gendisk *disk, umode_t *mode);
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
-- 
2.38.1

