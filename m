Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0AE6F0E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbjD0W5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjD0W5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:57:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E7EE76
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682636231; x=1714172231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oo30p4zjO7R+SHBzRbEWPBwEjv6nOyVJP4VGo+qJFhY=;
  b=GApZXUG8RM75A1oEFvj72VrWp611QyB5ZtvyNiYJDn2aw0X3T/lMmMA9
   xFOrUwz7JWiW1vErFI8jMH0I3cRGUmkBAPr+kxQUDmHgCNS6GVcaAuRNH
   uMeuABP97qOqd7DuU/BTcL96FQvj9qtxu1p1TWBdK9ZQEhrQzKCsGy8wm
   o1dm4QqAad7m+iyX19dMD2JNQuPlEJfC2cavoirp2Cj0YQ8AO7q7W6a/N
   usdCTtDQprT0Wfz+CH9vBtQuxm6f8GbZkGEdJ6TR2YnWvnQPFkPKprcHT
   ku4TcexsYD95w/1rZAkwiafmezWkKTD0O9Z6osW7aslyUgf1aPcWJ0ujv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="433870798"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="433870798"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 15:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="725110244"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="725110244"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2023 15:57:09 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/mm for 6.4
Date:   Thu, 27 Apr 2023 15:56:47 -0700
Message-Id: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/mm changes for 6.4.  The only content here is
solely a new revision of Kirill's Linear Address Masking implementation.

You had some concerns[1] with the last version and the (lack of) locking
while the feature was being enabled in multithreaded programs.  It's
been fixed up since then to simply only allow LAM enabling when the
process is single threaded.  It's also accumulated a few random fixes
and cleanups since then.

This conflicts with the shadow stack work (x86/shstk) that I sent
earlier this week.  This is no surprise since LAM and shadow stacks both
add prctl()'s, selftests and touch the same headers.

Despite there being a few sites of conflict, the merge is logically
straightforward.  I've included a suggested resolution.  Both Kirill
(LAM) and Rick (shadow stacks) tested the result and confirmed that
nothing broke.

1. https://lore.kernel.org/all/CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com/

--

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.4

for you to fetch changes up to 97740266de26e5dfe6e4fbecacb6995b66c2e378:

  x86/mm/iommu/sva: Do not allow to set FORCE_TAGGED_SVA bit from outside (2023-04-06 13:45:06 -0700)

----------------------------------------------------------------
Add support for new Linear Address Masking CPU feature.  This is similar
to ARM's Top Byte Ignore and allows userspace to store metadata in some
bits of pointers without masking it out before use.

----------------------------------------------------------------
Kirill A. Shutemov (14):
      x86/mm: Rework address range check in get_user() and put_user()
      x86: Allow atomic MM_CONTEXT flags setting
      x86: CPUID and CR3/CR4 flags for Linear Address Masking
      x86/mm: Handle LAM on context switch
      mm: Introduce untagged_addr_remote()
      x86/uaccess: Provide untagged_addr() and remove tags before address check
      x86/mm: Reduce untagged_addr() overhead for systems without LAM
      x86/mm: Provide arch_prctl() interface for LAM
      mm: Expose untagging mask in /proc/$PID/status
      iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
      x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
      selftests/x86/lam: Add test cases for LAM vs thread creation
      x86/mm/iommu/sva: Fix error code for LAM enabling failure due to SVA
      x86/mm/iommu/sva: Do not allow to set FORCE_TAGGED_SVA bit from outside

Weihong Zhang (5):
      selftests/x86/lam: Add malloc and tag-bits test cases for linear-address masking
      selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address masking
      selftests/x86/lam: Add io_uring test cases for linear-address masking
      selftests/x86/lam: Add inherit test cases for linear-address masking
      selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for linear-address masking

 arch/arm64/include/asm/mmu_context.h        |    6 +
 arch/sparc/include/asm/mmu_context_64.h     |    6 +
 arch/sparc/include/asm/uaccess_64.h         |    2 +
 arch/x86/Kconfig                            |   11 +
 arch/x86/entry/vsyscall/vsyscall_64.c       |    2 +-
 arch/x86/include/asm/cpufeatures.h          |    1 +
 arch/x86/include/asm/disabled-features.h    |    8 +-
 arch/x86/include/asm/mmu.h                  |   18 +-
 arch/x86/include/asm/mmu_context.h          |   49 +-
 arch/x86/include/asm/processor-flags.h      |    2 +
 arch/x86/include/asm/tlbflush.h             |   48 +-
 arch/x86/include/asm/uaccess.h              |   58 +-
 arch/x86/include/uapi/asm/prctl.h           |    5 +
 arch/x86/include/uapi/asm/processor-flags.h |    6 +
 arch/x86/kernel/process.c                   |    6 +
 arch/x86/kernel/process_64.c                |   68 +-
 arch/x86/kernel/traps.c                     |    6 +-
 arch/x86/lib/getuser.S                      |   83 +-
 arch/x86/lib/putuser.S                      |   54 +-
 arch/x86/mm/init.c                          |    5 +
 arch/x86/mm/tlb.c                           |   53 +-
 drivers/iommu/iommu-sva.c                   |    8 +-
 drivers/vfio/vfio_iommu_type1.c             |    2 +-
 fs/proc/array.c                             |    7 +
 fs/proc/task_mmu.c                          |    9 +-
 include/linux/ioasid.h                      |    9 -
 include/linux/mm.h                          |   11 -
 include/linux/mmu_context.h                 |   14 +
 include/linux/sched/mm.h                    |    8 +-
 include/linux/uaccess.h                     |   22 +
 mm/gup.c                                    |    4 +-
 mm/madvise.c                                |    5 +-
 mm/migrate.c                                |   11 +-
 tools/testing/selftests/x86/Makefile        |    2 +-
 tools/testing/selftests/x86/lam.c           | 1241 +++++++++++++++++++++++++++
 35 files changed, 1701 insertions(+), 149 deletions(-)
 create mode 100644 tools/testing/selftests/x86/lam.c
diff --cc arch/x86/include/asm/disabled-features.h
index fafe9be7a6f4,652e366b68a0..702d93fdd10e
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@@ -120,8 -126,8 +132,8 @@@
  #define DISABLED_MASK9	(DISABLE_SGX)
  #define DISABLED_MASK10	0
  #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
- 			 DISABLE_CALL_DEPTH_TRACKING)
+ 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
 -#define DISABLED_MASK12	0
 +#define DISABLED_MASK12	(DISABLE_LAM)
  #define DISABLED_MASK13	0
  #define DISABLED_MASK14	0
  #define DISABLED_MASK15	0
diff --cc arch/x86/include/uapi/asm/prctl.h
index eb290d89cb32,1b85bc876c2d..abe3fe6db6d2
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@@ -20,9 -20,16 +20,21 @@@
  #define ARCH_MAP_VDSO_32		0x2002
  #define ARCH_MAP_VDSO_64		0x2003
  
+ /* Don't use 0x3001-0x3004 because of old glibcs */
+ 
 +#define ARCH_GET_UNTAG_MASK		0x4001
 +#define ARCH_ENABLE_TAGGED_ADDR		0x4002
 +#define ARCH_GET_MAX_TAG_BITS		0x4003
 +#define ARCH_FORCE_TAGGED_SVA		0x4004
 +
+ #define ARCH_SHSTK_ENABLE		0x5001
+ #define ARCH_SHSTK_DISABLE		0x5002
+ #define ARCH_SHSTK_LOCK			0x5003
+ #define ARCH_SHSTK_UNLOCK		0x5004
+ #define ARCH_SHSTK_STATUS		0x5005
+ 
+ /* ARCH_SHSTK_ features bits */
+ #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
+ #define ARCH_SHSTK_WRSS			(1ULL <<  1)
+ 
  #endif /* _ASM_X86_PRCTL_H */
diff --cc arch/x86/kernel/process.c
index 50d950771371,8bf13cff0141..7157b09d1cbf
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@@ -48,7 -48,7 +48,8 @@@
  #include <asm/frame.h>
  #include <asm/unwind.h>
  #include <asm/tdx.h>
 +#include <asm/mmu_context.h>
+ #include <asm/shstk.h>
  
  #include "process.h"
  
diff --cc arch/x86/kernel/process_64.c
index b46924c9e46d,31241930b60c..74c7e84a94d8
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@@ -875,22 -831,13 +877,28 @@@ long do_arch_prctl_64(struct task_struc
  # endif
  	case ARCH_MAP_VDSO_64:
  		return prctl_map_vdso(&vdso_image_64, arg2);
 +#endif
 +#ifdef CONFIG_ADDRESS_MASKING
 +	case ARCH_GET_UNTAG_MASK:
 +		return put_user(task->mm->context.untag_mask,
 +				(unsigned long __user *)arg2);
 +	case ARCH_ENABLE_TAGGED_ADDR:
 +		return prctl_enable_tagged_addr(task->mm, arg2);
 +	case ARCH_FORCE_TAGGED_SVA:
 +		set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
 +		return 0;
 +	case ARCH_GET_MAX_TAG_BITS:
 +		if (!cpu_feature_enabled(X86_FEATURE_LAM))
 +			return put_user(0, (unsigned long __user *)arg2);
 +		else
 +			return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
  #endif
+ 	case ARCH_SHSTK_ENABLE:
+ 	case ARCH_SHSTK_DISABLE:
+ 	case ARCH_SHSTK_LOCK:
+ 	case ARCH_SHSTK_UNLOCK:
+ 	case ARCH_SHSTK_STATUS:
+ 		return shstk_prctl(task, option, arg2);
  	default:
  		ret = -EINVAL;
  		break;
diff --cc fs/proc/array.c
index 6daea628bc76,3e1a33dcd0d0..a880c4e44752
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@@ -424,11 -423,11 +424,16 @@@ static inline void task_thp_status(stru
  	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
  }
  
 +static inline void task_untag_mask(struct seq_file *m, struct mm_struct *mm)
 +{
 +	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(mm));
 +}
 +
+ __weak void arch_proc_pid_thread_features(struct seq_file *m,
+ 					  struct task_struct *task)
+ {
+ }
+ 
  int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
  			struct pid *pid, struct task_struct *task)
  {
diff --cc tools/testing/selftests/x86/Makefile
index 598135d3162b,cfc8a26ad151..fa2216a8c0d5
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@@ -18,7 -18,7 +18,7 @@@ TARGETS_C_32BIT_ONLY := entry_from_vm8
  			test_FCMOV test_FCOMI test_FISTTP \
  			vdso_restorer
  TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
- 			corrupt_xstate_header amx lam
 -			corrupt_xstate_header amx test_shadow_stack
++			corrupt_xstate_header amx test_shadow_stack lam
  # Some selftests require 32bit support enabled also on 64bit systems
  TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
  
