Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56153741B39
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjF1VzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjF1Vyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE772132
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+0w023mz5OfdmLI6Zdp3hWUHid6rdaL/9V50JZhDTo=;
        b=WAVyg2vOBMSZEI73gnmbY6XMoO98SXLZrWWEZIfILHHaF13dsnb2VkEfu2emXaQTBjyjLy
        e6ZnDWlGk+bECAub3yQAAQLtiqaYA2MZNs+klTvQlbMywmFNDNLzqgcZW/HaK8lQrt2LFk
        HCRRIRs0PcCtgDKFzPEqb5PqTh9BK7I=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-AIS6DH5mN5Gj7gPGGoNDYA-1; Wed, 28 Jun 2023 17:53:24 -0400
X-MC-Unique: AIS6DH5mN5Gj7gPGGoNDYA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-440bb217ba2so3077137.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989203; x=1690581203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+0w023mz5OfdmLI6Zdp3hWUHid6rdaL/9V50JZhDTo=;
        b=WChpdnOkd86hXPmfOcGe22/C95IcPqfROSj/z5ENpEl6Kcc/tqfO6N7gbXfoLFH4wu
         7pkpjrMbZx2mqn4oqltvbklOxE5dvZI5y32Cm2iprvrbHQt3JDyXQJCQL/xHM9N0hCAv
         FF1WIT5IwFiIdsasrBz9HHKRIyWUXvfAkYkR1gBhp0YnvAawXY997PTuBSkdTq6K1yxV
         c9nmL22WY9QT6if75Cxfsss8Hng3T6O7jrdaU/kxS8TVbTy4TCNQMVT8dgFOV2xQaRzd
         dcDseFer8PuQmLXkSwP4s6Pe4UKIjpbJWQMerSovw4AAgug6hVD5utq6wIjiIqO+zwjC
         X93Q==
X-Gm-Message-State: AC+VfDxZcwiCvY1hGwC6Mv1pXJSG2+a+FoL9Ovbs7iPnuqhLeTnEhxzr
        sdjxDPdLt6L43hIzgKfdcUdMZGZ0S4ycHh1PGNeZXKJw9ETNTrsiO2+Yjq89ZL62PrY+6h62C4C
        S0STajzGgTLoq0WKHZ0yMUO/F
X-Received: by 2002:a05:6102:3e16:b0:440:9794:fefa with SMTP id j22-20020a0561023e1600b004409794fefamr960328vsv.0.1687989203594;
        Wed, 28 Jun 2023 14:53:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ593pf/LYdqYwensAF9OSWrZV3jL3XksL0J6jNBIon+rk3QrdtClhhmqvv34L8EI9C3xofIng==
X-Received: by 2002:a05:6102:3e16:b0:440:9794:fefa with SMTP id j22-20020a0561023e1600b004409794fefamr960312vsv.0.1687989203304;
        Wed, 28 Jun 2023 14:53:23 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        James Houghton <jthoughton@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com
Subject: [PATCH v4 8/8] selftests/mm: Add gup test matrix in run_vmtests.sh
Date:   Wed, 28 Jun 2023 17:53:10 -0400
Message-ID: <20230628215310.73782-9-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215310.73782-1-peterx@redhat.com>
References: <20230628215310.73782-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a matrix for testing gup based on the current gup_test.  Only run the
matrix when -a is specified because it's a bit slow.

It covers:

  - Different types of huge pages: thp, hugetlb, or no huge page
  - Permissions: Write / Read-only
  - Fast-gup, with/without
  - Types of the GUP: pin / gup / longterm pins
  - Shared / Private memories
  - GUP size: 1 / 512 / random page sizes

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 37 ++++++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 824e651f62f4..9666c0c171ab 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -90,6 +90,30 @@ test_selected() {
 	fi
 }
 
+run_gup_matrix() {
+    # -t: thp=on, -T: thp=off, -H: hugetlb=on
+    local hugetlb_mb=$(( needmem_KB / 1024 ))
+
+    for huge in -t -T "-H -m $hugetlb_mb"; do
+        # -u: gup-fast, -U: gup-basic, -a: pin-fast, -b: pin-basic, -L: pin-longterm
+        for test_cmd in -u -U -a -b -L; do
+            # -w: write=1, -W: write=0
+            for write in -w -W; do
+                # -S: shared
+                for share in -S " "; do
+                    # -n: How many pages to fetch together?  512 is special
+                    # because it's default thp size (or 2M on x86), 123 to
+                    # just test partial gup when hit a huge in whatever form
+                    for num in "-n 1" "-n 512" "-n 123"; do
+                        CATEGORY="gup_test" run_test ./gup_test \
+                                $huge $test_cmd $write $share $num
+                    done
+                done
+            done
+        done
+    done
+}
+
 # get huge pagesize and freepages from /proc/meminfo
 while read -r name size unit; do
 	if [ "$name" = "HugePages_Free:" ]; then
@@ -194,13 +218,16 @@ fi
 
 CATEGORY="mmap" run_test ./map_fixed_noreplace
 
-# get_user_pages_fast() benchmark
-CATEGORY="gup_test" run_test ./gup_test -u
-# pin_user_pages_fast() benchmark
-CATEGORY="gup_test" run_test ./gup_test -a
+if $RUN_ALL; then
+    run_gup_matrix
+else
+    # get_user_pages_fast() benchmark
+    CATEGORY="gup_test" run_test ./gup_test -u
+    # pin_user_pages_fast() benchmark
+    CATEGORY="gup_test" run_test ./gup_test -a
+fi
 # Dump pages 0, 19, and 4096, using pin_user_pages:
 CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
-
 CATEGORY="gup_test" run_test ./gup_longterm
 
 CATEGORY="userfaultfd" run_test ./uffd-unit-tests
-- 
2.41.0

