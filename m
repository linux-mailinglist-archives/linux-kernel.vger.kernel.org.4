Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC465E8F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjAEKXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjAEKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306D24FD63
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a4-20020a5b0004000000b006fdc6aaec4fso36883924ybp.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgIq+1+XdJ7ES1jkz4HOORu1ptYeWb67NT6vWcXFv0I=;
        b=c7YTwst+CXQAde/EC4BKjPkQxQslDinc3BRCYCIN4Tt+2cEbTnwk0TU3bwgaP6mee9
         kEFf2wTCzpL5xUl7MHVCSLefee0s5iUkXnq/BXDX7FnSsqYa/Xt+MvBh9hZyl95WL9rl
         VzfwsERIDQ64g0aldVR7KIXBbKA6yB7hRzB4DLlyHtDcrEcwlH1V2Z30dYIICNHagJAF
         qbjJhxKV7+3WFweiPZZyzSyK5XDS2kSEUb5iNNMFi6ZL9VpJlG160jKr5BCMmceiKdCo
         7Po0f1f/HHNFQPSs5wgIOpRg/gJwmw4aukeHNgtzIRiDRL7lBaiZl3zRpKSymn7/ugDK
         YcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgIq+1+XdJ7ES1jkz4HOORu1ptYeWb67NT6vWcXFv0I=;
        b=GW19mtECeLCwwUkMK2+PLwq2ZwvlpNPRflD2FnrPsm9+Egg3ZSV67OAaLYTbSn3SXD
         tzqDjzf4OuhMT8i2yRfCKZkA09p8DvQJM9r8HdF6XHSHbxYUNTS1GnMij9Tf6ATjzHHi
         2p4AaFSJPr4RHqUsy19wWcJoqrTOKt9+NvL8ru/6vS6C2Mq6ug6aPX1QsOp9z/o3hCC9
         y85M592N3pKZMg5Zmvz6YruzTvILIj0EaeXQCeR1lY4LA8AVHaDYMm0pHLwSSkkgYLw6
         QjmPNNjrZo0tLKhQ2mjNhXNCnNJrqHRTsMb6rI06VxmkLcjrhT3wABOSqrt/LJ4yHcj4
         GPBQ==
X-Gm-Message-State: AFqh2krdFVnCwezt++MtpQ6ypsGHsydYTzxIM3AD6BUZHarzr1veO7q2
        XL1Nw4TijIdQi4feGBqbeedWVpFp9ShDZoYY
X-Google-Smtp-Source: AMrXdXubDVLgqn6t3MFjyOos5j8PLQg8z932QeBEdnknXJ+cAn7ASWClpeYwjz5bduTLnJufUdF/dV8Ta+ZRR9S8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:17d6:0:b0:3ea:9ce2:cd76 with SMTP
 id 205-20020a8117d6000000b003ea9ce2cd76mr93735ywx.217.1672913996509; Thu, 05
 Jan 2023 02:19:56 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:41 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-44-jthoughton@google.com>
Subject: [PATCH 43/46] selftests/kvm: add HugeTLB HGM to KVM demand paging selftest
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
 tools/testing/selftests/kvm/demand_paging_test.c   |  2 +-
 tools/testing/selftests/kvm/include/test_util.h    |  2 ++
 .../selftests/kvm/include/userfaultfd_util.h       |  6 +++---
 tools/testing/selftests/kvm/lib/kvm_util.c         |  2 +-
 tools/testing/selftests/kvm/lib/test_util.c        | 14 ++++++++++++++
 tools/testing/selftests/kvm/lib/userfaultfd_util.c | 14 +++++++++++---
 6 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index b0e1fc4de9e2..e534f9c927bf 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -170,7 +170,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			uffd_descs[i] = uffd_setup_demand_paging(
 				p->uffd_mode, p->uffd_delay, vcpu_hva,
 				vcpu_args->pages * memstress_args.guest_page_size,
-				&handle_uffd_page_request);
+				p->src_type, &handle_uffd_page_request);
 		}
 	}
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 80d6416f3012..a2106c19a614 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -103,6 +103,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
 	VM_MEM_SRC_SHARED_HUGETLB,
+	VM_MEM_SRC_SHARED_HUGETLB_HGM,
 	NUM_SRC_TYPES,
 };
 
@@ -121,6 +122,7 @@ size_t get_def_hugetlb_pagesz(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
+bool is_backing_src_shared_hugetlb(enum vm_mem_backing_src_type src_type);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 long get_run_delay(void);
diff --git a/tools/testing/selftests/kvm/include/userfaultfd_util.h b/tools/testing/selftests/kvm/include/userfaultfd_util.h
index 877449c34592..d91528a58245 100644
--- a/tools/testing/selftests/kvm/include/userfaultfd_util.h
+++ b/tools/testing/selftests/kvm/include/userfaultfd_util.h
@@ -26,9 +26,9 @@ struct uffd_desc {
 	pthread_t thread;
 };
 
-struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
-					   void *hva, uint64_t len,
-					   uffd_handler_t handler);
+struct uffd_desc *uffd_setup_demand_paging(
+		int uffd_mode, useconds_t delay, void *hva, uint64_t len,
+		enum vm_mem_backing_src_type src_type, uffd_handler_t handler);
 
 void uffd_stop_demand_paging(struct uffd_desc *uffd);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c88c3ace16d2..67e7223f054b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -972,7 +972,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->fd = -1;
 	if (backing_src_is_shared(src_type))
 		region->fd = kvm_memfd_alloc(region->mmap_size,
-					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
+				is_backing_src_shared_hugetlb(src_type));
 
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 5c22fa4c2825..712a0878932e 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -271,6 +271,13 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
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
@@ -289,6 +296,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
 	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_SHARED_HUGETLB_HGM:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
@@ -305,6 +313,12 @@ bool is_backing_src_hugetlb(uint32_t i)
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
diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
index 92cef20902f1..3c7178d6c4f4 100644
--- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
+++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
@@ -25,6 +25,10 @@
 
 #ifdef __NR_userfaultfd
 
+#ifndef MADV_SPLIT
+#define MADV_SPLIT 26
+#endif
+
 static void *uffd_handler_thread_fn(void *arg)
 {
 	struct uffd_desc *uffd_desc = (struct uffd_desc *)arg;
@@ -108,9 +112,9 @@ static void *uffd_handler_thread_fn(void *arg)
 	return NULL;
 }
 
-struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
-					   void *hva, uint64_t len,
-					   uffd_handler_t handler)
+struct uffd_desc *uffd_setup_demand_paging(
+		int uffd_mode, useconds_t delay, void *hva, uint64_t len,
+		enum vm_mem_backing_src_type src_type, uffd_handler_t handler)
 {
 	struct uffd_desc *uffd_desc;
 	bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
@@ -140,6 +144,10 @@ struct uffd_desc *uffd_setup_demand_paging(int uffd_mode, useconds_t delay,
 		    "ioctl UFFDIO_API failed: %" PRIu64,
 		    (uint64_t)uffdio_api.api);
 
+	if (src_type == VM_MEM_SRC_SHARED_HUGETLB_HGM)
+		TEST_ASSERT(!madvise(hva, len, MADV_SPLIT),
+				"Could not enable HGM");
+
 	uffdio_register.range.start = (uint64_t)hva;
 	uffdio_register.range.len = len;
 	uffdio_register.mode = uffd_mode;
-- 
2.39.0.314.g84b9a713c41-goog

