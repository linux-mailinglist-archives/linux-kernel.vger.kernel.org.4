Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177EE69B6E0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBRAb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBRAbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:31:22 -0500
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E36D25F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:55 -0800 (PST)
Received: by mail-vk1-xa49.google.com with SMTP id o73-20020a1f414c000000b0040163d749ecso646898vka.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVcqYSKj99pGLWaPkurlgRpM4dq8t04RSFrIu2L3zgA=;
        b=q4c+hojX4+dTZygB2Tks0txtgbVxj7x8TKkFZ4tMc+sqQf6GeN73tsvcqCiW02hDp4
         8XPu7pKfyuoWyWf0l6efa5Zl8QTeR0XBVVaGrv+Wd9WG+jAQtWkF9yUFkUA6luQj+6cl
         jVGauOVy3CkA+wV1fgTRQ99Wfw3xgg3rfIr1+mhVfMwPBkQ+w4aIyIAy3UP92Sz6TP2b
         rQ4LOt/rb25Xw9+JRDlRHS/Ym0me/mMiwA3HH1eYVYoYEY9NAXA/3czNh8h0WNs5P9nw
         XagFyrun6V7H5uqPSe2BtAfdYCj11o7oZZljG6RocZ2iOY2K7t3KE+FE2jG7TajzTzWr
         Fm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVcqYSKj99pGLWaPkurlgRpM4dq8t04RSFrIu2L3zgA=;
        b=pjf/EGM78TOgMpolN8znEAxniik47ZXYh5R5s/capKMnFXX/Q3WNp8/9OwTLD63mQP
         Q2LrDR27bc/XpMxZe6U5HZv3oMOFpOjUE8HNmB0QiLKMgrvGWYrtWV1mpwpJFH+vVN9m
         uwQJm74HVJhwFmrgUbQ+hSSbl3yhhSV2/o9UtOJQ3zCLx3tFKJlJmj5JJWcc3hy1YaXq
         b65RDP6sm43bE3gUoUALCtwNuUEhRRJ3v3+fOTCPYdPZKmS+xSy03O4H7jdrgn8Cn406
         q2nuyToL8vegjh3IxWAV4K+l6s/JBrF2qT7oEVgEaA8nKrasx2VCjqqBiazdKH9lddKT
         gwLg==
X-Gm-Message-State: AO0yUKX17HODU8+NeSdCcMejTk5b3+rDJVdm65o8wQvE5HesSQhJEaRr
        n9KyYfRvneJ4nZ1BNNTVQgj2i+WSWqTmQbnZ
X-Google-Smtp-Source: AK7set9Tf2rc8YP45MnilA/p/YM3vrBRBTo5dK3QsJoCd53f/+o/OkfQqN5UhVm88d9/++IMJB7K0rC38dMHYTlb
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:100c:0:b0:68b:9eed:1c7d with SMTP
 id f12-20020ab0100c000000b0068b9eed1c7dmr77489uab.0.1676680165444; Fri, 17
 Feb 2023 16:29:25 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:14 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-42-jthoughton@google.com>
Subject: [PATCH v2 41/46] docs: proc: include information about HugeTLB HGM
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

Include the updates that have been made to smaps, specifically,
the addition of Hugetlb[Pud,Pmd,Pte]Mapped.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e224b6d5b642..1d2a1cd1fe6a 100644
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
+"HugetlbPudMapped", "HugetlbPmdMapped", and "HugetlbPteMapped" may appear and
+show the amount of HugeTLB memory mapped with PUDs, PMDs, and PTEs respectively.
+Folded levels won't appear. See Documentation/admin-guide/mm/hugetlbpage.rst.
+
 "Swap" shows how much would-be-anonymous memory is also used, but out on swap.
 
 For shmem mappings, "Swap" includes also the size of the mapped (and not
-- 
2.39.2.637.g21b0678d19-goog

