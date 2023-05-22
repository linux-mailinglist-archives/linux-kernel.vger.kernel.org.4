Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDB70B44D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjEVFGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEVFGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:06:38 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F330A92
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:06:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-561bcd35117so70100797b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731996; x=1687323996;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=itm4lMYCv8hAr7oWbErSKKsiGUM8mghvSpbiblkFfbk=;
        b=xUO60/u0hCL36TvKXHyURnnxqO5vn7ZybjY7ONPqMVFmXcRaGi5WJ1fjIK85dRtVJa
         +whV5tpXJtxlVEd0xUGkv7xuykXYLwzIAtD/A83Pd0ByM1utIbe7HqhKdkTngJ8uTZye
         nXdCtHMDNgLl+HSpG2o6gWxk89SbFvj51bDmDs5EUuxNtQO799f4KEwsfMDYpb1aA0JV
         G1qpsPEAFFQ60/jP3AFkOagxrcttoK3mZdLQdFsbhRCY1FyAsYOWEizdcI6h50IGdllG
         JcD8IVUHEVvPfu5cztMQwnxIE3n4xO4E81T6/znW0rbNwJzdKCpC1q5F2RM6c3EnqDt5
         BYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731996; x=1687323996;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itm4lMYCv8hAr7oWbErSKKsiGUM8mghvSpbiblkFfbk=;
        b=JGede4ErEdyjhrVGGycNcFkSlUzDrvCtgqWU0mr2ngN1RWwWkpuG7SwIm9NmseuFLm
         3A8tm2hbTSo59diT3g4riGqiQQXsv99qZ6pSNVGejltHyDcspDTDMXwE9ZBaKGdqhmiJ
         q+wfrWRCje9E9i2Ajz1CeEj/wCp2m+ufJ/A2/VwJLeFrYvZWJ7puGzz0FkFGmk99b7Ki
         +f/amxmJncen/f2z0D9nFl1cCUw1fGOKdPnx6b29OyqHiKGpX5y46aoKz7pgrqNrzVee
         USvVE5a0x2q8Lf+emynG6xHaTetF2VkRWOLdXyG1i9oygMjXOPUNDp5u+4dptyjebj7o
         9rqQ==
X-Gm-Message-State: AC+VfDyWEanvfquZs+woCunWTjm387zYd+Wrl8dX1Ux5wQZRyOpSTP0e
        6PZUZ4KCWi18UwXbKwNd72IEIQ==
X-Google-Smtp-Source: ACHHUZ78QIP2SjKpIXnCqaoasaQ8h+cR3FlbUtT2N1GVyk/3dI0nRSCd0E3wxVyacPDSOVPhhCpzYw==
X-Received: by 2002:a0d:ed43:0:b0:561:9d6e:6f45 with SMTP id w64-20020a0ded43000000b005619d6e6f45mr10989561ywe.26.1684731996077;
        Sun, 21 May 2023 22:06:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v184-20020a8148c1000000b0054f50f71834sm1805106ywa.124.2023.05.21.22.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:06:35 -0700 (PDT)
Date:   Sun, 21 May 2023 22:06:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 14/31] fs/userfaultfd: retry if pte_offset_map() fails
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <424274a4-7c13-e14-b380-428fc69a45c5@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of worrying whether the pmd is stable, userfaultfd_must_wait()
call pte_offset_map() as before, but go back to try again if that fails.

Risk of endless loop?  It already broke out if pmd_none(), !pmd_present()
or pmd_trans_huge(), and pte_offset_map() would have cleared pmd_bad():
which leaves pmd_devmap().  Presumably pmd_devmap() is inappropriate in
a vma subject to userfaultfd (it would have been mistreated before),
but add a check just to avoid all possibility of endless loop there.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/userfaultfd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f7a0817b1ec0..ca83423f8d54 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -349,12 +349,13 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (!pud_present(*pud))
 		goto out;
 	pmd = pmd_offset(pud, address);
+again:
 	_pmd = pmdp_get_lockless(pmd);
 	if (pmd_none(_pmd))
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd))
+	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
@@ -363,11 +364,11 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
-	/*
-	 * the pmd is stable (as in !pmd_trans_unstable) so we can re-read it
-	 * and use the standard pte_offset_map() instead of parsing _pmd.
-	 */
 	pte = pte_offset_map(pmd, address);
+	if (!pte) {
+		ret = true;
+		goto again;
+	}
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
 	 * changes under us.  PTE markers should be handled the same as none
-- 
2.35.3

