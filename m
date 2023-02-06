Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E193368B3A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBFBKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFBKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:10:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87450D533;
        Sun,  5 Feb 2023 17:10:18 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P97Tk2JtSzfYwq;
        Mon,  6 Feb 2023 09:10:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 09:10:16 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <sfrench@samba.org>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] cifs: Fix use-after-free in rdata->read_into_pages()
Date:   Mon, 6 Feb 2023 09:10:09 +0800
Message-ID: <20230206011009.1126177-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the network status is unstable, use-after-free may occur when
read data from the server.

  BUG: KASAN: use-after-free in readpages_fill_pages+0x14c/0x7e0

  Call Trace:
   <TASK>
   dump_stack_lvl+0x38/0x4c
   print_report+0x16f/0x4a6
   kasan_report+0xb7/0x130
   readpages_fill_pages+0x14c/0x7e0
   cifs_readv_receive+0x46d/0xa40
   cifs_demultiplex_thread+0x121c/0x1490
   kthread+0x16b/0x1a0
   ret_from_fork+0x2c/0x50
   </TASK>

  Allocated by task 2535:
   kasan_save_stack+0x22/0x50
   kasan_set_track+0x25/0x30
   __kasan_kmalloc+0x82/0x90
   cifs_readdata_direct_alloc+0x2c/0x110
   cifs_readdata_alloc+0x2d/0x60
   cifs_readahead+0x393/0xfe0
   read_pages+0x12f/0x470
   page_cache_ra_unbounded+0x1b1/0x240
   filemap_get_pages+0x1c8/0x9a0
   filemap_read+0x1c0/0x540
   cifs_strict_readv+0x21b/0x240
   vfs_read+0x395/0x4b0
   ksys_read+0xb8/0x150
   do_syscall_64+0x3f/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

  Freed by task 79:
   kasan_save_stack+0x22/0x50
   kasan_set_track+0x25/0x30
   kasan_save_free_info+0x2e/0x50
   __kasan_slab_free+0x10e/0x1a0
   __kmem_cache_free+0x7a/0x1a0
   cifs_readdata_release+0x49/0x60
   process_one_work+0x46c/0x760
   worker_thread+0x2a4/0x6f0
   kthread+0x16b/0x1a0
   ret_from_fork+0x2c/0x50

  Last potentially related work creation:
   kasan_save_stack+0x22/0x50
   __kasan_record_aux_stack+0x95/0xb0
   insert_work+0x2b/0x130
   __queue_work+0x1fe/0x660
   queue_work_on+0x4b/0x60
   smb2_readv_callback+0x396/0x800
   cifs_abort_connection+0x474/0x6a0
   cifs_reconnect+0x5cb/0xa50
   cifs_readv_from_socket.cold+0x22/0x6c
   cifs_read_page_from_socket+0xc1/0x100
   readpages_fill_pages.cold+0x2f/0x46
   cifs_readv_receive+0x46d/0xa40
   cifs_demultiplex_thread+0x121c/0x1490
   kthread+0x16b/0x1a0
   ret_from_fork+0x2c/0x50

The following function calls will cause UAF of the rdata pointer.

readpages_fill_pages
 cifs_read_page_from_socket
  cifs_readv_from_socket
   cifs_reconnect
    __cifs_reconnect
     cifs_abort_connection
      mid->callback() --> smb2_readv_callback
       queue_work(&rdata->work)  # if the worker completes first,
                                 # the rdata is freed
          cifs_readv_complete
            kref_put
              cifs_readdata_release
                kfree(rdata)
 return rdata->...               # UAF in readpages_fill_pages()

Similarly, this problem also occurs in the uncache_fill_pages().

Fix this by adjusts the order of condition judgment in the return
statement.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 fs/cifs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 22dfc1f8b4f1..b8d1cbadb689 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3889,7 +3889,7 @@ uncached_fill_pages(struct TCP_Server_Info *server,
 		rdata->got_bytes += result;
 	}
 
-	return rdata->got_bytes > 0 && result != -ECONNABORTED ?
+	return result != -ECONNABORTED && rdata->got_bytes > 0 ?
 						rdata->got_bytes : result;
 }
 
@@ -4665,7 +4665,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 		rdata->got_bytes += result;
 	}
 
-	return rdata->got_bytes > 0 && result != -ECONNABORTED ?
+	return result != -ECONNABORTED && rdata->got_bytes > 0 ?
 						rdata->got_bytes : result;
 }
 
-- 
2.31.1

