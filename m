Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6E6C8F46
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCYQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:01:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DEDEF8C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679760101; x=1711296101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5dVs+q2gLQVLDGkLHXJqHU1Gk6hiIVR86jEv5ozZ6/4=;
  b=Ogh81MVKGClQ82/ijh50Ztg/rED/UAk7jjR0u+U+6BXFS6+9WfDZRMWD
   5Us6o4B2lu8q7DIAdL70FYj+9bb+zesvAw9ZCwlmQWkbh/DEqZx00mRSQ
   OIbQbJnU5gR4/x2xqcffy+xcJImOY3LxHQlZ9TZ40ybSN62C1P0Ib3HyZ
   JUJCW0As+G3BlS/Ki95S6uqb3viqk/KZ7ECOAVOeyezFjMEcvUyBA2g0l
   4K6J+KZlPCiihEjA8PoigehxywWEXisrC6X+KClDBk8nFDUxa792zplUI
   hOrlWCjQLh2xzBqgcApzzgAz3VBXzLPxHP9m2SZ4h1Bj/hsdCsGODsVg9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="342385473"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="342385473"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="747506632"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="747506632"
Received: from benfis1x-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.47.35])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:01:37 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D62E510A607; Sat, 25 Mar 2023 19:01:34 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86: Disable kexec for TDX guests
Date:   Sat, 25 Mar 2023 19:01:28 +0300
Message-Id: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kexec enabling inside TDX guest requires addressing several issues:

 - Avoid clearing CR4.MCE during kexec;

 - Convert all shared memory back to private on kexec, so the next
   kernel could start normally;

 - Add support for offlining secondary CPUs, so the new kernel could
   bring them up again.

The first two items are relatively straight-forward. The initial attempt
to implement them can be found here - [1].

The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
it has woken up.

It is clearly missing functionality from the ACPI mechanism and it has
to be changed to allow offlining. The work in this direction has
started, but it takes time.

For now, disable kexec for TDX guests. It will fail kexec instead of
crashing on attempt.

[1] https://lore.kernel.org/all/20230213234836.3683-1-kirill.shutemov@linux.intel.com

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/kexec.h       |  3 +++
 arch/x86/kernel/machine_kexec_64.c | 10 ++++++++++
 include/linux/kexec.h              |  7 +++++++
 kernel/kexec.c                     |  4 ++++
 kernel/kexec_file.c                |  4 ++++
 5 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..89693684a7d1 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -189,6 +189,9 @@ extern void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages);
 void arch_kexec_protect_crashkres(void);
 #define arch_kexec_protect_crashkres arch_kexec_protect_crashkres
 
+int arch_kexec_load(void);
+#define arch_kexec_load arch_kexec_load
+
 void arch_kexec_unprotect_crashkres(void);
 #define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0611fd83858e..9a0ded12df70 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -600,3 +600,13 @@ void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 	 */
 	set_memory_encrypted((unsigned long)vaddr, pages);
 }
+
+int arch_kexec_load(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6883c5922701..9fa88c191605 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -442,6 +442,13 @@ static inline void arch_kexec_protect_crashkres(void) { }
 static inline void arch_kexec_unprotect_crashkres(void) { }
 #endif
 
+#ifndef arch_kexec_load
+static inline int arch_kexec_load(void)
+{
+	return 0;
+}
+#endif
+
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
 {
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..70e4923c135d 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -194,6 +194,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
 			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
 	int result;
 
+	result = arch_kexec_load();
+	if (result)
+		return result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
 		return -EPERM;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..d02b7eb0f6e6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -331,6 +331,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	struct kimage **dest_image, *image;
 	int ret = 0, i;
 
+	ret = arch_kexec_load();
+	if (ret)
+		return ret;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!kexec_load_permitted(image_type))
 		return -EPERM;
-- 
2.39.2

