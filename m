Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9436040EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJSK31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiJSK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:28:51 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420BC127BDA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:07:22 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id 8so8900138ilj.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lctdt7xKU2W5w8gZ0ZmMK8o6iNtjlEm1kVR6gDr/Tqs=;
        b=azz7whhIofhV6dNq+IvcUJPAUjbCNfvl3vKJyPjW72wvWGyw6jPg/RkDpwHAbCv3W9
         94AnUE69DuI7RM7xKmSYYooKJpF5y/N8mX2vGj4N5BGTM8LkQSI2lq+RrsvMv+4HE0PK
         5WR3deCHsMafGs7KLtXai79FiSkJjtKLr3lTapM3hALcVr0S8/eG72ZDZbhfXk2WKqwJ
         hVkomDg6F8zd3d5N0fltw4sn1YLzVwu+Z7udqrLY0Mj0s53vNEq1xo5r+8rZ2IGoVus9
         txu7TDUHmcflBVcTFAoglOSpL1Xv3XFf8K96Qva2ybjItMKC4TmwHS2xnRyPkK1DPICQ
         WvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lctdt7xKU2W5w8gZ0ZmMK8o6iNtjlEm1kVR6gDr/Tqs=;
        b=Mu2naFNpt453U31tRTjduXk8TnLN6popVOVEPlzJROqrqLRrssF7elvNiLbUS4Ez0A
         a6hp1axJL4iBDqUX8yRq2BStN4aO24JU7KljPENo6/UnkXgOAXPSODPDu11AyW8cs19l
         TYIKKcAx0Pd3BN2/8pZ63Ln6LizivkdcHCb1n0KfN5ULhswYgRyr8gs1G2VhbsGsdc6N
         N+gvMRWfTuSdbKD3Jlbz0ct+Gd/EhxXkih+JECj/S17A/ObnVd3DZItY83orbS+dhKou
         K7R8m16zQUOnoCEqoBWPo9VznQIXxayY1Qg0TFH2KGHXzkUvpGlbiMcT9JV3snK5cgVZ
         lLsQ==
X-Gm-Message-State: ACrzQf3oToa0GgZj355MNolbCErEGqwfil/O34snbtdQwgIh3Xwbs9yG
        nqCOwiaMzeLFa229n1oWh8WGSLze1lrbTA==
X-Google-Smtp-Source: AMsMyM58iub7ESHfa48FrgnOmzaMcWvkgwmAW8caBAentKFSof8Duq0VF1bxr5JfnFXxxIIBSFqH5A==
X-Received: by 2002:a65:62c7:0:b0:463:9c67:5fe2 with SMTP id m7-20020a6562c7000000b004639c675fe2mr6419990pgv.443.1666171791791;
        Wed, 19 Oct 2022 02:29:51 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b0017da2798025sm10364877plg.295.2022.10.19.02.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 02:29:51 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     mike.kravetz@oracle.com
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] mm: hugetlb: support for shared memory policy
Date:   Wed, 19 Oct 2022 17:29:25 +0800
Message-Id: <20221019092928.44146-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <Y0mUt84TctGP3BtT@monkey>
References: <Y0mUt84TctGP3BtT@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

implement get/set_policy for hugetlb_vm_ops to support the shared policy
This ensures that the mempolicy of all processes sharing this huge page
file is consistent.

In some scenarios where huge pages are shared:
if we need to limit the memory usage of vm within node0, so I set qemu's
mempilciy bind to node0, but if there is a process (such as virtiofsd)
shared memory with the vm, in this case. If the page fault is triggered
by virtiofsd, the allocated memory may go to node1 which depends on
virtiofsd. Although we can use the memory prealloc provided by qemu to
avoid this issue, but this method will significantly increase the
creation time of the vm(a few seconds, depending on memory size).

after we hooked up hugetlb_vm_ops(set/get_policy):
both the shared memory segments created by shmget() with SHM_HUGETLB flag
and the mmap(MAP_SHARED|MAP_HUGETLB), also support shared policy.

v1->v2:
1、hugetlb share the memory policy when the vma with the VM_SHARED flag.
2、update the documentation.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 20 +++++++++------
 mm/hugetlb.c                                  | 25 +++++++++++++++++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 5a6afecbb0d0..5672a6c2d2ef 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -133,14 +133,18 @@ Shared Policy
 	the object share the policy, and all pages allocated for the
 	shared object, by any task, will obey the shared policy.
 
-	As of 2.6.22, only shared memory segments, created by shmget() or
-	mmap(MAP_ANONYMOUS|MAP_SHARED), support shared policy.  When shared
-	policy support was added to Linux, the associated data structures were
-	added to hugetlbfs shmem segments.  At the time, hugetlbfs did not
-	support allocation at fault time--a.k.a lazy allocation--so hugetlbfs
-	shmem segments were never "hooked up" to the shared policy support.
-	Although hugetlbfs segments now support lazy allocation, their support
-	for shared policy has not been completed.
+	As of 2.6.22, only shared memory segments, created by shmget() without
+	SHM_HUGETLB flag or mmap(MAP_ANONYMOUS|MAP_SHARED) without MAP_HUGETLB
+	flag, support shared policy. When shared policy support was added to Linux,
+	the associated data structures were added to hugetlbfs shmem segments.
+	At the time, hugetlbfs did not support allocation at fault time--a.k.a
+	lazy allocation--so hugetlbfs shmem segments were never "hooked up" to
+	the shared policy support. Although hugetlbfs segments now support lazy
+	allocation, their support for shared policy has not been completed.
+
+	after we hooked up hugetlb_vm_ops(set/get_policy):
+	both the shared memory segments created by shmget() with SHM_HUGETLB flag
+	and mmap(MAP_SHARED|MAP_HUGETLB), also support shared policy.
 
 	As mentioned above in :ref:`VMA policies <vma_policy>` section,
 	allocations of page cache pages for regular files mmap()ed
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 87d875e5e0a9..fc7038931832 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4632,6 +4632,27 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
+int hugetlb_vm_op_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+
+	if (!(vma->vm_flags & VM_SHARED))
+		return 0;
+
+	return mpol_set_shared_policy(&HUGETLBFS_I(inode)->policy, vma, mpol);
+}
+
+struct mempolicy *hugetlb_vm_op_get_policy(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	pgoff_t index;
+
+	index = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+	return mpol_shared_policy_lookup(&HUGETLBFS_I(inode)->policy, index);
+}
+#endif
+
 /*
  * When a new function is introduced to vm_operations_struct and added
  * to hugetlb_vm_ops, please consider adding the function to shm_vm_ops.
@@ -4645,6 +4666,10 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.close = hugetlb_vm_op_close,
 	.may_split = hugetlb_vm_op_split,
 	.pagesize = hugetlb_vm_op_pagesize,
+#ifdef CONFIG_NUMA
+	.set_policy = hugetlb_vm_op_set_policy,
+	.get_policy = hugetlb_vm_op_get_policy,
+#endif
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
-- 
2.37.0 (Apple Git-136)

