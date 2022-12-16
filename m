Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAA64EE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLPPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiLPPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BAA55A8D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6TRH+D4KiiNcSkU8trC/D1fuTVk/3U3ig0mjyWFdEw=;
        b=Ji0Qc+bH8yvuFExhq3bToVUi1NAsako3VaGAwPJFtAazaL2HwoNhM71zeNkfio5ro/Vxwx
        myesIRRbuBLvnAIU37kl3O5OANqYkE22mZbQ57Q5g/ahU0fy2qk7wfp7Xofo3EqCqRcDtn
        qLsRq4DrPO6uUInv4s5/O22fKSz5Ub0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-PZ6micg3OUmAMECJIDHXjg-1; Fri, 16 Dec 2022 10:51:09 -0500
X-MC-Unique: PZ6micg3OUmAMECJIDHXjg-1
Received: by mail-qk1-f197.google.com with SMTP id br6-20020a05620a460600b007021e1a5c48so2081907qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6TRH+D4KiiNcSkU8trC/D1fuTVk/3U3ig0mjyWFdEw=;
        b=N8j7mX4q+P64sStrJPl+3WanZ6FLahT2hUXNJKSqi1CRvoJfgHgUiU6MTbngGMGMeO
         AC0xM1lckpdMXkXF5aOFhU0+nPCwOKymnTO8Tc31HS3vkUCVOgyqo6WmkrxRfDR66Cnt
         1AjXEbNEm7NUysMqh9giCArbXcxgWI8IuOeAFOwPEIrAiSHfIpsD5xueYiGrl8mMEKhN
         hUMiLgVMw3W5TbqiFs7A46iMpIiVR0C6w084hf0XXqEAe5q3q716l0IsVTHERh0a3Ykh
         BF1aPNSAVlir0C3h9QVGHxq7QV49Vu/bpHI3mfCXA0UR07CFOam589oGWpBofAgushto
         2aAQ==
X-Gm-Message-State: ANoB5pkckugmehqSUz/Rkv5eixDFY/mwYizyEMiMovIQAooaMJHT9ioU
        1PEQS8RH17Tbj8sT2fnlILRI6sB1W4jKrGXPmHN0ckv8CZOABilyM9DRy+kC0rjT+5q6glaOT5g
        j6oR3HXfL+Rc4kUQlNffESZIvFnRBUUrfVtvjsxmGm9xrv5CX2JLdjwfmjEATq3KBQUkzDmZgFg
        ==
X-Received: by 2002:ad4:5883:0:b0:4c6:f65b:2e16 with SMTP id dz3-20020ad45883000000b004c6f65b2e16mr49280210qvb.21.1671205867842;
        Fri, 16 Dec 2022 07:51:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KCS0PO65p/SFUOeoYSoiml6w+3ib8mlnjzyMFPkaRCZw2NRbc7RAQAd1lnesrPAfcNCB8IQ==
X-Received: by 2002:ad4:5883:0:b0:4c6:f65b:2e16 with SMTP id dz3-20020ad45883000000b004c6f65b2e16mr49280167qvb.21.1671205867572;
        Fri, 16 Dec 2022 07:51:07 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id s81-20020a37a954000000b006eeb3165554sm1682297qke.19.2022.12.16.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:51:03 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        James Houghton <jthoughton@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v4 1/9] mm/hugetlb: Let vma_offset_start() to return start
Date:   Fri, 16 Dec 2022 10:50:52 -0500
Message-Id: <20221216155100.2043537-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221216155100.2043537-1-peterx@redhat.com>
References: <20221216155100.2043537-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though vma_offset_start() is named like that, it's not returning "the
start address of the range" but rather the offset we should use to offset
the vma->vm_start address.

Make it return the real value of the start vaddr, and it also helps for all
the callers because whenever the retval is used, it'll be ultimately added
into the vma->vm_start anyway, so it's better.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 790d2727141a..fdb16246f46e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -412,10 +412,12 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
  */
 static unsigned long vma_offset_start(struct vm_area_struct *vma, pgoff_t start)
 {
+	unsigned long offset = 0;
+
 	if (vma->vm_pgoff < start)
-		return (start - vma->vm_pgoff) << PAGE_SHIFT;
-	else
-		return 0;
+		offset = (start - vma->vm_pgoff) << PAGE_SHIFT;
+
+	return vma->vm_start + offset;
 }
 
 static unsigned long vma_offset_end(struct vm_area_struct *vma, pgoff_t end)
@@ -457,7 +459,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
-		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
+		if (!hugetlb_vma_maps_page(vma, v_start, page))
 			continue;
 
 		if (!hugetlb_vma_trylock_write(vma)) {
@@ -473,8 +475,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 			break;
 		}
 
-		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
-				NULL, ZAP_FLAG_DROP_MARKER);
+		unmap_hugepage_range(vma, v_start, v_end, NULL,
+				     ZAP_FLAG_DROP_MARKER);
 		hugetlb_vma_unlock_write(vma);
 	}
 
@@ -507,10 +509,9 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		 */
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
-		if (hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
-			unmap_hugepage_range(vma, vma->vm_start + v_start,
-						v_end, NULL,
-						ZAP_FLAG_DROP_MARKER);
+		if (hugetlb_vma_maps_page(vma, v_start, page))
+			unmap_hugepage_range(vma, v_start, v_end, NULL,
+					     ZAP_FLAG_DROP_MARKER);
 
 		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
 		hugetlb_vma_unlock_write(vma);
@@ -540,8 +541,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
-		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
-				     NULL, zap_flags);
+		unmap_hugepage_range(vma, v_start, v_end, NULL, zap_flags);
 
 		/*
 		 * Note that vma lock only exists for shared/non-private
-- 
2.37.3

