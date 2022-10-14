Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688CA5FE67C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJNBO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJNBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:14:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4315380D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:14:25 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MpSys6RWBzDsVV;
        Fri, 14 Oct 2022 09:11:49 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 09:14:13 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 09:14:12 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <jannh@google.com>
CC:     <mhocko@suse.com>, <vbabka@suse.cz>, <koct9i@gmail.com>,
        <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/1] mm/rmap: Fix comment in anon_vma_clone
Date:   Fri, 14 Oct 2022 09:39:31 +0800
Message-ID: <20221014013931.1565969-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Commit 2555283eb40d ("mm/rmap: Fix anon_vma->degree ambiguity leading to
double-reuse") use num_children and num_active_vmas to replace the origin
degree to fix anon_vma UAF problem. Update the comment in anon_vma_clone
to fit this change.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/rmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2ec925e5fa6a..92ed6fe3d038 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -315,8 +315,8 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 
  enomem_failure:
 	/*
-	 * dst->anon_vma is dropped here otherwise its degree can be incorrectly
-	 * decremented in unlink_anon_vmas().
+	 * dst->anon_vma is dropped here otherwise its num_active_vmas can
+	 * be incorrectly decremented in unlink_anon_vmas().
 	 * We can safely do this because callers of anon_vma_clone() don't care
 	 * about dst->anon_vma if anon_vma_clone() failed.
 	 */
-- 
2.25.1

