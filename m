Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B056265E8E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjAEKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjAEKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:20:56 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C758310
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4b34cf67fb6so64986277b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjKcTgCHQU9dL6HEL7BjnCeJzokWebjD5rXkoH4g/pM=;
        b=VKrl9diSEpwY713/gRrQ7D7jynnfdDKrTaaauRJ8Kmx76DzNiFvpsbu9cleofopMYY
         +vN1ez44452yYnBQYI9/ica76cicDmXhDVXewbjHC7ZvbpYxQspAVjUda//9KqW+Xs8u
         LR39HFBaerFN0EvlEGK+6/C5d0YJLK8kf7/07SPIgTMOJAJTpX9hXOYciZWdCmvO2ahR
         6iZd5/Y9MDnIUiesI7LWvxsmnqWFe7L9Ef31ukl3F+hZHDBLwQWc9oEr3/AQYOzqITnW
         ykinTUIHoWMFPDqTP4+sgJ80WGoY/Y9vThhY32VjfbhOO1aAUa7akpnfIabYK+/jBMcc
         tlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjKcTgCHQU9dL6HEL7BjnCeJzokWebjD5rXkoH4g/pM=;
        b=dozJYGMf0EahLV50FKPQ2GA6ZqN+wjmgaIFUUjkmOXjbHLCGDbUzDUTTxrNLMdD3TN
         Z45uexTIULbT6DRJPPtGyye1+dJqSMggVLo7gYMlJAzbadYMnkmtVB4i4B8Bsvlik4i6
         LzpgMF7K5vVx1U0VyEcTygECw6XsWw8f2xdDhULtGHqUwBCrmTu2gWkwNP/BI+zkEaBM
         vQWGFvawytiC/r4iOCaIuH1jUduDTPGbjI6OCfbVForg0jCPbW69Qz1Aabsf2LB9244z
         MbCKqOPe5HfBhFNnGYqyQNLR/GnAmkSAXDlaSe27kB32nUN0hUTCvKQQAgjumTFiiDpL
         Dj5Q==
X-Gm-Message-State: AFqh2koyx+qFux8swDKWLjAdg4ddjew1hNvyeloe4BlvvwCM+9DguBsG
        wZo+J9nqhfQO2+bd32N6G9JXOh2QX9JXWe3R
X-Google-Smtp-Source: AMrXdXtvsvCs5r5FUeplh9bq/0ejsb5delwBkknRcvX6W1H9wwf0TLqecw9cf1JUKuPILl1zHw3RCKREeb0/+0ng
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:b78c:0:b0:769:74cd:9c63 with SMTP
 id n12-20020a25b78c000000b0076974cd9c63mr4949127ybh.257.1672913980684; Thu,
 05 Jan 2023 02:19:40 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:30 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-33-jthoughton@google.com>
Subject: [PATCH 32/46] hugetlb: add for_each_hgm_shift
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

This is a helper macro to loop through all the usable page sizes for a
high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
loop, in descending order, through the page sizes that HugeTLB supports
for this architecture. It always includes PAGE_SIZE.

This is done by looping through the hstates; however, there is no
hstate for PAGE_SIZE. To handle this case, the loop intentionally goes
out of bounds, and the out-of-bounds pointer is mapped to PAGE_SIZE.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1e9e149587b3..1eef6968b1fa 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7780,6 +7780,24 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
 	return vma && (vma->vm_flags & VM_HUGETLB_HGM);
 }
+/* Should only be used by the for_each_hgm_shift macro. */
+static unsigned int __shift_for_hstate(struct hstate *h)
+{
+	/* If h is out of bounds, we have reached the end, so give PAGE_SIZE */
+	if (h >= &hstates[hugetlb_max_hstate])
+		return PAGE_SHIFT;
+	return huge_page_shift(h);
+}
+
+/*
+ * Intentionally go out of bounds. An out-of-bounds hstate will be converted to
+ * PAGE_SIZE.
+ */
+#define for_each_hgm_shift(hstate, tmp_h, shift) \
+	for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
+			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
+			       (tmp_h)++)
+
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
-- 
2.39.0.314.g84b9a713c41-goog

