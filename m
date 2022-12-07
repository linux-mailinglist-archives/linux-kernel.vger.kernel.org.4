Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90B646264
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLGUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiLGUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810997BC0B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670445041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXTqB5FubF2+0tcQcQ/EoMxi6C2oCNf5KVcHgua8JL0=;
        b=Im3ALiQKcTTxBuHeDHt7J8QeADRqBKXkTtD81mw8FxP/KL79b6Fk6G501blrJcgW83y9k3
        QdUiTcvHqb08JEhl2VydHaBA2+QEgWLiOq39EK+YpgTBMotHiM7VNuxnJDySTyrWFs6/tG
        JGoT5aztdo5inxoPlUMgfnsQ3jfYXoc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-kel4CzXMMU6vcV0mWT6bLQ-1; Wed, 07 Dec 2022 15:30:40 -0500
X-MC-Unique: kel4CzXMMU6vcV0mWT6bLQ-1
Received: by mail-qk1-f200.google.com with SMTP id ay43-20020a05620a17ab00b006fa30ed61fdso25687997qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXTqB5FubF2+0tcQcQ/EoMxi6C2oCNf5KVcHgua8JL0=;
        b=hFVuHw1cfvGPCF2eHFcd6MdR2y2Z95qN7G/RAaxDjdbD3gi6bFciLNU6LAyW+cAN/Z
         oixlf4DH/AYd1sRRzdXQz7HDK+zrVTnqsevl0PX+igtp+pRt0USNOc/oBi1rk47TWxok
         t1mOAsxNYloe7nHu5D0iBso1Grtx1KkMDNnPFfPgvwedQ1zjRUDTortwox8m9F5SRfQh
         ygmilgHfQR8ZnQwa2AC1++mo5xtq3rtgrDnV/tdehsZo6ZLpGjV+0XpJdGkEdyNTZnqd
         pn1G28LY0GIG5bmY8P9zSGIeAaIYc4b9iBK2YKLFC1YBipikrc0mEVVsHJqS+O90Rq4E
         poDw==
X-Gm-Message-State: ANoB5pmC6ukSypW8I9IIpjmJdlC+nXMu0qLW5HX8SLIVrsI1CzZzodki
        bUnpTmEHTsiFEYnv6CPcmRTKGupXZajTEk6R7fkL7Mt/SoCTRDwpCpjMQxCDOE62wO0vFn7AreX
        kYAt6o0D79mfu1wfYbBJpGxRQ
X-Received: by 2002:ac8:4e47:0:b0:3a5:63ef:cf4e with SMTP id e7-20020ac84e47000000b003a563efcf4emr1902947qtw.16.1670445040113;
        Wed, 07 Dec 2022 12:30:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6IQwsRhSSOAs+i008iOESp/4MgizW47uNvKVfGDqpV4y6exkH0YuDqLS4fPXFFuTpd369j9Q==
X-Received: by 2002:ac8:4e47:0:b0:3a5:63ef:cf4e with SMTP id e7-20020ac84e47000000b003a563efcf4emr1902931qtw.16.1670445039881;
        Wed, 07 Dec 2022 12:30:39 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dc53-20020a05620a523500b006fefa5f7fcesm855594qkb.10.2022.12.07.12.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:37 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 01/10] mm/hugetlb: Let vma_offset_start() to return start
Date:   Wed,  7 Dec 2022 15:30:25 -0500
Message-Id: <20221207203034.650899-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207203034.650899-1-peterx@redhat.com>
References: <20221207203034.650899-1-peterx@redhat.com>
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
Reviewed-by: David Hildenbrand <david@redhat.com>
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

