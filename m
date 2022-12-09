Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD748648728
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLIRC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLIRCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C6E8F08B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670605282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uAZCG3P+mUZeKCIXPYURgU7pcsgAcHbWcWGaDTy3vU=;
        b=DzIjkVtpK7Cp1Jj+m6zRAtywQWuMDR/7tV5tS+evqXmt64NxJB/4gfhY/0cj9b4c6u9HsY
        Dl47pHcs8SZHgPkQ1eTAYEQkNVG0YMNQhWtz+xZ6Vwss/aeCWM4UKkhsibCTXiAexk/QGT
        Rr5uiyfe/uPpiBHC3AufQk8xaP5WifM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-P1I0-qKkN-6KU1hwasDSOA-1; Fri, 09 Dec 2022 12:01:13 -0500
X-MC-Unique: P1I0-qKkN-6KU1hwasDSOA-1
Received: by mail-oo1-f71.google.com with SMTP id u22-20020a4a6c56000000b004a38aa46a1fso1578747oof.22
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uAZCG3P+mUZeKCIXPYURgU7pcsgAcHbWcWGaDTy3vU=;
        b=E55SgkSfoQwsHLpjbJG3MLUvJn1lSsaBb8vfRXDBwHcY0+Ci1JuFM8xTBvqLzxdFyM
         NpawgnEgIQgYxuk2tdCbgoe4eVC5m1WBIT59LdAV58Y44/MuGhGpwk0zMbHR2JsbfRry
         w2fO3uLqyfxrCQLgB8t+IrYjWea4dLrjz8tlBlmWEX0pbYFHttyaMcvwSIpbjMHhsIo9
         f99dKFCulVo8MO9gBirDvhhqx7Se3bRLywpm6yvOJVkpmFBJVM6CdauKbVmWYXXLBHIj
         j+QBemK5291JIZv9/iaCHvcXv7wPydyBrGQwHnBo1QYQJXg/otxLuXg15Xs9IFkMeNdB
         kBJQ==
X-Gm-Message-State: ANoB5pmv2PQKivi3NzWMTLDSAYmXRA0aNntiKCNRsr/LU+u+6tfd0MEE
        +sL2GK2uR5izNmvhFC1MZA1zPK5zGy+shZlAKSfJnny8BuDQ2oYi+qV3a65q95iIU3zMcXdy9Pi
        yrJjqgbaItosd+EdVjOC7auxz
X-Received: by 2002:a54:438d:0:b0:35e:1ca6:ff6d with SMTP id u13-20020a54438d000000b0035e1ca6ff6dmr2673227oiv.5.1670605273064;
        Fri, 09 Dec 2022 09:01:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4i+e1KtxZvFOzCGHgXB6sOxKF23L/F2cv/jo46p0ozGa2WnFiSOSP68F7KBtkljhg4CQrInw==
X-Received: by 2002:a54:438d:0:b0:35e:1ca6:ff6d with SMTP id u13-20020a54438d000000b0035e1ca6ff6dmr2673199oiv.5.1670605272841;
        Fri, 09 Dec 2022 09:01:12 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006cf38fd659asm178907qkl.103.2022.12.09.09.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:01:12 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/9] mm/hugetlb: Don't wait for migration entry during follow page
Date:   Fri,  9 Dec 2022 12:00:53 -0500
Message-Id: <20221209170100.973970-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209170100.973970-1-peterx@redhat.com>
References: <20221209170100.973970-1-peterx@redhat.com>
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

That's what the code does with !hugetlb pages, so we should logically do
the same for hugetlb, so migration entry will also be treated as no page.

This is probably also the last piece in follow_page code that may sleep,
the last one should be removed in cf994dd8af27 ("mm/gup: remove
FOLL_MIGRATION", 2022-11-16).

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1088f2f41c88..c8a6673fe5b4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6232,7 +6232,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
-retry:
 	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (!pte)
 		return NULL;
@@ -6255,16 +6254,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 			page = NULL;
 			goto out;
 		}
-	} else {
-		if (is_hugetlb_entry_migration(entry)) {
-			spin_unlock(ptl);
-			__migration_entry_wait_huge(pte, ptl);
-			goto retry;
-		}
-		/*
-		 * hwpoisoned entry is treated as no_page_table in
-		 * follow_page_mask().
-		 */
 	}
 out:
 	spin_unlock(ptl);
-- 
2.37.3

