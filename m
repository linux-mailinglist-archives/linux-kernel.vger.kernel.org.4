Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0461607C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJUQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiJUQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:38:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2992892C2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368036d93abso34003447b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZXIzSP66kpr06+Kt+tXVsbo2+8AOhJazRiZYv7H/E0=;
        b=AaEDv6vDecL09NV8IK8qq+jwZiQZvvW6A8x7Ma8TJX0CZ7w6xMLKRf3Y909I4MsZZu
         0hYooJEJeyPq66zTIVLiJg5dt/gi8xbCkq4HqSj0EjYIEz8fyCwDNYdQStbGaf9MswBA
         cM0TuGM5Hkk/qVgNL10a3ya+lk67Uue+WlYyzDhlhPN60sp+XydnBo5yzMI6BKPgITpI
         H+hf53xNhGv8YGv7YkIqkTgxh9mHI8YlwlzFtLYveDQJ8oSEEIKb54V3+B6SA/Eioz/A
         s4eUG3ERd3oa9TzjeUGeXvx0oAzfFHUOWw0ZDZJbL1DS3wUfuFPlKrawoJROET5ltInS
         kxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZXIzSP66kpr06+Kt+tXVsbo2+8AOhJazRiZYv7H/E0=;
        b=shIvyF5HzE9g98YV7rlLNbxFBMcJhfZWb/1ek8VJKye90T/aKT8NYaRZaKTA1wvGzh
         BUogy9z5rhplcpDsBKDPtDdRgVPU5yO55I67As2EaGaJpCO2mFTrGTGH0uewRcrVw67R
         Ej1qUldpjEsW+c3IzvpKEfqxUO8dJn1w4Kgog0kZQ06CX21c1S23Qxxbu2C9oQQ094Ck
         PyH2sscHclqVGULhT/lffuZOJKMVlNTiJXQAAKBjaCZOoAq0hwGEi4H3iyNzFTe+N+ds
         V+fh7zo0fgHw1LNAez24CfhsLbC+2b4UH5VTtTnNN6SrmXTMsAEfFoC2v41VjjVJA5AA
         fXDw==
X-Gm-Message-State: ACrzQf3/XmZAmKI6t2LL1JT+3uZmGCdsfzM9XohigeuwUSK9yzxvsJCh
        NTwWhNIQkjG4vZdr9Y/hJ4PL5e70uoV9BPg+
X-Google-Smtp-Source: AMsMyM5fFT2NWW07vlUOD6TzMkML3qSAAmP9Dq6cl7bToYf1cSTCX5pGnWQwkImQeBAyI0NRH5KmT/OClGf1fMeI
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:c1c2:0:b0:6c4:318:642f with SMTP id
 r185-20020a25c1c2000000b006c40318642fmr16424485ybf.561.1666370264324; Fri, 21
 Oct 2022 09:37:44 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:46 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-31-jthoughton@google.com>
Subject: [RFC PATCH v2 30/47] hugetlb: add high-granularity check for hwpoison
 in fault path
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

Because hwpoison swap entries may be placed beneath the hstate-level
PTE, we need to check for it separately (on top of the hstate-level PTE
check that remains).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8dba8d59ebe5..bb0005d57cab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6154,6 +6154,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		migration_entry_wait_huge(vma, &hpte);
 		return 0;
+	} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+		hugetlb_vma_unlock_read(vma);
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		return VM_FAULT_HWPOISON_LARGE |
+			VM_FAULT_SET_HINDEX(hstate_index(h));
 	}
 
 	/* PTE markers should be handled the same way as none pte */
-- 
2.38.0.135.g90850a2211-goog

