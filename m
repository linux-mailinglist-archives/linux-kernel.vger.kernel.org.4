Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4300D65C7B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbjACTuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbjACTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:49:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A013F8A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:49:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso31271537ybf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDIlvgpkH8iNlqq7l2184WeZDOwRlpuQV03cFER0U7w=;
        b=aTOJgoJy8rySUAkoIrvXhFtGQYvn2sTF5/jcit5bwFsGNIoBSLgup3v6qSrpBRHauM
         /s2W8ykqO5uFbndv1m3PWj3CY9Sk0OiSUCtujS3cQy0SKi6X0whsdkiSa1Mlu4pHQi9t
         gD5FQVHkij3l49o2c6pK7uQd0EnWZqKksH/56++BeKTQ3jV4wnr7WkmyxGNAp3G4Z4WQ
         ZhEpCU6gZkOUGJJWHm/T6ZxykJEVnR8jSKYMnh7urVdnlWcEy94t2uJvfucyUrsu+m00
         SFXq8M6EG9XmnVU5ApQcKb4GZIElm8O6Gr4tFPL0+dVD5BKa3ybwuevjTrSAvVU7V2E+
         iNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDIlvgpkH8iNlqq7l2184WeZDOwRlpuQV03cFER0U7w=;
        b=O9dLsXQKHwUMDM9262s12z+kydpUZ+gCLCQ9gyneQievhTLxJNVJJKqRdOt7/J1IQm
         rU6HeAj0Td+zYkFrtUZMLnJAeOIWPmMwAUqB2R+uSIqOBFQr+Fya1tqJNd1umCF1a1F8
         JcuX2GkOWGP2wile54lLKcBZj4HtRRZamXRBmYrVTJ5tEt023lVGdXG9+stLrAJlRL7j
         z66nJn0balA4NCjd844wlInGCn+AwgsLT6bxZYMmO7odRGkVFbLKN0qVg/kAdNCXEGfS
         YZf1NmacQ2Lx+dA8UU050hED246gZ+St50NvszMwag6gykbIgeUxOJ3pX2sPO7eGWbai
         PjXw==
X-Gm-Message-State: AFqh2kpqiZUPs86nI45H8cd7AcslyZ0lcNXX6izq1ROSQzKA5qq56oNj
        rP2wcaaY5CK4Uc7M6mssO1sglGnslWIvjg==
X-Google-Smtp-Source: AMrXdXs94OhfYslkzD4CrXv2Mg2dC+rwFPWdjEmy72Ik6eroOQ37CgxOVr2BWvGwbhkolun6DdMx8ZPqP8rw+Q==
X-Received: from shacharr-cloud.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4338])
 (user=shacharr job=sendgmr) by 2002:a25:664d:0:b0:7aa:110b:ea86 with SMTP id
 z13-20020a25664d000000b007aa110bea86mr433342ybm.248.1672775396448; Tue, 03
 Jan 2023 11:49:56 -0800 (PST)
Date:   Tue,  3 Jan 2023 19:49:48 +0000
In-Reply-To: <20230103104338.4371e012.alex.williamson@redhat.com>
Mime-Version: 1.0
References: <20230103104338.4371e012.alex.williamson@redhat.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230103194948.1806373-1-shacharr@google.com>
Subject: [PATCH v2] Convert backwards goto with a while loop
From:   Shachar Raindel <shacharr@google.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shachar Raindel <shacharr@google.com>
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

The function vaddr_get_pfns used a goto retry structure to implement
retrying.  This is a gray area in the coding style guide (which is
only explicitly recommending goto for handling function exits).
Convert the code to a while loop, making it explicit that the
following block only runs when the pin attempt failed.

Signed-off-by: Shachar Raindel <shacharr@google.com>
---

Changelog:

v1 -> v2: Refine commit message, fix minor code style issue

 drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 23c24fe98c00..6335eabe1b7c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -570,27 +570,28 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		}
 
 		*pfn = page_to_pfn(pages[0]);
-		goto done;
-	}
+	} else {
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
+	}
 	mmap_read_unlock(mm);
 	return ret;
 }
-- 
2.39.0.314.g84b9a713c41-goog

