Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D86F6AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjEDMJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEDMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:09:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE285FCE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:09:48 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QBsyj5Z7kzsR5q;
        Thu,  4 May 2023 20:07:57 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 20:09:43 +0800
Subject: Re: [PATCH -next,V2 1/2] ubi: fix slab-out-of-bounds in
 ubi_eba_get_ldesc+0xfb/0x130
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230504025354.3595768-1-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3158c9dc-9f7b-b443-e442-6e38afd340de@huawei.com>
Date:   Thu, 4 May 2023 20:09:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230504025354.3595768-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/5/4 10:53, ZhaoLong Wang Ð´µÀ:
> From: Guo Xuenan <guoxuenan@huawei.com>
> 
> When using ioctl interface to resize ubi volume, ubi_resize_volume will
> resize eba table first, but not change vol->reserved_pebs in the same
> atomic context which may cause concurrency access eba table.
> 
> For example, When user do shrink ubi volume A calling ubi_resize_volume,
> while the other thread is writing (volume B) and triggering wear-leveling,
> which may calling ubi_write_fastmap, under these circumstances, KASAN may
> report: slab-out-of-bounds in ubi_eba_get_ldesc+0xfb/0x130.
> 
> The main work of this patch include:
> 1. fix races in ubi_resize_volume and ubi_update_fastmap, to avoid
>     eba_tbl read out of bounds. first, we make eba_tbl and reserved_pebs
>     updating under the protect of vol->volumes_lock. second, rollback
>     volume in case of resize failure. Also mention that for volume
>     shrinking failure, since part of volume has been shrunk and unmapped,
>     there is no need to recover {rsvd/avail}_pebs.

> 2. fix some memleak in error path of ubi_resize_volume when destroy
>     new_eba_tbl.

This line can be deleted.

> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in ubi_eba_get_ldesc+0xfb/0x130 [ubi]
> Read of size 4 at addr ffff88800f43f570 by task kworker/u16:0/7
> CPU: 0 PID: 7 Comm: kworker/u16:0 Not tainted 5.16.0-rc7 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Workqueue: writeback wb_workfn (flush-ubifs_0_0)
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4d/0x66
>   print_address_description.constprop.0+0x41/0x60
>   kasan_report.cold+0x83/0xdf
>   ubi_eba_get_ldesc+0xfb/0x130 [ubi]
>   ubi_update_fastmap.cold+0x60f/0xc7d [ubi]
>   ubi_wl_get_peb+0x25b/0x4f0 [ubi]
>   try_write_vid_and_data+0x9a/0x4d0 [ubi]
>   ubi_eba_write_leb+0x7e4/0x17d0 [ubi]
>   ubi_leb_map+0x1a0/0x2c0 [ubi]
>   ubifs_leb_map+0x139/0x270 [ubifs]
>   ubifs_add_bud_to_log+0xb40/0xf30 [ubifs]
>   make_reservation+0x86e/0xb00 [ubifs]
>   ubifs_jnl_write_data+0x430/0x9d0 [ubifs]
>   do_writepage+0x1d1/0x550 [ubifs]
>   ubifs_writepage+0x37c/0x670 [ubifs]
>   __writepage+0x67/0x170
>   write_cache_pages+0x259/0xa90
>   do_writepages+0x277/0x5d0
>   __writeback_single_inode+0xb8/0x850
>   writeback_sb_inodes+0x4b3/0xb20
>   __writeback_inodes_wb+0xc1/0x220
>   wb_writeback+0x59f/0x740
>   wb_workfn+0x6d0/0xca0
>   process_one_work+0x711/0xfc0
>   worker_thread+0x95/0xd00
>   kthread+0x3a6/0x490
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> Allocated by task 711:
>   kasan_save_stack+0x1e/0x50
>   __kasan_kmalloc+0x81/0xa0
>   ubi_eba_create_table+0x88/0x1a0 [ubi]
>   ubi_resize_volume.cold+0x175/0xae7 [ubi]
>   ubi_cdev_ioctl+0x57f/0x1a60 [ubi]
>   __x64_sys_ioctl+0x13a/0x1c0
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Last potentially related work creation:
>   kasan_save_stack+0x1e/0x50
>   __kasan_record_aux_stack+0xb7/0xc0
>   call_rcu+0xd6/0x1000
>   blk_stat_free_callback+0x28/0x30
>   blk_release_queue+0x8a/0x2e0
>   kobject_put+0x186/0x4c0
>   scsi_device_dev_release_usercontext+0x620/0xbd0
>   execute_in_process_context+0x2f/0x120
>   device_release+0xa4/0x240
>   kobject_put+0x186/0x4c0
>   put_device+0x20/0x30
>   __scsi_remove_device+0x1c3/0x300
>   scsi_probe_and_add_lun+0x2140/0x2eb0
>   __scsi_scan_target+0x1f2/0xbb0
>   scsi_scan_channel+0x11b/0x1a0
>   scsi_scan_host_selected+0x24c/0x310
>   do_scsi_scan_host+0x1e0/0x250
>   do_scan_async+0x45/0x490
>   async_run_entry_fn+0xa2/0x530
>   process_one_work+0x711/0xfc0
>   worker_thread+0x95/0xd00
>   kthread+0x3a6/0x490
>   ret_from_fork+0x1f/0x30
> The buggy address belongs to the object at ffff88800f43f500
>   which belongs to the cache kmalloc-128 of size 128
> The buggy address is located 112 bytes inside of
>   128-byte region [ffff88800f43f500, ffff88800f43f580)
> The buggy address belongs to the page:
> page:ffffea00003d0f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xf43c
> head:ffffea00003d0f00 order:2 compound_mapcount:0 compound_pincount:0
> flags: 0x1fffff80010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
> raw: 001fffff80010200 ffffea000046ba08 ffffea0000457208 ffff88810004d1c0
> raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> Memory state around the buggy address:
>   ffff88800f43f400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88800f43f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff88800f43f500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>                                                               ^
>   ffff88800f43f580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88800f43f600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> 
> The following steps can used to reproduce:
> Process 1: write and trigger ubi wear-leveling
>      ubimkvol /dev/ubi0 -s 5000MiB -N v1
>      ubimkvol /dev/ubi0 -s 2000MiB -N v2
>      ubimkvol /dev/ubi0 -s 10MiB -N v3
>      mount -t ubifs /dev/ubi0_0 /mnt/ubifs
>      while true;
>      do
>          filename=/mnt/ubifs/$((RANDOM))
>          dd if=/dev/random of=${filename} bs=1M count=$((RANDOM % 1000))
>          rm -rf ${filename}
>          sync /mnt/ubifs/
>      done
> 
> Process 2: do random resize
>      struct ubi_rsvol_req req;
>      req.vol_id = 1;
>      req.bytes = (rand() % 50) * 512KB;
>      ioctl(fd, UBI_IOCRSVOL, &req);
> 
> V2:
>   - Add volumes_lock in ubi_eba_copy_leb() to avoid race caused by
>     updating eba_tbl.
> 
> V1:
>   - Rebase the patch on the latest mainline.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/eba.c |  7 +++++++
>   drivers/mtd/ubi/vmt.c | 24 +++++++++++++++++-------
>   2 files changed, 24 insertions(+), 7 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
