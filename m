Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255C2728D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjFIBYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbjFIBYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:24:45 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9F18D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:24:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bacfb7acdb7so1331310276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273883; x=1688865883;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNia0t/q7bIuS9YTvnKusLroNIjYrblkNZ2RtXpvdKE=;
        b=En3MWCFjZBPbHoaHE9aTCrwnidrPgxHv9KrEbLe/hJSNlvG00NQArOmMAEVh1cdPK1
         c0avwttgIxMg1/M4xoSdtZvgHC6q+oGNCMIaib2sYWv0Fx3ipPlY1RUsAjzGUeuRCY7q
         f4C9d8VWmMay/sRpQantLYEl4VbdRT+IrwRgP0s1LNmuiH920qhuNY3jPTG46R78i5+k
         9bDaQ6fLa6fnzNxc3zf976MlEqNb+2p/4gql5IeQqWDTKZblvLqIpzvT31fUaUlXU1zw
         KT/OmxBpL9FU5MCWQGoReuGTHeYWIqJH3GhVd3emhvyvLQrP6bSWfVqdEbmUf+1ykpPu
         0Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273883; x=1688865883;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNia0t/q7bIuS9YTvnKusLroNIjYrblkNZ2RtXpvdKE=;
        b=UFrFA2/aQlviVuEA4sVXd9YBokF8eFuiDbeDw225RIsbxsCFEbOxRixaDb9flg+2/+
         LHes5NQft8DEoqSMr8x+Bm1JP/5YIXkbfDP+4YI1yvT9yuopBhsf3ikFYu2vYIMwh1Ab
         Svw6S48rn4KZ0gAMNsahZtXKSeKxTfzS/eHoGjUJdW+48f8YJXf723P4JUnqFS9ymge3
         rEZwfDylaD8S488wCsHXvv7cje6Z8fascxgjftWHhMTRnUfsE6Q+AyYfNFUzwiHA81CJ
         yoD/+H7XUeMSL+eRFNZ8vTQRUIY1PzGW/6JrRTMPce37joA6PUxF/B1oInSmeQrIEtB5
         zVYg==
X-Gm-Message-State: AC+VfDwoGAtuJMfsr/yK3TSD7+uSfqe0ock2RsY2Du/n7I9uMPU6IMrW
        s7UEMIHiMKsZrh2P2panpgHWyA==
X-Google-Smtp-Source: ACHHUZ7fnPyD1AB15VbBenw69LG3/w2FA1xyBpqbSoDD115cddrIVPxKnnpMPhIjJpC81nscf3jcJA==
X-Received: by 2002:a25:8d83:0:b0:ba1:6bad:41a4 with SMTP id o3-20020a258d83000000b00ba16bad41a4mr1193186ybl.14.1686273882963;
        Thu, 08 Jun 2023 18:24:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ch22-20020a0569020b1600b00bac1087b44esm587924ybb.35.2023.06.08.18.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:24:42 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:24:38 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 14/32] mm/userfaultfd: retry if pte_offset_map() fails
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <54423f-3dff-fd8d-614a-632727cc4cfb@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
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
Acked-by: Peter Xu <peterx@redhat.com>
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

