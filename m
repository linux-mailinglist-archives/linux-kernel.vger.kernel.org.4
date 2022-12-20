Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B792651B91
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiLTHZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLTHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:25:19 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A602F17048
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:13 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f3so7795626pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zN8GQXHI00/HeROFQmKChe4iFQdC5KCgpNeUIT0KwLk=;
        b=EtsN9zsJ3pirsct1axwSXx4qLQ1AewI0Q6+8HUX5Q51hUSXHkvjDCYErp3TgLe7ajY
         0sRp2l1jXLkz7Fy6reBRji4kSlFqrrkuZ8YdL0doJbFjZN2Rz5nWrs9EYXCyzekF4m0G
         NLitGc5Nay+QWeU6bpxn9/khd11FbuGY48vk5ZxFOqNm6dVEqcb2ahY6OnOrVcYbvYFU
         +wbAKrZe5YEZWGq0dZfV5K9X9zE9yhctCyAMsaMY0WGVwykhGeXjL9gdsb+cowMkk3aZ
         MfK94XMaAsIo9CUWFtFOlw4aOtnipNUkGGJ/SC1AKwv48MtgS1iYkC45E1u4/UrAguyr
         Cvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zN8GQXHI00/HeROFQmKChe4iFQdC5KCgpNeUIT0KwLk=;
        b=6X3sh9b3TQS6iKK5dacJGWa8KwLHEYAxr+027CzA3Tjp3vwNnPqF/N4JYfWHFsW0CD
         cWRQIbI0ueaqrXzgPGz8ytmQt9OA84rA05Kyzz/MYIRGEvb5tAA1OhVUD7Ntz9PE7GU0
         0CvGgtLX29e+3AEmauSjKuLxFuBaPrHCM0ZsZOx3tDeXXNUihvGm8JssMhUQPFQ9Itv+
         VEooi1hSEXUYNtsNO7ZMfc6bi4RYvpAXL8ml1WrPo/iPBo39Y1fyQFSwKXBZVHpIgAc+
         4p8q+r8S15XxlEaCTN+Gi8N3Y88MLeDNVGlY1ep0H204m+bx0Yn5if/HwdLjRkJNB9H7
         MJIg==
X-Gm-Message-State: ANoB5pl1Kxgy1MFNdTCYch+oUb9dpTHTI4ZXbpQbwLVGuk4nfw6rCVdh
        7G3wrxBbNmiTV5IkpIAM7mU=
X-Google-Smtp-Source: AA0mqf6gYVbHTs7yr9zs2kZWYw2+Km59Nz3mlW60Y6fD48DeDmKuygSgqg9b/c4U7WwnJgSjc/H0kA==
X-Received: by 2002:a05:6a00:1988:b0:577:49da:6074 with SMTP id d8-20020a056a00198800b0057749da6074mr60208490pfl.19.1671521113122;
        Mon, 19 Dec 2022 23:25:13 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:25:12 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Brian Geffon <bgeffon@google.com>, Yu Zhao <yuzhao@google.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Barret Rhoden <brho@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v3 01/14] mm: Allow user to control COW PTE via prctl
Date:   Tue, 20 Dec 2022 15:27:30 +0800
Message-Id: <20221220072743.3039060-2-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221220072743.3039060-1-shiyn.lin@gmail.com>
References: <20221220072743.3039060-1-shiyn.lin@gmail.com>
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

Add a new prctl, PR_SET_COW_PTE, to allow the user to enable COW PTE.
Since it has a time gap between using the prctl to enable the COW PTE
and doing the fork, we use two states (MMF_COW_PTE_READY and MMF_COW_PTE)
to determine the task that wants to do COW PTE or already doing it.

The MMF_COW_PTE_READY flag marks the task to do COW PTE in the next time
of fork(). During fork(), if MMF_COW_PTE_READY set, fork() will unset the
flag and set the MMF_COW_PTE flag. After that, fork() might shares PTEs
instead of duplicates it.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/sched/coredump.h | 12 +++++++++++-
 include/uapi/linux/prctl.h     |  6 ++++++
 kernel/sys.c                   | 11 +++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 8270ad7ae14c2..570d599ebc851 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -83,7 +83,17 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
+/*
+ * MMF_COW_PTE_READY: Marking the task to do COW PTE in the next time of
+ * fork(). During fork(), if MMF_COW_PTE_READY set, fork() will unset the
+ * flag and set the MMF_COW_PTE flag. After that, fork() might shares PTEs
+ * rather than duplicates it.
+ */
+#define MMF_COW_PTE_READY	29 /* Share PTE tables in next time of fork() */
+#define MMF_COW_PTE		30 /* PTE tables are shared between processes */
+#define MMF_COW_PTE_MASK	(1 << MMF_COW_PTE)
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_COW_PTE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba136..664a3c0230192 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,10 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/*
+ * Set the prepare flag, MMF_COW_PTE_READY, to do the share (copy-on-write)
+ * page table in the next time of fork.
+ */
+#define PR_SET_COW_PTE			65
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e8867..d1062ea33981e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2348,6 +2348,14 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
+static int prctl_set_cow_pte(struct mm_struct *mm)
+{
+	if (test_bit(MMF_COW_PTE, &mm->flags))
+		return -EINVAL;
+	set_bit(MMF_COW_PTE_READY, &mm->flags);
+	return 0;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2626,6 +2634,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_SET_COW_PTE:
+		error = prctl_set_cow_pte(me->mm);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.37.3

