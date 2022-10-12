Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452C35FC56F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJLMgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJLMgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:36:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4401DF00;
        Wed, 12 Oct 2022 05:36:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MnXCV6ZjLzl9XM;
        Wed, 12 Oct 2022 20:34:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCXl8nJtEZjnY6gAA--.12812S4;
        Wed, 12 Oct 2022 20:36:27 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, gregkh@linuxfoundation.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com,
        johannes.thumshirn@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RFC] block: fix use after free for bd_holder_dir/slave_dir
Date:   Wed, 12 Oct 2022 20:58:38 +0800
Message-Id: <20221012125838.1608619-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXl8nJtEZjnY6gAA--.12812S4
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW3Kr47WFyDGw1DCr4DArb_yoW7ZryfpF
        s8Ga97ArW8WryDuw47Xa4xWr1UJa1DJwn7Gasa9r4I9r43A3yqyFyUtrW7ua47WryfCFW5
        Z3WDt3W5Jr18G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Our test report a following uaf:

==================================================================
BUG: KASAN: use-after-free in sysfs_remove_link+0x23/0x60
Read of size 8 at addr ffff888117398db0 by task dmsetup/1097

CPU: 12 PID: 1097 Comm: dmsetup Not tainted 6.0.0-next-20221007-00011-gf46c8956
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-4
Call Trace:
 <TASK>
 ? dump_stack_lvl+0x73/0x9f
 ? print_report+0x249/0x746
 ? __virt_addr_valid+0xd4/0x200
 ? sysfs_remove_link+0x23/0x60
 ? kasan_report+0xc0/0x120
 ? sysfs_remove_link+0x23/0x60
 ? __asan_load8+0x74/0x110
 ? sysfs_remove_link+0x23/0x60
 ? __unlink_disk_holder.isra.0+0x2f/0x80
 ? bd_unlink_disk_holder+0xd2/0x1c0
 ? dm_put_table_device+0xf1/0x250
 ? dm_put_device+0x14f/0x230
 ? linear_dtr+0x34/0x50
 ? dm_table_destroy+0x7b/0x280
 ? table_load+0x34a/0x710
 ? list_devices+0x4c0/0x4c0
 ? kvmalloc_node+0x7d/0x160
 ? __kmalloc_node+0x185/0x2b0
 ? ctl_ioctl+0x388/0x7b0
 ? list_devices+0x4c0/0x4c0
 ? free_params+0x50/0x50
 ? do_vfs_ioctl+0x931/0x10d0
 ? tick_program_event+0x65/0xd0
 ? __kasan_check_read+0x1d/0x30
 ? __fget_light+0xc2/0x370
 ? dm_ctl_ioctl+0x12/0x20
 ? __x64_sys_ioctl+0xd5/0x150
 ? do_syscall_64+0x35/0x80
 ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

Allocated by task 1097:
 kasan_save_stack+0x26/0x60
 kasan_set_track+0x29/0x40
 kasan_save_alloc_info+0x1f/0x40
 __kasan_kmalloc+0xcb/0xe0
 kmalloc_trace+0x7e/0x150
 kobject_create_and_add+0x3d/0xc0
 device_add_disk+0x429/0x7e0
 dm_setup_md_queue+0x15b/0x240
 table_load+0x469/0x710
 ctl_ioctl+0x388/0x7b0
 dm_ctl_ioctl+0x12/0x20
 __x64_sys_ioctl+0xd5/0x150
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 1097:
 kasan_save_stack+0x26/0x60
 kasan_set_track+0x29/0x40
 kasan_save_free_info+0x32/0x60
 __kasan_slab_free+0x172/0x2c0
 __kmem_cache_free+0x11c/0x560
 kfree+0xd3/0x240
 dynamic_kobj_release+0x1e/0x60
 kobject_put+0x192/0x410
 device_add_disk+0x535/0x7e0
 dm_setup_md_queue+0x15b/0x240
 table_load+0x469/0x710
 ctl_ioctl+0x388/0x7b0
 dm_ctl_ioctl+0x12/0x20
 __x64_sys_ioctl+0xd5/0x150
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

This problem is very easy to reporduce by injecting failure while creating
dm, and root cause is that lifetime of bd_holder_dir/slave_dir is
problematic:

1) device alloc
alloc_disk_node
 kzalloc_node			-> gendisk
 disk->part0 = bdev_alloc	-> part0
 device_initialize
  kobject_init()		-> part0->bd_device

2) device create
device_add_disk
 device_add
  kobject_add			-> part0->bd_device
 kobject_create_and_add		-> part0->bd_holder_dir
 kobject_create_and_add		-> gendisk->slave_dir

3) device remove
del_gendisk
 kobject_put			-> part0->bd_holder_dir
 kobject_put			-> gendisk->slave_dir
 device_del
  kobject_del			-> part0->bd_device

4) device free
disk_release
 iput
  bdev_free_inode
   kfree			-> gendisk
   kmem_cache_free		-> part0

bd_holder_dir and slave_dir is allocated in step 2), and freed in steup
3), while they are still accessible before step 4).

This patch delay the kobject destruction to disk_release/part_release to
fix the problem.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c           | 7 ++++---
 block/partitions/core.c | 3 ++-
 drivers/base/core.c     | 1 -
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c..7ebd085d3a3f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -615,9 +615,6 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_unregister_queue(disk);
 
-	kobject_put(disk->part0->bd_holder_dir);
-	kobject_put(disk->slave_dir);
-
 	part_stat_set_all(disk->part0, 0);
 	disk->part0->bd_stamp = 0;
 	if (!sysfs_deprecated)
@@ -1139,6 +1136,10 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
+	kobject_put(disk->part0->bd_holder_dir);
+	kobject_put(disk->slave_dir);
+	kobject_del(&dev->kobj);
+
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b8112f52d388..b86a66198cc8 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -250,6 +250,8 @@ static const struct attribute_group *part_attr_groups[] = {
 
 static void part_release(struct device *dev)
 {
+	kobject_put(dev_to_bdev(dev)->bd_holder_dir);
+	kobject_del(&dev->kobj);
 	put_disk(dev_to_bdev(dev)->bd_disk);
 	iput(dev_to_bdev(dev)->bd_inode);
 }
@@ -279,7 +281,6 @@ static void delete_partition(struct block_device *part)
 	__invalidate_device(part, true);
 
 	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
-	kobject_put(part->bd_holder_dir);
 	device_del(&part->bd_device);
 
 	/*
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d02501933467..d2ff3d2a8710 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3712,7 +3712,6 @@ void device_del(struct device *dev)
 					     BUS_NOTIFY_REMOVED_DEVICE, dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
-	kobject_del(&dev->kobj);
 	cleanup_glue_dir(dev, glue_dir);
 	memalloc_noio_restore(noio_flag);
 	put_device(parent);
-- 
2.31.1

