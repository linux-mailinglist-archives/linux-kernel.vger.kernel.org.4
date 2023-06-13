Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA572EE58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjFMVzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjFMVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7E1BDB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwdaHYLXZAtZykSCGumfFt7VLYdtQYhxN3KKFt+1ERs=;
        b=WCWQc/c0JjyggKyki1eLvLVeLlV58MZVpK3znCwWwCp1jUVKCxEZInvijX+ONix375sTnW
        1nCUHuCQMYj5M4cCnmqF9tmhXBS2IjKrH4zKLmxBZHDIArR1UktMUNiNA+WM/hBnvNKBAb
        emU35NDQ4v5zHY8oXHI/loMZewxG6vc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-Qquw00nBMdWYlcgd7xZzzw-1; Tue, 13 Jun 2023 17:54:08 -0400
X-MC-Unique: Qquw00nBMdWYlcgd7xZzzw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7606a134623so44621685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693245; x=1689285245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwdaHYLXZAtZykSCGumfFt7VLYdtQYhxN3KKFt+1ERs=;
        b=gwFvz4E+SPJwdeBQGrRqqR6ghu72gSd0V+97Ws+Ad+rQbeEMv7x8LtNjp7BTGkaBKM
         Ba8Kzl/tlHg1tChRj6kw6h5g9jhaa0zw2T6kPydgkuj8NyCu2p1LwSWyFdZFzoYBMFe4
         EPo5zbKzRfJSn3MGvYdReev7xCjz2WdjSG/nWsEd5w44RxLed4oY1Ws8DjBhWiLW+LXQ
         /rxwJMX3DVS2GbETOwhrovbONH0JkLMjlaTc6Fd9LzUAJnqBcEalsyzVK+QD0s/9M69A
         X5XO1yOYyOWDTiFTFJgawgUC6J2oiq1gwXz/16LrPw0VquV/5T9zUo4fCghLuoNjjQus
         S7tQ==
X-Gm-Message-State: AC+VfDx4ZeuQeh7r+4cPopGcKmpzQdTEovHOQk6neFh9kwgmV2fc4rld
        C9/FrZmYxY4QBbYMxZSyW3qe4TGBIDgVaYkIKW/oPZSdBNV82gfnqMxMR3RD94e4fZz4n+kn8VW
        rAwicqEb266o3Zi6ejeJKjnffbrjKz+wEz7typFaku1rNLiHCaFOhn3/91QZFBrIQta+1r02nEO
        SWSG91ig==
X-Received: by 2002:ac8:5c4e:0:b0:3f6:b556:7c97 with SMTP id j14-20020ac85c4e000000b003f6b5567c97mr18597060qtj.4.1686693245305;
        Tue, 13 Jun 2023 14:54:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oqukQ8w9LAlWsT5JOrpxotagWUzu2HoxH3Yt91lRCBju32vz1LdI431t9L/5PA4lN4Cy+gA==
X-Received: by 2002:ac8:5c4e:0:b0:3f6:b556:7c97 with SMTP id j14-20020ac85c4e000000b003f6b5567c97mr18597030qtj.4.1686693244966;
        Tue, 13 Jun 2023 14:54:04 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fz24-20020a05622a5a9800b003f9bccc3182sm4522330qtb.32.2023.06.13.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:54:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, peterx@redhat.com,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 6/7] mm/gup: Accelerate thp gup even for "pages != NULL"
Date:   Tue, 13 Jun 2023 17:53:45 -0400
Message-Id: <20230613215346.1022773-7-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613215346.1022773-1-peterx@redhat.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a2d1b3c4b104..cdabc8ea783b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1210,16 +1210,38 @@ static long __get_user_pages(struct mm_struct *mm,
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
+			 * Since we already hold refcount on the head page,
+			 * it should never fail.
+			 *
+			 * NOTE: here the page may not be the head page
+			 * e.g. when start addr is not thp-size aligned.
+			 */
+			if (page_increm > 1)
+				WARN_ON_ONCE(
+				    try_grab_folio(compound_head(page),
+						   page_increm - 1,
+						   foll_flags) == NULL);
+
+			for (j = 0; j < page_increm; j++) {
+				subpage = nth_page(page, j);
+				pages[i+j] = subpage;
+				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
+				flush_dcache_page(subpage);
+			}
+		}
+
 		i += page_increm;
 		start += page_increm * PAGE_SIZE;
 		nr_pages -= page_increm;
-- 
2.40.1

