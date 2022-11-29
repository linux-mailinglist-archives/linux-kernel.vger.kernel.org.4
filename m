Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275C663C88D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiK2Thj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiK2Tgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C495B844
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUaUMokAqyi3NHrr8ZrIfiPSDBorB4zEKfPSOjIyLzs=;
        b=ECSG+bkId8KgrsWq1A+PQCFRT54WsNO/jS+s5kqbAAKdgi7UE7aUvArTbBQgOtzRla2e3H
        TSA6Ul4J53OzVReEhsZ3J3sjH9TR2P0quuLNyWHsHwpokFZMu6Gp59X88hUTm1RcNaWeJI
        8HVcoZJUfRcHXFiCbXg9KlGP5OlV6U0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-63AQCtf0OQ-VbWLGMWAWCg-1; Tue, 29 Nov 2022 14:35:32 -0500
X-MC-Unique: 63AQCtf0OQ-VbWLGMWAWCg-1
Received: by mail-qk1-f198.google.com with SMTP id y22-20020a05620a25d600b006fc49e06062so29392650qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUaUMokAqyi3NHrr8ZrIfiPSDBorB4zEKfPSOjIyLzs=;
        b=38TnVtYOUz7cKzzPcUqi82E/w55Y6tbgz9QqffS0Fz0iM1fSTxQH+HC89TijjPEzxT
         QSVHGz/3h+liFFSBtp2dJTzhzaVb4jTXNu4yd1o5SWiaQbQJQbnmPS8UPVabQJlGCNGT
         7nUo93LyQiWwpJg3TzTpj9LEv9XPaJctL7wgt9/6lnTDvIR3oj3YncS0MbWsb6+KGYMR
         kXz2ykHvWUjHZlWJ0qLRN9YFPyxA7/RIBnG6qbeMujIkisWOVSpFVikYKPgwEyjKsciG
         XOKVwjzlapJChmA5K0TMKa9ZOdyq+U+wVcNCkRqh4Ul1LHxRwlgFoaHLxIKAcFmNg7sh
         yAxA==
X-Gm-Message-State: ANoB5pmyTDtaNArNZP/asiV8uFwfw2g7H6XZAIEXYvFuNFmHsgEAGD9P
        k9EbNooDgmwnJuuU//Jhu0AL7vXk90KQzSeDyH+QnEtXbwV/qJoqg5R+kV7pgTPIhWaLh4fihzF
        cXxPxk618RFXsYcVuFiHHkVbD
X-Received: by 2002:a05:620a:b83:b0:6fb:ec6:da03 with SMTP id k3-20020a05620a0b8300b006fb0ec6da03mr51132381qkh.206.1669750532188;
        Tue, 29 Nov 2022 11:35:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5YA/acon+LhfHPHPKaW5yLk7KnmfoilNeObxz2Q7Ei8/I2mWOfNhuwDiUBf8dY9EaFWOGB6Q==
X-Received: by 2002:a05:620a:b83:b0:6fb:ec6:da03 with SMTP id k3-20020a05620a0b8300b006fb0ec6da03mr51132361qkh.206.1669750531938;
        Tue, 29 Nov 2022 11:35:31 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:29 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 01/10] mm/hugetlb: Let vma_offset_start() to return start
Date:   Tue, 29 Nov 2022 14:35:17 -0500
Message-Id: <20221129193526.3588187-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
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

