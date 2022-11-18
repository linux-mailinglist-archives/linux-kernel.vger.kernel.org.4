Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8550A62F5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiKRNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiKRNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:13:40 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B72AE01
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:13:34 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDHF23DkxzqSW1;
        Fri, 18 Nov 2022 21:09:42 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 21:13:32 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 21:13:32 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <hugh@veritas.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        <xialonglong1@huawei.com>, <chenwandun@huawei.com>
Subject: [RFC PATCH] swapfile: fix soft lockup in scan_swap_map_slots
Date:   Fri, 18 Nov 2022 21:38:50 +0800
Message-ID: <20221118133850.3360369-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A soft lockup occur in scan free swap slot by constructing
huge memory pressure.
The test scenario is: 64 CPU cores, 64GB memory, and 28
zram devices, the disksize of each zram device is 50MB.

LATENCY_LIMIT is used to prevent soft lockup in function
scan_swap_map_slots, but the real loop number would more
than LATENCY_LIMIT because of "goto checks and goto scan"
repeatly without decrease of latency limit.

In order to fix it, move decrease latency_ration code in advance.

There is also a suspicious place that will cause soft lockup in
function get_swap_pages, in this function, the "goto start_over"
may result in continuous scanning of swap partition, if there is
no cond_sched in scan_swap_map_slots, it would cause soft lockup
(I am not sure about this).

WARN: soft lockup - CPU#11 stuck for 11s! [kswapd0:466]
CPU: 11 PID: 466 Comm: kswapd@ Kdump: loaded Tainted: G
dump backtrace+0x0/0x1le4
show stack+0x20/@x2c
dump_stack+0xd8/0x140
watchdog print_info+0x48/0x54
watchdog_process_before_softlockup+0x98/0xa0
watchdog_timer_fn+0xlac/0x2d0
hrtimer_rum_queues+0xb0/0x130
hrtimer_interrupt+0x13c/0x3c0
arch_timer_handler_virt+0x3c/0x50
handLe_percpu_devid_irq+0x90/0x1f4
handle domain irq+0x84/0x100
gic_handle_irq+0x88/0x2b0
e11 ira+0xhB/Bx140
scan_swap_map_slots+0x678/0x890
get_swap_pages+0x29c/0x440
get_swap_page+0x120/0x2e0
add_to_swap+UX2U/0XyC
shrink_page_list+0x5d0/0x152c
shrink_inactive_list+0xl6c/Bx500
shrink_lruvec+0x270/0x304

WARN: soft lockup - CPU#32 stuck for 11s! [stress-ng:309915]
watchdog_timer_fn+0x1ac/0x2d0
__run_hrtimer+0x98/0x2a0
__hrtimer_run_queues+0xb0/0x130
hrtimer_interrupt+0x13c/0x3c0
arch_timer_handler_virt+0x3c/0x50
handle_percpu_devid_irq+0x90/0x1f4
__handle_domain_irq+0x84/0x100
gic_handle_irq+0x88/0x2b0
el1_irq+0xb8/0x140
get_swap_pages+0x1e8/0x440
get_swap_page+0x1c8/0x2e0
add_to_swap+0x20/0x9c
shrink_page_list+0x5d0/0x152c
reclaim_pages+0x160/0x310
madvise_cold_or_pageout_pte_range+0x7bc/0xe3c
walk_pmd_range.isra.0+0xac/0x22c
walk_pud_range+0xfc/0x1c0
walk_pgd_range+0x158/0x1b0
__walk_page_range+0x64/0x100
walk_page_range+0x104/0x150

Fixes: 048c27fd7281 ("[PATCH] swap: scan_swap_map latency breaks")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/swapfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e99b291fb01a..5e7c98570ede 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -972,23 +972,23 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 scan:
 	spin_unlock(&si->lock);
 	while (++offset <= READ_ONCE(si->highest_bit)) {
-		if (swap_offset_available_and_locked(si, offset))
-			goto checks;
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
 			latency_ration = LATENCY_LIMIT;
 			scanned_many = true;
 		}
+		if (swap_offset_available_and_locked(si, offset))
+			goto checks;
 	}
 	offset = si->lowest_bit;
 	while (offset < scan_base) {
-		if (swap_offset_available_and_locked(si, offset))
-			goto checks;
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
 			latency_ration = LATENCY_LIMIT;
 			scanned_many = true;
 		}
+		if (swap_offset_available_and_locked(si, offset))
+			goto checks;
 		offset++;
 	}
 	spin_lock(&si->lock);
-- 
2.25.1

