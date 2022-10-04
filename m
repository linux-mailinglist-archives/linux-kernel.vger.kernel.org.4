Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7180B5F4B19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiJDVqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiJDVpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13E96D9E2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664919789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1leZa+nnl9FNTENOcXSgCnyxuJRrfcW3iiJbWx0HuuA=;
        b=C121Aoo8tsktwYue02bnSXh2o66cdYdXUND6CF5Iq+5IkMsTW7HPqBHTTedivbIAFk0kxB
        PDshUsJM5FE1Js3s0Y+/vxnc3QbGjhn9sY3VWgvtrOBj2tTqzWVBbD5opTorhVRmx9Hk28
        UfNhPWCBRxyu7rsCLWSipffz/S4NWf8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-drbrBNo4MMqEOmunw90faw-1; Tue, 04 Oct 2022 17:43:08 -0400
X-MC-Unique: drbrBNo4MMqEOmunw90faw-1
Received: by mail-qv1-f71.google.com with SMTP id g6-20020a0ce746000000b004b1ab29799dso2705876qvn.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1leZa+nnl9FNTENOcXSgCnyxuJRrfcW3iiJbWx0HuuA=;
        b=ZZepmrCIq4adetSbnxb7nxdQ3LlAKUPCNG+qd4jpc/RTaXgrmNSspXWbZl0Eea3JPp
         VBHlu+DJwz5jxbP7cuk2qU46dc6V9zr1SVAA8g6WgKUa/KwUMhOlnhspsCkNComCB5TA
         j0cta1yo7O6uNToma3VnzIb8p+ovnmGiPJf9aCmVUWpCuaDP20jdeXn/8Bcacl4vbNtg
         gfl1+dVGJRla3qUtxfsM5xYbBNPUhYqVx/5z6mhjXuFG/wUk/Ahk7ea5hd6qBs8cIywo
         w7ILSnZj3n6NVtlSeTSQRyT2VlRw/Z6J2kEi2H1Sffhn16szDHPdNu9YN3Kxr14qtm40
         P0HA==
X-Gm-Message-State: ACrzQf32LKcoiwmd5iG29O2PeNpG7UWaC+KNsOVQ6VIUdFn2OydArRyq
        Mdcj8q3xYHCIY26iv0q2/4XqrRFOWe5QTkw1KyuB6WZjAjOdSjg4l87FHpc8Yy8Or0XYYllCMf9
        C/CoZW8xefA4Z5kHF61AkCbs3uz1NhwqawUzAry69fCG8yKMHxVfC7qcJRdv1mQ6NXwNjg1AHBw
        ==
X-Received: by 2002:a05:622a:1aa8:b0:35c:c831:d601 with SMTP id s40-20020a05622a1aa800b0035cc831d601mr21283893qtc.434.1664919787693;
        Tue, 04 Oct 2022 14:43:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/aHhdBDx5/pr6lLga5+ZqFgqfZHwQEpATTsLPquYDFCPYwZ1/spc/bamiVaGZogL3kF2qCQ==
X-Received: by 2002:a05:622a:1aa8:b0:35c:c831:d601 with SMTP id s40-20020a05622a1aa800b0035cc831d601mr21283879qtc.434.1664919787439;
        Tue, 04 Oct 2022 14:43:07 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id l20-20020ac81494000000b0035d27b254f3sm12482275qtj.40.2022.10.04.14.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:43:07 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] selftests/vm: Drop mnt point for hugetlb in run_vmtests.sh
Date:   Tue,  4 Oct 2022 17:43:05 -0400
Message-Id: <20221004214305.121405-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004214125.120993-1-peterx@redhat.com>
References: <20221004214125.120993-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After converting all the three relevant testcases (uffd, madvise, mremap)
to use memfd, no test will need the hugetlb mount point anymore.  Drop the
code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e780e76c26b8..0dc9f545a32d 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -5,7 +5,6 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-mnt=./huge
 exitcode=0
 
 #get huge pagesize and freepages from /proc/meminfo
@@ -84,9 +83,6 @@ run_test() {
 	fi
 }
 
-mkdir "$mnt"
-mount -t hugetlbfs none "$mnt"
-
 run_test ./hugepage-mmap
 
 shmmax=$(cat /proc/sys/kernel/shmmax)
@@ -98,14 +94,9 @@ echo "$shmmax" > /proc/sys/kernel/shmmax
 echo "$shmall" > /proc/sys/kernel/shmall
 
 run_test ./map_hugetlb
-
-run_test ./hugepage-mremap "$mnt"/huge_mremap
-rm -f "$mnt"/huge_mremap
-
+run_test ./hugepage-mremap
 run_test ./hugepage-vmemmap
-
-run_test ./hugetlb-madvise "$mnt"/madvise-test
-rm -f "$mnt"/madvise-test
+run_test ./hugetlb-madvise
 
 echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
@@ -126,14 +117,11 @@ for mod in "${uffd_mods[@]}"; do
 	# Hugetlb tests require source and destination huge pages. Pass in half
 	# the size ($half_ufd_size_MB), which is used for *each*.
 	run_test ./userfaultfd hugetlb${mod} "$half_ufd_size_MB" 32
-	run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32 "$mnt"/uffd-test
-	rm -f "$mnt"/uffd-test
+	run_test ./userfaultfd hugetlb_shared${mod} "$half_ufd_size_MB" 32
 	run_test ./userfaultfd shmem${mod} 20 16
 done
 
 #cleanup
-umount "$mnt"
-rm -rf "$mnt"
 echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 run_test ./compaction_test
-- 
2.37.3

