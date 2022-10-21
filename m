Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89687607C83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiJUQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiJUQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A528B193
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b142-20020a253494000000b006ca86d5f40fso920429yba.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3+VTs02NGQ5oyT2/qztgs968E2VJInsJwZCRXskVX8=;
        b=B67mZeoRzaRq4630o3McC0EzYYV2BfBTiABJMfKCzqnLycO3omT8Gy4/5jQCJFz8AY
         Qu+pjgsVsBEQ7iOage5JALUzkvGcVzVAI+BCZzndDO2njS28MHuucgPnHYGjHi0MMXoR
         Jp5rOJtddtvnQu8CbcPae/HSkg70RTOIctaRcEgcIMgYrmnjlaiPn4cNjpoWw5tTnOGk
         A3Uul0URZQlgQ2/D4cBlS3e4c0tE/yI2F+txMyFPuIxYVsSXN6ldOmoWU22e+oy+uchS
         z7av7s9Z3JIen2P4NfWiU5pOIplHTUb/SK5SQWwj0gI2b/bXVCp6bRB3GWynd6s9gcat
         VN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3+VTs02NGQ5oyT2/qztgs968E2VJInsJwZCRXskVX8=;
        b=U1ehZgjeRpWYIV7uzRSnubXLHHE3ZMUwhJwYNFjHHaTurRg7sYlYf+1V+UfL7izgOB
         AGi1VnN1FM/bBtQam1deHMrSAQW9EHAdZBvuLGyGvwzC5m8of+S+HG+dDioqaerBe79b
         oQaJIQI347/KJrPMch4PnQurRr5tOvT28izKNU5nl/CNn9elmmRp1a25c9Ao12zgXyFX
         nKGJ6MdtiMSxLdn7G+Iy0OquWnP1t8mOr8J2KfP1Yxdwcxdjch5bz/qCJOzxGNomTs7M
         CSM015g0d/l4zI++xRu3O9QFk1DZ7MHS1HrqYNi5Ky6Shu5nR1Krk2tSII4/uiOXd/j4
         D3Ag==
X-Gm-Message-State: ACrzQf1ZEVjDqn7WgoTuFZcflGer1NTDfDFJH0Z7XXfZe5kcUqGEKMhF
        aWp/pAtNeBApdPtYwwRHVe39MIpNT85b5wNA
X-Google-Smtp-Source: AMsMyM5EIJbefFWR9wH2Ga6LCed1ohj9fcbD4MeuIorT1fpq+Z8mg3azIGenpfDISn40nNMhrx3GeTcUaANowwsy
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:2187:0:b0:6b0:1abc:2027 with SMTP
 id h129-20020a252187000000b006b01abc2027mr17110269ybh.348.1666370269187; Fri,
 21 Oct 2022 09:37:49 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:51 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-36-jthoughton@google.com>
Subject: [RFC PATCH v2 35/47] userfaultfd: require UFFD_FEATURE_EXACT_ADDRESS
 when using HugeTLB HGM
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

To avoid bugs in userspace, we require that userspace provide
UFFD_FEATURE_EXACT_ADDRESS when using UFFD_FEATURE_MINOR_HUGETLBFS_HGM,
otherwise UFFDIO_API will fail with EINVAL.

The potential confusion is this: without EXACT_ADDRESS, the address
given in the userfaultfd message will be rounded down to the hugepage
size. Userspace may think that, because they're using HGM, just
UFFDIO_CONTINUE the interval [address, address+PAGE_SIZE), but for
faults that didn't occur in the first base page of the hugepage, this
won't resolve the fault. The only choice it has in this scenario is to
UFFDIO_CONTINUE the interval [address, address+hugepage_size), which
negates the purpose of using HGM in the first place.

By requiring userspace to provide UFFD_FEATURE_EXACT_ADDRESS, there is
no rounding, and userspace now has the information it needs to
appropriately resolve the fault.

Another potential solution here is to change the behavior when
UFFD_FEATURE_EXACT_ADDRESS is not provided: when HGM is enabled, start
rounding to PAGE_SIZE instead of to the hugepage size. I think requiring
UFFD_FEATURE_EXACT_ADDRESS is cleaner.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/userfaultfd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0204108e3882..c8f21f53e37d 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1990,6 +1990,17 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #ifndef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
 	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS_HGM;
+#else
+
+	ret = -EINVAL;
+	if ((uffdio_api.features & UFFD_FEATURE_MINOR_HUGETLBFS_HGM) &&
+	    !(uffdio_api.features & UFFD_FEATURE_EXACT_ADDRESS))
+		/*
+		 * UFFD_FEATURE_MINOR_HUGETLBFS_HGM is mostly
+		 * useless without UFFD_FEATURE_EXACT_ADDRESS,
+		 * so require userspace to provide both.
+		 */
+		goto err_out;
 #endif  /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 #endif  /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 
-- 
2.38.0.135.g90850a2211-goog

