Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92975EC976
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiI0Q2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiI0Q1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:27:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A4F17E01
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w20so9527279ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ch3iRYZG7BvL1WANyT2EwsRBrbvSXhTcdOkD0Wx+tJI=;
        b=pHNTTWGV0DU4hVyvtY8TSpgEsj5JBeZ0rgMCeZ1pu5d+GY8morwfkAM9ptjbMVdEyV
         imM/g2tHkw7xSPN6fTQ6IGpuWJJr0EOnbyn/XoIvshsjJ50vnPRCxNlUkF3jaUVWmU7F
         xASEF/UvfT3Vh4pOYFibeqK6mPl8pI81Ac3DVe2ScTQs1DfV2bOmjuoQeJLPlrvZIcC4
         HzYkpeh0ZE+m4I8MtBo4z484pUCJHOrvcY0OE0LoR9klOfG7RTIF6qbmdP1WpWscKnwK
         RZx0TUoBv9qUKFVVTOWkZO8yQqdNeoJpi/In6PXF7/whmu03EZ7QotXz5Qsb+WOLMr4n
         T7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ch3iRYZG7BvL1WANyT2EwsRBrbvSXhTcdOkD0Wx+tJI=;
        b=xO3P5uCJ1ob3VeUg8YE8Pl03E4oAX/7RFw+HeJUcZjKUcasMGwJlq19yt0RZ9H496X
         IeT5J6thH3ra48YBCOn9PAWzL4wmGsVH96gW14DfGVkHYQX8zp2XNdeZpto6UIX3BJxE
         yID6y6PjcodM+ddUCsMIAOC++mfJqiMHimrriRGe+BXHZs2niYIagZBCXXjx+5pINr4G
         ieIEciSSyeVu6r7WKtn4Onh6ZNPq92sBgGlZobBzKtGvIAC7fZKht67lnqxEoBE4fDos
         EXpSeEtyv9Qy/sKR763VPXMiehnQb18JqlGo+uVx+HOqdvxSOYWON8n821gU7x2adnYn
         a70g==
X-Gm-Message-State: ACrzQf2b4reF1edhqMBv3HpdKGWbMDMiwuUjRaSfE8jLnaW8J0GqWXyg
        id/Oa0M0HmZNBT2SynpCV2Y=
X-Google-Smtp-Source: AMsMyM7/Fqm4HVnIjXka29tQsuAw6B6XFfSVE1NQCCiSrxD8Nnbtv5yV5dZwRsdAW0VLVfM3KrVz5w==
X-Received: by 2002:a17:902:f70e:b0:178:9a17:8e42 with SMTP id h14-20020a170902f70e00b001789a178e42mr28423664plo.14.1664296066874;
        Tue, 27 Sep 2022 09:27:46 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:27:46 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 2/9] mm: pgtable: Add sysctl to enable COW PTE
Date:   Wed, 28 Sep 2022 00:29:50 +0800
Message-Id: <20220927162957.270460-3-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927162957.270460-1-shiyn.lin@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sysctl vm.cow_pte to set MMF_COW_PTE_READY flag for enabling
copy-on-write (COW) to the PTE page table during the next time of fork.

Since it has a time gap between using the sysctl to enable the COW PTE
and doing the fork, we use two states to determine the task that wants
to do COW PTE or already doing it.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/pgtable.h |  6 ++++++
 kernel/fork.c           |  5 +++++
 kernel/sysctl.c         |  8 ++++++++
 mm/Makefile             |  2 +-
 mm/cow_pte.c            | 39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 mm/cow_pte.c

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 014ee8f0fbaab..d03d01aefe989 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -937,6 +937,12 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+int cow_pte_handler(struct ctl_table *table, int write, void *buffer,
+		    size_t *lenp, loff_t *ppos);
+
+extern int sysctl_cow_pte_pid;
+
 #endif /* CONFIG_MMU */
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 8a9e92068b150..6981944a7c6ec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2671,6 +2671,11 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 			trace = 0;
 	}
 
+	if (current->mm && test_bit(MMF_COW_PTE_READY, &current->mm->flags)) {
+		clear_bit(MMF_COW_PTE_READY, &current->mm->flags);
+		set_bit(MMF_COW_PTE, &current->mm->flags);
+	}
+
 	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
 	add_latent_entropy();
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 205d605cacc5b..c4f54412ae3a9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2360,6 +2360,14 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= mmap_min_addr_handler,
 	},
+	{
+		.procname	= "cow_pte",
+		.data		= &sysctl_cow_pte_pid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= cow_pte_handler,
+		.extra1		= SYSCTL_ZERO,
+	},
 #endif
 #ifdef CONFIG_NUMA
 	{
diff --git a/mm/Makefile b/mm/Makefile
index 9a564f8364035..7a568d5066ee6 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -40,7 +40,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o
+			   pgtable-generic.o rmap.o vmalloc.o cow_pte.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/cow_pte.c b/mm/cow_pte.c
new file mode 100644
index 0000000000000..4e50aa4294ce7
--- /dev/null
+++ b/mm/cow_pte.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sysctl.h>
+#include <linux/pgtable.h>
+#include <linux/sched.h>
+#include <linux/sched/coredump.h>
+#include <linux/pid.h>
+
+/* sysctl will write to this variable */
+int sysctl_cow_pte_pid = -1;
+
+static void set_cow_pte_task(void)
+{
+	struct pid *pid;
+	struct task_struct *task;
+
+	pid = find_get_pid(sysctl_cow_pte_pid);
+	if (!pid) {
+		pr_info("pid %d does not exist\n", sysctl_cow_pte_pid);
+		sysctl_cow_pte_pid = -1;
+		return;
+	}
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!test_bit(MMF_COW_PTE, &task->mm->flags))
+		set_bit(MMF_COW_PTE_READY, &task->mm->flags);
+	sysctl_cow_pte_pid = -1;
+}
+
+int cow_pte_handler(struct ctl_table *table, int write, void *buffer,
+		    size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (write && !ret)
+		set_cow_pte_task();
+
+	return ret;
+}
-- 
2.37.3

