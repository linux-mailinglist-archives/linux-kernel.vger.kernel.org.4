Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E511658716
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 22:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiL1VdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 16:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiL1VdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 16:33:06 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C49140E4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 13:33:02 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id qf9-20020a0562144b8900b004c71efc3528so9121397qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 13:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IL2YbOoN7yPmIShOQbEFF8vOUsSkAn/M3lJ9txKjS40=;
        b=DQd928Kdr25J4ElaX6WZIg0y5aPMxnpaZIJg7IPsyFdp7Z3sU095SY0P4pr93F+joX
         xUOk7tHxITprNKxjOzKUe37tbXK/nCU27n9rSpuQq1RpZsLqxdkYR8J3rkdvDie+cd+y
         ICbF0Bb4zALDvouCsj8CQka5kHUqA+uGamn/b8vdYyT2UPKCSqXq3xcLHVYsCFJ49nfE
         DEiCH87vUImae/stFU5wBLHDK0H2wgLqT9wzF1M2QF/ObcdX/Z82QE3LEsX8T45STvmL
         D1V14FdeAMzvVu4ud311bpNBF3CP3ub9xaQlueCFvMG89KPT/0ILIL398AEZfuEQs4Zg
         I1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IL2YbOoN7yPmIShOQbEFF8vOUsSkAn/M3lJ9txKjS40=;
        b=0Hoq/GbikiqbwWVPVsQeGUu2PBHpSPhJRumghzGoukGQDfr4srcHLybqDxX+Znt5fN
         55+4RmDs1RimgjunkJm5kMXF5cc0eutV9gSAhXaJZiqKHWOL+nBG9qAgmYTWujrb6nGA
         z6bc5826E/4ob8SQ7rNNTxtJZx3xJJsoNhogWDLT15eFWMfNuF3hAh5Vqfajm4M5h9ao
         jb4ZA/pCfeCvEm4H/gvoOm2QyTeUwxwRY8KkSrYZ3abwrliBWj9aoRHxrs7R/sKLS0nd
         6XPxOqhuV5fbLcv1DZrm18lIRqVfSuTjMOB8sz+03jXoh6oB9U0DA99io+z1CFiLXBtv
         8smA==
X-Gm-Message-State: AFqh2kqvkKCmfRHv0JPooUTzcJbwLIkgSE8kW4dN8zIMTjwdC1CWFGB0
        0LhMfVlrtodeP8Rhf6wCsDjFIeMBKENJEw==
X-Google-Smtp-Source: AMrXdXuT3YZ7pyxLMjotm+dwHDwO4EFMSgwCmbIC0SCzzCpxPS24vC4Udc+/ecWzG0atJluAdQBMxnC4sffFuA==
X-Received: from shacharr-cloud.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4338])
 (user=shacharr job=sendgmr) by 2002:a0c:e991:0:b0:530:eae2:9240 with SMTP id
 z17-20020a0ce991000000b00530eae29240mr750777qvn.106.1672263181304; Wed, 28
 Dec 2022 13:33:01 -0800 (PST)
Date:   Wed, 28 Dec 2022 21:32:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221228213212.628636-1-shacharr@google.com>
Subject: [PATCH] Convert backwards goto into a while loop
From:   Shachar Raindel <shacharr@google.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shachar Raindel <shacharr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function vaddr_get_pfns used a goto retry structure to implement
retrying.  This is discouraged by the coding style guide (which is
only recommending goto for handling function exits). Convert the code
to a while loop, making it explicit that the follow block only runs
when the pin attempt failed.

Signed-off-by: Shachar Raindel <shacharr@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 23c24fe98c00..7f38d7fc3f62 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -570,27 +570,28 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		}
 
 		*pfn = page_to_pfn(pages[0]);
-		goto done;
-	}
+	} else
+		do {
+
+			/* This is not a normal page, lookup PFN for P2P DMA */
+			vaddr = untagged_addr(vaddr);
 
-	vaddr = untagged_addr(vaddr);
+			vma = vma_lookup(mm, vaddr);
 
-retry:
-	vma = vma_lookup(mm, vaddr);
+			if (!vma || !(vma->vm_flags & VM_PFNMAP))
+				break;
 
-	if (vma && vma->vm_flags & VM_PFNMAP) {
-		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
-		if (ret == -EAGAIN)
-			goto retry;
+			ret = follow_fault_pfn(vma, mm, vaddr, pfn,
+					       prot & IOMMU_WRITE);
+			if (ret)
+				continue; /* Retry for EAGAIN, otherwise bail */
 
-		if (!ret) {
 			if (is_invalid_reserved_pfn(*pfn))
 				ret = 1;
 			else
 				ret = -EFAULT;
-		}
-	}
-done:
+		} while (ret == -EAGAIN);
+
 	mmap_read_unlock(mm);
 	return ret;
 }
-- 
2.39.0.314.g84b9a713c41-goog

