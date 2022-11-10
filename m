Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8756239A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiKJCOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKJCOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:14:03 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486713DD2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:14:02 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 94-20020a9d0067000000b0066c8d13a33dso402158ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 18:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ5gUxhZkoh4ZqQ1bcivI/3wrTPkC+2Pwjz27W6nqVY=;
        b=hkWyuWg5OmCw+m8n+jU/hEL2SZEyvZZsF5o109BrS1bEC/oc1yxlIjRs8KNwa1Yt7L
         KaI3Pns5MBH582GuIyu7ww++uOE1lZCVg6+DB7jA7Z2Hu8TvKX6OXLP1BCWXxMziU3Kx
         PMpZtCvWfFdYvompuhsL+52Z/S7QXwAOKElAMH6wZWzsn9bBEGFlwV2ayA+ps6s9toZa
         5E+9Fgqz8JgGH7RgDG0jGp3K5fWiHZyAOA98zdE2TOm1yj3SnirsFAF2KcAle/Xz6935
         dKolrUkd+gRIuxCz0WTf2LmnM/J0Y2m5TdksjF8OhR33Of62sXNIuxOzRBMjUDdr/HEX
         D26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ5gUxhZkoh4ZqQ1bcivI/3wrTPkC+2Pwjz27W6nqVY=;
        b=qnqiPuT1xGUlGB8lbBJUm26eYM9ya0oCuMNVvFvCc0JwiU+78sLTbtf3q9UQRvMLvf
         ZTfp1wFOOclYcWu9PuRhMRiMoMRlJVeNjSZZj7YgD0eKxG+6fR49MltkeM8WxcfjXUQg
         nAmtQNScCK0EHWpn0XtsBxpMUEG1I0gyaNhPAeZ7hBBgGI9GqnOQ6zNKkK76n2tNItiC
         sOJKyvhDKd+CCK4cQR6344tcQv/LI8rX0j+TO2aJlmhNEDaLymhLC8jGmeBR1mw1vrNE
         t7hn+hI4BL9MZpMgILHMaZDP7/i9BBv+4Gyl9jpDg7RRXIUPxDQiVh8iKSRs8w5yhbrJ
         dEow==
X-Gm-Message-State: ACrzQf1BfJVNGQkUYWwKhur43qhg2HjzEn844LCqufEu9kWgDOYPbvQo
        GSg6Fnn3SbqDaCvnYVmfGt8CnA==
X-Google-Smtp-Source: AMsMyM4dcGqo0An9JN9vCjwoOpNHZTTIU7z3U6tVi3khgS8u3goRM6xFEtxLIwnDfEf20Yl+wAOCFw==
X-Received: by 2002:a05:6830:6084:b0:65c:3942:e3bf with SMTP id by4-20020a056830608400b0065c3942e3bfmr18619123otb.49.1668046441175;
        Wed, 09 Nov 2022 18:14:01 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y5-20020a544d85000000b003509cc4ad4esm5258842oix.39.2022.11.09.18.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:14:00 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:13:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3 fix] mm,hugetlb: use folio fields in second tail page:
 fix
In-Reply-To: <7f60bcac-a2e5-9c4b-8a8f-e972a93e116@google.com>
Message-ID: <9e2cb6b-5b58-d3f2-b5ee-5f8a14e8f10@google.com>
References: <5f52de70-975-e94f-f141-543765736181@google.com> <3818cc9a-9999-d064-d778-9c94c5911e6@google.com> <5bd8a365-e2c5-a721-1257-81ec4ae0c626@oracle.com> <3934b34-ae2f-2119-9a68-33e51e909795@google.com> <e5bd10cd-eb86-3a70-a0fe-21ba49b5ab25@oracle.com>
 <7f60bcac-a2e5-9c4b-8a8f-e972a93e116@google.com>
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

Per review comment from Sidhartha: prefix folio's page_1 and page_2 with
double underscore, to underscore that they are fillers for alignment
rather than directly usable members of the union (whereas the first
"struct page page" is important for folio<->page conversions).

Per review comment from Kirill: give folio's _flags_2 and _head_2 a line
of documentation each, though both of them "Do not use" (I think _flags_1
should be enough for now, and shouldn't recommend spilling to _flags_2).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm_types.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5d28bbd19e3f..1b8db9b4a7e6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -275,6 +275,8 @@ struct page {
  * @_subpages_mapcount: Do not use directly, call folio_mapcount().
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_flags_2: For alignment.  Do not use.
+ * @_head_2: Points to the folio.  Do not use.
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
@@ -330,7 +332,7 @@ struct folio {
 			unsigned int _folio_nr_pages;
 #endif
 		};
-		struct page page_1;
+		struct page __page_1;
 	};
 	union {
 		struct {
@@ -341,7 +343,7 @@ struct folio {
 			void *_hugetlb_cgroup_rsvd;
 			void *_hugetlb_hwpoison;
 		};
-		struct page page_2;
+		struct page __page_2;
 	};
 };
 
-- 
2.35.3

