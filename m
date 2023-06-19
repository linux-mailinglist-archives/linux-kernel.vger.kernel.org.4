Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F39736001
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjFSXLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFSXLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400FDF9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5PvpMSc9PWeUNzovzE5WASqMyhgs2MBMMaZX0mlkro=;
        b=HsrfWaFGRNGW7TyqANKJXScYe9zyJOxCR9WJ2uLjTGhDhqAWnatUQY7r1NI3E5AyZZhr0l
        3x3Csn0p86ULBAcyHGR1YwyVNu45UN/5trM7b/w/POwyHylavMtMVJwQciwVg6hxa/Ru71
        v0exEzuJzbpZ2yI1ce+yxe71MAIgH4M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-ADuqldeKOdC8jdP2BC1-Wg-1; Mon, 19 Jun 2023 19:10:53 -0400
X-MC-Unique: ADuqldeKOdC8jdP2BC1-Wg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76077669a5aso105210085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216252; x=1689808252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5PvpMSc9PWeUNzovzE5WASqMyhgs2MBMMaZX0mlkro=;
        b=RF39+mw1lECiHeviN7uE0PT+gnphVOGi182Z5xSfA+KCcVuoCnbin9yzecpBqawujg
         1CyKn1G529yVjklqbX+o7KX04WE6HrLCi1gmMXa09esKEcw5AE20nctGqJYUzavBEkYS
         Yad+9gny8Zqk9xYVFKDkE/ocK3hwyk/DRTxY8a60p4rASuZo8l0P/wJBxqa/cnAlQe9G
         UHI+az9wzuMV3zfc9vi639V9szqlh7eVk1FXhRxb5QGS6wFU1wwdBg0da3eL2NMLQFxH
         m88NWspXIc8x/PGDESW4YRd7QheGT056Phsjl5fGVOx9rlTItGXgUAf+ZZt+BwruWtsY
         +T0A==
X-Gm-Message-State: AC+VfDz8GmTaexW9uJ/MPRW5YC5YuLJNvtMVkZt8NOri0rmvlILX/Cd/
        SVaJGjX7B8PL7nPT8OUNQmZu0epVBpjiA0GYuaHiJ+MuxZylI+35X5UjCt9t1dCF4WFmwjh3RQI
        y4OyE6NSN8k4hUocTLaqZwsZq
X-Received: by 2002:a05:620a:800e:b0:763:b025:9f40 with SMTP id ee14-20020a05620a800e00b00763b0259f40mr146888qkb.7.1687216252497;
        Mon, 19 Jun 2023 16:10:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gUaxPapWXj9fyTcJWWnL1Kgv2ncFDRbyXTEYoD6E6DhEtoWY/2AMdIngB3HsMpWlNRnZ+zw==
X-Received: by 2002:a05:620a:800e:b0:763:b025:9f40 with SMTP id ee14-20020a05620a800e00b00763b0259f40mr146867qkb.7.1687216252208;
        Mon, 19 Jun 2023 16:10:52 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:51 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 4/8] mm/gup: Cleanup next_page handling
Date:   Mon, 19 Jun 2023 19:10:40 -0400
Message-Id: <20230619231044.112894-5-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619231044.112894-1-peterx@redhat.com>
References: <20230619231044.112894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only path that doesn't use generic "**pages" handling is the gate vma.
Make it use the same path, meanwhile tune the next_page label upper to
cover "**pages" handling.  This prepares for THP handling for "**pages".

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 9fc9271cba8d..4a00d609033e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1124,7 +1124,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
-						pages ? &pages[i] : NULL);
+						pages ? &page : NULL);
 				if (ret)
 					goto out;
 				ctx.page_mask = 0;
@@ -1194,19 +1194,18 @@ static long __get_user_pages(struct mm_struct *mm,
 				ret = PTR_ERR(page);
 				goto out;
 			}
-
-			goto next_page;
 		} else if (IS_ERR(page)) {
 			ret = PTR_ERR(page);
 			goto out;
 		}
+next_page:
 		if (pages) {
 			pages[i] = page;
 			flush_anon_page(vma, page, start);
 			flush_dcache_page(page);
 			ctx.page_mask = 0;
 		}
-next_page:
+
 		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
-- 
2.40.1

