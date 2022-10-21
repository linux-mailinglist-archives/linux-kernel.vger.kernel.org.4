Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB932607C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiJUQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiJUQjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F6828B1BD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-360b9418f64so34092477b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmmajsS+yF0Y+smc9uDIgSrHWhiWWvbw0yNGeqoJ1B4=;
        b=k/CWTQ2SpQJfccU+Jmu5n5m3XKwNOcn09ydVormKK4vMumeUdIUvjCVCl5GIZ9SIyh
         C7Inn0LyzhxsNSOMjm/4020a5BNYgiNEhy78qAvhW1Twuq2iFbHu60cGARKIabVVIokR
         utHTdzZJsAzCrzV4+3TLa3tG7Ervq6FCIxHIVfY86Qt7eoS/8UiFf/E6EZGcJbnBuQHC
         zZp90iS8OmSktGOr/SeHXA0/BixmjPhSHK2BJ4SArbN3ZuBM6g0pEG45aPZ9TlAcsNeA
         Wt8tZXRb5+asexv88RaTMkaItUpev6DjCp9jt/Dnh6ebstfYDAyaIV6Q4tpqhyYhq9jK
         6mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmmajsS+yF0Y+smc9uDIgSrHWhiWWvbw0yNGeqoJ1B4=;
        b=Z9r5svrNp7mcxN6GccCzeATb4v7s4PxpKarJDM2Yq8Ery8rfKlgGUo9PB++S0PIqp8
         3db6gpzjzgr9fuUi6ewcfIaGKvIu+R9t2IgHefqs7bYdNhltJ/C39fHyEIOmN+knfEdV
         4G589b+TDJz+vpQjmdrwmt5rvREhqWNzjeJv//mmYPSanJ1+nVcZJLjoGogcWdFLJY+k
         V881JSuM222Rr9lzdaCSN/tNMoAnCcib1ERmyEXTjkIps5VkWSgexeaNyrRjPwks630n
         IJ2Ye4aU91Ngj/CqR8d0ASOADuPGUlpoG72YlrAQgcX8M4nDELvwiMdoBuy3GVNMO8O0
         /Djw==
X-Gm-Message-State: ACrzQf0Pdg5mWB4L1e6ED5YtR1oFGZBYfO2/dK+1O3OJcH6+XT0j6ecM
        i1Cjx+DWAosrV/NcsknbwsQGxYjTMbe5VqKs
X-Google-Smtp-Source: AMsMyM5msxZHKYsLs81LjcYQrDmjGVSx8z+U4iBhnZGc75i/WnwO2D1HOQtkJBFaF+q0Bi5FivhkVZCgmEY2BbDT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:1aca:0:b0:35f:1d9e:fbc8 with SMTP
 id a193-20020a811aca000000b0035f1d9efbc8mr17306594ywa.261.1666370275936; Fri,
 21 Oct 2022 09:37:55 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:58 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-43-jthoughton@google.com>
Subject: [RFC PATCH v2 42/47] docs: proc: include information about HugeTLB HGM
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
index ec6cfdf1796a..807d6c0694c2 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -444,29 +444,32 @@ Memory Area, or VMA) there is a series of lines such as the following::
 
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
@@ -507,10 +510,15 @@ implementation. If this is not desirable please file a bug report.
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
2.38.0.135.g90850a2211-goog

