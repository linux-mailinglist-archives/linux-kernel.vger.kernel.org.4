Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC06120EB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJ2HRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2HRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:17:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C9717FD53;
        Sat, 29 Oct 2022 00:17:16 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MzrFz06WJzVjK5;
        Sat, 29 Oct 2022 15:12:23 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 15:17:14 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 15:17:14 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <mcgrof@kernel.org>, <hare@suse.de>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] block: Fix possible memory leak for rq_wb on add_disk failure
Date:   Sat, 29 Oct 2022 15:13:55 +0800
Message-ID: <20221029071355.35462-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak reported memory leaks in device_add_disk():

kmemleak: 3 new suspected memory leaks

unreferenced object 0xffff88800f420800 (size 512):
  comm "modprobe", pid 4275, jiffies 4295639067 (age 223.512s)
  hex dump (first 32 bytes):
    04 00 00 00 08 00 00 00 01 00 00 00 00 00 00 00  ................
    00 e1 f5 05 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d3662699>] kmalloc_trace+0x26/0x60
    [<00000000edc7aadc>] wbt_init+0x50/0x6f0
    [<0000000069601d16>] wbt_enable_default+0x157/0x1c0
    [<0000000028fc393f>] blk_register_queue+0x2a4/0x420
    [<000000007345a042>] device_add_disk+0x6fd/0xe40
    [<0000000060e6aab0>] nbd_dev_add+0x828/0xbf0 [nbd]
    ...

It is because the memory allocated in wbt_enable_default() is not
released in device_add_disk() error path.
Normally, these memory are freed in:

del_gendisk()
  rq_qos_exit()
    rqos->ops->exit(rqos);
      wbt_exit()

So rq_qos_exit() is called to free the rq_wb memory for wbt_init().
However in the error path of device_add_disk(), only
blk_unregister_queue() is called and make rq_wb memory leaked.

Add rq_qos_exit() to the error path to fix it.

Fixes: 83cbce957446 ("block: add error handling for device_add_disk / add_disk")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 block/genhd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/genhd.c b/block/genhd.c
index fee90eb98b4a..0f9769db2de8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -527,6 +527,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		bdi_unregister(disk->bdi);
 out_unregister_queue:
 	blk_unregister_queue(disk);
+	rq_qos_exit(disk->queue);
 out_put_slave_dir:
 	kobject_put(disk->slave_dir);
 out_put_holder_dir:
-- 
2.17.1

