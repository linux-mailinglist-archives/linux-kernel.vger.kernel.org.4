Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF246C1248
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjCTMsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCTMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:48:02 -0400
X-Greylist: delayed 1103 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 05:47:45 PDT
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B012BE8;
        Mon, 20 Mar 2023 05:47:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PgDN6589Vz9v7Z6;
        Mon, 20 Mar 2023 20:20:38 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.48.148.162])
        by APP2 (Coremail) with SMTP id GxC2BwBnOF9kURhkkqGyAQ--.46782S6;
        Mon, 20 Mar 2023 13:29:08 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: [RFC v1 4/4] swiotlb: Add an option to allow dynamic bounce buffers
Date:   Mon, 20 Mar 2023 13:28:16 +0100
Message-Id: <e00c8c576b8ef2fa3cf867ab776cd136a519a835.1679309810.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnOF9kURhkkqGyAQ--.46782S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUXw4rKw1kZw1kJFWfuFg_yoWrZryUpr
        y0va4YgFZ7JF18Z347Cw47GF1Fkan29ay3ZayFgryFyr98Xrn0qwnrtr4YqF1rt3y09F47
        ZFyYvF4Ykr17t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0Ew4
        C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
        Xa7IU8gAw7UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Dynamic allocation of bounce buffers may introduce regression for
some workloads. The expected outcomes are bigger worst-case I/O
latency reduced performance for some workloads. Unfortunately,
real-world testing has been too unstable to draw any conclusion.

To stay on the safe side, make the feature disabled by default and
let people turn it on with "swiotlb=dynamic" if needed. Since this
option can be combined with "force", the parser must be modified to
allow multiple options separated by commas.

A new bool field is added to struct io_tlb_mem to tell whether
dynamic allocations are allowed. This field is always false for
DMA restricted pools. It is also false for other software IO
TLBs unless "swiotlb=dynamic" was specified.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++-
 include/linux/swiotlb.h                       |  3 ++-
 kernel/dma/swiotlb.c                          | 19 ++++++++++++++-----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..6240a463631b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6081,14 +6081,18 @@
 			Execution Facility on pSeries.
 
 	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
-			Format: { <int> [,<int>] | force | noforce }
+			Format: { <int> [,<int>] [,option-list] | option-list }
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
 				 areas with their own lock. Will be rounded up
 				 to a power of 2.
+			<option-list> -- Comma-separated list of options.
+
+			Available options:
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
+			dynamic -- allow dynamic allocation of bounce buffers
 
 	switches=	[HW,M68k]
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 0ef27d6491b9..628e25ad7db7 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -101,6 +101,7 @@ struct io_tlb_mem {
 	bool late_alloc;
 	bool force_bounce;
 	bool for_alloc;
+	bool allow_dyn;
 	unsigned int nareas;
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
@@ -123,7 +124,7 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 
 	return mem &&
 		(is_swiotlb_fixed(mem, paddr) ||
-		 is_swiotlb_dyn(mem, paddr));
+		 (mem->allow_dyn && is_swiotlb_dyn(mem, paddr)));
 }
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c6a0b8f2aa6f..3efaefebb6af 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -78,6 +78,7 @@ struct io_tlb_dyn_slot {
 
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
+static bool swiotlb_dynamic;
 
 struct io_tlb_mem io_tlb_default_mem;
 
@@ -159,10 +160,17 @@ setup_io_tlb_npages(char *str)
 		swiotlb_adjust_nareas(simple_strtoul(str, &str, 0));
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force"))
-		swiotlb_force_bounce = true;
-	else if (!strcmp(str, "noforce"))
-		swiotlb_force_disable = true;
+	while (str && *str) {
+		char *opt = strsep(&str, ",");
+		if (!strcmp(opt, "force"))
+			swiotlb_force_bounce = true;
+		else if (!strcmp(opt, "noforce"))
+			swiotlb_force_disable = true;
+		else if (!strcmp(opt, "dynamic"))
+			swiotlb_dynamic = true;
+		else
+			pr_warn("Invalid swiotlb option: %s", opt);
+	}
 
 	return 0;
 }
@@ -287,6 +295,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->area_nslabs = nslabs / mem->nareas;
 
 	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	mem->allow_dyn = swiotlb_dynamic;
 
 	for (i = 0; i < mem->nareas; i++) {
 		spin_lock_init(&mem->areas[i].lock);
@@ -930,7 +939,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	}
 
 	tlb_addr = (phys_addr_t)DMA_MAPPING_ERROR;
-	if (!is_swiotlb_for_alloc(dev))
+	if (mem->allow_dyn)
 		tlb_addr = swiotlb_dyn_map(dev, orig_addr, alloc_size,
 					   alloc_align_mask, dir, attrs);
 	if (tlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
-- 
2.25.1

