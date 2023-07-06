Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534DC7497BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGFIxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjGFIw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:52:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395E1BE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:52:55 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QxVf232rWz1HCxm;
        Thu,  6 Jul 2023 16:52:26 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 16:52:52 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <xu.xin16@zte.com.cn>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <sunnanyong@huawei.com>
Subject: [PATCH] mm/ksm: prepare to remove the redundant ksm_merging_pages in procfs
Date:   Thu, 6 Jul 2023 17:49:17 +0800
Message-ID: <20230706094917.588213-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ksm_merging_pages information already included in
/proc/<pid>/ksm_stat, we could remove /proc/<pid>/ksm_merging_pages
to make the directory more clean, and can save a little bit resources.

To delete this interface more smoothly and avoid userspace break,
retain this interface temporarily and modify its function to hint
users to use ksm_stat instead.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 fs/proc/base.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index eb2e498e3b8d..d080c58cbe6c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3189,14 +3189,7 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
-	struct mm_struct *mm;
-
-	mm = get_task_mm(task);
-	if (mm) {
-		seq_printf(m, "%lu\n", mm->ksm_merging_pages);
-		mmput(mm);
-	}
-
+	seq_puts(m, "please use /proc/<pid>/ksm_stat instead\n");
 	return 0;
 }
 static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
-- 
2.25.1

