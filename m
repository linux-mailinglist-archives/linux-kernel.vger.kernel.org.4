Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF7860389A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJSDaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJSDaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:30:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2293B9B5;
        Tue, 18 Oct 2022 20:30:00 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Msbk81L6QznTV5;
        Wed, 19 Oct 2022 11:26:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:29:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 11:29:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Dinh Nguyen <dinguyen@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-sgx@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 4/5] mm: debug_vm_pgtable: use VM_ACCESS_FLAGS
Date:   Wed, 19 Oct 2022 11:49:44 +0800
Message-ID: <20221019034945.93081-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221019034945.93081-1-wangkefeng.wang@huawei.com>
References: <20221019034945.93081-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly use VM_ACCESS_FLAGS instead VMFLAGS.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/debug_vm_pgtable.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index dc7df1254f0a..2b61fde8c38c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -38,11 +38,7 @@
  * Please refer Documentation/mm/arch_pgtable_helpers.rst for the semantics
  * expectations that are being validated here. All future changes in here
  * or the documentation need to be in sync.
- */
-
-#define VMFLAGS	(VM_READ|VM_WRITE|VM_EXEC)
-
-/*
+ *
  * On s390 platform, the lower 4 bits are used to identify given page table
  * entry type. But these bits might affect the ability to clear entries with
  * pxx_clear() because of how dynamic page table folding works on s390. So
@@ -1125,7 +1121,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	 */
 	memset(args, 0, sizeof(*args));
 	args->vaddr              = get_random_vaddr();
-	args->page_prot          = vm_get_page_prot(VMFLAGS);
+	args->page_prot          = vm_get_page_prot(VM_ACCESS_FLAGS);
 	args->page_prot_none     = vm_get_page_prot(VM_NONE);
 	args->is_contiguous_page = false;
 	args->pud_pfn            = ULONG_MAX;
-- 
2.35.3

