Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC66427D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiLELvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiLELu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:50:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48E19299;
        Mon,  5 Dec 2022 03:50:56 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQhgL0VGgzRphm;
        Mon,  5 Dec 2022 19:50:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 19:50:52 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, <akpm@linux-foundation.org>,
        <xueshuai@linux.alibaba.com>, <ashish.kalra@amd.com>
CC:     <xiezhipeng1@huawei.com>, <wangkefeng.wang@huawei.com>,
        <xiexiuqi@huawei.com>, <tanxiaofei@huawei.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [RFC 2/2] ACPI: APEI: fix reboot caused by synchronous error loop because of memory_failure() failed
Date:   Mon, 5 Dec 2022 19:51:11 +0800
Message-ID: <20221205115111.131568-3-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221205115111.131568-1-lvying6@huawei.com>
References: <20221205115111.131568-1-lvying6@huawei.com>
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
 mm/memory-failure.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3b6ac3694b8d..4c1c558f7161 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2266,7 +2266,11 @@ static void __memory_failure_work_func(struct work_struct *work, bool sync)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(entry.pfn, entry.flags);
-		else if (!sync || (entry.flags & MF_ACTION_REQUIRED))
+		else if (sync) {
+			if ((entry.flags & MF_ACTION_REQUIRED) &&
+					memory_failure(entry.pfn, entry.flags))
+				force_sig_mceerr(BUS_MCEERR_AR, 0, 0);
+		} else
 			memory_failure(entry.pfn, entry.flags);
 	}
 }
-- 
2.33.0

