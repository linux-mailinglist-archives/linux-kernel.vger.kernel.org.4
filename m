Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD17607C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiJUQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiJUQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183F2892E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o4-20020a258d84000000b006bcfc1aafbdso3722554ybl.14
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WxKGqQ6TZ4IrlRpo46PGVbYr6hPIEsEGe3hsSCnb6qg=;
        b=nd84xfoSk805dVcAVyuoNqGohV7P5cWuxEwnitdbs1rkx0N7wPZbXDeJ4RvhkuBQuI
         1v5ieZAWL4fzYytJgsDwUG418qnEFB1/qmZtj48lT3wl5WE9DVb2V1XTv+zdOICQ5pda
         5diZHurVjQaoJ7Iv2PjP8DCGO1/4fukcBNdxrI/uAXh+hc99Z5wn2kayMv2lFTeOX5T6
         kP7/z1HmhxO1WbkpEmUOZN3ey0YjwgIFaCUcG52wZtr3jBV58ShZQQ9oLg2hp/N1Ghjm
         Ji/V0BtPfvSDPqTGOkZQH+0TcxQ7lca6EKfHqsThwhdtFcp6XI9rp8phcpX8i0ybjokl
         Tk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxKGqQ6TZ4IrlRpo46PGVbYr6hPIEsEGe3hsSCnb6qg=;
        b=4dLlbuKN1GjeYFVaTXVd+pXYSwmLJtxH5AGeziP8I2DOEds1H8LgrYVQT+Vvl5HVrm
         1NNqjoiN7cCqNxR5DvTZ9ZO+JA2YI2gKKn87D0U+qMBNw8Ww35hReEcjGeIXwi+6fbXh
         Linz5DUSuMASKGTTwdx1Rx/rJ1+LTYVRq51ZlBMmLWJK1aryDht4hMPb/iyu2q/OFJt0
         dA4rJKwx9zWxqhrJBxzyLDTQeguJEQFyDhUbAZJ4dcwaiTZqxZ1hoyjY0yPygRflTTlz
         IkMG1NiDvZEJJFAopJzd3QjRDD83XfHPi2EwpSNXiCr9hFTvNGvqN0p443JmpVJU9UEc
         0Z3w==
X-Gm-Message-State: ACrzQf1/PzzSaZh+ktpR5zGTAafpSOzXCsIPlzRs9KSbEr+3/erj2DFJ
        UNA4wdQpSQvn8DHGnabWL+Cg/gKmm7W1R4tX
X-Google-Smtp-Source: AMsMyM4H5gt46GP7GjF8ARtqp9296GvSN14OD4CSfEEEt+Wku4dIzgl6cgqSu20XIEbBbUbyH8kZp+Wknizu7ee3
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1027:b0:6ca:71ca:e68b with
 SMTP id x7-20020a056902102700b006ca71cae68bmr2934076ybt.2.1666370266458; Fri,
 21 Oct 2022 09:37:46 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:48 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-33-jthoughton@google.com>
Subject: [RFC PATCH v2 32/47] hugetlb: add for_each_hgm_shift
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
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6f07968156c..6eaec40d66ad 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7856,6 +7856,25 @@ int enable_hugetlb_hgm(struct vm_area_struct *vma)
 	hugetlb_unshare_all_pmds(vma);
 	return 0;
 }
+
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
2.38.0.135.g90850a2211-goog

