Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB26308EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiKSByQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKSBww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:52:52 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC9BC6059
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:35:18 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s206so7233218oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj3z/V74h8yTKGx3pmSAn8bqVk2d50oyi+g/jzPn/nQ=;
        b=niWUweP5jiGZkx/0pJn6FjxAeah1BRgJ9gyy7AKD4m2WgXDRc0+ag/J6QAC/ycuvSL
         bA71e+gsiJJ0nsG3hF0zeqT1dviyy9+/F/6ea/xknYjVoGD/2NPXFTEbfcUlgfqe8aaS
         WuGFOzqAsc2lahsbyBUVC6vlf96WGnVSIh9o5ZHycQaZQfKeYjubhCOghTRgC7BKdbbm
         ZxxD4gJWoCcBLS0jO2e0Ivl+viCo1qZX7JD70IkT4SxbsdlpPPvXAckEYApEGrEfEXee
         i0P0G49NGzljmhXEHtzxa0XhdU3e//V5TKTPGpHMkikIakKq4qRh8psar2FkojwuMbDx
         BgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj3z/V74h8yTKGx3pmSAn8bqVk2d50oyi+g/jzPn/nQ=;
        b=jc1M6kt6HQ/oIagE2th4is8+CIZxShnTcvRvJbWgTgsRWf/MNIysayxv0gWVLxqFmb
         MXxMZc2TILmVVhgZBN3YLL5cme6rhy2DOzmiKcZ8HmhNk+ZIslcHDcB3STEkEOrEFyZU
         LBGYVKZwUlbl25LLeqa/U/N3+qRxhUaVK+cRqSVGTlriSIi3yK5d89+zi2CaMO8P2akQ
         ncgZotZY7vFE3zq4xabHoobA/lrjXf+6oV7ZDnYgieSbhTIHbJu0Kn94X27oP7U3L+Wq
         /3NJ5CFnGdL8l0RINgmvMtjdH/4jKn70+oS1j2BUCQblLGCXYBNv3qUf6PPzCdMjFm9S
         2jDg==
X-Gm-Message-State: ANoB5pnQvKAEJmX+dj53Jv18QlAKHgWORprHnlAGtQM9io04aaFJ1iEe
        VUWJIgKLG9p0dNJhr0gc4uppSg==
X-Google-Smtp-Source: AA0mqf5aIEbivu26ey9OlowmkMM+doa7untfdHh/eS5VWo9g+FarWZIq5tgcjK1oQ0VbUQsCqot1ig==
X-Received: by 2002:a05:6808:2024:b0:354:e065:7849 with SMTP id q36-20020a056808202400b00354e0657849mr7319954oiw.170.1668821717601;
        Fri, 18 Nov 2022 17:35:17 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y9-20020a4ac409000000b0049e9a80c690sm2014172oop.1.2022.11.18.17.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 17:35:17 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:35:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3 fix] mm,thp,rmap: subpages_mapcount of PTE-mapped subpages:
 fix
In-Reply-To: <759077a6-a08-5bb0-a0b6-53be2fe8b56a@google.com>
Message-ID: <7a4f5e5e-de33-dace-c526-4a3d3cf5f6e0@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com> <78fa518-85b5-32c0-ee92-537fa46131f6@google.com> <CAOUHufYf9Ns6vPpDeSOnUBaQm3Th+N6WbLiT7F=191LNpsatNQ@mail.gmail.com>
 <759077a6-a08-5bb0-a0b6-53be2fe8b56a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao reports compiler warning in page_add_anon_rmap():

mm/rmap.c:1236:13: warning: variable 'first' is used uninitialized
whenever 'if' condition is false [-Wsometimes-uninitialized]
        } else if (PageTransHuge(page)) {
                   ^~~~~~~~~~~~~~~~~~~
mm/rmap.c:1248:18: note: uninitialized use occurs here
        VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
                        ^~~~~

We do need to fix that, even though it's only uninitialized in an
impossible condition: I've chosen to initialize "first" true, to
minimize the BUGs it might then hit; but you could just as well
choose to initialize it false, to maximize the BUGs it might hit.

Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 66be8cae640f..25b720d5ba17 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1281,7 +1281,7 @@ void page_add_anon_rmap(struct page *page,
 	struct compound_mapcounts mapcounts;
 	int nr = 0, nr_pmdmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
-	bool first;
+	bool first = true;
 
 	if (unlikely(PageKsm(page)))
 		lock_page_memcg(page);
-- 
2.35.3

