Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54673FBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjF0MIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0MIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:08:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2734C173C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:08:41 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qr3Pc1D1mzTlP5;
        Tue, 27 Jun 2023 20:07:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 20:08:38 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH 2/2] swap: Stop add to avail list is swap is full
Date:   Tue, 27 Jun 2023 20:08:33 +0800
Message-ID: <20230627120833.2230766-3-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627120833.2230766-1-mawupeng1@huawei.com>
References: <20230627120833.2230766-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Our test find a WARN_ON in add_to_avail_list. During add_to_avail_list,
avail_lists is already in swap_avail_heads, while lead to this WARN_ON.

Here is the simplified calltrace:

------------[ cut here ]------------
Call trace:
 add_to_avail_list+0xb8/0xc0
 swap_range_free+0x110/0x138
 swapcache_free_entries+0x100/0x1c0
 free_swap_slot+0xbc/0xe0
 put_swap_folio+0x1f0/0x2ec
 delete_from_swap_cache+0x6c/0xd0
 folio_free_swap+0xa4/0xe4
 __try_to_reclaim_swap+0x9c/0x190
 free_swap_and_cache+0x84/0x88
 unmap_page_range+0x31c/0x934
 unmap_single_vma.isra.0+0x48/0x84
 unmap_vmas+0x98/0x10c
 exit_mmap+0xa4/0x210
 mmput+0x88/0x158
 do_exit+0x284/0x970
 do_group_exit+0x34/0x90
 post_copy_siginfo_from_user32+0x0/0x1cc
 do_notify_resume+0x15c/0x470
 el0_svc+0x74/0x84
 el0t_64_sync_handler+0xb8/0xbc
 el0t_64_sync+0x190/0x194

During swapoff, try_to_unuse fail to alloc memory due to memory limit and
this lead the failure of swapoff and casing re-insert swap space back into
swap_list. During _enable_swap_info, this swap device is added to avail
list even this swap device if full. At the same time, one entry in this
full swap device in released and try to add this device into avail list
and found it is already in the avail list. This cause this WARN_ON.

To fix this. Stop add to avail list is swap is full.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/swapfile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 879cb80bf37b..0167999fa228 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2337,7 +2337,10 @@ static void _enable_swap_info(struct swap_info_struct *p)
 	 * swap_info_struct.
 	 */
 	plist_add(&p->list, &swap_active_head);
-	add_to_avail_list(p);
+
+	/* add to avaliable list iff swap device is not full */
+	if (p->highest_bit)
+		add_to_avail_list(p);
 }
 
 static void enable_swap_info(struct swap_info_struct *p, int prio,
-- 
2.25.1

