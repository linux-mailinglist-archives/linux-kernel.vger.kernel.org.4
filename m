Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42D165E8D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjAEKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjAEKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FAB551C6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i17-20020a25bc11000000b007b59a5b74aaso773082ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZkjgoDFSdPqMdf6PVi66Nkhma8WC4z5Ws9uGEsRfvU=;
        b=b1RVVWEcn7xCiOOjSjy13xNZs7I3m2tPgL+vaICF4A006PbkCzbik5RH+bvlc5t1Qx
         smy7s9lD0NeMHyXR/guX74nirJ4mhSP/b5OsHYtrukajSYuo8SN51XOlUZveqfcIBxTi
         pCfvLZWOwBGymc/6OMx4GvgiaEZ8gEeK8Ch/w/fxFKNdFChMKGauZEpNnT4CrnGxewHT
         oGPT+PC4YdlyU5cZzBSC43pYPeJidbn+PHc6Uj+0smcgsOefwqWpVuhCtBoBfzEfEMFV
         upTK7E8QZhz98epzC3+PkHQg4sEDxGGdEgPVD9h872OYNbYRLMjyEnUxFS/EyfSg2GYD
         aEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZkjgoDFSdPqMdf6PVi66Nkhma8WC4z5Ws9uGEsRfvU=;
        b=qshl5wbcNG5G1zJME2vwAA5XZS+LHFNuzg1NZFuKbP7rHWQCjXqAOtUoPWakgVToYk
         iAjPVmRxzRZDz4oJ2x/daRb517k5qrsj2wMUD3MANz+QRtOwGj/00h6wDG7TCtx0Z8KK
         8Y6TK5TB1ZMB2vgtfyouvQqllM8cb6I8IP+8Vxnt0ntVZCtBbGBdhMt+7PjsQihiEMXt
         1tLpZOy/zAaMVkVZAXyL3OJ2101dATlzL6NqFTyGj9f2+lCmkpn2uCAXnkuXx38p48cg
         H/TIeWXNYv72s5rDyGc8VwuSwf35aF48GnaxdHMfi3W7bMtYgKklG+BQ7tdNObsCSLW2
         iAnQ==
X-Gm-Message-State: AFqh2kpgy87sLN9NRZSP5NErS6bL4Nfh84FBpI78o8LkEvqSLTyyq0PK
        NuqEFlw4Mvw3vGxY2WatFM+nLCfkJ5CNc7pD
X-Google-Smtp-Source: AMrXdXvdfTkOB9SHQm3CQqLDUm9d4RcxTmzh/cSUAY1Ri2gZNPJRC9o4+adxaYDY9ZV7J44JX0JcbEjpnhe2Rp/q
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:f41:0:b0:6f9:bd92:e428 with SMTP id
 62-20020a250f41000000b006f9bd92e428mr4815135ybp.28.1672913955309; Thu, 05 Jan
 2023 02:19:15 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:12 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-15-jthoughton@google.com>
Subject: [PATCH 14/46] hugetlb: add make_huge_pte_with_shift
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

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aa8e59cbca69..3a75833d7aba 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5028,11 +5028,11 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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
@@ -5046,6 +5046,14 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
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
2.39.0.314.g84b9a713c41-goog

