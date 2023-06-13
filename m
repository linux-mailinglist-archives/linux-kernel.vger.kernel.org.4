Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC66472D95D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbjFMFgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjFMFgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:36:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB32346A4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686634372; x=1718170372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MfeQ32YmwQOX37H5kBSFBJAOSspLS/hxDGI+9I+LwqM=;
  b=NFTwcvZ/QqcqUu1gIbUmvlIclw8n2CIRAMk42jyXzwH8fm0SfX5qDUdD
   0/7aciTlUE0DIYSTvQVwJxKNd7F2Rxt3nGEMhFNGdEN0Dxrm6E6noQEvu
   ES2zQSlPzTyy44xZHl3v2EwCGn+kR2zJXhGPY3T8WRz6fWZ8nkxFTWZlw
   C6Lrmfe1JHYnP3y3haDK1M3KTi8tW9oIzFdHcoqTb61yxaTqKDZhC4ltA
   sNzWCy7DGUa/UMB+SEtngYDVzQfLJB5xrDkIo4cHkHo13Hp8L7jRhXzp9
   ndswoKEbkFW9MCXSfM365SUXSYelFkGplcQqo+S5vulKxR5SbjLi9nzLY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="357117782"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="357117782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 22:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776671600"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="776671600"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2023 22:32:36 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [Patch v2 1/2] smp: Add helper function to mark possible bad package number
Date:   Tue, 13 Jun 2023 13:25:22 +0800
Message-Id: <20230613052523.1106821-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some architecture like x86, it calculates processor package number
in the process of bringing up all CPUs. The 'nr_cpus=' and 'maxcpus='
cmdline parameter setup may reduce the number of CPUs which actually
get brought up, and make the package number inaccurate (less than the
real number).

Add a general helper function arch_mark_bad_package_count() to enable
affected architectures to mark the possible unreliable package
estimation. Also implement the support in x86 to leverage it.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/smpboot.c |  9 +++++++++
 include/linux/smp.h       | 13 +++++++++++++
 kernel/smp.c              | 10 +++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..b78770b0c43d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1274,6 +1274,15 @@ void arch_disable_smp_support(void)
 	disable_ioapic_support();
 }
 
+void arch_mark_bad_package_count(char *reason)
+{
+	if (package_count_unreliable)
+		return;
+
+	package_count_unreliable = true;
+	pr_warn("Processor package count may be unreliable due to: %s\n", reason);
+}
+
 /*
  * Fall back to non SMP mode after errors.
  *
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 91ea4a67f8ca..25bfdc73cc78 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -188,6 +188,13 @@ static inline int get_boot_cpu_id(void)
 	return __boot_cpu_id;
 }
 
+extern bool package_count_unreliable;
+
+static inline bool is_package_count_reliable(void)
+{
+	 return !package_count_unreliable;
+}
+
 #else /* !SMP */
 
 static inline void smp_send_stop(void) { }
@@ -230,6 +237,10 @@ static inline int get_boot_cpu_id(void)
 	return 0;
 }
 
+static inline bool is_package_count_reliable(void)
+{
+	return true;
+}
 #endif /* !SMP */
 
 /**
@@ -283,6 +294,8 @@ extern void arch_disable_smp_support(void);
 extern void arch_thaw_secondary_cpus_begin(void);
 extern void arch_thaw_secondary_cpus_end(void);
 
+extern void arch_mark_bad_package_count(char *reason);
+
 void smp_setup_processor_id(void);
 
 int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par,
diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe..494288bedd9b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -904,13 +904,20 @@ static int __init nosmp(char *str)
 
 early_param("nosmp", nosmp);
 
+bool package_count_unreliable;
+
+void __weak arch_mark_bad_package_count(char *reason) { }
+
 /* this is hard limit */
 static int __init nrcpus(char *str)
 {
 	int nr_cpus;
 
-	if (get_option(&str, &nr_cpus) && nr_cpus > 0 && nr_cpus < nr_cpu_ids)
+	if (get_option(&str, &nr_cpus) && nr_cpus > 0 &&
+		nr_cpus < nr_cpu_ids) {
 		set_nr_cpu_ids(nr_cpus);
+		arch_mark_bad_package_count("'nr_cpus' setup");
+	}
 
 	return 0;
 }
@@ -923,6 +930,7 @@ static int __init maxcpus(char *str)
 	if (setup_max_cpus == 0)
 		arch_disable_smp_support();
 
+	arch_mark_bad_package_count("'maxcpus' setup");
 	return 0;
 }
 
-- 
2.34.1

