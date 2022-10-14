Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829175FF07D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJNOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJNOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C045A32BB1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665758418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLJyHDSa1XQjsFtgHwRksRspzx5xxcL5BS8fvTY+AU0=;
        b=UsT97ZClr4/SeZvJKlLKREonCleLLyQP4u9p5A5jYtk6zBDjoEbdfyTUmun2c2+3snCZ30
        XttAhYrPfjo6VbJvXJFilPWTiLK31cqD0hRWucFRyXXpI0Sljq5mbJ0QcHtRPu9cUjU4H5
        cPnoxBadxv7g9P1RV4Ixiyz98R6JUEo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-473-l2-pIrjSOlSd8JWwGEzymQ-1; Fri, 14 Oct 2022 10:40:17 -0400
X-MC-Unique: l2-pIrjSOlSd8JWwGEzymQ-1
Received: by mail-qt1-f200.google.com with SMTP id fy10-20020a05622a5a0a00b0039cd5097697so3083687qtb.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLJyHDSa1XQjsFtgHwRksRspzx5xxcL5BS8fvTY+AU0=;
        b=njLf7CxO1+a141ENli4XFLoYuI9II0UZjYyWavLSxV4BjK/ynXj/5YAxk2Uu48jiNp
         HS6L9p6LSMMtESvRDA1d2K8yQRNq27F4FQCO8eZomKu506cJiqVeEn22zlRMMIDhFyWh
         dvsObceuBa9DKKaCOP8JdrWNb25hMIvKw3U4YcPtWVHZHrSxo/6NdYY4yR9JnKqnq5Dt
         HtOhR30puE03eHvIiY1UG8twz9VG8q+JjZsp6mLX72dhrc2mZzIjDvHw+qfFFoH8iuCd
         tP5QAc3GMmlkdXqYR8+zoI3RbTdxR5Z5mYQrv7tnE0J2o+qkSNlKBkkUJzNH2FCA2vdy
         /KbA==
X-Gm-Message-State: ACrzQf1FrJGx/maQWs3Z6A4SK6bdNHcM11ny0HmjXWvnRcJH8m2suPRb
        rbhXHvAhMEmNvd9HfXb3VSjlBbhc6RlvNCncEzd6itLNVLoWG4AQ0Ra5V90NTSr84Jl/ljg6Hor
        bt42bpSEG2vw8Y9WpGug8s6VrZ09ik0W6M8XNdvKfPsuyiOfJqYjWcCjck9CFNRGyQX6OOzgj7Q
        ==
X-Received: by 2002:a0c:a98e:0:b0:4ac:929d:216f with SMTP id a14-20020a0ca98e000000b004ac929d216fmr4569053qvb.16.1665758417185;
        Fri, 14 Oct 2022 07:40:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4t7KsjP3Hg9ck1XOwaKdT6cqdt/Zic+OGydxXGKoiUwwJ5ZsQBmo1MvrILCejlsR+qV7KlAg==
X-Received: by 2002:a0c:a98e:0:b0:4ac:929d:216f with SMTP id a14-20020a0ca98e000000b004ac929d216fmr4569025qvb.16.1665758416855;
        Fri, 14 Oct 2022 07:40:16 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006cec8001bf4sm2414202qki.26.2022.10.14.07.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:40:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 4/4] selftests/vm: Drop mnt point for hugetlb in run_vmtests.sh
Date:   Fri, 14 Oct 2022 10:40:15 -0400
Message-Id: <20221014144015.94039-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014143921.93887-1-peterx@redhat.com>
References: <20221014143921.93887-1-peterx@redhat.com>
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

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
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

