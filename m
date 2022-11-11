Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C57625582
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiKKIlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKKIlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:41:12 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20B573744
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:41:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso7180122pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eQh9ktaBcsp+i7swiPrXKSqRxb4TB2EKM2Wn2dJ6lXY=;
        b=socp5fnSHG/9oOdotryJmewP3Rj+qWxAST0edtLtxCPKkXX3P2Ee4mwKRsCB5Y8/1C
         7hfUcsBdH4z4N2z1UPHtrVfpCr0DqXPpKY4r1l2chM7yAiWnAIafsBGNAbCuzaCTf840
         G6MkmOI9DBSNaiavnR89M63c0VgxMYlbmKmqxBdZGIXNooiTVAFUSdPIOzIWix1bwEit
         +A4twPWgCSu1aHwFHCUodY7+yLW2D6zTnn7OwMcTg3HQ9B1o5IJ7yqU80igfPicZS40d
         FFsP1XUuD/X4qvvW/B0Rc+OUtgmKvTAbHwXB5s2tI8pc1EIPl1hezudVPe010prLKBGL
         N04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQh9ktaBcsp+i7swiPrXKSqRxb4TB2EKM2Wn2dJ6lXY=;
        b=biGkP+I8G8UhHhn0MavEedSHr+iX5eWs8/7y8LaZhW7OfTxNhf/adxDQLfQohUK6xt
         pEHttcsbxHXMZoa5vbdFN+T6Ib+NWt7q5D6GrN491VZFMymzg6smGVHTikyWpaRIop3w
         oqM3lxUsQDBVK2RICgx4I7GZPADEZg4V5SoO9wGWtPp1MHIpLqSImXGysV2xk8h4s6bw
         PVbkLr3fd9LErsnUXwigBa83c8wxXZvDUiAR3kkmRWwLbcNXqchWlt1GxjdVRrWrkd0R
         +7uRIH5OizNu3neEGjNcNcAteIjDmQZXiIEJZX84I1nwB0q5b/YeNGK3H9FlXB7jDPZ5
         gpPA==
X-Gm-Message-State: ANoB5plw7SlKRjDbAsViHDnnz/pNYZMKgPuOThwh9t8cmcWngzqNfkVw
        rxTm3+k9TPafG1ee36rV2AXT+Q==
X-Google-Smtp-Source: AA0mqf6hLxSQF5+cEx78W+4QKE1Xs1jqmGmN0Ws6oj5CSI3XAxRSh4+XW04hjrQlbAdYBRWt+LdaSg==
X-Received: by 2002:a17:902:b492:b0:186:a97d:6bc8 with SMTP id y18-20020a170902b49200b00186a97d6bc8mr1600096plr.101.1668156068140;
        Fri, 11 Nov 2022 00:41:08 -0800 (PST)
Received: from Tower.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id w190-20020a6230c7000000b0056bb99db338sm1043958pfw.175.2022.11.11.00.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:41:07 -0800 (PST)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     corbet@lwn.net, mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH v2] mm: add new syscall pidfd_set_mempolicy().
Date:   Fri, 11 Nov 2022 16:40:51 +0800
Message-Id: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are usecases when system management utilities want to
apply memory policy to processes to make better use of memory.

These utilities doesn't set memory usage policy, but rather
the job of reporting memory usage and setting the policy is
offloaded to a userspace daemon.

Cpuset has the ability to dynamically modify the numa nodes of
memory policy, but not the mode, which determines how to apply
for memory.

To solve the issue above, introduce new syscall
pidfd_set_mempolicy(2). The syscall sets NUMA memory policy for
the thread specified in pidfd.

Page allocation usage of task or vma policy occurs in the fault
path where we hold the mmap_lock for read. because replacing the
task or vma policy requires that the mmap_lock be held for write,
the policy can't be freed out from under us while we're using
it for page allocation. But there are some corner cases(e.g.
alloc_pages()) which not acquire any lock for read during the
page allocation. For this reason, task_work is used in
mpol_put_async() to free mempolicy in  pidfd_set_mempolicy().
Thuse, it avoids into race conditions.

The API is as follows,

                long pidfd_set_mempolicy(int pidfd, int mode,
                                     const unsigned long __user *nmask,
                                     unsigned long maxnode,
                                     unsigned int flags);

Set's the [pidfd] task's "task/process memory policy". The pidfd argument
is a PID file descriptor (see pidfd_open(2) man page) that specifies the
process to which the mempolicy is to be applied. The flags argument is
reserved for future use; currently, this argument must be specified as 0.
Please see the set_mempolicy(2) man page for more details about
other's arguments.

Permission to apply memory policy to another process is governed by a
ptrace access mode PTRACE_MODE_ATTACH_REALCREDS check (see
ptrace(2)); in addition, because of the performance implications
of applying the policy, the caller must have the CAP_SYS_NICE
capability.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |  19 +-
 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   3 +-
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 include/linux/cpuset.h                        |   2 +
 include/linux/mempolicy.h                     |   2 +
 include/linux/syscalls.h                      |   4 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 kernel/sys_ni.c                               |   1 +
 mm/mempolicy.c                                | 178 ++++++++++++++----
 25 files changed, 187 insertions(+), 45 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 5a6afecbb0d0..b45ceb0b165c 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -408,9 +408,10 @@ follows:
 Memory Policy APIs
 ==================
 
-Linux supports 4 system calls for controlling memory policy.  These APIS
-always affect only the calling task, the calling task's address space, or
-some shared object mapped into the calling task's address space.
+Linux supports 5 system calls for controlling memory policy.  The first four
+APIS affect only the calling task, the calling task's address space, or
+some shared object mapped into the calling task's address space. The last
+one sets the mempolicy of task specified in the pidfd.
 
 .. note::
    the headers that define these APIs and the parameter data types for
@@ -473,6 +474,18 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+Set [pidfd Task] Memory Policy::
+
+        long sys_pidfd_set_mempolicy(int pidfd, int mode,
+                                     const unsigned long __user *nmask,
+                                     unsigned long maxnode,
+                                     unsigned int flags);
+
+Sets the task/process memory policy for the [pidfd] task. The pidfd argument
+is a PID file descriptor (see pidfd_open(2) man page for details) that
+specifies the process for which the mempolicy is applied to. The flags
+argument is reserved for future use; currently, it must be specified as 0.
+For the description of all other arguments, see set_mempolicy(2) man page.
 
 Memory Policy Command Line Interface
 ====================================
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8ebacf37a8cf..3aeaefe7d45b 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -490,3 +490,4 @@
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common	pidfd_set_mempolicy		sys_ni_syscall
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index ac964612d8b0..a7ccab8aafef 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -464,3 +464,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 037feba03a51..64a514f90131 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		451
+#define __NR_compat_syscalls		452
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 604a2053d006..2e178e9152e6 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -907,7 +907,8 @@ __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
-
+#define __NR_pidfd_set_mempolicy 451
+__SYSCALL(__NR_pidfd_set_mempolicy, sys_pidfd_set_mempolicy)
 /*
  * Please add new compat syscalls above this comment and update
  * __NR_compat_syscalls in asm/unistd.h.
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 72c929d9902b..6f60981592b4 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -371,3 +371,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index b1f3940bc298..8e50bf8ec41d 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -450,3 +450,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 820145e47350..f48e32532c5f 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 253ff994ed2e..58e7c3140f4a 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -389,3 +389,4 @@
 448	n32	process_mrelease		sys_process_mrelease
 449	n32	futex_waitv			sys_futex_waitv
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n32	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 3f1886ad9d80..70090c3ada16 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -365,3 +365,4 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	n64	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 8f243e35a7b2..b0b0bad64fa0 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -438,3 +438,4 @@
 448	o32	process_mrelease		sys_process_mrelease
 449	o32	futex_waitv			sys_futex_waitv
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	o32	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 8a99c998da9b..4dfd328490ad 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -448,3 +448,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index a0be127475b1..34bd3cea5954 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -537,3 +537,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	nospu	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 799147658dee..5e170dca81f6 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+451  common	pidfd_set_mempolicy	sys_pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 2de85c977f54..bd3a24a9b41f 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4398cc6fb68d..bea2b5c6314b 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -496,3 +496,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..97bc70f5a8f7 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	pidfd_set_mempolicy	sys_pidfd_set_mempolicy
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..ba6d19dbd8f8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy	sys_pidfd_set_mempolicy
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 52c94ab5c205..9f7c563da4fb 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -421,3 +421,4 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	pidfd_set_mempolicy		sys_pidfd_set_mempolicy
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d58e0476ee8e..e9db7e10f171 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -77,6 +77,7 @@ extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
+#define cpuset_task_mems_allowed(task) ((task)->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
 int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
 
@@ -216,6 +217,7 @@ static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 }
 
 #define cpuset_current_mems_allowed (node_states[N_MEMORY])
+#define cpuset_task_mems_allowed(task) (node_states[N_MEMORY])
 static inline void cpuset_init_current_mems_allowed(void) {}
 
 static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..afb92020808e 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
+#include <linux/task_work.h>
 #include <uapi/linux/mempolicy.h>
 
 struct mm_struct;
@@ -51,6 +52,7 @@ struct mempolicy {
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
+		struct callback_head cb_head;   /* async free */
 	} w;
 };
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..e611c088050b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,6 +1056,10 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_pidfd_set_mempolicy(int pidfd, int mode,
+					const unsigned long __user *nmask,
+					unsigned long maxnode,
+					unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..c38013bbf5b0 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_pidfd_set_mempolicy 451
+__SYSCALL(__NR_pidfd_set_mempolicy, sys_pidfd_set_mempolicy)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..5053deb888f7 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -299,6 +299,7 @@ COND_SYSCALL(set_mempolicy);
 COND_SYSCALL(migrate_pages);
 COND_SYSCALL(move_pages);
 COND_SYSCALL(set_mempolicy_home_node);
+COND_SYSCALL(pidfd_set_mempolicy);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..2ac307aba01c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -221,7 +221,7 @@ static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
  * Must be called holding task's alloc_lock to protect task's mems_allowed
  * and mempolicy.  May also be called holding the mmap_lock for write.
  */
-static int mpol_set_nodemask(struct mempolicy *pol,
+static int mpol_set_nodemask(struct task_struct *task, struct mempolicy *pol,
 		     const nodemask_t *nodes, struct nodemask_scratch *nsc)
 {
 	int ret;
@@ -236,7 +236,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 
 	/* Check N_MEMORY */
 	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+		  cpuset_task_mems_allowed(task), node_states[N_MEMORY]);
 
 	VM_BUG_ON(!nodes);
 
@@ -248,7 +248,7 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (mpol_store_user_nodemask(pol))
 		pol->w.user_nodemask = *nodes;
 	else
-		pol->w.cpuset_mems_allowed = cpuset_current_mems_allowed;
+		pol->w.cpuset_mems_allowed = cpuset_task_mems_allowed(task);
 
 	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
 	return ret;
@@ -312,6 +312,36 @@ void __mpol_put(struct mempolicy *p)
 	kmem_cache_free(policy_cache, p);
 }
 
+static void mpol_free_async(struct callback_head *work)
+{
+	kmem_cache_free(policy_cache,
+			container_of(work, struct mempolicy, w.cb_head));
+}
+
+/*
+ * mpol destructor for pidfd_set_mempolicy().
+ * free mempolicy directly if task is null or task_work_add() failed.
+ */
+void mpol_put_async(struct task_struct *task, struct mempolicy *p)
+{
+	enum task_work_notify_mode notify = TWA_RESUME;
+
+	if (!atomic_dec_and_test(&p->refcnt))
+		return;
+
+	if (!task)
+		goto out;
+
+	init_task_work(&p->w.cb_head, mpol_free_async);
+	if (task_work_pending(task))
+		notify = TWA_SIGNAL; /* free memory in time */
+
+	if (!task_work_add(task, &p->w.cb_head, notify))
+		return;
+out:
+	kmem_cache_free(policy_cache, p);
+}
+
 static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 {
 }
@@ -850,8 +880,8 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 }
 
 /* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+static long do_set_mempolicy(struct task_struct *task, unsigned short mode,
+		unsigned short flags, nodemask_t *nodes)
 {
 	struct mempolicy *new, *old;
 	NODEMASK_SCRATCH(scratch);
@@ -866,20 +896,24 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
-	task_lock(current);
-	ret = mpol_set_nodemask(new, nodes, scratch);
+	task_lock(task);
+	ret = mpol_set_nodemask(task, new, nodes, scratch);
 	if (ret) {
-		task_unlock(current);
+		task_unlock(task);
 		mpol_put(new);
 		goto out;
 	}
 
-	old = current->mempolicy;
-	current->mempolicy = new;
+	old = task->mempolicy;
+	task->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
-		current->il_prev = MAX_NUMNODES-1;
-	task_unlock(current);
-	mpol_put(old);
+		task->il_prev = MAX_NUMNODES-1;
+	task_unlock(task);
+
+	if (old && task != current)
+		mpol_put_async(task, old);
+	else
+		mpol_put(old);
 	ret = 0;
 out:
 	NODEMASK_SCRATCH_FREE(scratch);
@@ -932,7 +966,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 	int err;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct mempolicy *pol = current->mempolicy, *pol_refcount = NULL;
+	struct mempolicy *pol;
 
 	if (flags &
 		~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR|MPOL_F_MEMS_ALLOWED))
@@ -947,6 +981,15 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		task_unlock(current);
 		return 0;
 	}
+	/*
+	 * Take a refcount on the mpol, because it may be freed by
+	 * pidfd_set_mempolicy() asynchronously, which will
+	 * override w.user_nodemask used below.
+	 */
+	task_lock(current);
+	pol = current->mempolicy;
+	mpol_get(pol);
+	task_unlock(current);
 
 	if (flags & MPOL_F_ADDR) {
 		/*
@@ -954,6 +997,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		 * vma/shared policy at addr is NULL.  We
 		 * want to return MPOL_DEFAULT in this case.
 		 */
+		mpol_put(pol);	/* put the refcount of task mpol*/
 		mmap_read_lock(mm);
 		vma = vma_lookup(mm, addr);
 		if (!vma) {
@@ -964,23 +1008,18 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			pol = vma->vm_ops->get_policy(vma, addr);
 		else
 			pol = vma->vm_policy;
-	} else if (addr)
-		return -EINVAL;
+		mpol_get(pol);
+		mmap_read_unlock(mm);
+	} else if (addr) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (!pol)
 		pol = &default_policy;	/* indicates default behavior */
 
 	if (flags & MPOL_F_NODE) {
 		if (flags & MPOL_F_ADDR) {
-			/*
-			 * Take a refcount on the mpol, because we are about to
-			 * drop the mmap_lock, after which only "pol" remains
-			 * valid, "vma" is stale.
-			 */
-			pol_refcount = pol;
-			vma = NULL;
-			mpol_get(pol);
-			mmap_read_unlock(mm);
 			err = lookup_node(mm, addr);
 			if (err < 0)
 				goto out;
@@ -1004,21 +1043,17 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 
 	err = 0;
 	if (nmask) {
-		if (mpol_store_user_nodemask(pol)) {
+		if (mpol_store_user_nodemask(pol))
 			*nmask = pol->w.user_nodemask;
-		} else {
-			task_lock(current);
+		else
 			get_policy_nodemask(pol, nmask);
-			task_unlock(current);
-		}
 	}
 
  out:
 	mpol_cond_put(pol);
-	if (vma)
-		mmap_read_unlock(mm);
-	if (pol_refcount)
-		mpol_put(pol_refcount);
+
+	if (pol != &default_policy)
+		mpol_put(pol);
 	return err;
 }
 
@@ -1309,7 +1344,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
-			err = mpol_set_nodemask(new, nmask, scratch);
+			err = mpol_set_nodemask(current, new, nmask, scratch);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
@@ -1578,7 +1613,7 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
-	return do_set_mempolicy(lmode, mode_flags, &nodes);
+	return do_set_mempolicy(current, lmode, mode_flags, &nodes);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
@@ -1587,6 +1622,71 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(mode, nmask, maxnode);
 }
 
+/* Set the memory policy of the process specified in pidfd. */
+static long do_pidfd_set_mempolicy(int pidfd, int mode, const unsigned long __user *nmask,
+		unsigned long maxnode, unsigned int flags)
+{
+	struct mm_struct *mm = NULL;
+	struct task_struct *task;
+	unsigned short mode_flags;
+	int err, lmode = mode;
+	unsigned int f_flags;
+	nodemask_t nodes;
+
+	if (flags)
+		return -EINVAL;
+
+	err = get_nodes(&nodes, nmask, maxnode);
+	if (err)
+		return err;
+
+	err = sanitize_mpol_flags(&lmode, &mode_flags);
+	if (err)
+		return err;
+
+	task = pidfd_get_task(pidfd, &f_flags);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	/*
+	 * Require CAP_SYS_NICE for influencing process performance.
+	 * User's task is allowed only.
+	 */
+	if (!capable(CAP_SYS_NICE) || (task->flags & PF_KTHREAD)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * Require PTRACE_MODE_ATTACH_REALCREDS  to avoid
+	 * leaking ASLR metadata.
+	 */
+	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+	if (IS_ERR_OR_NULL(mm)) {
+		err = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+		goto out;
+	}
+
+	if (mmap_write_lock_killable(mm)) {
+		err = -EINTR;
+		goto release_mm;
+	}
+
+	err = do_set_mempolicy(task, lmode, mode_flags, &nodes);
+	mmap_write_unlock(mm);
+release_mm:
+	mmput(mm);
+out:
+	put_task_struct(task);
+	return err;
+}
+
+SYSCALL_DEFINE5(pidfd_set_mempolicy, int, pidfd, int, mode, const unsigned long __user *, nmask,
+		unsigned long, maxnode, unsigned int, flags)
+{
+	return do_pidfd_set_mempolicy(pidfd, mode, nmask, maxnode, flags);
+}
+
 static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *old_nodes,
 				const unsigned long __user *new_nodes)
@@ -2790,7 +2890,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 			goto free_scratch; /* no valid nodemask intersection */
 
 		task_lock(current);
-		ret = mpol_set_nodemask(new, &mpol->w.user_nodemask, scratch);
+		ret = mpol_set_nodemask(current, new, &mpol->w.user_nodemask, scratch);
 		task_unlock(current);
 		if (ret)
 			goto put_new;
@@ -2946,7 +3046,7 @@ void __init numa_policy_init(void)
 	if (unlikely(nodes_empty(interleave_nodes)))
 		node_set(prefer, interleave_nodes);
 
-	if (do_set_mempolicy(MPOL_INTERLEAVE, 0, &interleave_nodes))
+	if (do_set_mempolicy(current, MPOL_INTERLEAVE, 0, &interleave_nodes))
 		pr_err("%s: interleaving failed\n", __func__);
 
 	check_numabalancing_enable();
@@ -2955,7 +3055,7 @@ void __init numa_policy_init(void)
 /* Reset policy of current process to default */
 void numa_default_policy(void)
 {
-	do_set_mempolicy(MPOL_DEFAULT, 0, NULL);
+	do_set_mempolicy(current, MPOL_DEFAULT, 0, NULL);
 }
 
 /*
-- 
2.25.1

