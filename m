Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51E65E8F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjAEKX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjAEKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564658D23
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4528903f275so370835987b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=99zyT64KwIVcKcOLonOKX5TPwNAFDbPGP6/roR2wJeg=;
        b=BGsOO1Xac220ouarsldL8eKmYhPBMh3Wgm0XdhF2qRYBawDIEYWKUm1fx3k2kI0tO3
         6haBYEyU52usmxK/1mMxlgVirWHauUoqjfTmpqfD8C4NnA9XgvhoFikpqHngC1fco9V7
         S+UlF+nVqFxP0rGL7Ey8oAS/AXZi5EU2c143l7lqDwLU7BB+WKAdEjqfM7TPqkG2EeyJ
         uasY9UGaoogWW9/VJti+da2o1nbNCj584CdLWxHWuI/cw3xKS8dYTTiOo6VECuB/GmOW
         1BhWMy0g/FBHeLD+VAxCyqfvElw8RGe86lYpIg6QfrQJ1bwD+NpCsEMEh5dkAuTWPcaJ
         K9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99zyT64KwIVcKcOLonOKX5TPwNAFDbPGP6/roR2wJeg=;
        b=EJikxhHm4HhLDHl09ThbXkuMOs/TZp8+nFApVYemYvhnWryG0Z4+TZxF88JhUYyvBP
         oqLBejfYcsC02TmJ4z9hNPBzB299Z0HBjCC3nrNyZjewlxocJx3ZLh2mAlaK0cXXNz1i
         vGUJUCu3fEB0ZgHr4rzK10QEC8aceyfqu3bWCniil3qobX4BD4vwqMQwvasNJQ2jekbN
         6WAcA3vkZDZQppNxiAh7+jTEFD1U+uOvWIjXRHXMUhs2DIoDmhMtC6evPb5yOszBDdP0
         7Nxi3kQU+g3bBVfcI/ESpXLkXQNqJ6NdRNu0U6Ez++3dXmyU8nlnWeak98JIfg9P5IRs
         O2sA==
X-Gm-Message-State: AFqh2koiIqBJTzhWquFMGKhdxA34AuAdqwQkUGrg8F3EXt1fYVXZ5lIA
        +7XqgWiJavzWzBpXAamyj7Q/BUcf1Bq0WFJX
X-Google-Smtp-Source: AMrXdXvsBqG28GRMWBm56GtDbnxmt0iS/OB8Uv+tWQOADD6vpQwS1iuiPqZuiNCSbnQC4jMgqN7qExiWxrGFRxIC
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:3146:0:b0:6fb:80c:fe0f with SMTP id
 x67-20020a253146000000b006fb080cfe0fmr4203995ybx.25.1672913993943; Thu, 05
 Jan 2023 02:19:53 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:39 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-42-jthoughton@google.com>
Subject: [PATCH 41/46] docs: proc: include information about HugeTLB HGM
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

This includes the updates that have been made to smaps, specifically,
the addition of Hugetlb[Pud,Pmd,Pte]Mapped.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 Documentation/filesystems/proc.rst | 56 +++++++++++++++++-------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e224b6d5b642..1fbb1310cea1 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -447,29 +447,32 @@ Memory Area, or VMA) there is a series of lines such as the following::
 
     08048000-080bc000 r-xp 00000000 03:02 13130      /bin/bash
 
-    Size:               1084 kB
-    KernelPageSize:        4 kB
-    MMUPageSize:           4 kB
-    Rss:                 892 kB
-    Pss:                 374 kB
-    Pss_Dirty:             0 kB
-    Shared_Clean:        892 kB
-    Shared_Dirty:          0 kB
-    Private_Clean:         0 kB
-    Private_Dirty:         0 kB
-    Referenced:          892 kB
-    Anonymous:             0 kB
-    LazyFree:              0 kB
-    AnonHugePages:         0 kB
-    ShmemPmdMapped:        0 kB
-    Shared_Hugetlb:        0 kB
-    Private_Hugetlb:       0 kB
-    Swap:                  0 kB
-    SwapPss:               0 kB
-    KernelPageSize:        4 kB
-    MMUPageSize:           4 kB
-    Locked:                0 kB
-    THPeligible:           0
+    Size:                 1084 kB
+    KernelPageSize:          4 kB
+    MMUPageSize:             4 kB
+    Rss:                   892 kB
+    Pss:                   374 kB
+    Pss_Dirty:               0 kB
+    Shared_Clean:          892 kB
+    Shared_Dirty:            0 kB
+    Private_Clean:           0 kB
+    Private_Dirty:           0 kB
+    Referenced:            892 kB
+    Anonymous:               0 kB
+    LazyFree:                0 kB
+    AnonHugePages:           0 kB
+    ShmemPmdMapped:          0 kB
+    Shared_Hugetlb:          0 kB
+    Private_Hugetlb:         0 kB
+    HugetlbPudMapped:        0 kB
+    HugetlbPmdMapped:        0 kB
+    HugetlbPteMapped:        0 kB
+    Swap:                    0 kB
+    SwapPss:                 0 kB
+    KernelPageSize:          4 kB
+    MMUPageSize:             4 kB
+    Locked:                  0 kB
+    THPeligible:             0
     VmFlags: rd ex mr mw me dw
 
 The first of these lines shows the same information as is displayed for the
@@ -510,10 +513,15 @@ implementation. If this is not desirable please file a bug report.
 "ShmemPmdMapped" shows the ammount of shared (shmem/tmpfs) memory backed by
 huge pages.
 
-"Shared_Hugetlb" and "Private_Hugetlb" show the ammounts of memory backed by
+"Shared_Hugetlb" and "Private_Hugetlb" show the amounts of memory backed by
 hugetlbfs page which is *not* counted in "RSS" or "PSS" field for historical
 reasons. And these are not included in {Shared,Private}_{Clean,Dirty} field.
 
+If the kernel was compiled with ``CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING``,
+"HugetlbPudMapped", "HugetlbPmdMapped", and "HugetlbPteMapped" will appear and
+show the amount of HugeTLB memory mapped with PUDs, PMDs, and PTEs respectively.
+See Documentation/admin-guide/mm/hugetlbpage.rst.
+
 "Swap" shows how much would-be-anonymous memory is also used, but out on swap.
 
 For shmem mappings, "Swap" includes also the size of the mapped (and not
-- 
2.39.0.314.g84b9a713c41-goog

