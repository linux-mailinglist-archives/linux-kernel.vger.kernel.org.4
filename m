Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C009765E8F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjAEKXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjAEKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62C58D1C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-460ab8a327eso378504857b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksh61HdFJKW5FzhQ3xBVqQbws7N9eS43eLhKNpPeqew=;
        b=MCxyEzTTO0yqg91shqPo6Ni+5EFzxsgTqYc3+pyMOGf0oatdr3BfMXYm2vwczO7xxN
         6eXisofnTjW6ihZw5N2TmlX/02IpUvl2Obfz7KJBIRlML8eUYj2RVscTVOTPLqUOfEUl
         7ALcPn6iafF/zuFvLcOWLr1Ggm27nMtZb4wuXZmie98LQOT+8Oo6f9LCBYicU9kTcsva
         a2UPiZZmZL+sjQYo2rL2gE+wftIxhHkEnB5vkmujJzydzSbw5WDTc7LnG3S0nQMS6Apd
         oD0DG4TxblVTSmtrDjw3jcw1qYcj6bz1oBV8ULyJY3Xpek6MnVH6iGGXHSiY51d0n8u/
         xlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksh61HdFJKW5FzhQ3xBVqQbws7N9eS43eLhKNpPeqew=;
        b=6tZ+z8JBShw/JQJtKaxOK6DrsJqczZOUOe4P2D/WFv9ViqRG8E25m/v4aySebX4rF5
         SFCzTh5VqRHy4Xq17CHRk7Emklkc/99kEPOu9efDPQSktxtfM7yLWOcNHc52NfkQ2PhV
         QK1emZZLKLpP+2IsfAo9wxBjIQ1rcCu6YiPQmr5gOtcckoUs2PgtIStKoeR95vvQ6SBs
         gLYniUqkcT40oR1L9qZLE0CoD6ryAX81FiIiGb3EfYdIHLeS8cGCt3RrqvXK9YZm06X2
         BSjNso+VvF4oN8m4pTTZFwyAzkYV3APK2wN3XQ7gQg0WQn5iDSiCOeKMfsgE9nAOHFUo
         88yQ==
X-Gm-Message-State: AFqh2kruN8NiX7rPCIcOKZOYJjaXzAChHHjFv3KTj+c3NiY7gj3J4uQ2
        I+Xj+R3AJB6aiSfQB+fMujz6lPDqSp7pVZzP
X-Google-Smtp-Source: AMrXdXuUdtLbHKVzfYol7vn49W5JNTDiD617kfFDgxP5DZEb9ADfn2YrSfngVZdq4KyN5rcGwmq3pEoz4PydDJ4S
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:1c17:0:b0:475:7911:2119 with SMTP
 id c23-20020a811c17000000b0047579112119mr5474920ywc.359.1672913992847; Thu,
 05 Jan 2023 02:19:52 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:38 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-41-jthoughton@google.com>
Subject: [PATCH 40/46] docs: hugetlb: update hugetlb and userfaultfd
 admin-guides with HGM info
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

This includes information about how UFFD_FEATURE_MINOR_HUGETLBFS_HGM
should be used and when MADV_COLLAPSE should be used with it.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst |  4 ++++
 Documentation/admin-guide/mm/userfaultfd.rst | 16 +++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 19f27c0d92e0..ca7db15ae768 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -454,6 +454,10 @@ errno set to EINVAL or exclude hugetlb pages that extend beyond the length if
 not hugepage aligned.  For example, munmap(2) will fail if memory is backed by
 a hugetlb page and the length is smaller than the hugepage size.
 
+It is possible for users to map HugeTLB pages at a higher granularity than
+normal using HugeTLB high-granularity mapping (HGM). For example, when using 1G
+pages on x86, a user could map that page with 4K PTEs, 2M PMDs, a combination of
+the two. See Documentation/admin-guide/mm/userfaultfd.rst.
 
 Examples
 ========
diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 83f31919ebb3..19877aaad61b 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -115,6 +115,14 @@ events, except page fault notifications, may be generated:
   areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
   support for shmem virtual memory areas.
 
+- ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM`` indicates that the kernel supports
+  small-page-aligned regions for ``UFFDIO_CONTINUE`` in HugeTLB-backed
+  virtual memory areas. ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM`` and
+  ``UFFD_FEATURE_EXACT_ADDRESS`` must both be specified explicitly to enable
+  this behavior. If ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM`` is specified but
+  ``UFFD_FEATURE_EXACT_ADDRESS`` is not, then ``UFFDIO_API`` will fail with
+  ``EINVAL``.
+
 The userland application should set the feature flags it intends to use
 when invoking the ``UFFDIO_API`` ioctl, to request that those features be
 enabled if supported.
@@ -169,7 +177,13 @@ like to do to resolve it:
   the page cache). Userspace has the option of modifying the page's
   contents before resolving the fault. Once the contents are correct
   (modified or not), userspace asks the kernel to map the page and let the
-  faulting thread continue with ``UFFDIO_CONTINUE``.
+  faulting thread continue with ``UFFDIO_CONTINUE``. If this is done at the
+  base-page size in a transparent-hugepage-eligible VMA or in a HugeTLB VMA
+  (requires ``UFFD_FEATURE_MINOR_HUGETLBFS_HGM``), then userspace may want to
+  use ``MADV_COLLAPSE`` when a hugepage is fully populated to inform the kernel
+  that it may be able to collapse the mapping. ``MADV_COLLAPSE`` will may undo
+  the effect of any ``UFFDIO_WRITEPROTECT`` calls on the collapsed address
+  range.
 
 Notes:
 
-- 
2.39.0.314.g84b9a713c41-goog

