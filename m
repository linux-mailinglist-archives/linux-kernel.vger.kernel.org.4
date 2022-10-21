Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1711607C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiJUQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJUQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:34 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5700A28C310
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:59 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id 65-20020a670344000000b0039b3020da1bso1053592vsd.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9y9Kps0uMUxaUviUQmHpRsZg2wkh8g+3BdgpOUsdpD0=;
        b=l/7qHlTlqK2+odgNL+qqaWtZd95RSQmfjj2EnMNPwPzYUopC/nQW9oknGDwJAIzM/V
         toI7WNbfT5WjVMs9srJI2QLMSDhRHFgSpdvMACL3z+IizihCksdhhkBJ5mEioYTHCvo0
         FmIcUxXZMiWS/ZIIxOqSMSBxAewQGqIH5uUcc6n9Dwa4sD9nRkufaMXxSFItUN7lDgfT
         9USzcKP2HR68osgtg5cJtSMN3cXJ4Jhqhm/TxBcpRTG1sKA8CwhRmqo/CkU6R16k9yiZ
         DFjIvC7I9+PQFY+MIk1rCSd9HJjdGzJoKWKELko+HJE1P98O26BCJKJPZ6KXbv/ZPUig
         8qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9y9Kps0uMUxaUviUQmHpRsZg2wkh8g+3BdgpOUsdpD0=;
        b=lQjolw3JnpHzgvISkzrbZUqzqq650Nm9t6w8GfSVWdGOD/5ta5dgUySPY0ouvS95P0
         5Hbo+8fDJGinFH/Y4KwbYGnCCpbrTXn8MDWRazgKmsqeSAzPHzkM+o2F3QBngiFON+jL
         inTXpkF7sySUk+r9CkBU+/Wj86XafSdDfyPAHdnp9FAB0Rauy6lNxPTmD5nCBT26XsAw
         ZvnwLYYs5AKPT+2yytuTb2T2lsql58jpBm6HqvYOm7++A61r746m7cfIsUu5x1RQxdcW
         hWt8IJOqz3Qs6K8He1BhN9NMFvo3JCkn2Dv2DKRhpMdgl1G0uzzhcsQYcR8+yQDjJVnq
         GS3w==
X-Gm-Message-State: ACrzQf3fO39wODjFI36JCOLh3qCWl/z77s+jQmnbr8cKw0HPxLwcZR5e
        Tnro57lxxMkfzbxbUV2yGgDv+hgqXmBHVLgQ
X-Google-Smtp-Source: AMsMyM4nbZOrU1c/6hMqiMfGOpW3jUqhlLxnmrA187TxhDh2sp8xpyGXRT14XguSYLO8M1Ws1W5QM12ugy8JoJHf
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:c80d:0:b0:3aa:895:9630 with SMTP id
 u13-20020a67c80d000000b003aa08959630mr2609998vsk.15.1666370277616; Fri, 21
 Oct 2022 09:37:57 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:37:00 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-45-jthoughton@google.com>
Subject: [RFC PATCH v2 44/47] selftests/kvm: add HugeTLB HGM to KVM demand
 paging selftest
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

This test exercises the GUP paths for HGM. MADV_COLLAPSE is not tested.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 20 ++++++++++++++++---
 .../testing/selftests/kvm/include/test_util.h |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
 tools/testing/selftests/kvm/lib/test_util.c   | 14 +++++++++++++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 779ae54f89c4..67ca8703c6b7 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -76,6 +76,12 @@ static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 
+	/*
+	 * We're using UFFD_FEATURE_EXACT_ADDRESS, so round down the address.
+	 * This is needed to support HugeTLB high-granularity mapping.
+	 */
+	addr &= ~(demand_paging_size - 1);
+
 	if (uffd_mode == UFFDIO_REGISTER_MODE_MISSING) {
 		struct uffdio_copy copy;
 
@@ -214,7 +220,8 @@ static void setup_demand_paging(struct kvm_vm *vm,
 				pthread_t *uffd_handler_thread, int pipefd,
 				int uffd_mode, useconds_t uffd_delay,
 				struct uffd_handler_args *uffd_args,
-				void *hva, void *alias, uint64_t len)
+				void *hva, void *alias, uint64_t len,
+				enum vm_mem_backing_src_type src_type)
 {
 	bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
 	int uffd;
@@ -244,9 +251,15 @@ static void setup_demand_paging(struct kvm_vm *vm,
 	TEST_ASSERT(uffd >= 0, __KVM_SYSCALL_ERROR("userfaultfd()", uffd));
 
 	uffdio_api.api = UFFD_API;
-	uffdio_api.features = 0;
+	uffdio_api.features = is_minor
+		? UFFD_FEATURE_EXACT_ADDRESS | UFFD_FEATURE_MINOR_HUGETLBFS_HGM
+		: 0;
 	ret = ioctl(uffd, UFFDIO_API, &uffdio_api);
 	TEST_ASSERT(ret != -1, __KVM_SYSCALL_ERROR("UFFDIO_API", ret));
+	if (src_type == VM_MEM_SRC_SHARED_HUGETLB_HGM)
+		TEST_ASSERT(uffdio_api.features &
+			    UFFD_FEATURE_MINOR_HUGETLBFS_HGM,
+			    "UFFD_FEATURE_MINOR_HUGETLBFS_HGM not present");
 
 	uffdio_register.range.start = (uint64_t)hva;
 	uffdio_register.range.len = len;
@@ -329,7 +342,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 					    pipefds[i * 2], p->uffd_mode,
 					    p->uffd_delay, &uffd_args[i],
 					    vcpu_hva, vcpu_alias,
-					    vcpu_args->pages * perf_test_args.guest_page_size);
+					    vcpu_args->pages * perf_test_args.guest_page_size,
+					    p->src_type);
 		}
 	}
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index befc754ce9b3..0410326dbc18 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -96,6 +96,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
 	VM_MEM_SRC_SHARED_HUGETLB,
+	VM_MEM_SRC_SHARED_HUGETLB_HGM,
 	NUM_SRC_TYPES,
 };
 
@@ -114,6 +115,7 @@ size_t get_def_hugetlb_pagesz(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
+bool is_backing_src_shared_hugetlb(enum vm_mem_backing_src_type src_type);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 long get_run_delay(void);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f1cb1627161f..7d769a117e14 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -896,7 +896,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->fd = -1;
 	if (backing_src_is_shared(src_type))
 		region->fd = kvm_memfd_alloc(region->mmap_size,
-					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
+				is_backing_src_shared_hugetlb(src_type));
 
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 6d23878bbfe1..710dc42077fe 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -254,6 +254,13 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			 */
 			.flag = MAP_SHARED,
 		},
+		[VM_MEM_SRC_SHARED_HUGETLB_HGM] = {
+			/*
+			 * Identical to shared_hugetlb except for the name.
+			 */
+			.name = "shared_hugetlb_hgm",
+			.flag = MAP_SHARED,
+		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
@@ -272,6 +279,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
 	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_SHARED_HUGETLB_HGM:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
@@ -288,6 +296,12 @@ bool is_backing_src_hugetlb(uint32_t i)
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
 }
 
+bool is_backing_src_shared_hugetlb(enum vm_mem_backing_src_type src_type)
+{
+	return src_type == VM_MEM_SRC_SHARED_HUGETLB ||
+		src_type == VM_MEM_SRC_SHARED_HUGETLB_HGM;
+}
+
 static void print_available_backing_src_types(const char *prefix)
 {
 	int i;
-- 
2.38.0.135.g90850a2211-goog

