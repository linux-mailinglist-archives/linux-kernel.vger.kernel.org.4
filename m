Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0765E09E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjADW47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjADW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC401EAF2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672872924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZyTLJHuaFPBCABjbLPe2M3+m2RCTfeHYSklpqyimWbc=;
        b=g+jLU58ZKlaNmWTpIwI+LKjjHtKpgtbEULTXrfJMOW8N/3Qrn6Y7luLxe3uki7MVcaJAee
        OMfGZAidoRVe3QJtHjUEKJH/plY1j8dqpJEJ0w3AZ7cWxNeH+EkqnghvuQ4jSXyfhzz0Vb
        sBC4Suxf1GCKMt73epp7Fua2evhTxXs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-154-XGjd8dJKO_6VXIz947yA4A-1; Wed, 04 Jan 2023 17:52:11 -0500
X-MC-Unique: XGjd8dJKO_6VXIz947yA4A-1
Received: by mail-qk1-f199.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so23816151qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyTLJHuaFPBCABjbLPe2M3+m2RCTfeHYSklpqyimWbc=;
        b=QYwnO1W71CfJrDwsE/FVHEu/lRVU2pfqbrXZLhCJ98h6OtfycC8c2YEa0bUq/JFSLf
         f6z9rVDHjBh+E4+rCSw49PY8ABQQXMZEUBZVEHZl4AHvPGXpIAJv5DWzaZjwLZAXraSD
         972rlxT0WDtX8ezKl2fsR8zq07EdR3agqo8Hp7nDPE+RcPg/TUkUY15NC4Ce1OEOnfMO
         j+mefNNiXw2g7NtoWuZfpOHG+GPkv2rpd4yjLnMq26LT2RiEFNLdg2UnOTAWzIvsXeqH
         yaqSAGjD+h3psbOLBxQ39Yj/B+Loyl5f7wDEFn218b5dKCgN4yzXr30qHIgrHhtOCH/7
         o2ug==
X-Gm-Message-State: AFqh2kqe7Q+OzKyEcfM+rwOwB6i2pOqykqwaTbyW+c+oiZqIUsacz8fV
        6XKy8sjpYrJ5PyaGyK8OiGIWY6WZTAV4l0vI4v50gAgkLunHguH6rSV8GlsXiepWx1SWxEImRv7
        PBmgsb73zCDDvhHsqEnHPFQ9C
X-Received: by 2002:ad4:4507:0:b0:532:de3:9b7d with SMTP id k7-20020ad44507000000b005320de39b7dmr2272124qvu.9.1672872730487;
        Wed, 04 Jan 2023 14:52:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXttMw1zpmySJ1jlN/fXgDbyJj/7czFDfLKTRd1p2aZYSUC76jFCepdyVyNTX6QT2vSi43W2DA==
X-Received: by 2002:ad4:4507:0:b0:532:de3:9b7d with SMTP id k7-20020ad44507000000b005320de39b7dmr2272101qvu.9.1672872730163;
        Wed, 04 Jan 2023 14:52:10 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006eeb3165565sm24654710qkp.80.2023.01.04.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:52:09 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] mm/uffd: Fix missing markers on hugetlb
Date:   Wed,  4 Jan 2023 17:52:04 -0500
Message-Id: <20230104225207.1066932-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When James was developing the vma split fix for hugetlb pmd sharing, he
found that hugetlb uffd-wp is broken with the test case he developed [1]:

https://lore.kernel.org/r/CADrL8HWSym93=yNpTUdWebOEzUOTR2ffbfUk04XdK6O+PNJNoA@mail.gmail.com

Missing hugetlb pgtable pages caused uffd-wp to lose message when vma split
happens to be across a shared huge pmd range in the test.

The issue is pgtable pre-allocation on hugetlb path was overlooked.  That
was fixed in patch 1.

Meanwhile there's another issue on proper reporting of pgtable allocation
failures during UFFDIO_WRITEPROTECT.  When pgtable allocation failed during
the ioctl(UFFDIO_WRITEPROTECT), we will silent the error so the user cannot
detect it (even if extremely rare).  This issue can happen not only on
hugetlb but also shmem.  Anon is not affected because anon doesn't require
pgtable allocation during wr-protection.  Patch 2 prepares for such a
change, then patch 3 allows the error to be reported to the users.

This set only marks patch 1 to copy stable, because it's a real bug to be
fixed for all kernels 5.19+.

Patch 2-3 will be an enhancement to process pgtable allocation errors, it
should hardly be hit even during heavy workloads in the past of my tests,
but it should make the interface clearer.  Not copying stable for patch 2-3
due to that.  I'll prepare a man page update after patch 2-3 lands.

Tested with:

  - James's reproducer above [1] so it'll start to pass with the vma split
    fix:
    https://lore.kernel.org/r/20230101230042.244286-1-jthoughton@google.com
  - Faked memory pressures to make sure -ENOMEM returned with either shmem
    and hugetlbfs
  - Some uffd general routines

Peter Xu (3):
  mm/hugetlb: Pre-allocate pgtable pages for uffd wr-protects
  mm/mprotect: Use long for page accountings and retval
  mm/uffd: Detect pgtable allocation failures

 include/linux/hugetlb.h       |  4 +-
 include/linux/mm.h            |  2 +-
 include/linux/userfaultfd_k.h |  2 +-
 mm/hugetlb.c                  | 21 +++++++--
 mm/mempolicy.c                |  4 +-
 mm/mprotect.c                 | 89 ++++++++++++++++++++++-------------
 mm/userfaultfd.c              | 16 +++++--
 7 files changed, 88 insertions(+), 50 deletions(-)

-- 
2.37.3

