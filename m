Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB545FC1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJLIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJLIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:15:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1C53D0C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 01:15:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so15558296pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 01:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofda32LPZu7lWSl20UKRGtfT8GE9G8KpQ50I/r7L2UI=;
        b=50kRz2RseqZqhVkCNVfryDTOcVDlb78vcfTZRWtKliNsYLIpHMkQVFWQiUkUk8+VfL
         UJkpVl/VO7qi0d7YNYY49uYm+RPbsEu4AJk2UCmciWYHQ+8bLYUVecTxX98wp8REPF0h
         muSZEhT70wNOWxYBCcFReMkfQBmqp5e0KFWlRoVPvDKUVEUIpuhHD7zSgv69v5bawY9u
         WQCGPUyta1n53toSYZufxWQCicBF4MSkp/aBw0RkR1zvZ9qiA7El7gdSN7Gc1VTCPfqB
         mcB6MatzXzSVdjgwWN7kJyeGmNRhOa7Uc/48Zz+AdpdH0whV2FJwY8iOXbU9i+Sr8VHX
         07HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofda32LPZu7lWSl20UKRGtfT8GE9G8KpQ50I/r7L2UI=;
        b=SfjbBtW9uIveyMr4z8M4wstkZ3OhXXRuchcvtBLPxDTaUIqR/mrM6+AcGNsSjOwFlm
         V909aGbTkFmvdzIyUQ72TK6JTj8OXuMY+pYoDz1vHzc7bttebWFV95R2hSn46PTuJxpT
         +bfrZJLZBp6POvzW/VWJkgrjvSNvY+aMFyHRXXQJ0/NbF5jE/0oclr540L/HWO21FlWx
         8bJa72Ma8922Im/q+epFCRj7xLsqjQC1ZpRkLozltynuIyt/91O1Y+Bmu/zB7sCESXOM
         NENz56awuNdG/Jco1Nau3kJIsxRS+MTDnRJBUoEujLOOQiegW2qFFgVwrR3NQVxhs47+
         hH1w==
X-Gm-Message-State: ACrzQf3Tv3XwYUYZhvoW0rq5CWhov0eiYH/7pTC51isrHNByIeyn6l5H
        jT0J3mut6e3CNvCYXHUMPkcrqQ==
X-Google-Smtp-Source: AMsMyM73y4yvEpl2fqOEISK2r+hxSqUI6/frXGpX7FvzZS+Pautcan6/4Py1TGhC5o/9n0xQj6xRtg==
X-Received: by 2002:a17:90b:4c48:b0:20d:5c55:b8a8 with SMTP id np8-20020a17090b4c4800b0020d5c55b8a8mr3793626pjb.207.1665562552127;
        Wed, 12 Oct 2022 01:15:52 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b0016c9e5f291bsm10211618plh.111.2022.10.12.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:15:51 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     songmuchun@bytedance.com
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: hugetlb: support get/set_policy for hugetlb_vm_ops
Date:   Wed, 12 Oct 2022 16:15:25 +0800
Message-Id: <20221012081526.73067-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

implement these two functions so that we can set the mempolicy to
the inode of the hugetlb file. This ensures that the mempolicy of
all processes sharing this huge page file is consistent.

In some scenarios where huge pages are shared:
if we need to limit the memory usage of vm within node0, so I set qemu's
mempilciy bind to node0, but if there is a process (such as virtiofsd)
shared memory with the vm, in this case. If the page fault is triggered
by virtiofsd, the allocated memory may go to node1 which  depends on
virtiofsd.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 mm/hugetlb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0ad53ad98e74..ed7599821655 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4678,6 +4678,24 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
+int hugetlb_vm_op_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
+{
+	struct inode *inode = file_inode(vma->vm_file);
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
@@ -4691,6 +4709,10 @@ const struct vm_operations_struct hugetlb_vm_ops = {
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
2.31.1

