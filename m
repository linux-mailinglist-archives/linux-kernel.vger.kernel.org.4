Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB66612CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ3Vag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJ3Vad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE91A190
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgQM4vgy+7KnPWYFNhgrYbDAEMQY1XSSTWC+/NJ93CA=;
        b=c2WcbyRMABi8Dplc0jXgTe7OJGJJMhuRRsv0NmtP5tbNj/uSou87A6leo4xWEuva1dMBvF
        hitqb5MaVttgCI4BuNlhzN2uzHkVjcy73vpoullBXdWTNgCEwlxWB6D6LsgnKc2p8QQ/T1
        pb5f778ffOel+kznbPTpwpEb/VoyJOc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-PM-fcrfCPQ-pwSPLlw_Csw-1; Sun, 30 Oct 2022 17:29:35 -0400
X-MC-Unique: PM-fcrfCPQ-pwSPLlw_Csw-1
Received: by mail-qt1-f197.google.com with SMTP id fb5-20020a05622a480500b003a525d52abcso655048qtb.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgQM4vgy+7KnPWYFNhgrYbDAEMQY1XSSTWC+/NJ93CA=;
        b=DYsghoWSS8o89aP8AF2ySpqs7uV7eTAqRh7e/eYLbSd9HEgCpkQ+9XWUaFEh6Q97qI
         Rev2/b6HTw9PcPgLjvGcUjohpQpBUuNCFeQ3zABsie2SdlipT+Ovwnw7iT0Jf+/qlmG2
         82hx+Q32Ly8QNmjwxlLrA3J1qm5/rOBvJj31qL3XK0JJQN+ARFWfnzgYgmTM+46EQ5xi
         Nu9OfM1uR1PJwYbMJOZh1vQg+9M/EgbDVPXXR1SIrpC8gEdRr70nimLq6gHk1DwoCl3f
         UD0dxJWBVALWvwTsI1tRdlMSzK3KOvc8UznJq0rc3hCOlBNsqqLjpPBzX2QqpT3jOzgp
         R33Q==
X-Gm-Message-State: ACrzQf3I27vqRc8mCWjOZELqEH6c2VcOKxUSVvK1rqdSTUZemGeypuZF
        z1rzBe8duTOfPIu1KIZq3roZUCuwLGDDc4pEV1YK/zBaTgrOPADUe62upRv5S4XB4B4FxfL+LRg
        EDK9vt4i9L3Vy2vtBqP7EVCzsv42BRbu7He4CSXLZTJ1XAcABIza7MqwEIG8yY6ncqsIgZAKUTQ
        ==
X-Received: by 2002:a05:620a:88a:b0:6f9:c32b:5fc6 with SMTP id b10-20020a05620a088a00b006f9c32b5fc6mr7043720qka.288.1667165374749;
        Sun, 30 Oct 2022 14:29:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6gRJ4q4CUl52TBJKx7VsDhJCeJVh7fc6aYcv1+iKVnCNyNlKKvVpkjHmjx+cbWeRM6B/g+2w==
X-Received: by 2002:a05:620a:88a:b0:6f9:c32b:5fc6 with SMTP id b10-20020a05620a088a00b006f9c32b5fc6mr7043701qka.288.1667165374468;
        Sun, 30 Oct 2022 14:29:34 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH RFC 01/10] mm/hugetlb: Let vma_offset_start() to return start
Date:   Sun, 30 Oct 2022 17:29:20 -0400
Message-Id: <20221030212929.335473-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
References: <20221030212929.335473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3ee84604e36d..ac3a69fe29c3 100644
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

