Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0962EAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiKRBNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbiKRBM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3385EEB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ap7neQhploF5O2byy6eWIJyWsli20vMRANWIX9Kzu5I=;
        b=P1IX7psOa/NnYfYPqPJ1kd126SeNdbqEdLG3F67xKHFwx82gdpYlvjqYnUVIxhuiv7MJPj
        fa80cpwvPLKMbRwzghTDILBdNXnT0yTkhBMIBhHW9MBmyniD/aIcafM7KrdltGg0Cu3/14
        IxWVERb6Lf3sVcFuqRx73T8dkoExFLw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-pwlNGIrpNam8O9R7mgqptA-1; Thu, 17 Nov 2022 20:10:42 -0500
X-MC-Unique: pwlNGIrpNam8O9R7mgqptA-1
Received: by mail-qt1-f197.google.com with SMTP id fz10-20020a05622a5a8a00b003a4f466998cso3416993qtb.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap7neQhploF5O2byy6eWIJyWsli20vMRANWIX9Kzu5I=;
        b=YIaj/wgTcXZh3tueT9NlLSHE7iwghayOUAlDmGsnAOsc9eNbcxy7KINSgwD4+n8oLA
         d9hZqZRjWM8y1Dn08t1OWoIESk+muXxdLJE34Mst+hmShXV8kvHCUawo8PUymMfKu0Ja
         PFvpXOELYWGEzrfDHsFXOPJR6NIspBcbU19RdfgEKBBY/aYlL2wu+kt2u6Fd9o0vN51Y
         LjBFXxloWWg3P0qwt60NJxUA9/b6AXubRBCX7k+L3rL1jEHBCdWDQoaUYQbGExnFoq9U
         orGb9bi0Akb5u/tNxt6XrfEyyw3RL9f691tzSng+KKuWkRKeD8eTpcqK5TEqibHE2u1x
         7Azw==
X-Gm-Message-State: ANoB5pkglY3XShVZFyLNmBpOm878PjNFBX1jYdp7pjFMBrIjsZzrimnk
        aJPvS2mlp4sGftoUx1qQh3VIzo0ifPWBedzpS24fuM5S2AZupGs9biypAdL1SGb5P3KWKgW5mSD
        YyDSGHgTlfqYCfyCTbuFZfzMM
X-Received: by 2002:a0c:c682:0:b0:4c6:80d9:844d with SMTP id d2-20020a0cc682000000b004c680d9844dmr4921259qvj.34.1668733842345;
        Thu, 17 Nov 2022 17:10:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ri6W+Ys/uE6Yihgvm71dHXQ64Qx2xPRu/QHx/egaYRiWuxzZqmcFd9on3+WOH893ouf3hGw==
X-Received: by 2002:a0c:c682:0:b0:4c6:80d9:844d with SMTP id d2-20020a0cc682000000b004c680d9844dmr4921236qvj.34.1668733842116;
        Thu, 17 Nov 2022 17:10:42 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:41 -0800 (PST)
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
Subject: [PATCH RFC v2 09/12] mm/hugetlb: Use hugetlb walker lock in hugetlb_vma_maps_page()
Date:   Thu, 17 Nov 2022 20:10:22 -0500
Message-Id: <20221118011025.2178986-10-peterx@redhat.com>
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

Hugetlb walker lock makes sure the pte_t* won't go away from under us.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index fdb16246f46e..265508981ba1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -387,21 +387,24 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 				unsigned long addr, struct page *page)
 {
 	pte_t *ptep, pte;
+	bool result = false;
 
+	hugetlb_walker_lock();
 	ptep = huge_pte_offset(vma->vm_mm, addr,
 			huge_page_size(hstate_vma(vma)));
 
 	if (!ptep)
-		return false;
+		goto out;
 
 	pte = huge_ptep_get(ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
-		return false;
+		goto out;
 
 	if (pte_page(pte) == page)
-		return true;
-
-	return false;
+		result = true;
+out:
+	hugetlb_walker_unlock();
+	return result;
 }
 
 /*
-- 
2.37.3

