Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F57607C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJUQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJUQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525427B579
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t17-20020a257811000000b006c509f9a16dso3792779ybc.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/NM5zqKrp3T0mJhjHHyOLUnz62gupmqJK/DDFGexZI=;
        b=kNo3BI9LgJDNbw4zG7f+BcfBeEsxT7zZGWcOge04kuwB3WGs4ua5FnV/ikxacl43mD
         M6k0xqIMh4xV/kNssOly5E5ouNZTJbE1jiHX8f4BQKdFzjOe8CtoSIjUdke5SPji+pEq
         kOZ846TjVCKjKeX4b6HxrkfJ6BQ6CGISZePlXZkN2Rm1jtqyKh+RfXYCoD2KqxlK58+X
         giN/v/U9prCXXWwTgQ+82EXYGKAT/w9/2BGshYZOi4LwaY3LCQutO9qEE+7l1KWb9pbv
         DCVuuxqs8fuEhlJkR2ekbMYvfUQkoMuOLpKGVnSHPaC+P69I+ARfmCsKOI9PHLE6d5yH
         SWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/NM5zqKrp3T0mJhjHHyOLUnz62gupmqJK/DDFGexZI=;
        b=PE7K8aCeBtl9dPQk2G2iangSq8o390LGl2zyxcz7mCCAMCjsC78mP1kdSk1+MglYdi
         iRzVxb+pJ5HMkkHJeHwEQL8hbgffR2eo+Hu4e7qp+yTOTHD9f2Rw1fWwuBPzlpgbGrLj
         Yv6tv3/PB6W4A2LrO89Yhbdx8d4r/yPhqpT5bEB+zRIxQiNKZBDvukphOC2110mPvFex
         VH9UOVwrwz98a5LYzZZdkDwWA0dCnAHbAYQnu72lmqYCvFcHVMhDF1W1wavNBJ3clUVG
         zsZea1jbdohwLrEvd3Acm4lPxpu8gbQySy9T8m2X8mdFiOngk9/DnBqrxCHmq341pPY9
         lPRg==
X-Gm-Message-State: ACrzQf0eRFmTgnQiIODRCrlRFrmtlHgDfLcPQ0SA5Uew7qTxqWxTEDLl
        TT3xagEHB3Xg296AUjcZ4QtPCufheQCXdxwz
X-Google-Smtp-Source: AMsMyM6lUFLmKl2u24xYHvEYAF3HSHyv+Q9NHWaQ4uC8W+BKyVcH1krHI+4kAFLxi7gYBA7W761SZPhq47YrIqjR
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:4b96:0:b0:354:8935:d5a9 with SMTP
 id y144-20020a814b96000000b003548935d5a9mr18239585ywa.36.1666370248722; Fri,
 21 Oct 2022 09:37:28 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:29 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-14-jthoughton@google.com>
Subject: [RFC PATCH v2 13/47] hugetlb: add make_huge_pte_with_shift
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to make huge PTEs at shifts other than the hstate shift,
which will be necessary for high-granularity mappings.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 90db59632559..74a4afda1a7e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4867,11 +4867,11 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.pagesize = hugetlb_vm_op_pagesize,
 };
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
-				int writable)
+static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
+				      struct page *page, int writable,
+				      int shift)
 {
 	pte_t entry;
-	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
 	if (writable) {
 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_pte(page,
@@ -4885,6 +4885,14 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 	return entry;
 }
 
+static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+			   int writable)
+{
+	unsigned int shift = huge_page_shift(hstate_vma(vma));
+
+	return make_huge_pte_with_shift(vma, page, writable, shift);
+}
+
 static void set_huge_ptep_writable(struct vm_area_struct *vma,
 				   unsigned long address, pte_t *ptep)
 {
-- 
2.38.0.135.g90850a2211-goog

