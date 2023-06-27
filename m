Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0373FC10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjF0MjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjF0MjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:39:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6726A5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:39:01 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qr42P74fbzlW0J;
        Tue, 27 Jun 2023 20:36:13 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Jun
 2023 20:38:56 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <xu.xin16@zte.com.cn>, <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <sunnanyong@huawei.com>
Subject: [PATCH] mm/ksm: delete the redundant ksm_merging_pages interafce in proc
Date:   Tue, 27 Jun 2023 21:35:42 +0800
Message-ID: <20230627133542.2446285-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
/proc/<pid>/ksm_stat, we can delete /proc/<pid>/ksm_merging_pages to
make the directory more clean, and can save a little bit resources.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 Documentation/admin-guide/mm/ksm.rst              |  6 +++---
 .../translations/zh_CN/admin-guide/mm/ksm.rst     |  4 ++--
 fs/proc/base.c                                    | 15 ---------------
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 7626392fe82c..e668d4b5e800 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -208,9 +208,9 @@ several times, which are unprofitable memory consumed.
 	process_profit =~ ksm_merging_pages * sizeof(page) -
 			  ksm_rmap_items * sizeof(rmap_item).
 
-   where ksm_merging_pages is shown under the directory ``/proc/<pid>/``,
-   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process profit
-   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
+   where ksm_merging_pages and ksm_rmap_items is shown in the file
+   ``/proc/<pid>/ksm_stat``. The process profit is also shown in
+   ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
 
 From the perspective of application, a high ratio of ``ksm_rmap_items`` to
 ``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst b/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
index 0029c4fd2201..1662f271efc8 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
@@ -167,8 +167,8 @@ KSM可以通过合并相同的页面来节省内存，但也会消耗额外的
        process_profit =~ ksm_merging_pages * sizeof(page) -
                          ksm_rmap_items * sizeof(rmap_item).
 
-   其中ksm_merging_pages显示在 ``/proc/<pid>/`` 目录下，而ksm_rmap_items
-   显示在 ``/proc/<pid>/ksm_stat`` 。
+   其中ksm_merging_pages、ksm_rmap_items显示在 ``/proc/<pid>/ksm_stat`` 文件中，收益
+   值ksm_process_profit也显示在该文件中。
 
 从应用的角度来看， ``ksm_rmap_items`` 和 ``ksm_merging_pages`` 的高比例意
 味着不好的madvise-applied策略，所以开发者或管理员必须重新考虑如何改变madvis策
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..173261dbeaea 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3186,19 +3186,6 @@ static int proc_pid_patch_state(struct seq_file *m, struct pid_namespace *ns,
 #endif /* CONFIG_LIVEPATCH */
 
 #ifdef CONFIG_KSM
-static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *ns,
-				struct pid *pid, struct task_struct *task)
-{
-	struct mm_struct *mm;
-
-	mm = get_task_mm(task);
-	if (mm) {
-		seq_printf(m, "%lu\n", mm->ksm_merging_pages);
-		mmput(mm);
-	}
-
-	return 0;
-}
 static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
@@ -3348,7 +3335,6 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
 #ifdef CONFIG_KSM
-	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
 };
@@ -3686,7 +3672,6 @@ static const struct pid_entry tid_base_stuff[] = {
 	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
 #endif
 #ifdef CONFIG_KSM
-	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
 	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
 };
-- 
2.25.1

