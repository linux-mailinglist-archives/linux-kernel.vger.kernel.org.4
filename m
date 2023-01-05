Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA33A65E8EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjAEKWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjAEKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BDC5831B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so36650445ybd.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCmSbITJPCJiNnskiU3UeHLtqxSjqb+c0ixZX/ofLl4=;
        b=lJAnXXDaHr20zsyaBijCW0KfmxNaRfjZpxfzb+EmrpYOQBN9AQ+W3KqrhpFEfEMu4i
         +7s1tvD7xS0kP2x25VUp+DunUaseeJKeyN1avNtBeuFHDsiHsskzjfBlou/AESX/+GyZ
         Yno3ggoNr2tSyK2HIjIkjbcpNd8owTXKEPNm9MytpSANgE4bv5+upiaLxV9VBMb4i1Xe
         S8lJoonIgUC5GAtZGJIrTMLDZnJTnMIHM2tRy+FWyrtFT6x4k3aGvbCYpCKZhQPF1Ozf
         oa94HBmejEbGCXSYJeddbV1BbDR2UK5+OlrJ4o06xbexPYzwtOlvGFmkuLgDAu3Jz91E
         fNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCmSbITJPCJiNnskiU3UeHLtqxSjqb+c0ixZX/ofLl4=;
        b=YeW62+CoHH4lNTYNWYaLBcy4Xl8oVz/2dW+ROprR6V6PoeVZ29IDaRoVLZ0CNJjkDn
         PGGzljPay8NqxToUdiHEeCrIi0DeLn/xhb/N6K2FSB+ZljkFKEOmAKuw81SqAyOHp3nm
         Iw7qPiRrsDc8fSx8gquXAhov5p3KCHOUTaBJf39ouOYxLw5aoJirz+Lfln+i+jx1r49E
         QMAvEwFOJL0UsgVjlgObTLGBG4ztGFhRfBOAuOk41s7Uou12m89wLf7OxVUPbycLxfhi
         ooRzUWtPtgdcii+4QfGIaNpiknTkahM/0sj7nsiafTvOAoTnr5QoW++v4kYhEjgu2qE+
         irag==
X-Gm-Message-State: AFqh2kqceEh9qYmGoYMyI5SHzLk2LL63ZEz7YDCjmLTaO6yNtSb2+4Bc
        Vk9T5CgafEi1CAA/D2QPyUaVNkTzgXNCxk/+
X-Google-Smtp-Source: AMrXdXvfobcg0pSW7Zq/998deX0KaxCoddWWbcyCzeLy3zOMp15r6k8px++xOzaFbco23vhIryJAmAiJaJYBCriJ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:688a:0:b0:3b7:e501:90cf with SMTP
 id d132-20020a81688a000000b003b7e50190cfmr2167375ywc.501.1672913983311; Thu,
 05 Jan 2023 02:19:43 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:32 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-35-jthoughton@google.com>
Subject: [PATCH 34/46] hugetlb: userfaultfd: when using MADV_SPLIT, round
 addresses to PAGE_SIZE
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

MADV_SPLIT enables HugeTLB HGM which allows for UFFDIO_CONTINUE in
PAGE_SIZE chunks. If a huge-page-aligned address were to be provided,
userspace would be completely unable to take advantage of HGM. That
would then require userspace to know to provide
UFFD_FEATURE_EXACT_ADDRESS.

This patch would make it harder to make a mistake. Instead of requiring
userspace to provide UFFD_FEATURE_EXACT_ADDRESS, always provide a usable
address.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5af6db52f34e..5b6215e03fe1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5936,28 +5936,27 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 						  unsigned long addr,
 						  unsigned long reason)
 {
+	u32 hash;
+	struct vm_fault vmf;
+
 	/*
 	 * Don't use the hpage-aligned address if the user has explicitly
 	 * enabled HGM.
 	 */
 	if (hugetlb_hgm_advised(vma) && reason == VM_UFFD_MINOR)
-		haddr = address & PAGE_MASK;
-
-	u32 hash;
-	struct vm_fault vmf = {
-		.vma = vma,
-		.address = haddr,
-		.real_address = addr,
-		.flags = flags,
+		haddr = addr & PAGE_MASK;
 
-		/*
-		 * Hard to debug if it ends up being
-		 * used by a callee that assumes
-		 * something about the other
-		 * uninitialized fields... same as in
-		 * memory.c
-		 */
-	};
+	vmf.vma = vma;
+	vmf.address = haddr;
+	vmf.real_address = addr;
+	vmf.flags = flags;
+	/*
+	 * Hard to debug if it ends up being
+	 * used by a callee that assumes
+	 * something about the other
+	 * uninitialized fields... same as in
+	 * memory.c
+	 */
 
 	/*
 	 * vma_lock and hugetlb_fault_mutex must be dropped before handling
-- 
2.39.0.314.g84b9a713c41-goog

