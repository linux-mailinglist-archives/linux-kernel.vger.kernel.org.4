Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2537264EE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiLPPx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiLPPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEBB2D1FB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7a/XOpLMoccJVDSJCL0inQbFYq9WEos4O0UHGEG2GQ8=;
        b=gcukfW1jx9ghc3Rxufk88BiLnwzhHzCfgP2XJE/8mW0eMRhZLDZODrPPF4u2QkIlwgJuN4
        Pm3YueXz49zCuOj3nAatDVBY5YC9AGzJDKkf/vXStR6JynnOIkG1HKZVmAi6QasnPdQUh+
        pqs+WLfz/BN2Q7yUqZJfR0npU3z7+uc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-ShNxBb3rM6WTLcfA3stdXg-1; Fri, 16 Dec 2022 10:52:25 -0500
X-MC-Unique: ShNxBb3rM6WTLcfA3stdXg-1
Received: by mail-qk1-f198.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso2068038qkp.21
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a/XOpLMoccJVDSJCL0inQbFYq9WEos4O0UHGEG2GQ8=;
        b=fPcB4WN+0S5MZj8Eoq1pix7GLfdTZPDu8ViVxFrtG4HG4hlFwGzpyBV3N1vCuniuDO
         aX8dCM3KMnM77mBchZ0mCQgNQvGJ1CBXOIkeVwqH4JU08j/qtmk0a1v7/+ESKCQyxNIv
         3alMtc0Rxhu858K5adkAI3BXVL0zI3ZsgMVyf4tBwkmP7OdWL0RKHHZxDhYuLlP+7amK
         quwCaDRmente9ZdJj3ssyV80HzQrMN/UCLfe9fPIDQduoLk0x+DxSVtQoL4VMNrzZ2Du
         i7uyihR/MHBO1Uf6o7T3q/Qb/8RlhwmXviYrudXGwl9ROB5hHzLoUnwtI6r8pttd7BBV
         GruQ==
X-Gm-Message-State: ANoB5pnswnm1/J8u/TUrlyM35BAWl7C9mb3X/I1V0oFDWVULax0voNcP
        d4yYHlPZU9sTMrwb59CuSME5xdGdixuHp2lLrFppoP3laULI9MTvO4P3R78XHMqIlTAlOjJraAt
        UEwXGBNzkXKz2ZC0JcomN5V/WU76oqKnwevSzAt6ToOu3OEs92lc8uLqAn6ayt01xYhla0PzwFA
        ==
X-Received: by 2002:ac8:5755:0:b0:3a6:9162:245e with SMTP id 21-20020ac85755000000b003a69162245emr61455526qtx.36.1671205943533;
        Fri, 16 Dec 2022 07:52:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4eRO6j6nITJR7U5O1saoqGPaZuUJ+DbwInDy4iHwhtjCTw5HCWKMaEHXGZqHgIE74QZNrEYA==
X-Received: by 2002:ac8:5755:0:b0:3a6:9162:245e with SMTP id 21-20020ac85755000000b003a69162245emr61455484qtx.36.1671205943290;
        Fri, 16 Dec 2022 07:52:23 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b006fef157c8aesm1673001qkg.36.2022.12.16.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:52:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>, peterx@redhat.com,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jann Horn <jannh@google.com>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 6/9] mm/hugetlb: Make hugetlb_follow_page_mask() safe to pmd unshare
Date:   Fri, 16 Dec 2022 10:52:19 -0500
Message-Id: <20221216155219.2043714-1-peterx@redhat.com>
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

Since hugetlb_follow_page_mask() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64512a151567..0bf0abea388d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6375,9 +6375,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
+	hugetlb_vma_lock_read(vma);
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
-		return NULL;
+		goto out_unlock;
 
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
@@ -6400,6 +6401,8 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	}
 out:
 	spin_unlock(ptl);
+out_unlock:
+	hugetlb_vma_unlock_read(vma);
 	return page;
 }
 
-- 
2.37.3

