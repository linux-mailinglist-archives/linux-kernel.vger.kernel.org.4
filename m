Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD876F0418
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbjD0KUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243521AbjD0KUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:20:08 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 03:19:58 PDT
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04CD4696
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:19:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="94534338"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; 
   d="scan'208";a="94534338"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 19:18:52 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C76A5D66A1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:18:50 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0811ED969C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:18:50 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id B3D861145FC8;
        Thu, 27 Apr 2023 19:18:46 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     x86@kernel.org, nvdimm@lists.linux.dev, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, ruansy.fnst@fujitsu.com,
        Li Zhijian <lizhijian@fujitsu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Baoquan He <bhe@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sean Christopherson <seanjc@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Colin Foster <colin.foster@in-advantage.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 3/3] resource, crash: Make kexec_file_load support pmem
Date:   Thu, 27 Apr 2023 18:18:34 +0800
Message-Id: <20230427101838.12267-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427101838.12267-1-lizhijian@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27590.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27590.006
X-TMASE-Result: 10--7.728400-10.000000
X-TMASE-MatchedRID: +Dq5+AB/HWKUG5QaGlcSvSFcmxL76KeOwMc7ZZ8e7/dgPgeggVwCFnOw
        /jufb+urjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRutvHF25zoU8YH39vFLryE7rfxlRjqBJ3k8q
        tQTvc3FF+J/o+y9+xUrCUXHFFjdR48ZTibkDR5X0JGwniUXM+M9Y3ddD/vCxPaskqKES/kfLiuX
        4UcbdWgHeRkG9uGhVN3B7MhNx6/YcfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPCqPXzIJWKFRWTxV
        nPsfXK/2KFWEl0RCT8sKsYTWZ7DajkOabXnQVrB
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does:
1. Add pmem region into PT_LOADs of vmcore
2. Mark pmem region's p_flags as PF_DEV

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Eric Biederman <ebiederm@xmission.com>
CC: Takashi Iwai <tiwai@suse.de>
CC: Baoquan He <bhe@redhat.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Sean Christopherson <seanjc@google.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Ira Weiny <ira.weiny@intel.com>
CC: Raul E Rangel <rrangel@chromium.org>
CC: Colin Foster <colin.foster@in-advantage.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: x86@kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 arch/x86/kernel/crash.c |  2 ++
 include/linux/ioport.h  |  3 +++
 kernel/kexec_file.c     | 10 ++++++++++
 kernel/resource.c       | 11 +++++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..dc9d03083565 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -178,6 +178,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	if (!nr_ranges)
 		return NULL;
 
+	walk_pmem_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
 	/*
 	 * Exclusion of crash region and/or crashk_low_res may cause
 	 * another range split. So add extra two slots here.
@@ -243,6 +244,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	ret = walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
 	if (ret)
 		goto out;
+	walk_pmem_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
 
 	/* Exclude unwanted mem ranges */
 	ret = elf_header_exclude_ranges(cmem);
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 25d768d48970..bde88a47cc1a 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -331,6 +331,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_pmem_res(u64 start, u64 end, void *arg,
+	      int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..e79ceaee2926 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,6 +29,8 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#define PF_DEV (1 << 4)
+
 #ifdef CONFIG_KEXEC_SIG
 static bool sig_enforce = IS_ENABLED(CONFIG_KEXEC_SIG_FORCE);
 
@@ -1221,6 +1223,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
+static bool is_pmem_range(u64 start, u64 size)
+{
+	return REGION_INTERSECTS == region_intersects(start, size,
+			IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY);
+}
+
 int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 			  void **addr, unsigned long *sz)
 {
@@ -1302,6 +1310,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 
 		phdr->p_type = PT_LOAD;
 		phdr->p_flags = PF_R|PF_W|PF_X;
+		if (is_pmem_range(mstart, mend - mstart))
+			phdr->p_flags |= PF_DEV;
 		phdr->p_offset  = mstart;
 
 		phdr->p_paddr = mstart;
diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef..f3f1ce6fc384 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -431,6 +431,17 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				     func);
 }
 
+/*
+ * This function calls the @func callback against all memory ranges, which
+ * are ranges marked as IORESOURCE_MEM and IORES_DESC_PERSISTENT_MEMORY.
+ */
+int walk_pmem_res(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *))
+{
+	return __walk_iomem_res_desc(start, end, IORESOURCE_MEM,
+				     IORES_DESC_PERSISTENT_MEMORY, arg, func);
+}
+
 /*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
-- 
2.29.2

