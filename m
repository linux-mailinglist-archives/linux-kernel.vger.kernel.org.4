Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FCB74756B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGDPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjGDPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:37:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031BE42
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:37:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d20548adso6353240f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688485032; x=1691077032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7tunI1lKMH4tXxhhZlNnHm4rteRjjg9hHxMHKz9rMs=;
        b=IH8/lYadcMH//iw9M9Op8dU0l1sj9aFWw0lBe6q6pMiopghB2cvLo/OcIkjbXfOgC6
         Y7x5+a5kcNvS9pp+WWGqp5o36R5bI4rsQwvbYsUc1Qx6T4i713ReMLLt4ZaDVZsYaSd5
         A3rBFK/cCnkuHUUrd8RED5SGzIm8RjYv50e0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485032; x=1691077032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7tunI1lKMH4tXxhhZlNnHm4rteRjjg9hHxMHKz9rMs=;
        b=YAJu9BjjfN8+TYd0Nt1Lp57Ikw7WDZGHqjRCYNtEScSb6Qjj8aZNy1t6b8kUtHG1TV
         rCz/4heUAb+GZmuur/RIr+limqkce2IJxrtUv6eBZ1gXT/kYSOXEUtdgDXsvNs2DCx6L
         Ml7uPZxHNcYZjNPXeBWh7qpAqSzeO7J83mxfO0u12ZLUnc6VGj6hn3aEZqL/XnzYpygF
         HHTEkTGE6gq4C+69vRUsYBOtZ+7vg120cTmwkkU/AtBFcI9LRikgW9fYHoG+ix4tM+0q
         NPVPnYJUWtbpfyFB27w+uX7KZvbFVpd3gKNF8f3xs4J1Czvw8K1dwcqdo/+l9DEDv0J3
         cOnw==
X-Gm-Message-State: ABy/qLZRFdQIjVjwyk4k2bYnmt8rncUUGbFjOsZr+8c4ZZzqXTkYF1+x
        3EpqAeGx6lukjvHAJyhI81cnS8FMZuwNtr3krGc=
X-Google-Smtp-Source: APBJJlEk398zYlZ/TviSclnfJx8pfvjJ6ut2plYZwXPVcNfINX4lPmJVH71We1oWGxYpyyxB1gS6eg==
X-Received: by 2002:a5d:4f86:0:b0:30f:c42e:3299 with SMTP id d6-20020a5d4f86000000b0030fc42e3299mr10482799wru.60.1688485032503;
        Tue, 04 Jul 2023 08:37:12 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:99b2:81bb:8407:5369])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0030c4d8930b1sm28538709wrm.91.2023.07.04.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:37:11 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Date:   Tue,  4 Jul 2023 17:36:28 +0200
Message-ID: <20230704153630.1591122-5-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230704153630.1591122-1-revest@chromium.org>
References: <20230704153630.1591122-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the current PR_SET_MDWE prctl arg with a bit to indicate
that the process doesn't want MDWE protection to propagate to children.

To implement this no-inherit mode, the tag in current->mm->flags must be
absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
without inherit" is different in the prctl than in the mm flags. This
leads to a bit of bit-mangling in the prctl implementation.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/sched/coredump.h   | 10 ++++++++++
 include/uapi/linux/prctl.h       |  1 +
 kernel/fork.c                    |  2 +-
 kernel/sys.c                     | 32 ++++++++++++++++++++++++++------
 tools/include/uapi/linux/prctl.h |  1 +
 5 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 0ee96ea7a0e9..1b37fa8fc723 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -91,4 +91,14 @@ static inline int get_dumpable(struct mm_struct *mm)
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
 
 #define MMF_VM_MERGE_ANY	29
+#define MMF_HAS_MDWE_NO_INHERIT	30
+
+static inline unsigned long mmf_init_flags(unsigned long flags)
+{
+	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
+		flags &= ~((1UL << MMF_HAS_MDWE) |
+			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
+	return flags & MMF_INIT_MASK;
+}
+
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 6e9af6cbc950..dacbe824e7c3 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,6 +284,7 @@ struct prctl_mm_map {
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
 # define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+# define PR_MDWE_NO_INHERIT		(1UL << 1)
 
 #define PR_GET_MDWE			66
 
diff --git a/kernel/fork.c b/kernel/fork.c
index d17995934eb4..bc3c762d378f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1284,7 +1284,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	hugetlb_count_init(mm);
 
 	if (current->mm) {
-		mm->flags = current->mm->flags & MMF_INIT_MASK;
+		mm->flags = mmf_init_flags(current->mm->flags);
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
 		mm->flags = default_dump_filter;
diff --git a/kernel/sys.c b/kernel/sys.c
index 339fee3eff6a..1a2dc3da43ea 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2362,19 +2362,41 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
+static inline unsigned long get_current_mdwe(void)
+{
+	unsigned long ret = 0;
+
+	if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
+		ret |= PR_MDWE_REFUSE_EXEC_GAIN;
+	if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
+		ret |= PR_MDWE_NO_INHERIT;
+
+	return ret;
+}
+
 static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 				 unsigned long arg4, unsigned long arg5)
 {
+	unsigned long current_bits;
+
 	if (arg3 || arg4 || arg5)
 		return -EINVAL;
 
-	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
+	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
+		return -EINVAL;
+
+	/* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
+	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
 		return -EINVAL;
 
+	current_bits = get_current_mdwe();
+	if (current_bits && current_bits != bits)
+		return -EPERM; /* Cannot unset the flags */
+
+	if (bits & PR_MDWE_NO_INHERIT)
+		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
 	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
 		set_bit(MMF_HAS_MDWE, &current->mm->flags);
-	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
-		return -EPERM; /* Cannot unset the flag */
 
 	return 0;
 }
@@ -2384,9 +2406,7 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 {
 	if (arg2 || arg3 || arg4 || arg5)
 		return -EINVAL;
-
-	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
-		PR_MDWE_REFUSE_EXEC_GAIN : 0;
+	return (int)get_current_mdwe();
 }
 
 static int prctl_get_auxv(void __user *addr, unsigned long len)
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 6e9af6cbc950..dacbe824e7c3 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,6 +284,7 @@ struct prctl_mm_map {
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
 # define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+# define PR_MDWE_NO_INHERIT		(1UL << 1)
 
 #define PR_GET_MDWE			66
 
-- 
2.41.0.255.g8b1d071c50-goog

