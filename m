Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3635F848F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJHJOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJHJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:14:07 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5489E4D271
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 02:14:05 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id DLX00001;
        Sat, 08 Oct 2022 17:14:01 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server id
 15.1.2507.12; Sat, 8 Oct 2022 17:14:02 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <airlied@gmail.com>, <daniel@ffwll.ch>, <Felix.Kuehling@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] drm/amdkfd: use vma_lookup() instead of find_vma()
Date:   Thu, 6 Oct 2022 22:48:18 -0400
Message-ID: <20221007024818.4921-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202210081714012c959af65021b156089005c68f8b32f8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() verifies the start address is contained in the found
vma.  This results in easier to read the code.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 64fdf63093a0..cabcc2ca3c23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1586,8 +1586,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		unsigned long npages;
 		bool readonly;
 
-		vma = find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start) {
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
 			r = -EFAULT;
 			goto unreserve_out;
 		}
@@ -2542,8 +2542,8 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	struct interval_tree_node *node;
 	unsigned long start_limit, end_limit;
 
-	vma = find_vma(p->mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+	vma = vma_lookup(p->mm, addr << PAGE_SHIFT);
+	if (!vma) {
 		pr_debug("VMA does not exist in address [0x%llx]\n", addr);
 		return -EFAULT;
 	}
@@ -2871,8 +2871,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	/* __do_munmap removed VMA, return success as we are handling stale
 	 * retry fault.
 	 */
-	vma = find_vma(mm, addr << PAGE_SHIFT);
-	if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
+	vma = vma_lookup(mm, addr << PAGE_SHIFT);
+	if (!vma) {
 		pr_debug("address 0x%llx VMA is removed\n", addr);
 		r = 0;
 		goto out_unlock_range;
-- 
2.27.0

