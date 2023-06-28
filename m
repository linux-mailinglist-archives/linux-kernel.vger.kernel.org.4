Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A69741B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjF1Vze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjF1Vyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7F211D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LErGcSwJladPWljtQDBZEDG1gs3DbaZNQ9dZknt9+SI=;
        b=bE1pmSAGRaHObDruWiFGWoU2a0fcU2xPfyl3oncN6oCiWwKj5aNjSaLYs8vu/QCXmkoDMU
        XuAbRgG1Lr38UfrRf6rgNWcBGL1AbhwSAH1unYIn/y0/mbsORqW2YK+7ZDVb4E4qN8MGlg
        zMRLGlppt+4IJVTOR4q7ncFFNSV0VEM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-gJ9xuyYVOUOJFMofO_LFbA-1; Wed, 28 Jun 2023 17:53:19 -0400
X-MC-Unique: gJ9xuyYVOUOJFMofO_LFbA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e2618aaeso42496d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989199; x=1690581199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LErGcSwJladPWljtQDBZEDG1gs3DbaZNQ9dZknt9+SI=;
        b=cDV/hM+b43d+MbPRxVRdMMTBye2AcJ05aMtildRSxipnD1rl+9KaJ5FsFhFvcCdSY6
         GzDYSzZ4t+RXBmpfyWLY9rdZfVz6khzhJLR1Ev37W70ypkU4/NKs1ZXJ3d7WQ6XAJ2PX
         M0wzC8gdZcyXz8t5uQHmZnbRZOkUcDkwhBlsnYHkJt8JliBae8zEGtMGgWELSB0ihEeb
         y2zIT3DPCV/+dUrftaamlS1OSOMfDZHQL/qta/H5gSUD+scs2ETWU28dn+n3vb4hwFpd
         aGM8XBddVWHuCNb142mlBhTWcOVL0gKxPk91xzvAvD/sd5IP88J5esECzn57l6ZTDxJp
         NAyQ==
X-Gm-Message-State: AC+VfDwaJGSOGeCiqpuykHnkNht0NjWisg7doKMM8GBv2P9xuS1bZztL
        JYBbdiuL9gY1Vd/Wal7KrSAXPLgpqHJZ9qM/fYeJI+8dEbSP5zryfQxMrqLI1B/BQmnZApJ/WZF
        ZSGapHYUpetYVWYixoHgt9jak
X-Received: by 2002:a05:6214:501d:b0:621:65de:f60c with SMTP id jo29-20020a056214501d00b0062165def60cmr6650320qvb.3.1687989199421;
        Wed, 28 Jun 2023 14:53:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aH92Xekg+ZXFKVELiAnLIK82VapCJUdD+ZE2LzSIKvWv5j/RuoE6PplAHYjC4on1+uql7Bw==
X-Received: by 2002:a05:6214:501d:b0:621:65de:f60c with SMTP id jo29-20020a056214501d00b0062165def60cmr6650303qvb.3.1687989199149;
        Wed, 28 Jun 2023 14:53:19 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:18 -0700 (PDT)
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
Subject: [PATCH v4 5/8] mm/gup: Accelerate thp gup even for "pages != NULL"
Date:   Wed, 28 Jun 2023 17:53:07 -0400
Message-ID: <20230628215310.73782-6-peterx@redhat.com>
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

The acceleration of THP was done with ctx.page_mask, however it'll be
ignored if **pages is non-NULL.

The old optimization was introduced in 2013 in 240aadeedc4a ("mm:
accelerate mm_populate() treatment of THP pages").  It didn't explain why
we can't optimize the **pages non-NULL case.  It's possible that at that
time the major goal was for mm_populate() which should be enough back then.

Optimize thp for all cases, by properly looping over each subpage, doing
cache flushes, and boost refcounts / pincounts where needed in one go.

This can be verified using gup_test below:

  # chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10

Before:    13992.50 ( +-8.75%)
After:       378.50 (+-69.62%)

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 5af1be81390b..0e2b0ff1143a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1199,16 +1199,53 @@ static long __get_user_pages(struct mm_struct *mm,
 			goto out;
 		}
 next_page:
-		if (pages) {
-			pages[i] = page;
-			flush_anon_page(vma, page, start);
-			flush_dcache_page(page);
-			ctx.page_mask = 0;
-		}
-
 		page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
 		if (page_increm > nr_pages)
 			page_increm = nr_pages;
+
+		if (pages) {
+			struct page *subpage;
+			unsigned int j;
+
+			/*
+			 * This must be a large folio (and doesn't need to
+			 * be the whole folio; it can be part of it), do
+			 * the refcount work for all the subpages too.
+			 *
+			 * NOTE: here the page may not be the head page
+			 * e.g. when start addr is not thp-size aligned.
+			 * try_grab_folio() should have taken care of tail
+			 * pages.
+			 */
+			if (page_increm > 1) {
+				struct folio *folio;
+
+				/*
+				 * Since we already hold refcount on the
+				 * large folio, this should never fail.
+				 */
+				folio = try_grab_folio(page, page_increm - 1,
+						       foll_flags);
+				if (WARN_ON_ONCE(!folio)) {
+					/*
+					 * Release the 1st page ref if the
+					 * folio is problematic, fail hard.
+					 */
+					gup_put_folio(page_folio(page), 1,
+						      foll_flags);
+					ret = -EFAULT;
+					goto out;
+				}
+			}
+
+			for (j = 0; j < page_increm; j++) {
+				subpage = nth_page(page, j);
+				pages[i + j] = subpage;
+				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
+				flush_dcache_page(subpage);
+			}
+		}
+
 		i += page_increm;
 		start += page_increm * PAGE_SIZE;
 		nr_pages -= page_increm;
-- 
2.41.0

