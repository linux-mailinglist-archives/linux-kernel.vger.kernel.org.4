Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4BB70B439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjEVEwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEVEwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:52:36 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C634BBB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:52:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-561bcd35117so70007567b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731155; x=1687323155;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc/g6LXQOs93yTgCiGczTkkFK+sAgodNjTysgahDEVw=;
        b=y0KD6rBKhVlt+/hQTMgxrgHr2ryOWmswWrxwVwW1aFZ79LkRBOC59dixF5L/cDZc4B
         qnUQhKlaq1KoTySTp2vqiuM8rApR8HI8YhApmutmEIgesAjWn3Zc6GfqRJFCVIZETmFo
         Ve2TuK1DkPJI4FLOOGkjpX3SgGZwTv9PexqmJixY6pwUW+8F8Muuz17KmV5M/4+hZQ/g
         NOfOuuy9xT5Aq5lXVwksnHlv6Vlink7vPREGhAD7sqE7v5xbbRTG+tMaRpWIb/f65tVQ
         6KthNz49DESDlvL8PCw3g3sz72EdxO0SmuuSbMBDwQ700O/IFokzhDePdlcNOBT1Ipvs
         7n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731155; x=1687323155;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lc/g6LXQOs93yTgCiGczTkkFK+sAgodNjTysgahDEVw=;
        b=X/aaKhL6/S0/F2VAAvvi6H28sfJbZ2k889yvEb/LN3q7gcsUz9VoRnVvoBV25qKH70
         zuLXGW0rL9YGWxlNH1IsPJhnPS4FJK9Z5a95TlIQNUI3NS3cIA6UGF1WbQIavO3u/Qw/
         E5TJxpxpZgt25xJEMCUfh34VZaFGXtwyLydeLQjPTeX2zvnWSWsKE/xbI1Qs+JldE6t/
         TeLrebYA9wHbQzbXjGw1UH5oCjNhp+5lPqTVXRzWVGUNEq08smkIbC1QQriUQkAkMJBy
         BREWWOSwAzWiY3Q/xm7eXqmZ3CwYbWS1H08lUycRvvYweSCGDhN+SBu8arqFhFKQh5rE
         TUug==
X-Gm-Message-State: AC+VfDwhrP3DRIYXNxaLLRcx6TvOsbWIWKvuEsOKLXzJu0PZhKxr/Zku
        fGhyndr5mdqWa8EWXpDnfR/HhA==
X-Google-Smtp-Source: ACHHUZ5dIfhq7xIc6CspLmzSUsrpzIMl80pglZ3+j6+NrHQ8JwvnQ0G2n+LIPSBV/lbo+YJXvCTWKQ==
X-Received: by 2002:a0d:d901:0:b0:55a:9e43:7efe with SMTP id b1-20020a0dd901000000b0055a9e437efemr10375067ywe.44.1684731154895;
        Sun, 21 May 2023 21:52:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w6-20020a814906000000b0054f8b201c70sm1786111ywa.108.2023.05.21.21.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:52:34 -0700 (PDT)
Date:   Sun, 21 May 2023 21:52:31 -0700 (PDT)
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
Subject: [PATCH 03/31] mm/pgtable: kmap_local_page() instead of
 kmap_atomic()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <9df4aba7-fd2f-2da3-1543-fc6b4b42f5b9@google.com>
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

pte_offset_map() was still using kmap_atomic(): update it to the
preferred kmap_local_page() before making further changes there, in case
we need this as a bisection point; but I doubt it can cause any trouble.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8ec27fe69dc8..94235ff2706e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -96,9 +96,9 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 
 #if defined(CONFIG_HIGHPTE)
 #define pte_offset_map(dir, address)				\
-	((pte_t *)kmap_atomic(pmd_page(*(dir))) +		\
+	((pte_t *)kmap_local_page(pmd_page(*(dir))) +		\
 	 pte_index((address)))
-#define pte_unmap(pte) kunmap_atomic((pte))
+#define pte_unmap(pte) kunmap_local((pte))
 #else
 #define pte_offset_map(dir, address)	pte_offset_kernel((dir), (address))
 #define pte_unmap(pte) ((void)(pte))	/* NOP */
-- 
2.35.3

