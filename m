Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75A963C895
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiK2Ti4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiK2Th1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7050D76
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wYg4N/GqmDYcLEMWI8FN15PYOVGEp4Ds74Kweju+do=;
        b=VL+TY/0MQDEO1WM70MooWGBlO02wzHzY2iLEhtaHgoKSvOnC8v70UuQ4g5Is9tS4JNPQms
        GEOtclbSalzJgO0yd1ac5Zvw1I2nfQrSLeQ1XWsSXHZhRk/HZ9VMNky5R6q1U+VNURX6dJ
        Q+cKD+JoCj2JDrVF3NMuhwiQ3w4ToyE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-135-WlClVYzNNPCdJxpBjrExTw-1; Tue, 29 Nov 2022 14:35:40 -0500
X-MC-Unique: WlClVYzNNPCdJxpBjrExTw-1
Received: by mail-qt1-f200.google.com with SMTP id n12-20020ac85a0c000000b003a5849497f9so23431862qta.20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wYg4N/GqmDYcLEMWI8FN15PYOVGEp4Ds74Kweju+do=;
        b=sOJXNsWpyq1/zwKn+hSfelw4dkfmTLAK6H6PtMKyDDcz/cnsmvJ+xOX+8eiQftk6ZJ
         YFs7Pnl5RrrFyD/6s4MfRKBRy+nXQxF/jUZj8zjVkLTOS+ZxnfDfa2nyIZN/0PNy0g9x
         NLSbxwhjuNbCcEAF6dgVjxwquMR+QVmi9cAFtdzaanGw/qbNSRd3udBj8RTKPZJ3DnLW
         xsGAV5MgiHg/Hx2zrT0BfG5c6ICwlcCWDdgo5fO1RS4vK7fi04bmqp1lFLscB10J7wZ4
         hXJ/gS6hEM6lOfS1T/xuoI1JsT/FzjTyzZnJd7gPK2lJ8/OQi7FGGZjL6mGaYsnRb1gN
         M8Ow==
X-Gm-Message-State: ANoB5pl2OkPa0TDmQq+prO9rd3syMMmW3GO8+HWGdrzXcVoLpdfKnKAW
        VegOEVpTx3JBuYs4dtjNaG//hloM+/jsjaZav2Va/9Y9WtDMm7Pj3a3CmC1vZr075U3eZcyOz8n
        aFYuB2r3HF0g+yevXk9SG9eOA
X-Received: by 2002:a05:6214:207:b0:4c6:4ac0:12c1 with SMTP id i7-20020a056214020700b004c64ac012c1mr37457103qvt.111.1669750539639;
        Tue, 29 Nov 2022 11:35:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4u/49M+6rzccmqGiecb+5YeMty5DWCqGQppJOYyST0NA7r4AdqewGNpJUPOi2AgkzWJM2jYA==
X-Received: by 2002:a05:6214:207:b0:4c6:4ac0:12c1 with SMTP id i7-20020a056214020700b004c64ac012c1mr37457088qvt.111.1669750539374;
        Tue, 29 Nov 2022 11:35:39 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:38 -0800 (PST)
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
Subject: [PATCH 06/10] mm/hugetlb: Make hugetlb_follow_page_mask() safe to pmd unshare
Date:   Tue, 29 Nov 2022 14:35:22 -0500
Message-Id: <20221129193526.3588187-7-peterx@redhat.com>
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

Since hugetlb_follow_page_mask() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 776e34ccf029..d6bb1d22f1c4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6232,9 +6232,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
+	hugetlb_vma_lock_read(vma);
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
-		return NULL;
+		goto out_unlock;
 
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
@@ -6257,6 +6258,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	}
 out:
 	spin_unlock(ptl);
+out_unlock:
+	hugetlb_vma_unlock_read(vma);
 	return page;
 }
 
-- 
2.37.3

