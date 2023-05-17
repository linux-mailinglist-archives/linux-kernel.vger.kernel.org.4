Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1BC706C31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjEQPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjEQPEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060A0AD0A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-307c040797bso607158f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684335833; x=1686927833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcjJGxge+F640GphIVPPWC0i7d+7dT4zRE3gQfpttMo=;
        b=Rm1/o51a2lpXg5BFBk6NXPTxOQL/+q5wPYqudYkYD0LO0vbb3G0X6cU/WUbHK9OmTT
         xyGPbYoI6XKipdHkAru8gZICWPEsUbwO6Jkk3dOBXa87Qq8BY6bIYCXC4rzbLx1Q5gZs
         9jEBolPQhL6s6/L97SOAkqIjsQdHbRbx6RyLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335833; x=1686927833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcjJGxge+F640GphIVPPWC0i7d+7dT4zRE3gQfpttMo=;
        b=V8Yr3z4cUWrhcAuuoqf+g/27c2BoijkcUw2TetXgoMLCjreUXNK1+gqMg7EqJVPMNP
         JS9lsmTgHvvtOhHQwTppWhXFZxuWbsq+gzib1aiKpDBKAJmnsuuggnwGK0pRslzrZK0p
         sv+k9CyUe3LemZ6SxZUJ3Mz2MAfC2EpFyTfSaffoGJgmsSmPx+a4TDeYPWvwXIwDm8a3
         uy+XUnH68gB1QodG0fkplM8K1eyrL5mHPmPQOWmSE/I38GsaULsk4/T+UlWAdEebGZdM
         tY7y6dMDpSeaC2oVioQINT0vcRbafudjnio4c61B+N7C5ab21LbUdEHWbye61QmFhNHl
         iScA==
X-Gm-Message-State: AC+VfDwzgr5gvYEMKQOBXTKEcNmYzBTqfctDtN+QH6Gez1PlA+pNI+jK
        ifWZusrp7VXU99JYjkUj837id5jxihJvBZXZAuA=
X-Google-Smtp-Source: ACHHUZ4O8rAQRY7/SDtireYdx2b2WsNyHeNpxz46Wl77Y6SHU0G8sbk4ZV8PBx+Me/5EbKQW1yjj/w==
X-Received: by 2002:a5d:4a50:0:b0:2f6:1a30:605c with SMTP id v16-20020a5d4a50000000b002f61a30605cmr999306wrs.3.1684335832915;
        Wed, 17 May 2023 08:03:52 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:e223:a0c2:d2c:c371])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b003047ea78b42sm3038211wrr.43.2023.05.17.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:03:52 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Date:   Wed, 17 May 2023 17:03:20 +0200
Message-ID: <20230517150321.2890206-5-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230517150321.2890206-1-revest@chromium.org>
References: <20230517150321.2890206-1-revest@chromium.org>
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
 kernel/sys.c                     | 24 +++++++++++++++++++++---
 tools/include/uapi/linux/prctl.h |  1 +
 5 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 0ee96ea7a0e9..11f5e3dacb4e 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -91,4 +91,14 @@ static inline int get_dumpable(struct mm_struct *mm)
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
 
 #define MMF_VM_MERGE_ANY	29
+#define MMF_HAS_MDWE_NO_INHERIT	30
+
+#define MMF_INIT_FLAGS(flags)	({					\
+	unsigned long new_flags = flags;				\
+	if (new_flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))		\
+		new_flags &= ~((1UL << MMF_HAS_MDWE) |			\
+				(1UL << MMF_HAS_MDWE_NO_INHERIT));	\
+	new_flags & MMF_INIT_MASK;					\
+})
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
index d17995934eb4..62d52ad99937 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1284,7 +1284,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	hugetlb_count_init(mm);
 
 	if (current->mm) {
-		mm->flags = current->mm->flags & MMF_INIT_MASK;
+		mm->flags = MMF_INIT_FLAGS(current->mm->flags);
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
 		mm->flags = default_dump_filter;
diff --git a/kernel/sys.c b/kernel/sys.c
index 339fee3eff6a..320eae3b12ab 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2368,9 +2368,25 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
 	if (arg3 || arg4 || arg5)
 		return -EINVAL;
 
-	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
+	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
 		return -EINVAL;
 
+	/* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
+	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
+		return -EINVAL;
+
+	/* Can't gain NO_INHERIT from !NO_INHERIT */
+	if (bits & PR_MDWE_NO_INHERIT &&
+	    test_bit(MMF_HAS_MDWE, &current->mm->flags) &&
+	    !test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
+		return -EPERM;
+
+	if (bits & PR_MDWE_NO_INHERIT)
+		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
+	else if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags)
+		 && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
+		return -EPERM; /* Cannot unset the flag */
+
 	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
 		set_bit(MMF_HAS_MDWE, &current->mm->flags);
 	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
@@ -2385,8 +2401,10 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 	if (arg2 || arg3 || arg4 || arg5)
 		return -EINVAL;
 
-	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
-		PR_MDWE_REFUSE_EXEC_GAIN : 0;
+	return (test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
+		PR_MDWE_REFUSE_EXEC_GAIN : 0) |
+		(test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags) ?
+		PR_MDWE_NO_INHERIT : 0);
 }
 
 static int prctl_get_auxv(void __user *addr, unsigned long len)
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 6e6563e97fef..f7448d99520c 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,6 +284,7 @@ struct prctl_mm_map {
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
 # define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+# define PR_MDWE_NO_INHERIT		(1UL << 1)
 
 #define PR_GET_MDWE			66
 
-- 
2.40.1.606.ga4b1b128d6-goog

