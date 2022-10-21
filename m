Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F46074B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJUKMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJUKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770D17AB16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aghhJvVu2AzGZHMKahkE2d4moWkPJZMDtfGDcWTlxz0=;
        b=ggHARlN58ztbHKfWjdmxfx6MW6uLvIt4baXwtoXsq1IX8BNyF9MGldGPibUaUmtfPEj5eS
        MHhMSEAPYve3qh7fUVunarjNKfNFrdcRzhSrd53UGZH/v3eH4PVzwk0g6qt33VvdwVNNjp
        hNWZmA2yObt09RGQE6j4IfPWANXKgl8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-X4wZcbWdNd6TO9gjx7dqew-1; Fri, 21 Oct 2022 06:12:23 -0400
X-MC-Unique: X4wZcbWdNd6TO9gjx7dqew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7F8729ABA00;
        Fri, 21 Oct 2022 10:11:51 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69A9F40D298B;
        Fri, 21 Oct 2022 10:11:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/9] mm/ksm: break_ksm() cleanups and fixes
Date:   Fri, 21 Oct 2022 12:11:32 +0200
Message-Id: <20221021101141.84170-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up and fixes break_ksm(). In summary, we no longer
use fake write faults to break COW but instead FAULT_FLAG_UNSHARE. Further,
we move away from using follow_page() --- that we can hopefully remove
completely at one point --- and use new walk_page_range_vma() instead.

Fortunately, we can get rid of VM_FAULT_WRITE and FOLL_MIGRATION in common
code now.

Extend the existing ksm tests by an unmerge benchmark, and a some new
unmerge tests.

Add a selftest to measure MADV_UNMERGEABLE performance. In my setup
(AMD Ryzen 9 3900X), running the KSM selftest to test unmerge performance
on 2 GiB (taskset 0x8 ./ksm_tests -D -s 2048), this results in a
performance degradation of ~6% -- 7% (old: ~5250 MiB/s, new: ~4900 MiB/s).
I don't think we particularly care for now, but it's good to be aware
of the implication.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>

v1 -> v2:
* "selftests/vm: add KSM unmerge tests"
 -> Add new unmerge tests
* "mm/ksm: fix KSM COW breaking with userfaultfd-wp via FAULT_FLAG_UNSHARE"
 -> Simplify patch description now that we have a selftest
* "mm/pagewalk: don't trigger test_walk() in walk_page_vma()"
 -> Added
* "mm/pagewalk: add walk_page_range_vma()"
 -> Don't call test_walk()
* "mm/ksm: convert break_ksm() to use walk_page_range_vma()"
 -> Simplify and fix missing unlock, fix missing "static"

David Hildenbrand (9):
  selftests/vm: add test to measure MADV_UNMERGEABLE performance
  mm/ksm: simplify break_ksm() to not rely on VM_FAULT_WRITE
  mm: remove VM_FAULT_WRITE
  selftests/vm: add KSM unmerge tests
  mm/ksm: fix KSM COW breaking with userfaultfd-wp via
    FAULT_FLAG_UNSHARE
  mm/pagewalk: don't trigger test_walk() in walk_page_vma()
  mm/pagewalk: add walk_page_range_vma()
  mm/ksm: convert break_ksm() to use walk_page_range_vma()
  mm/gup: remove FOLL_MIGRATION

 include/linux/mm.h                            |   1 -
 include/linux/mm_types.h                      |   3 -
 include/linux/pagewalk.h                      |   5 +
 mm/gup.c                                      |  55 +---
 mm/huge_memory.c                              |   2 +-
 mm/ksm.c                                      |  78 +++--
 mm/memory.c                                   |   9 +-
 mm/pagewalk.c                                 |  27 +-
 tools/testing/selftests/vm/Makefile           |   2 +
 .../selftests/vm/ksm_functional_tests.c       | 279 ++++++++++++++++++
 tools/testing/selftests/vm/ksm_tests.c        |  76 ++++-
 tools/testing/selftests/vm/run_vmtests.sh     |   2 +
 tools/testing/selftests/vm/vm_util.c          |  10 +
 tools/testing/selftests/vm/vm_util.h          |   1 +
 14 files changed, 456 insertions(+), 94 deletions(-)
 create mode 100644 tools/testing/selftests/vm/ksm_functional_tests.c


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.37.3

