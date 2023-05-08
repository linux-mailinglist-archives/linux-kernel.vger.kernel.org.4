Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011966F9D82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjEHBpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjEHBpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:45:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464171437F
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:45:01 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QF3tp09PtzLnwc;
        Mon,  8 May 2023 09:42:09 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 09:44:57 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v9 4/5] mm/hwpoison: return -EFAULT when copy fail in copy_mc_[user]_highpage()
Date:   Mon, 8 May 2023 09:44:35 +0800
Message-ID: <20230508014436.198717-5-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508014436.198717-1-tongtiangen@huawei.com>
References: <20230508014436.198717-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hardware errors are encountered during page copying, returning the bytes
not copied is not meaningful, and the caller cannot do any processing on
the remaining data. Returning -EFAULT is more reasonable, which represents
a hardware error encountered during the copying.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 include/linux/highmem.h | 8 ++++----
 mm/khugepaged.c         | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 4de1dbcd3ef6..c29f51ea8517 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -335,8 +335,8 @@ static inline void copy_highpage(struct page *to, struct page *from)
 /*
  * If architecture supports machine check exception handling, define the
  * #MC versions of copy_user_highpage and copy_highpage. They copy a memory
- * page with #MC in source page (@from) handled, and return the number
- * of bytes not copied if there was a #MC, otherwise 0 for success.
+ * page with #MC in source page (@from) handled, and return -EFAULT if there
+ * was a #MC, otherwise 0 for success.
  */
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 					unsigned long vaddr, struct vm_area_struct *vma)
@@ -352,7 +352,7 @@ static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 	kunmap_local(vto);
 	kunmap_local(vfrom);
 
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 
 static inline int copy_mc_highpage(struct page *to, struct page *from)
@@ -368,7 +368,7 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 	kunmap_local(vto);
 	kunmap_local(vfrom);
 
-	return ret;
+	return ret ? -EFAULT : 0;
 }
 #else
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9d39d65b73..ef8b70377292 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -805,7 +805,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
 			continue;
 		}
 		src_page = pte_page(pteval);
-		if (copy_mc_user_highpage(page, src_page, _address, vma) > 0) {
+		if (copy_mc_user_highpage(page, src_page, _address, vma)) {
 			result = SCAN_COPY_MC;
 			break;
 		}
@@ -2140,7 +2140,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			clear_highpage(hpage + (index % HPAGE_PMD_NR));
 			index++;
 		}
-		if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR), page) > 0) {
+		if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR), page)) {
 			result = SCAN_COPY_MC;
 			goto rollback;
 		}
-- 
2.25.1

