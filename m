Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0206FDA61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbjEJJEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbjEJJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:04:12 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78D962D6D;
        Wed, 10 May 2023 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=2eQiKNbmNB0cBb76E1biqVCFyySu9cxeIj
        xUbq5lhR4=; b=IjabRYa2Ap9uopNiQeD47aPcufM28HR0RHjoKsOhIR12qQ4ZpT
        FROSfqWOuZffd0CES1/syPG+YdyibjIl6z5gURXgj8a9RLFQ8Nwp6tJTQNQwwnCR
        RxsCp/BaDPJC9c4eQIgayWUQtumxuwH+la46uhM9AavTn2zsJmeUxgb94=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBnb2cIXFtkW9d5Ag--.63159S6;
        Wed, 10 May 2023 16:55:43 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-mm@kvack.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH 4/4] mm: page_table_check: Ensure user pages are not slab pages
Date:   Wed, 10 May 2023 16:55:27 +0800
Message-Id: <20230510085527.57953-5-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510085527.57953-1-lrh2000@pku.edu.cn>
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBnb2cIXFtkW9d5Ag--.63159S6
X-Coremail-Antispam: 1UD129KBjvJXoWxurWrCw4UAFyDWF48ZF17GFg_yoW5Wr48pa
        95u3W0yrW5Ka43Kw1DZ3ZayryrJa98G3yUC347J3WYv3ZxtFy0vF1jkr9Iy345KrW7Ca45
        AFZ8tr1jvrWDX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
        WkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEHBVPy77151gAAsd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current uses of PageAnon in page table check functions can lead to
type confusion bugs between struct page and slab [1], if slab pages are
accidentally mapped into the user space. This is because slab reuses the
bits in struct page to store its internal states, which renders PageAnon
ineffective on slab pages.

Since slab pages are not expected to be mapped into user spaces, this
patch adds BUG_ON(PageSlab(page)) checks to ensure that slab pages are
not inadvertently mapped. Otherwise, there must be some bugs in the
kernel.

Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
Fixes: df4e817b7108 ("mm: page table check")
Cc: <stable@vger.kernel.org> # 5.17
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 include/linux/page-flags.h | 6 ++++++
 mm/page_table_check.c      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c68d67b8..7475a5399 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -617,6 +617,12 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * Please note that, confusingly, "page_mapping" refers to the inode
  * address_space which maps the page from disk; whereas "page_mapped"
  * refers to user virtual address space into which the page is mapped.
+ *
+ * For slab pages, since slab reuses the bits in struct page to store its
+ * internal states, the page->mapping does not exist as such, nor do these
+ * flags below.  So in order to avoid testing non-existent bits, please
+ * make sure that PageSlab(page) actually evaluates to false before calling
+ * the following functions (e.g., PageAnon).  See slab.h.
  */
 #define PAGE_MAPPING_ANON	0x1
 #define PAGE_MAPPING_MOVABLE	0x2
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 25d8610c0..f2baf97d5 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -71,6 +71,8 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -107,6 +109,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -133,6 +137,8 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 	struct page_ext *page_ext;
 	unsigned long i;
 
+	BUG_ON(PageSlab(page));
+
 	page_ext = page_ext_get(page);
 	BUG_ON(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {
-- 
2.40.1

