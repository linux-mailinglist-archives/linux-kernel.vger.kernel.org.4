Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5D741B37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjF1Vyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjF1VyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4CC2110
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1A4ivN2AFC1lD1f3DRS9KX47rVe/ku79YHFPXkOfKI=;
        b=Kt5ZAVDdr/jVhGx1pHDLciGBS5vMnFB4Ut2NcAbS5uYT0z1LRk4hQLNBXKmPIjBybkDoLm
        AKdANP0+1OwJzS32vBeWGapRVMeCNTZFe2u/R+xtmIllhpxxvhar9qT+8Yz29M2ZzGkLZD
        yNeKT/bQwUxyPULf8pU1+t2udNgVMzA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Repg9S1sOki2fFtIypOy6g-1; Wed, 28 Jun 2023 17:53:18 -0400
X-MC-Unique: Repg9S1sOki2fFtIypOy6g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635df023844so9736d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989198; x=1690581198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1A4ivN2AFC1lD1f3DRS9KX47rVe/ku79YHFPXkOfKI=;
        b=HWx37WgvLrFAFvxRb62f5CdxN3t01hlsq6cxG3AnCyKUUEpok9TcaPw1vwHxZG0R0o
         77DjUbORdmvzfWWI2We12w/1k8+s4RDFlnTKf2W8vGrlMwQjx62zem4XoyBJz5Tpwbv7
         rn1uWdKAOzxaP1kWMH/tAuKPfi7zX2c1MCiPxJjoeOst2e3xFEgHRf1IcRsZw2O5wi3c
         sbZBFEubftghBFpdTo2oc4Ub2XZmiZjuYOEr/3oMo36dpn5Pgc1dya/hzVxUrVRr4H2V
         DTq2XqOxWXDJyM6rI/IcS0Ioz2dfA6JLq7EPnFaq3j/fqoQJNVEvGYMZEVRrjKFug3rJ
         ltCw==
X-Gm-Message-State: AC+VfDyRO6WFc7FoUjC8DN5IyZSrXHH+GuGoKX3yPLZzYGrsNkw/rJXa
        Dqr0SpJ/O6sZIi9Gp0jjPi9GV6N/UE0ltlTEjT/FqIBgSYipXRhF65K+C1vrri452OcBKvYw1Oi
        e0Sir6apH8lgLdGocPyuIWGOP
X-Received: by 2002:a05:6214:301a:b0:635:da19:a67f with SMTP id ke26-20020a056214301a00b00635da19a67fmr13098204qvb.1.1687989198001;
        Wed, 28 Jun 2023 14:53:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bWthzbIpu8brAzYWFel0vezukPFHw5JtwGCHRd23ZlsKMqKd/fjN3mRP22Dyi1lIzaJO53Q==
X-Received: by 2002:a05:6214:301a:b0:635:da19:a67f with SMTP id ke26-20020a056214301a00b00635da19a67fmr13098180qvb.1.1687989197705;
        Wed, 28 Jun 2023 14:53:17 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        James Houghton <jthoughton@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com
Subject: [PATCH v4 4/8] mm/gup: Cleanup next_page handling
Date:   Wed, 28 Jun 2023 17:53:06 -0400
Message-ID: <20230628215310.73782-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215310.73782-1-peterx@redhat.com>
References: <20230628215310.73782-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only path that doesn't use generic "**pages" handling is the gate vma.
Make it use the same path, meanwhile tune the next_page label upper to
cover "**pages" handling.  This prepares for THP handling for "**pages".

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1e2e23084f3c..5af1be81390b 100644
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
2.41.0

