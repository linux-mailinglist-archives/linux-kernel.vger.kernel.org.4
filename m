Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6818B6F707E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEDRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjEDRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:10:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8990D46B6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:10:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so5847615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683220212; x=1685812212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as31pCoPiH/Lp8KLJm8spaUi4yVvoAv9TTcEhjCAAgY=;
        b=LPi2IBa3epGcENfstLDmxknEDjzoeVoyMCOVXvn2hIqJbhS/z3Z7beqcX8HNc6RUU/
         /pzEgUoHJDLiDTe06ySVWNrxzOY57B8Ei43G0kuT69v4VEEQebPwALydX2HCV6VqXzRz
         DN1UCfrQbZ+PMVzcuWYehyE4oV9BCc+rsc8xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220212; x=1685812212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as31pCoPiH/Lp8KLJm8spaUi4yVvoAv9TTcEhjCAAgY=;
        b=cWWmQbZZwkkwdC+1phIlvfvsKIeVdWp2u/MvMaHuZCRvZIGVmlXxgSYYHXvA2rhMuE
         UtXWUecxEwAWjPCN55gJsBNqAML6qtdPGo2UksBYAYufCP/xJCG23KU+J6v+2anw+U7G
         eq5qMRrVbk3AsUJDnMCG9D0pDYFQYNWnSJE+jPkmiEAwwwqzYvRZFxmJe+22FS7VnVxh
         QjbuoeQEXDCZPyL0TRybeuvhigXIzY76YCKIqd/vXJOaOho/p9wKqQVdFmXkecuaAoIK
         pogMvGZuzQgwBJWKqk9COQRkGdwB50UvYrywdb5D6tWQ9puaFC5eGAoYnVH82bBHN2/k
         bV3w==
X-Gm-Message-State: AC+VfDzL4he7dN5t6MmlrvMLdzaOIkQNAtplTf4Djujz3WtCZutkDHj2
        wDqdhRPxHBMhBQveL2Maf3OvpKlF3rU2kwWahn8=
X-Google-Smtp-Source: ACHHUZ4E7M1YUpqW0h8R/EXzvhzI1Z5KyW0l0wGNsfKg6JHhw1LfgpgTa2/V7lU+cw1m2C7vUKdAkg==
X-Received: by 2002:a7b:ce84:0:b0:3f2:4fca:1b0f with SMTP id q4-20020a7bce84000000b003f24fca1b0fmr255985wmj.24.1683220212624;
        Thu, 04 May 2023 10:10:12 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:c740:f74d:132c:ca99])
        by smtp.gmail.com with ESMTPSA id q3-20020a1cf303000000b003f3157988f8sm5447895wmq.26.2023.05.04.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 10:10:11 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, nd@arm.com, broonie@kernel.org,
        szabolcs.nagy@arm.com, Florent Revest <revest@chromium.org>
Subject: [PATCH 3/4] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Date:   Thu,  4 May 2023 19:09:41 +0200
Message-ID: <20230504170942.822147-4-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230504170942.822147-1-revest@chromium.org>
References: <20230504170942.822147-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 include/linux/mman.h             |  8 +++++++-
 include/linux/sched/coredump.h   |  1 +
 include/uapi/linux/prctl.h       |  1 +
 kernel/sys.c                     | 29 +++++++++++++++++++++++------
 tools/include/uapi/linux/prctl.h |  1 +
 5 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index cee1e4b566d8..3d7a0b70ad2d 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -157,6 +157,12 @@ calc_vm_flag_bits(unsigned long flags)
 
 unsigned long vm_commit_limit(void);
 
+static inline bool has_mdwe_enabled(struct task_struct *task)
+{
+	return test_bit(MMF_HAS_MDWE, &task->mm->flags) ||
+	       test_bit(MMF_HAS_MDWE_NO_INHERIT, &task->mm->flags);
+}
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
@@ -178,7 +184,7 @@ unsigned long vm_commit_limit(void);
  */
 static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
 {
-	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
+	if (!has_mdwe_enabled(current))
 		return false;
 
 	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 0ee96ea7a0e9..b2d9659ef863 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -91,4 +91,5 @@ static inline int get_dumpable(struct mm_struct *mm)
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
 
 #define MMF_VM_MERGE_ANY	29
+#define MMF_HAS_MDWE_NO_INHERIT	30
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index f23d9a16507f..31ec44728412 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,6 +284,7 @@ struct prctl_mm_map {
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
 # define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_NO_INHERIT		2
 
 #define PR_GET_MDWE			66
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 339fee3eff6a..c864fd42ece1 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2368,12 +2368,25 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 	if (arg3 || arg4 || arg5)
 		return -EINVAL;
 
-	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
+	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
 		return -EINVAL;
 
-	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
-		set_bit(MMF_HAS_MDWE, &current->mm->flags);
-	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
+	/* Cannot set NO_INHERIT without REFUSE_EXEC_GAIN */
+	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
+		return -EINVAL;
+
+	if (bits & PR_MDWE_REFUSE_EXEC_GAIN) {
+		if (bits & PR_MDWE_NO_INHERIT) {
+			/* Cannot go from inherit mode to no inherit */
+			if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
+				return -EPERM;
+
+			set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
+		} else {
+			set_bit(MMF_HAS_MDWE, &current->mm->flags);
+			clear_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
+		}
+	} else if (has_mdwe_enabled(current))
 		return -EPERM; /* Cannot unset the flag */
 
 	return 0;
@@ -2385,8 +2398,12 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 	if (arg2 || arg3 || arg4 || arg5)
 		return -EINVAL;
 
-	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
-		PR_MDWE_REFUSE_EXEC_GAIN : 0;
+	if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
+		return PR_MDWE_REFUSE_EXEC_GAIN;
+	else if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
+		return PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT;
+
+	return 0;
 }
 
 static int prctl_get_auxv(void __user *addr, unsigned long len)
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 759b3f53e53f..a3424852d2d6 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,6 +284,7 @@ struct prctl_mm_map {
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
 # define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_NO_INHERIT		2
 
 #define PR_GET_MDWE			66
 
-- 
2.40.1.495.gc816e09b53d-goog

