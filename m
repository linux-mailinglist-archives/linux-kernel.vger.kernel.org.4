Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0201C70DD43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjEWNMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjEWNMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:12:30 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE94118
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684847548;
  x=1716383548;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RUsNkf5+Wyu4/3oi86PLsyVVhLWM8zFhO0TpoHKYz90=;
  b=m61cYwm3cRTHn9zXZso2dbTGIxJsArciwxaatZiBNrMT/Np4brtkI4Vn
   ijF2CUqHU7JxFj8LL9PTD9p//6hT7yhEsy2RK/1K1kb6tgvKBdV77U5Wn
   1t/E8ZDN2fCJT2EDH+2nwyw9GHu1IWhUb8+nMGqItK0xluBsE3vL8mGad
   ZG9iJDuP1DBq8oTWpLT7+wzagEPJjg6xQlJ8y8/Jz5++qjaR7oT3Sw4mY
   bYiyMXA95RMnPY5y3fGmQ3XMZp9aAVEacy75OvChXltK6yLKRheN+2yos
   iWBR08QrnDyDO1sc2dYy86/q+cgzfPTd/G1wJdYutwYE5awxDOahmRjSG
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Tue, 23 May 2023 15:12:16 +0200
Subject: [PATCH 1/2] ubi: block: Fix use-after-free of gendisk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230523-ubiblock-remove-v1-1-240bed75849b@axis.com>
References: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
In-Reply-To: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not touch the gendisk after put_disk() to fix this use-after-free:

 ==================================================
 BUG: KASAN: slab-use-after-free in ubiblock_remove
 Read of size 4 by task ubiblock/361

 Call Trace:
 ubiblock_remove (drivers/mtd/ubi/block.c:459 drivers/mtd/ubi/block.c:483)
 vol_cdev_ioctl
 ...

 Allocated by task 358:
 __alloc_disk_node (block/genhd.c:1377)
 __blk_mq_alloc_disk (block/blk-mq.c:4093)
 ubiblock_create (drivers/mtd/ubi/block.c:397)
 vol_cdev_ioctl
 ...

 Freed by task 0:
 bdev_free_inode (block/bdev.c:337)
 i_callback
 rcu_core
 __do_softirq
 ...

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mtd/ubi/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 3711d7f74600..70caec4606cd 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -448,13 +448,15 @@ int ubiblock_create(struct ubi_volume_info *vi)
 
 static void ubiblock_cleanup(struct ubiblock *dev)
 {
+	int first_minor = dev->gd->first_minor;
+
 	/* Stop new requests to arrive */
 	del_gendisk(dev->gd);
 	/* Finally destroy the blk queue */
 	dev_info(disk_to_dev(dev->gd), "released");
 	put_disk(dev->gd);
 	blk_mq_free_tag_set(&dev->tag_set);
-	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
+	idr_remove(&ubiblock_minor_idr, first_minor);
 }
 
 int ubiblock_remove(struct ubi_volume_info *vi)

-- 
2.34.1

