Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292673BA35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjFWObJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjFWOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC612699
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJajW3CLipjyQ640k+WW23diII/jzqCXLm/r+yoabGU=;
        b=QUQjzX1dXqe/Fw4J5ghRkijWgs0q7MnbC5WpVEC6Y0KjRjfs2/3dM59t+YK13yJUzxXSKo
        KBtZAtNsI/kcJFm1k1Lw2xmsIzGH7/lcSpvFFFyQEdgoyZZIbuIwFkHaE+KkQ91cNEMJLp
        H4PioZ6r15Fbb/exmimxgJ1M4dwKNN4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-Ju6IGAA_OyWEYRipBJRQCA-1; Fri, 23 Jun 2023 10:29:51 -0400
X-MC-Unique: Ju6IGAA_OyWEYRipBJRQCA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6340023ffbbso477766d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530591; x=1690122591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJajW3CLipjyQ640k+WW23diII/jzqCXLm/r+yoabGU=;
        b=VhGJOgqoLVy2ZXM0QQLF3NRO9VZAMZFMaDvL+u8xLjkHETfYsP0wbUS7Y4GkEdpdux
         nPQ64zlDT3GPRNxHLHYnDv6+pSiuLxJoIy7vEz1mTqT+dQ1VD4QKUjvx2EQf/o+lM7XE
         aP/m9Z30qzschNXezGs03opqnxubZbYnG/F0elV7e8AJFjBy30123pKdlWqKGzgIYdDN
         pKb9QXmoUyJk5hBgUJR6QmT/6TM8cwQdJRUHjex+HdqAdoqKtdoAxmz1bhT55qju8kDc
         atpt3dT3pY5kQ3sa0OTrFWIZpfCJpXxwVAYxPrFh0HC9gkRCAkSAh52d5dTctZ4ejwXq
         Fsfg==
X-Gm-Message-State: AC+VfDyDtfkNVg6uF2SNUrI9cv7zFkmzL0QdKRyQx66HUlGPaMa5r2zo
        EzNxhP/+0vlC6M4Y+Z0GiQXXfxVfZjHBRdpT2VMGgWJEr8mGSNLMKt8qSCgQ0gSlSwkPb1m5u1+
        aRrbzDGjxOnRwt0p7F+K8T7kU
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr25209293qvp.5.1687530590835;
        Fri, 23 Jun 2023 07:29:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LBdflQdmHl6rCFBv/aEN13DoGpkWXXDa3kzujb7sug+FgkYDvvz3ULmIE5oitFlMfpXnucg==
X-Received: by 2002:ad4:5b8a:0:b0:62f:e4de:5bed with SMTP id 10-20020ad45b8a000000b0062fe4de5bedmr25209269qvp.5.1687530590562;
        Fri, 23 Jun 2023 07:29:50 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 8/8] selftests/mm: Add gup test matrix in run_vmtests.sh
Date:   Fri, 23 Jun 2023 10:29:36 -0400
Message-Id: <20230623142936.268456-9-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623142936.268456-1-peterx@redhat.com>
References: <20230623142936.268456-1-peterx@redhat.com>
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
2.40.1

