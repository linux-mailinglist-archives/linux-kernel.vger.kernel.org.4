Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB115F9C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJJJtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJJJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:49:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DADD696F9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:49:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 128so2154124pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTPDnHFb6yn6yAzwBwLliycS3BZD970uvW0h1x4YfhY=;
        b=zfiJujTl6ctGmljHf4zIeMdLQj+DGnZLD2veaAb7eYP9RkpgrQ2UMDxLYIIyt/y5+l
         neyYluhxGwMAaR1Ii0tgRdpvFLoUTc3lJ1sapA1CRbt6NlhjRIyQW8AouDYq03W4MnKF
         edmGWdCpETS6LmE48BsIRIGY9Q+4upKEWjF1aGFx231jeyEO2sREvAA5yd1845M700Z2
         I60lJ4ghpfqbAwZvJaxKI/gGVYIIA52/rC5WmLz1bXxYaFw1IgJz7rGu9JVz0ZwWDQPD
         EmCYQ6HsF1A9DhWOhZ6KEet4odY6oG8oFR6tmAW+b+c+H7DpI3olGrUQAOf/KcjJNRfv
         EKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTPDnHFb6yn6yAzwBwLliycS3BZD970uvW0h1x4YfhY=;
        b=5H1D0yMw1PD0una5Dn3P1hmjGHo1R2n/DBZ8zvLBX84JwfgTasZ0Jk9/kgz9Q6AgmG
         xjlkJ1OFhIcVQfbURtsZx5SNZRzzP6qd2UxD6ALwWCtsw5WuJG/RrwyX2a2tGPC/dozn
         NQOSn2wnRFDiaB+FaCt6WoJzbwn8oRs7sOo9V6/na5Cr2lIyrwWAMLxCLEvuIiztAYuE
         sa96aDj4tdeUsN9skU/DdzTr7NEdnijD4B2TmM2125Vr1aLnmiGIqmDXHgjA3zjfFrtL
         NX6LRK3qiZ24sbkKaMtkDALzELDfB3mg9RM23r2eQo6DTNGIKIuB6Dn/xEEcS0eT+CXN
         hzLw==
X-Gm-Message-State: ACrzQf1s1LBwW9vqVfMRKi9PPTBuCk1NBBHD3YfrWvrpO6ExV9kUqOSy
        CHbEW9TM0yZSeOjg0t6Rj3327+i8RVcdWA==
X-Google-Smtp-Source: AMsMyM4QlzmXr990BjqxdtxVA+XsPYcs98cy7MfQmvDiPqz98Ph9nDpiV4kplioGKbLHfwSboylp4A==
X-Received: by 2002:a05:6a00:16c8:b0:53b:3b9f:7283 with SMTP id l8-20020a056a0016c800b0053b3b9f7283mr19046210pfc.46.1665395371044;
        Mon, 10 Oct 2022 02:49:31 -0700 (PDT)
Received: from Tower.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id t195-20020a635fcc000000b004608b721dfesm3532360pgb.38.2022.10.10.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 02:49:30 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     corbet@lwn.net, mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC] mm: add new syscall pidfd_set_mempolicy()
Date:   Mon, 10 Oct 2022 17:48:42 +0800
Message-Id: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is usecase that System Management Software(SMS) want to give a
memory policy to other processes to make better use of memory.

The information about how to use memory is not known to the app.
Instead, it is known to the userspace daemon(SMS), and that daemon
will decide the memory usage policy based on different factors.

To solve the issue, this patch introduces a new syscall
pidfd_set_mempolicy(2).  it sets the NUMA memory policy of the thread
specified in pidfd.

In current process context there is no locking because only the process
accesses its own memory policy, so task_work is used in
pidfd_set_mempolicy() to update the mempolicy of the process specified
in pidfd, avoid using locks and race conditions.

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

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 21 ++++-
 arch/alpha/kernel/syscalls/syscall.tbl        |  1 +
 arch/arm/tools/syscall.tbl                    |  1 +
 arch/arm64/include/asm/unistd.h               |  2 +-
 arch/arm64/include/asm/unistd32.h             |  3 +-
 arch/ia64/kernel/syscalls/syscall.tbl         |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |  1 +
 arch/s390/kernel/syscalls/syscall.tbl         |  1 +
 arch/sh/kernel/syscalls/syscall.tbl           |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |  1 +
 include/linux/mempolicy.h                     | 11 +++
 include/linux/syscalls.h                      |  4 +
 include/uapi/asm-generic/unistd.h             |  5 +-
 kernel/sys_ni.c                               |  1 +
 mm/mempolicy.c                                | 89 +++++++++++++++++++
 24 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 5a6afecbb0d0..b864dd88b2d2 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -408,9 +408,10 @@ follows:
 Memory Policy APIs
 ==================
 
-Linux supports 4 system calls for controlling memory policy.  These APIS
-always affect only the calling task, the calling task's address space, or
-some shared object mapped into the calling task's address space.
+Linux supports 5 system calls for controlling memory policy.  The first four
+APIS affect only the calling task, the calling task's address space, or some
+shared object mapped into the calling task's address space. The last one can
+set the mempolicy of task specified in pidfd.
 
 .. note::
    the headers that define these APIs and the parameter data types for
@@ -473,6 +474,20 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+Set [pidfd Task] Memory Policy::
+
+        long sys_pidfd_set_mempolicy(int pidfd, int mode,
+                                     const unsigned long __user *nmask,
+                                     unsigned long maxnode,
+                                     unsigned int flags);
+
+Set's the [pidfd] task's "task/process memory policy". The pidfd argument is
+a PID file descriptor (see pidfd_open(2) man page) that specifies the process
+to which the mempolicy is to be applied. The flags argument is reserved for
+future use; currently, this argument must be specified as 0. Please see the
+set_mempolicy(2) man page for more details about other's arguments.
+
+
 
 Memory Policy Command Line Interface
 ====================================
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 3515bc4f16a4..d86baa5a6eca 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -490,3 +490,4 @@
 558	common	process_mrelease		sys_process_mrelease
 559	common  futex_waitv                     sys_futex_waitv
 560	common	set_mempolicy_home_node		sys_ni_syscall
+561	common  pidfd_set_mempolicy		sys_ni_syscall
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
index 78b1d03e86e1..4e5bca7a985c 100644
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
index 2600b4237292..20381463b2b5 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -530,3 +530,4 @@
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
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..f3c522e8eb38 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -54,6 +54,17 @@ struct mempolicy {
 	} w;
 };
 
+/*
+ *  The information of mempolicy used by task_work
+ *  to update it dynamically.
+ */
+struct mpol_worker {
+	unsigned short mode;
+	unsigned short flags;
+	nodemask_t nodes;
+	struct rcu_head update_work;
+};
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
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
index b73d3248d976..2ce9be1a9dfd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -102,6 +102,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/task_work.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
@@ -1572,6 +1573,94 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(mode, nmask, maxnode);
 }
 
+/*
+ *  In process context there is no locking, so task_work is used to update
+ *  the mempolicy of process specified in pidfd, avoid using locks.
+ */
+static void pidfd_update_mpol(struct callback_head *cb)
+{
+	struct mpol_worker *worker = container_of(cb, struct mpol_worker, update_work);
+
+	do_set_mempolicy(worker->mode, worker->flags, &worker->nodes);
+	kfree(worker);
+}
+
+/* Set the memory policy of the process specified in pidfd. */
+static long do_pidfd_set_mempolicy(int pidfd, int mode, const unsigned long __user *nmask,
+		unsigned long maxnode, unsigned int flags)
+{
+	nodemask_t nodes, task_nodes, tmp;
+	struct mpol_worker *worker;
+	struct task_struct *task;
+	unsigned short mode_flags;
+	int ret, lmode = mode;
+	unsigned int f_flags;
+
+	if (flags)
+		return -EINVAL;
+
+	task = pidfd_get_task(pidfd, &f_flags);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+	/*
+	 * Check if this process has the right to modify the specified
+	 * process.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/*
+	 * Require CAP_SYS_NICE for influencing process performance.
+	 * User's task is allowed only.
+	 */
+	if (!capable(CAP_SYS_NICE) || (task->flags & PF_KTHREAD)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	ret = get_nodes(&nodes, nmask, maxnode);
+	if (ret)
+		goto out;
+
+	ret = sanitize_mpol_flags(&lmode, &mode_flags);
+	if (ret)
+		goto out;
+
+	task_nodes = cpuset_mems_allowed(task);
+
+	if (mode_flags & MPOL_F_RELATIVE_NODES)
+		mpol_relative_nodemask(&tmp, &nodes, &task_nodes);
+	else
+		nodes_and(tmp, nodes, task_nodes);
+
+	if (nodes_empty(tmp)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	worker = kzalloc(sizeof(struct mpol_worker), GFP_KERNEL | __GFP_NOWARN);
+	if (!worker) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	init_task_work(&worker->update_work, pidfd_update_mpol);
+	worker->flags = mode_flags;
+	worker->mode = lmode;
+	worker->nodes = nodes;
+
+	ret = task_work_add(task, &worker->update_work, TWA_SIGNAL);
+out:
+	put_task_struct(task);
+	return ret;
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
-- 
2.25.1

