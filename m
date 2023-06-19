Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ED3734CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjFSHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFSHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:53:31 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF9FA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:53:30 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-440ac4b44a8so257065137.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687161209; x=1689753209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UZlSaz+w1Ep6SIUPTI+QMgqBAsFAMeLh04/7pzE/p4=;
        b=gaS1jmYQocQ5Low42uqy1uu8BIYiK7iIAgslOlZ1stML68LicHlPg2jsBamInq2BJD
         Tj94I/Wve8/kIzE/Iq0AMwKVEaJRTrRK8yBXZwqthP6Z7PeIc2RWG10fSgIb/y3yEovC
         h9NmNdXBH6ls/C/eBQKzeVvESlAY2wdC1uuVvR+brH3OoSRO2qmkCXCY1CGNYvXAsr+P
         8YalDBuheshC4YoySLmJZ6DYtu8uSxQMrttFyMBb8/Xgzlg8MriKnlkczJ6GkO4eSfjB
         4qZWi7SA92tFyICsd2LRiYCjj1wF/WrLGXYTbzGQ4//pNPoNLW0E1iJ+YvedWMOzOcIU
         MP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161209; x=1689753209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UZlSaz+w1Ep6SIUPTI+QMgqBAsFAMeLh04/7pzE/p4=;
        b=LFP1tjuybzDkrff7j9qxpXo7FCEHVcfJfEr1Kjt81cn/lo4Ex58GSvtpLHh416VIen
         E7JMPKd90FecHVwfZQdXMntPqhCbJokYd0t2CeDPwMqNpWkpY4STQQHB1qmf8C0R2NNY
         IpIS0VLAOyFmq0XArAPJcxEz6ZR6xgeTQcssZVq4WKl8sB/uMFDwdf/b1ykOAqXO7pcT
         uV7K7Fn4yOJNekpoi+3a7rJFjpvgnLmc2wSNFgY+n2vOfYw56r99H2DiyqRmKt/HxIr+
         bHDeIUjrUDFDmyqmKvEeJnU6K+ZnY2/VfXugQBfUvwdRp7u81fe3joaEX2croY4Ena5Z
         QLIA==
X-Gm-Message-State: AC+VfDzoz247o7gOpSNqY6fBWujNeg5xgUamVDzD4Biq+VxaBLT+Qh6p
        IvElXp1ZMiKfyAT0t3wC71I=
X-Google-Smtp-Source: ACHHUZ7yyK1KcTiOqifjXZkPEx/BmkMtda9+pqKpPvFV1opxUumLsltZ3UP2vEhI5yUn8tjOCUvVXg==
X-Received: by 2002:a05:6102:98:b0:440:ad55:a589 with SMTP id t24-20020a056102009800b00440ad55a589mr775290vsp.12.1687161209483;
        Mon, 19 Jun 2023 00:53:29 -0700 (PDT)
Received: from aa-PC.zhaoxin.com ([180.169.121.82])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b004fbd91d9716sm17819965pgm.15.2023.06.19.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 00:53:28 -0700 (PDT)
From:   Liam Ni <zhiguangni01@gmail.com>
To:     rppt@kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam Ni <zhiguangni01@gmail.com>
Subject: [PATCH V2] x86,NUMA:improve the execution efficiency of numa_meminfo_cover_memory()
Date:   Mon, 19 Jun 2023 15:53:15 +0800
Message-Id: <20230619075315.49114-1-zhiguangni01@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of pages in memblock that doesn't have the node
assigned,which also means that these pages are not in numa_info.
So these pages can represent the number of lose pages.

Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
---
 arch/x86/mm/numa.c | 25 ++++++-------------------
 include/linux/mm.h |  2 ++
 mm/mm_init.c       | 26 ++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..ffe3b771eac7 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -451,28 +451,15 @@ EXPORT_SYMBOL(__node_distance);
  * Sanity check to catch more bad NUMA configurations (they are amazingly
  * common).  Make sure the nodes cover all memory.
  */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
+static bool __init numa_meminfo_cover_memory(void)
 {
-	u64 numaram, e820ram;
-	int i;
-
-	numaram = 0;
-	for (i = 0; i < mi->nr_blks; i++) {
-		u64 s = mi->blk[i].start >> PAGE_SHIFT;
-		u64 e = mi->blk[i].end >> PAGE_SHIFT;
-		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
-		if ((s64)numaram < 0)
-			numaram = 0;
-	}
+	u64 lo_pages;
 
-	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
+	lo_pages = without_node_pages_in_range(0, max_pfn);
 
 	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
-	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
-		printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
-		       (numaram << PAGE_SHIFT) >> 20,
-		       (e820ram << PAGE_SHIFT) >> 20);
+	if (lo_pages >= (1 << (20 - PAGE_SHIFT))) {
+		printk(KERN_ERR "NUMA: we lose more than 1M pages\n");
 		return false;
 	}
 	return true;
@@ -583,7 +570,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			return -EINVAL;
 		}
 	}
-	if (!numa_meminfo_cover_memory(mi))
+	if (!numa_meminfo_cover_memory())
 		return -EINVAL;
 
 	/* Finally register nodes. */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0daef3f2f029..99b7b49f1378 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3043,6 +3043,8 @@ unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
 						unsigned long end_pfn);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
+extern unsigned long without_node_pages_in_range(unsigned long start_pfn,
+						unsigned long end_pfn);
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3ddd18a89b66..1d5085a8f93b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1132,6 +1132,32 @@ static void __init adjust_zone_range_for_zone_movable(int nid,
 	}
 }
 
+/**
+ * @start_pfn: The start PFN to start searching for holes
+ * @end_pfn: The end PFN to stop searching for holes
+ *
+ * Return: Return the number of page frames without node assigned within a range.
+ */
+unsigned long __init without_node_pages_in_range(unsigned long start_pfn,
+						unsigned long end_pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *r;
+	unsigned long num_pages;
+	int i, nid;
+
+	for (i = 0; i < type->cnt; i++) {
+		r = &type->regions[i];
+		nid = memblock_get_region_node(r);
+
+		if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
+			continue;
+		if (nid == NUMA_NO_NODE)
+			num_pages += PFN_DOWN(r->base + r->size) - PFN_UP(r->base);
+	}
+	return num_pages;
+}
+
 /*
  * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
  * then all holes in the requested range will be accounted for.
-- 
2.25.1

