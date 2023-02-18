Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7D69B6D7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBRAcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBRAb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:31:58 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375EA6EBB7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:25 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id f13-20020ab060ad000000b0068e6c831945so354397uam.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Dfh3tVbu9NNOAuUQbMjQlcnIuGhIGz3LkhsyysEBM=;
        b=oC2H6v+tP8sxgSW/qaTkqpk/qQGFu8OqZp2lefzh5tpvjsOdoYS95fEme6g5r45Srg
         kK+SX7TkKqLd7NIyWtb5jibyXnm1w9QJR9oIYR7KWDFmDwxHgvIJ02BbB1UgyoTqeQL8
         89D9RKCX1G+/4ORDV+WYjrLRuKzAfDY/6QJdu8zlAz9TQtaROdykMDea9qi+W5pMHyEx
         npoMTQfezy/k56FzTnBrsh96SmGvpoH+UHWk3RlvjqE9gAwVIEdHIsW/fo6+TLVqF5XS
         Xw+BwwbTSNp8vpWaaHiMcSOExGAoahht2ywAUDVHMW8zc5X++I6XujZ6B7mVjrEIJDFO
         c0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Dfh3tVbu9NNOAuUQbMjQlcnIuGhIGz3LkhsyysEBM=;
        b=W4h0YZbq75V0QN5By17cfqrW36X76UtfA4wbewCMkqucHQrWHYG8HTKtPkNDEutdry
         FAebfldqH6FoXa8JdYiVVptCHqWtpf9u90eJXYhtckya/Kfc5azBbZ8Hd/bUO8MKd3BW
         ksT0N/gegloxr9Bx61iv+JmE7abi/N+YMkPWTMWzO0MiPU3St32jdv1LwVuJomnDC4HK
         JFEyf0xCBSBAEpcmv1IJgsqsPIODxR3V7+4TnMBwHvjG2uXR7BPcB1oV909RWB9oeVju
         3WxmjiydZ69HIc+vSr3o6iHsdMjzsVIhItXTDsv1SaROmWrjaS0g0M549W/8cwMIaozW
         0hgg==
X-Gm-Message-State: AO0yUKW7lPU5qmyIC4zdUW9M3HzkelpQVotwhtH2Gji1UZIqrkJLS5o1
        +I/+B2SEyCAs9XebYf+0pwKuMlW5+OdRMpJJ
X-Google-Smtp-Source: AK7set9ZL3hrEgPVLxygWFVRWkaZt5AY1vSRq45PWq0dcOktmSchjvn/Wzp1mppyMhkKtwEqnwlJ/llO3mZ7TTDg
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:a013:0:b0:401:9bc6:c40c with SMTP
 id j19-20020a1fa013000000b004019bc6c40cmr552024vke.20.1676680183989; Fri, 17
 Feb 2023 16:29:43 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:16 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-44-jthoughton@google.com>
Subject: [PATCH v2 43/46] KVM: selftests: add HugeTLB HGM to KVM demand paging selftest
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

This test exercises the GUP paths for HGM. MADV_COLLAPSE is not tested.

Signed-off-by: James Houghton <jthoughton@google.com>

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
index 56d5ea949cbb..b9c398dc295d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -981,7 +981,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
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
2.39.2.637.g21b0678d19-goog

