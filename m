Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D59608BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJVKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJVKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:41:13 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3AB1974E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:58:57 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id s28so3525024vsr.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8fM6rYJPNHtl4EjJzSXNeXO5m5rruppxnLzFbil+25o=;
        b=m568v2h1e+k+xKMACAwemU+yZ9FKevprFt2xlnViXK6+xUsUAvsnkPuCPi1XQrZiE+
         kwUs24/peh1N7SVlVAaJMh1TElGe8oZj6LdUVmGhoxnU42v2MAmkOV0T4JGfwd9hgMou
         IIOhlVUskbFnIde6S8sxXXuyiFckkVph6qfV2w0SGmwU+3BVDQrDELibPrlErnuKu054
         dh5RUdRXBCU3rjzdyw52KKLhIY5pc8tebznqFMKUzmEGcG+mzYm9EMztYqI/Zd9Q0nW9
         R0MVUeAJEA37qVBSzv5mqKgFyQc68OFZWYnGb4qSJ8PbRLGWpDcw8p0/z3NVD0z1i5sw
         sjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fM6rYJPNHtl4EjJzSXNeXO5m5rruppxnLzFbil+25o=;
        b=cE63OK4fUepkWDQ8piWn/ZLU4lcqSTmHV/GSgXU53OHYsLTDNjrGDiEx3WAxoZnnX/
         kEWNpViqXKy92LYi2367ZEVcmkd7MdcRFtisDMLlSKxHlFlKsAbY3M8zOCKvO3uX+ftl
         dJmy9MEg6QQQkSEl6yX5phWeTsuTjlOecwuS8BY9s2dDkITKTynoQdE4FGBT0drndYvN
         XAGXQuQcvMQS3o4jjzSeJhmBW71gDR7pC8j+Z3xWg+57MghcQhtHtpXKFeKUuDf89RwE
         ZV4w46eqoLS4yczYJ6e1OSrIxC38j0EPHBex/0uK1QmC8iMY47x+8i6sM4DFb16WyNrc
         CzdA==
X-Gm-Message-State: ACrzQf2XVizBVfD75Yx0SolHtJY46uSR4WsnpSRzKqFg3LqX3NdL6Qyk
        GJkD5zZCQomjSYhZeXAG3OmJE2JAXGLTsw==
X-Google-Smtp-Source: AMsMyM6wmhxMptBt3To5V35JYpDTyqYtGurH0UUxxG6yNTnj82CeT9yuzql9V3kkcvhrmrFhvX6crw==
X-Received: by 2002:a0c:a79a:0:b0:4b1:ca99:177 with SMTP id v26-20020a0ca79a000000b004b1ca990177mr19460750qva.34.1666425077057;
        Sat, 22 Oct 2022 00:51:17 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006eed75805a2sm11420398qkp.126.2022.10.22.00.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 00:51:16 -0700 (PDT)
Date:   Sat, 22 Oct 2022 00:51:06 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: prep_compound_tail() clear page->private
Message-ID: <1c4233bb-4e4d-5969-fbd4-96604268a285@google.com>
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

Although page allocation always clears page->private in the first page
or head page of an allocation, it has never made a point of clearing
page->private in the tails (though 0 is often what is already there).

But now commit 71e2d666ef85 ("mm/huge_memory: do not clobber swp_entry_t
during THP split") issues a warning when page_tail->private is found to
be non-0 (unless it's swapcache).

Change that warning to dump page_tail (which also dumps head), instead
of just the head: so far we have seen dead000000000122, dead000000000003,
dead000000000001 or 0000000000000002 in the raw output for tail private.

We could just delete the warning, but today's consensus appears to want
page->private to be 0, unless there's a good reason for it to be set:
so now clear it in prep_compound_tail() (more general than just for THP;
but not for high order allocation, which makes no pass down the tails).

Fixes: 71e2d666ef85 ("mm/huge_memory: do not clobber swp_entry_t during THP split")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
---
 mm/huge_memory.c | 2 +-
 mm/page_alloc.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 03fc7e5edf07..561a42567477 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2462,7 +2462,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	 * Fix up and warn once if private is unexpectedly set.
 	 */
 	if (!folio_test_swapcache(page_folio(head))) {
-		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, head);
+		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
 		page_tail->private = 0;
 	}
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5a6c815ae28..218b28ee49ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -807,6 +807,7 @@ static void prep_compound_tail(struct page *head, int tail_idx)
 
 	p->mapping = TAIL_MAPPING;
 	set_compound_head(p, head);
+	set_page_private(p, 0);
 }
 
 void prep_compound_page(struct page *page, unsigned int order)
-- 
2.35.3
