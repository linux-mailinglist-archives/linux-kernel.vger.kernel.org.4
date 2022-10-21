Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAECD60708A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJUGyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUGyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:54:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD822E8F8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:54:13 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtwDV50ZbzHty9;
        Fri, 21 Oct 2022 14:54:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 14:54:10 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <axboe@kernel.dk>, <chaitanya.kulkarni@wdc.com>
CC:     <lizetao1@huawei.com>, <hch@lst.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubi: block: KASAN null-ptr-deref in ubiblock_create()
Date:   Fri, 21 Oct 2022 15:57:28 +0800
Message-ID: <20221021075728.1209184-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a null-ptr-deref when testing the ubiblock tools:

  KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
  CPU: 1 PID: 2299 Comm: ubiblock Not tainted
  6.1.0-rc1-00002-gebb24af8c872-dirty #12
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
  BIOS 1.14.0-1.fc33 04/01/2014
  RIP: 0010:ubiblock_create.cold+0x175/0x1b5 [ubi]
  ...
  Call Trace:
   vol_cdev_ioctl+0x6ce/0x870 [ubi]
   __x64_sys_ioctl+0x11d/0x170
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0
  RIP: 0033:0x7fd9141230ab

when blk_mq_alloc_tag_set() returns an error, the dev->gd is
uninitialized, that causing null-ptr-deref fault.

Fix it by replacing the disk_to_dev(dev->gd) with NULL, that
will printk "(NULL device *): ..." message if blk_mq_alloc_tag_set()
returns an error.

Fixes: 77567b25ab9f ("ubi: use blk_mq_alloc_disk and blk_cleanup_disk")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/mtd/ubi/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 75eaecc8639f..9625dc2f45e2 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -408,7 +408,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
 
 	ret = blk_mq_alloc_tag_set(&dev->tag_set);
 	if (ret) {
-		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
+		dev_err(NULL, "blk_mq_alloc_tag_set failed");
 		goto out_free_dev;
 	}
 
-- 
2.31.1

