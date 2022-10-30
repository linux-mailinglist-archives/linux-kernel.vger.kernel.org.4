Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84E612CFF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJ3Van (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ3Vag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CDEA1A2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wagvClDr96VqW50v7EvOelntcB2vHhVhi8l6aUJsy+c=;
        b=Ento34bfcoEHMbFUVUOCg31FX7uM/ax295P8Y1/3QXPs8X+T8nNyFqtijJAaJBm6onyiJK
        sSHA310fpO4p72xxZnGsD+d+P4G90nrKm7TZKEGIIsYKRRGu26jfXQrbu5+kMqyQqIh2B2
        tJUUVVHoLWiCgLMgAdz1UoFSJmUvzZY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-crETd6G8NlypahQZeKVAnA-1; Sun, 30 Oct 2022 17:29:38 -0400
X-MC-Unique: crETd6G8NlypahQZeKVAnA-1
Received: by mail-qt1-f197.google.com with SMTP id fp9-20020a05622a508900b003a503ff1d4cso5118129qtb.22
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wagvClDr96VqW50v7EvOelntcB2vHhVhi8l6aUJsy+c=;
        b=lWvpk+lu9CsX+oW1BccnEs2RyoCD3LwUAZHETZlUh8dTC+s0vFVYdnXJmJvlpdG+n7
         Pb6qaDfiVHCcpL1NegUalfncL+0fI3os3jK1HMeikkrJGSVTpwTRJiYtqGOtzoCaxAb4
         g7VUQjiimYdm0saLsr+ABs/VLcVTii0b/7I+dbc1Y+710KFn8Hz8AoQxJ9WKKft3gc3V
         ghIvAR+mqtiNO0t96zCt+Rkg6vExa9KCmMv6cQtMF2Kdu0CVqtZoTWVgAR8v7fhg97Wo
         3N8Tkr/4GZg7NxCe7rxgTwsSUydsnDZhOTT8KCR3UVJICgyiXwMaQxKwe7rdfR4Lhoo8
         L7IQ==
X-Gm-Message-State: ACrzQf3zBcLTPK3wQm6GyxAePxP+WpuwjNXxxZjenFsHwfc6PZ3aDsKE
        Zdm0MgGFzJxSaPwariv4YQyecMvpcApdYFfQ1Cd6qh3Lw7EkwoZAR3GLqbiyA9W06Hjf7AJ8ugc
        PwDPj2n0CX3S2ukgOuZxcbsWCl8negb0kx+e4E2+HCVK4kIk9N9m/AfAsGaJr/rTb5WDa2A8PKw
        ==
X-Received: by 2002:a05:620a:270e:b0:6df:7dba:f45a with SMTP id b14-20020a05620a270e00b006df7dbaf45amr6855707qkp.661.1667165377674;
        Sun, 30 Oct 2022 14:29:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43y+Z2mW0srzuBvDKmocMA3VgcwsAHhf82R+MjgsQxdn6rUm6xToTQeXJSbTLNoU9IYHY77A==
X-Received: by 2002:a05:620a:270e:b0:6df:7dba:f45a with SMTP id b14-20020a05620a270e00b006df7dbaf45amr6855682qkp.661.1667165377401;
        Sun, 30 Oct 2022 14:29:37 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:36 -0700 (PDT)
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
Subject: [PATCH RFC 03/10] mm/hugetlb: Make hugetlb_vma_maps_page() RCU-safe
Date:   Sun, 30 Oct 2022 17:29:22 -0400
Message-Id: <20221030212929.335473-4-peterx@redhat.com>
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

RCU makes sure the pte_t* won't go away from under us.  Please refer to the
comment above huge_pte_offset() for more information.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ac3a69fe29c3..b9e7825079c7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -387,21 +387,26 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 				unsigned long addr, struct page *page)
 {
 	pte_t *ptep, pte;
+	bool result = false;
+
+	/* For huge_pte_offset() */
+	rcu_read_lock();
 
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
+	rcu_read_unlock();
+	return result;
 }
 
 /*
-- 
2.37.3

