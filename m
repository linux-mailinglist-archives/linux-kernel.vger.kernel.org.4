Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC041732255
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbjFOWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFOWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:01:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F9296C;
        Thu, 15 Jun 2023 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866464; x=1718402464;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=y9Fdd4CaXjYhM8c/kYRc/ffM8uFuEd3rHTJq5W9ozIE=;
  b=jJRSesBqLUd0urCv9o194jwNNzu4qMqaGTDmQ4n4qnPNrnMSmuTAR86q
   BP2sh/aOYCumaxuy+oVXIvRhS0YcejEucDVx7xePs5XnvWQtof6HULkgG
   jfjVfhj2LzMqtcwWNkdQBD0tEgEdXTLbvZlFuFBmnQ4pEW8CvkDeRnAaq
   zkxQKhTPjVHlsvDkYeqCynTH3a7/T1ZB3Lv6DOlbs1ZeDlUUlFx/glKyK
   6JIM9b26z5NEfqYAfXvxTq2QLvjiI+5GuPS4spQrr0moNG6I/i+IRd+87
   vlm6BPXIqfQnGuIZuyYl4EDc/OIixOwP7F4lcTf9xz1p3xbvNLzpwzrnh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343791130"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343791130"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715770091"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715770091"
Received: from smaurice-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.120.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:00 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 15 Jun 2023 16:00:23 -0600
Subject: [PATCH 1/3] mm/memory_hotplug: Allow an override for the
 memmap_on_memory param
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
In-Reply-To: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=5348;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=y9Fdd4CaXjYhM8c/kYRc/ffM8uFuEd3rHTJq5W9ozIE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCndXdJbnAJ++yhZVS3cvOTdxff5fUeOOrvs/W7jtJclP
 WTj/uU/OkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjARjZWMDOcv2YmZnLWzVvS7
 ZmDA/pxvkXo8w7k/p3WUixhuPrsgsYuR4cuznZa5advZfkrwz5A/cUmgei/3H+NlJ99c6hPf5ON
 4lxcA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For memory hotplug to consider MHP_MEMMAP_ON_MEMORY behavior, the
'memmap_on_memory' module parameter was a hard requirement.

In preparation for the dax/kmem driver to use memmap_on_memory
semantics, arrange for the module parameter check to be bypassed via the
appropriate mhp_flag.

Recall that the kmem driver could contribute huge amounts of hotplugged
memory originating from special purposes devices such as CXL memory
expanders. In some cases memmap_on_memory may be the /only/ way this new
memory can be hotplugged. Hence it makes sense for kmem to have a way to
force memmap_on_memory without depending on a module param, if all the
other conditions for it are met.

The only other user of this interface is acpi/acpi_memoryhotplug.c,
which only enables the mhp_flag if an initial
mhp_supports_memmap_on_memory() test passes. Maintain the existing
behavior and semantics for this by performing the initial check from
acpi without the MHP_MEMMAP_ON_MEMORY flag, so its decision falls back
to the module parameter.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 include/linux/memory_hotplug.h |  2 +-
 drivers/acpi/acpi_memhotplug.c |  2 +-
 mm/memory_hotplug.c            | 24 ++++++++++++++++--------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 9fcbf5706595..c9ddcd3cad70 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -358,7 +358,7 @@ extern struct zone *zone_for_pfn_range(int online_type, int nid,
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
-extern bool mhp_supports_memmap_on_memory(unsigned long size);
+extern bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 24f662d8bd39..119d3bb49753 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -211,7 +211,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		if (!info->length)
 			continue;
 
-		if (mhp_supports_memmap_on_memory(info->length))
+		if (mhp_supports_memmap_on_memory(info->length, 0))
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
 		result = __add_memory(mgid, info->start_addr, info->length,
 				      mhp_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..bb3845830922 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1283,15 +1283,21 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 	return device_online(&mem->dev);
 }
 
-bool mhp_supports_memmap_on_memory(unsigned long size)
+bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags)
 {
 	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
 	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
 	unsigned long remaining_size = size - vmemmap_size;
 
 	/*
-	 * Besides having arch support and the feature enabled at runtime, we
-	 * need a few more assumptions to hold true:
+	 * The MHP_MEMMAP_ON_MEMORY flag indicates a caller that wants to force
+	 * memmap_on_memory (if other conditions are met), regardless of the
+	 * module parameter. drivers/dax/kmem.c is an example, where large
+	 * amounts of hotplug memory may come from, and the only option to
+	 * successfully online all of it is to place the memmap on this memory.
+	 *
+	 * Besides having arch support and the feature enabled at runtime or
+	 * via the mhp_flag, we need a few more assumptions to hold true:
 	 *
 	 * a) We span a single memory block: memory onlining/offlinin;g happens
 	 *    in memory block granularity. We don't want the vmemmap of online
@@ -1315,10 +1321,12 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       altmap as an alternative source of memory, and we do not exactly
 	 *       populate a single PMD.
 	 */
-	return mhp_memmap_on_memory() &&
-	       size == memory_block_size_bytes() &&
-	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
+
+	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) || mhp_memmap_on_memory())
+		return size == memory_block_size_bytes() &&
+		       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
+		       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
+	return false;
 }
 
 /*
@@ -1375,7 +1383,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	 * Self hosted memmap array
 	 */
 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
-		if (!mhp_supports_memmap_on_memory(size)) {
+		if (!mhp_supports_memmap_on_memory(size, mhp_flags)) {
 			ret = -EINVAL;
 			goto error;
 		}

-- 
2.40.1

