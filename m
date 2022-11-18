Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8662EAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbiKRBNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiKRBMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71D787A40
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xcizgw09qxh5kxz+rR5aBntzCJEVxf2HEif8HyYLI/s=;
        b=PqdIUPDEcyT8Kjc18rxTtRuMgUDPHSkdOKrG66FljHRPfP4BkiywRvvXo05onknEZujc8T
        gf62WEk4iFu5fX732wrSgL/tVw/gcQTjjw+YTHhGMUAusXNYolqPNNQqAJS4YeBobXSRK8
        K184uYRl6ers5OWq+xSFhU9NG0C3Q4c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-507-KvkebOXWOVegu8epZcviJw-1; Thu, 17 Nov 2022 20:11:36 -0500
X-MC-Unique: KvkebOXWOVegu8epZcviJw-1
Received: by mail-qt1-f199.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so3460577qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xcizgw09qxh5kxz+rR5aBntzCJEVxf2HEif8HyYLI/s=;
        b=eQaz0X9ysrl6irVOdeT6K1CuPfzhdjUTwUyr4AZ1vzC18mNKp2cRgRnxSoodDyj5iZ
         QeetZVXc0TiTB55zPiaXFkIFame5Taxgyh/iFTBu2N9DiDL/m6jl9DYVnEpmuGCNyBsH
         NBoNp7YBYyx9Vlv7lR0uof+DgT670ayQvr8hkyNsBjeeWt5CaAr8IYwrDk6JasQbY8oo
         LLJhF3ITtAnMm+ja81pzTTaZ8Daxv7W5TBM95htxD5y8avpEpxt4IUfmvC+Bu3rM1Zhw
         6HP4IZTGMjNqZee0gqzVZ9g2aXkRk870CcJAUz9Xb0mCFuQGj2XBgBMwGl7VAUOQnHGy
         roMQ==
X-Gm-Message-State: ANoB5pnhXayYgEcQ/8ryBj7wVddjA7ptsuQLA09KRaWq+i3UjSZNsat2
        Bh15tRSF7vvWQILdz3y33lx9PyDQ/mSvLWK2PbYebtA8tU4+2++a6vIMEl19cspR/L1FCLn8gqM
        jdBfr6HJzMUkQbwYGQT8QRyvoxMZZguABg8ippOZonagiEPu3Ay9MtSYU27F33hdc3qnLRhY5bg
        ==
X-Received: by 2002:a0c:b3db:0:b0:4b3:e8bc:b06d with SMTP id b27-20020a0cb3db000000b004b3e8bcb06dmr4998984qvf.72.1668733895443;
        Thu, 17 Nov 2022 17:11:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5zY9gm/9Sq/rUG10fAy37Oz9ULSDk0Pq8azqj/JTmW8KGkcU5gXTaCvi5BCEs8EdrHiJsuRQ==
X-Received: by 2002:a0c:b3db:0:b0:4b3:e8bc:b06d with SMTP id b27-20020a0cb3db000000b004b3e8bcb06dmr4998963qvf.72.1668733895220;
        Thu, 17 Nov 2022 17:11:35 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a404500b006fb11eee465sm1507162qko.64.2022.11.17.17.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:11:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH RFC v2 11/12] mm/hugetlb: Use hugetlb walker lock in page_vma_mapped_walk()
Date:   Thu, 17 Nov 2022 20:11:33 -0500
Message-Id: <20221118011133.2179145-1-peterx@redhat.com>
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
 include/linux/rmap.h | 4 ++++
 mm/page_vma_mapped.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 011a7530dc76..94d25a67db2b 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -13,6 +13,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/memremap.h>
+#include <linux/hugetlb.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
+	/* This needs to be after unlock of the spinlock */
+	if (is_vm_hugetlb_page(pvmw->vma))
+		hugetlb_walker_unlock();
 }
 
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3c..5ac8a89130f6 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (pvmw->pte)
 			return not_found(pvmw);
 
+		hugetlb_walker_lock();
 		/* when pud is not present, pte will be NULL */
 		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
-		if (!pvmw->pte)
+		if (!pvmw->pte) {
+			hugetlb_walker_unlock();
 			return false;
+		}
 
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
 		if (!check_pte(pvmw))
-- 
2.37.3

