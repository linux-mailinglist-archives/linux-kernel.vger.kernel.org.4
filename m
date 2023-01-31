Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A474682561
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjAaHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAaHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:10:50 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3118179
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:10:48 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P5bkP5Tsxz16Mfp;
        Tue, 31 Jan 2023 15:08:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 15:10:45 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <chenwandun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH -next] mm/swapfile: remove pr_debug in get_swap_pages()
Date:   Tue, 31 Jan 2023 07:10:35 +0000
Message-ID: <20230131071035.1085968-1-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87wn54c1fi.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87wn54c1fi.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's known that get_swap_pages() may fail to find available space
under some extreme case, but pr_debug() provides useless information.
Let's remove it.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 mm/swapfile.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6202a6668a63..99143875d6f0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1098,8 +1098,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 		spin_unlock(&si->lock);
 		if (n_ret || size == SWAPFILE_CLUSTER)
 			goto check_out;
-		pr_debug("scan_swap_map of si %d failed to find offset\n",
-			si->type);
 		cond_resched();
 
 		spin_lock(&swap_avail_lock);
-- 
2.25.1

