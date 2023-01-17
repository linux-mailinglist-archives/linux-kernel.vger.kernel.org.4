Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318AA66D793
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjAQIJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjAQIJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:09:07 -0500
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 00:09:04 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37C3A27494;
        Tue, 17 Jan 2023 00:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=r3n04DJgFHVshEDEg+
        AUJ2higmuVvr0IAv+oKTfkU5w=; b=hvPQEkl7vLmnnVGbiby/qgFOJ3lbmnooCD
        mk4X6V8gWMeAM4D03HtPowa+m0EjoldoyOxvG0GDf9vRwlx9boOSKJ6RfYDNVTg7
        qyyyNQHAPASyAZT3J/4+MBA6AzCL1Tu81R4Kv12k1Z5mBeFfuikDu/LCassZfrZq
        U5ypyA7nI=
Received: from bj.company.local (unknown [210.12.115.82])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wB3nUX6U8ZjmpW1Ag--.1680S2;
        Tue, 17 Jan 2023 15:53:30 +0800 (CST)
From:   Jie Wang <wangjie2011cs@163.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjie2011cs@163.com
Subject: [PATCH] block: check disk flag before setting scan bit
Date:   Tue, 17 Jan 2023 15:53:29 +0800
Message-Id: <20230117075329.14968-1-wangjie2011cs@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wB3nUX6U8ZjmpW1Ag--.1680S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1UAFy8Kw4xZF1Dtr1rtFb_yoW8Ar1xpF
        4kCFW5Kay8Xws0gFWqga1Iyr15Ga92yw48JFW3A39FvwnxArsakF4kKa4DCFy7trW7A3y2
        gF1FgFW5WFyxuFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRcdb5UUUUU=
X-Originating-IP: [210.12.115.82]
X-CM-SenderInfo: pzdqwytlhsiiwrfvqiywtou0bp/1tbiRxz5RFc7aKEkegAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to scan partitions for disk who has set flag GENHD_FL_NO_PART in
driver code. In disk_scan_partitions function, the same checking is
existing, so we believe this change is reasonable.

In our case, some virtual block devices are not managed by GPT, then scan
partition operation is not a must. So we set GENHD_FL_NO_PART flag in
driver intended to avoid partitions being dropped/added.
But GD_NEED_PART_SCAN bit was still set by bdev_check_media_change, which
causing problems here.

Signed-off-by: Jie Wang <wangjie2011cs@163.com>
---
 block/disk-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index aee25a7e1ab7..68d911135bc7 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -284,7 +284,8 @@ bool bdev_check_media_change(struct block_device *bdev)
 	if (__invalidate_device(bdev, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			bdev->bd_disk->disk_name);
-	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
+	if (!(bdev->bd_disk->flags & GENHD_FL_NO_PART))
+		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 	return true;
 }
 EXPORT_SYMBOL(bdev_check_media_change);
@@ -310,7 +311,8 @@ bool disk_force_media_change(struct gendisk *disk, unsigned int events)
 	if (__invalidate_device(disk->part0, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			disk->disk_name);
-	set_bit(GD_NEED_PART_SCAN, &disk->state);
+	if (!(bdev->bd_disk->flags & GENHD_FL_NO_PART))
+		set_bit(GD_NEED_PART_SCAN, &disk->state);
 	return true;
 }
 EXPORT_SYMBOL_GPL(disk_force_media_change);
-- 
2.17.1

