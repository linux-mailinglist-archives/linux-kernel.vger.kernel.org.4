Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D689A736005
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFSXMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjFSXMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BEE6E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJajW3CLipjyQ640k+WW23diII/jzqCXLm/r+yoabGU=;
        b=ScTonLJPeCP5RcZsSjBU1fqNCsI1OK2Fxwbgp61vS/mHZwA2U2DjFvNmUWE+rf2Vg7sGgh
        vMVI7+lMLOodGnQx8p0pb16l/qPFG4QOx/1ZDy3R+POIhpTrQnN+TDA1GNAFRf24mFG+fw
        crYMmzrorQYffrGehFKmVpRPVUyPY9s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-Gm_WOQplN3i02Nm-V8_UgA-1; Mon, 19 Jun 2023 19:10:58 -0400
X-MC-Unique: Gm_WOQplN3i02Nm-V8_UgA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7625940fbf3so29808785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216258; x=1689808258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJajW3CLipjyQ640k+WW23diII/jzqCXLm/r+yoabGU=;
        b=R8jv0i9LiQpFdxOaiRX4+ZI5ZSTPp0D3ENp92HJj6/P1PVwXlcKSfseE0HQRTRURGc
         GnUYxoHYTOsKgDK6e4inegt2fJ2f9wqOSgzn3OlrtGg7Uvo8ed9JEdQf6fjeB5vg3t9Y
         TK0hlCk4y47QNs0cmq2vwh7kFhZqVjMkKS3eEUH/HCLqWUcipWt9lsAXPwjCtPqvw1HD
         y8CXBqTetItXwyWdQ9L5ZUXzerqbO+B3VO2l/fTwHLHSbXh2aw33DxqaOZKZ2znvR+E4
         UtvFGpAtI8czD/kXhYOt9T4xzi2r6gsdlRsJWOxM+kNXZUXDkZDK7iD2MJuIxg6W7DOC
         9C9w==
X-Gm-Message-State: AC+VfDxy40OVICivyymhJn7wX68bG1oGbsMeN7NoyyYqjPd8XPFs7kVb
        SOUAfLBoyBfJ72M3MRnoKBPexANujDRl9KZsDgacoKxWTRq2/8iJybbTRBtyTxuCSNAuf/hpzjc
        Ylk0pLljTMUM7ZsRkYALjw2b+
X-Received: by 2002:a05:620a:4104:b0:762:63b:e10b with SMTP id j4-20020a05620a410400b00762063be10bmr14345380qko.1.1687216258220;
        Mon, 19 Jun 2023 16:10:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WYX27wSLfWLAP6ptDSxeQjeiOuxTJdqk6j7utUmQ2LCWuj5byVhLohQPj0ZsEQC2nxlnrpw==
X-Received: by 2002:a05:620a:4104:b0:762:63b:e10b with SMTP id j4-20020a05620a410400b00762063be10bmr14345358qko.1.1687216257943;
        Mon, 19 Jun 2023 16:10:57 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:57 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 8/8] selftests/mm: Add gup test matrix in run_vmtests.sh
Date:   Mon, 19 Jun 2023 19:10:44 -0400
Message-Id: <20230619231044.112894-9-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619231044.112894-1-peterx@redhat.com>
References: <20230619231044.112894-1-peterx@redhat.com>
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

