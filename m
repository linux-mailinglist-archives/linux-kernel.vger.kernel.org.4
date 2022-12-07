Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FED6456B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLGJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLGJjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:39:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C66CDC;
        Wed,  7 Dec 2022 01:39:52 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRsc341rMzJp8f;
        Wed,  7 Dec 2022 17:36:19 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 17:39:16 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <xueshuai@linux.alibaba.com>, <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <lvying6@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC PATCH v1 2/2] ACPI: APEI: fix reboot caused by synchronous error loop because of memory_failure() failed
Date:   Wed, 7 Dec 2022 17:39:35 +0800
Message-ID: <20221207093935.1972530-3-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221207093935.1972530-1-lvying6@huawei.com>
References: <20221207093935.1972530-1-lvying6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronous error was detected as a result of user-space accessing a
corrupt memory location the CPU may take an abort instead. On arm64 this
is a 'synchronous external abort' which can be notified by SEA.

If memory_failure() failed, we return to user-space will trigger SEA again,
such loop may cause platform firmware to exceed some threshold and reboot
when Linux could have recovered from this error. Not all memory_failure()
processing failures will cause the reboot, VM_FAULT_HWPOISON[_LARGE]
handling in arm64 page fault will send SIGBUS signal to the user-space
accessing process to terminate this loop.

If process mapping fault page, but memory_failure() abnormal return before
try_to_unmap(), for example, the fault page process mapping is KSM page.
In this case, arm64 cannot use the page fault process to terminate the
loop.

Add judgement of memory_failure() result in task_work before returning to
user-space. If memory_failure() failed, send SIGBUS signal to the current
process to avoid SEA loop.

Signed-off-by: Lv Ying <lvying6@huawei.com>
---
 mm/memory-failure.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3b6ac3694b8d..07ec7b62f330 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2255,7 +2255,7 @@ static void __memory_failure_work_func(struct work_struct *work, bool sync)
 	struct memory_failure_cpu *mf_cpu;
 	struct memory_failure_entry entry = { 0, };
 	unsigned long proc_flags;
-	int gotten;
+	int gotten, ret;
 
 	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
@@ -2266,7 +2266,16 @@ static void __memory_failure_work_func(struct work_struct *work, bool sync)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(entry.pfn, entry.flags);
-		else if (!sync || (entry.flags & MF_ACTION_REQUIRED))
+		else if (sync) {
+			if (entry.flags & MF_ACTION_REQUIRED) {
+				ret = memory_failure(entry.pfn, entry.flags);
+				if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
+					return;
+
+				pr_err("Memory error not recovered");
+				force_sig(SIGBUS);
+			}
+		} else
 			memory_failure(entry.pfn, entry.flags);
 	}
 }
-- 
2.36.1

