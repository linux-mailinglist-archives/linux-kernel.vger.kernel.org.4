Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C63702DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbjEONLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbjEONKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:10:47 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF4B32686;
        Mon, 15 May 2023 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=L+SQ0nmfGSPRi8glqTzv3fHgUPypuBnrsB
        ZKLf4on5Y=; b=ox9S7sNSOR+qIM/NofYQxW7bDUidbSTXFsfF5W//szZbyOtCdS
        Zx5RZyiJbOaHg5CnaOa7fFpoekGi458S3qVhX4jk9l9h2KWAPGvkA57DX64e6HkD
        QZsoMnu23gTA4M6u1BC6GpPdd7iAD65zNx3q2817kRszYNDYcsmlLlyt4=
Received: from localhost.localdomain (unknown [10.7.98.243])
        by front02 (Coremail) with SMTP id 54FpogAnLDgqL2JkVboyFA--.10053S6;
        Mon, 15 May 2023 21:10:08 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-mm@kvack.org, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH v2 4/4] mm: page_table_check: Ensure user pages are not slab pages
Date:   Mon, 15 May 2023 21:09:58 +0800
Message-Id: <20230515130958.32471-5-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515130958.32471-1-lrh2000@pku.edu.cn>
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogAnLDgqL2JkVboyFA--.10053S6
X-Coremail-Antispam: 1UD129KBjvJXoWxurWrCw4UAFyDWF48ZrW3Awb_yoW5Wr4Dpa
        95u3W0krW5Ka4akw1kZ3ZayryrJFZ8G3yUCry7J3Wjv3ZxtFy0vF1jkr9ay3s8KrW7CFy5
        AFZ8tr1j9rWDZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
        7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
        x26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEMBVPy77495wAAsg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Since slab pages are not expected to be mapped into the user space, this
patch adds BUG_ON(PageSlab(page)) checks to make sure that slab pages
are not inadvertently mapped. Otherwise, there must be some bugs in the
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
index 1c68d67b8..92a2063a0 100644
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
+ * the following functions (e.g., PageAnon).  See mm/slab.h.
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

