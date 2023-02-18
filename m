Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3369B6C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBRA3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjBRA3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:29:19 -0500
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC96B311
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:58 -0800 (PST)
Received: by mail-vk1-xa4a.google.com with SMTP id n123-20020a1fbd81000000b00401684aa41aso609622vkf.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xG9DbE8VOder+S14FjxoH+IwzXAdpZM7a0a5kZcYva0=;
        b=a3A4PV5p5qh9WhQPMBGPxG18XU5syYapjVA8cJrIQKg9SlfzzX0meZ5KSEbjCS76/h
         KkgUk1GyrdDSRmNwgJs67ciqNHmVAv5DJmhTpojLF0Uyhx6Rxq0nYHhEXa500KqHdLSY
         8OPHt1vFrno7tMNUTlD5OZynE2nE9LC7G2tsTG/pmDJw36wEBjXLJkf3kjpEqyBFrFHU
         onGHC9FIBifpRYHynXz9NhBphtMbFvKNAw8XziHocmnSczkwT0klgF5M5m56ALq64vUA
         bsFoi/I6FyoSWC8X++RYI9nsaIKHXsGED5l665XewLFlFoDtjmgAh+mOcZ6rWrr94rxB
         1OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xG9DbE8VOder+S14FjxoH+IwzXAdpZM7a0a5kZcYva0=;
        b=44XdOPU0tjiy/GdRBHvTZJQxlwEc8kTJGm83Bx1p+wkIszjxL9vD+cKhBEYtyqGJCq
         xpEqttxco6656KAfXOFz2cny1Rhd6fajnXNtzxY/MyzRFNrcL402xU8gJyHCE3rbprw9
         R4dHWAYx44EuUwkEq3IaQtCQpaa3soxpIw9i+DEPGV1nItk6yKQN0IfxGJfrIRSoLfhn
         Q5MkW56KnoJo2EBcO8gpQ4oXp3Dpi9FesMD8lcT68Bnj2wm5DspYjhBtTmmL0Oyww6bz
         AYlenYlmukvtykVqqmmkYDcgxsOPesqcN9EoE1DSlPCuUHLuwhVOmBbMFvp7aj96IuIy
         UBug==
X-Gm-Message-State: AO0yUKWWwpudVbK7JLBdHtRgIWe8Fll5ur2FiOKcKdarbDoLp6HGLizN
        PTeaC1y4j9ogAej6+4/rPGN+g2mk/yu2Bru+
X-Google-Smtp-Source: AK7set90mnEVzNzEwK6fPTTkXMb5MvuuAdnXyAlauMlVrzIA9ZFHAX7xiVkHYeaXZEfkvh8rxB+tXWDlCgeheDym
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:53d9:0:b0:68d:6360:77b with SMTP id
 l25-20020ab053d9000000b0068d6360077bmr26282uaa.1.1676680137978; Fri, 17 Feb
 2023 16:28:57 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:48 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-16-jthoughton@google.com>
Subject: [PATCH v2 15/46] hugetlb: add make_huge_pte_with_shift
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f74183acc521..ed1d806020de 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5110,11 +5110,11 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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
@@ -5128,6 +5128,14 @@ static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
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
2.39.2.637.g21b0678d19-goog

