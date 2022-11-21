Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28660631DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKUKGl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 05:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiKUKGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:06:31 -0500
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A79C9DB94
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:06:29 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="38178262"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 21 Nov 2022 18:05:24 +0800
Received: from BJ-MBX04.mioffice.cn (10.237.8.124) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 18:05:22 +0800
Received: from mi-OptiPlex-7060.mioffice.cn (10.237.8.11) by
 BJ-MBX04.mioffice.cn (10.237.8.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 21 Nov 2022 18:05:21 +0800
From:   <wangbiao3@xiaomi.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <brauner@kernel.org>, <bsegall@google.com>
CC:     <linux-kernel@vger.kernel.org>, <wangbiao3@xiaomi.com>,
        <wenjieli@qti.qualcomm.com>, <chenguanyou@xiaomi.com>
Subject: [PATCH 1/1] sched: fix user_mask double free
Date:   Mon, 21 Nov 2022 18:04:20 +0800
Message-ID: <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669020858.git.wangbiao3@xiaomi.com>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.237.8.11]
X-ClientProxiedBy: BJ-MBX10.mioffice.cn (10.237.8.130) To BJ-MBX04.mioffice.cn
 (10.237.8.124)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_SOFTFAIL,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangbiao3 <wangbiao3@xiaomi.com>

Clone/Fork a new task,call dup_task_struct->arch_dup_task_struct(tsk,orig)
which copy the data of parent/sibling task inclding p->user_cpus_ptr,so
the user_cpus_ptr of newtask is the same with orig task's.When
dup_task_struct call dup_user_cpus_ptr(tsk, orig, node),it return 0
dircetly if src->user_cpus_ptris free by other task,in this case ,
the newtask's address of user_cpus_ptr is not changed. Finally,
wakup newtask to execute, call task_cpu_possible_mask-->
do_set_cpus_allowed to set new task's user_cpus_ptr(user_mask) which
call kfree user_mask at the end. So cause a slub double free panic.

Use pi_lock to protect content of user_cpus_ptr in dup_user_cpus_ptr and
clear dst->user_cpus_ptr when found src->user_cpus_ptr is null

kernel BUG at mm/slub.c:363!
Call trace:
 __slab_free+0x230/0x28c
 kfree+0x220/0x2cc
 do_set_cpus_allowed+0x74/0xa4
 select_fallback_rq+0x12c/0x200
 wake_up_new_task+0x26c/0x304
 kernel_clone+0x2c0/0x470
 __arm64_sys_clone+0x5c/0x8c
 invoke_syscall+0x60/0x150
 el0_svc_common.llvm.13030543509303927816+0x98/0x114
 do_el0_svc_compat+0x20/0x30
 el0_svc_compat+0x28/0x90
 el0t_32_sync_handler+0x7c/0xbc
 el0t_32_sync+0x1b8/0x1bc

Signed-off-by: wangbiao3 <wangbiao3@xiaomi.com>
---
 kernel/sched/core.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daff72f00385..b013d8b777b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2584,29 +2584,38 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
        __do_set_cpus_allowed(p, new_mask, 0);
 }

+static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
+{
+       struct cpumask *user_mask = NULL;
+
+       swap(p->user_cpus_ptr, user_mask);
+
+       return user_mask;
+}
+
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
                      int node)
 {
-       if (!src->user_cpus_ptr)
-               return 0;
+       unsigned long flags;
+       struct cpumask *user_mask = NULL;

        dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
        if (!dst->user_cpus_ptr)
                return -ENOMEM;

+       /* Use pi_lock to protect content of user_cpus_ptr */
+       raw_spin_lock_irqsave(&src->pi_lock, flags);
+       if (!src->user_cpus_ptr) {
+               user_mask = clear_user_cpus_ptr(dst);
+               raw_spin_unlock_irqrestore(&src->pi_lock, flags);
+               kfree(user_mask);
+               return 0;
+       }
        cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+       raw_spin_unlock_irqrestore(&src->pi_lock, flags);
        return 0;
 }

-static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
-{
-       struct cpumask *user_mask = NULL;
-
-       swap(p->user_cpus_ptr, user_mask);
-
-       return user_mask;
-}
-
 void release_user_cpus_ptr(struct task_struct *p)
 {
        kfree(clear_user_cpus_ptr(p));
--
2.38.1

#/******���ʼ����丽������С�׹�˾�ı�����Ϣ�������ڷ��͸������ַ���г��ĸ��˻�Ⱥ�顣��ֹ�κ����������κ���ʽʹ�ã�������������ȫ���򲿷ֵ�й¶�����ơ���ɢ�������ʼ��е���Ϣ������������˱��ʼ������������绰���ʼ�֪ͨ�����˲�ɾ�����ʼ��� This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
