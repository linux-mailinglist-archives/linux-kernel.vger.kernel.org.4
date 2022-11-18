Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE262EABE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiKRBLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbiKRBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283BC7EBEB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUaUMokAqyi3NHrr8ZrIfiPSDBorB4zEKfPSOjIyLzs=;
        b=NCAnpiPt+tc1mIfjedss7udThNf5UmUQ5mc3nevJ92rWnn57VteJso03Kjkc7c8exkaROa
        MctIKYmmTGoj4rkbK9rQ1P0BMoDpFIn03m1gl/+ab9aM6FNEFkrvcD7Z+l9j7REK5c6coo
        V2oflIZ3tlA7ZcSz9gjDzKngbSWoPfo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-lTuHbc7kNZK5XTTATgr4XQ-1; Thu, 17 Nov 2022 20:10:31 -0500
X-MC-Unique: lTuHbc7kNZK5XTTATgr4XQ-1
Received: by mail-qv1-f70.google.com with SMTP id lb11-20020a056214318b00b004c63b9f91e5so3226898qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUaUMokAqyi3NHrr8ZrIfiPSDBorB4zEKfPSOjIyLzs=;
        b=xrP9If9+6SazY5YAEnJDrrEq7AKtg6Ew5jD6eA2LiofVq/CVP9eI04BCuvG1bw7Kfd
         Y7/3HCNQaLKhsockwvdFffrAQxg0XEtRVQXLS5Eebika2Sala7kKbPj2bfwyqY6i8GQf
         7+9+fOPmCwjZ80eobkmwTsfoYNFpiDhrwQY7lAtf9MDrlmSLNOIc1RbjbUitzwVSSvma
         mQLMXFM3ru7D0ImM+CtiallauUYV0Ch6TnJ+uFltU5rbg2q3IOemev89V3qC3pfs3n32
         pPYTrpJbANPYxeQIvN1SwCdr0fg88RLr/rwZiR6nzOXan3g785o5Dg08KIN9nAcA2a4A
         aGUA==
X-Gm-Message-State: ANoB5pnIvveofU4U/FWU5kJcUfbdggW6y8IXzIwwll/E/sy34XmUznlT
        khSwilm3VdP3a7gU3jPGNtTIcx/8uj2m1ofON+FWu5P+D2fTjS8C6Z4m2AHWnkDOzgjfcEyKj21
        wGQtzsodwcVucVPfPZDi2Vb+p
X-Received: by 2002:a05:620a:d41:b0:6fa:1af0:7c2a with SMTP id o1-20020a05620a0d4100b006fa1af07c2amr4043641qkl.777.1668733830561;
        Thu, 17 Nov 2022 17:10:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf75PFHtqCG9q2KgS1yvrcaA+UfK7n2hAr9m/2KGhekXpy9/jpuVsMotL2vGdRkhVFniO41W+w==
X-Received: by 2002:a05:620a:d41:b0:6fa:1af0:7c2a with SMTP id o1-20020a05620a0d4100b006fa1af07c2amr4043628qkl.777.1668733830341;
        Thu, 17 Nov 2022 17:10:30 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 01/12] mm/hugetlb: Let vma_offset_start() to return start
Date:   Thu, 17 Nov 2022 20:10:14 -0500
Message-Id: <20221118011025.2178986-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

