Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5447073D31D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjFYTGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:06:37 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA79D1B3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:06:36 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5702116762fso27514147b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687719996; x=1690311996;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Imw9X6zO34JjN9/hKCePWCCRVn8bd8VU2k+bw1pFsBY=;
        b=k0/k1JwK2I3rzmS6zsa8hs0DxsZ/c8e4V4QnWNy0m/Q1BWMWLzfje6V3jr8Bvt5p5Y
         e9ifeimyb87A1h/0bK9pEamuzOZjkDSvDiKufwIHjesj45xp/aciV4VSvuT5DpIVa8Hl
         MKD4NqEMtMHaUVzlcqzXR7gekm1N1WJ67wOMI5TFB6ibeGiKgyI1fRyQcLKQaOZuwJHX
         429zmtl+ycmVsZ9C1qiyyLO6v2UwYEVMSMdyLjq0WcaA3rWg2DpwF65oznvKuD7Ikj1p
         H1qC8nGdH2lAHFxs8hG1KCS8WrmCgLHQD4gkilLz1sB9sQLIq32EHSObFA4IyaDOFWGY
         j5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687719996; x=1690311996;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imw9X6zO34JjN9/hKCePWCCRVn8bd8VU2k+bw1pFsBY=;
        b=a76lMdAomL2olBrxUWl/YW9Pcr0sErzCsDUZS+DBt/y5HX+L2/TdPAaTxKEdO6zx4P
         2v474ZgkWCfvAaxH0SgYJRcF/4ws5MHvElm5+FdIVIqFUr8+t3BfFQmpQzD2+2XGQQC5
         5UIdJmONGiKyeaZ5w8tbBX+TjfQbwSa+mR1sG3QseLfH0nSp4vB7e7Wh8GhkKq16Kzgd
         TQAIN+jgXiwk1SkdfOKg5xWjaaYAvc6kLNlNEylvlDXN4ytcmHzwRmkJPTR+QEPdO/r0
         RyQs+gMF4vpWo55SNVFM17MNe11I7dImFJYlmPTEc/bSQ1RSZEZyLjthGRnRm3LKpe2j
         MR1A==
X-Gm-Message-State: AC+VfDwZ+0r5Xo+nOZtBUThBtSBYW4uW87fvKJNgl4TOI9dBoS9LMzut
        e9WDPMS53ZeyFxmRpBcdFVqJKA==
X-Google-Smtp-Source: ACHHUZ6cMg1cmp1S9/7uKdhrCgUWhiY1OzAu6tDhk0Km5hJSweQoA7h/09Dzoy8xoEkANktpglIuEg==
X-Received: by 2002:a81:a115:0:b0:570:6654:68c8 with SMTP id y21-20020a81a115000000b00570665468c8mr25968000ywg.1.1687719995799;
        Sun, 25 Jun 2023 12:06:35 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p79-20020a0de652000000b00573a2a0808esm930818ywe.77.2023.06.25.12.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 12:06:35 -0700 (PDT)
Date:   Sun, 25 Jun 2023 12:06:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     David Stevens <stevensd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/khugepaged: fix regression in collapse_file()
In-Reply-To: <8ef3ee-ba41-8e9e-4453-73736ff27783@google.com>
Message-ID: <df5819aa-c79-6b10-4ce1-a45af118c0f3@google.com>
References: <20230607053135.2087354-1-stevensd@google.com> <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com> <CAD=HUj4vVbyHiT7vPmRorS+v9t2+N46ak=Xrew2cFf5+utC=tQ@mail.gmail.com> <8ef3ee-ba41-8e9e-4453-73736ff27783@google.com>
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

There is no xas_pause(&xas) in collapse_file()'s main loop, at the points
where it does xas_unlock_irq(&xas) and then continues.

That would explain why, once two weeks ago and twice yesterday, I have
hit the VM_BUG_ON_PAGE(page != xas_load(&xas), page) since "mm/khugepaged:
fix iteration in collapse_file" removed the xas_set(&xas, index) just
before it: xas.xa_node could be left pointing to a stale node, if there
was concurrent activity on the file which transformed its xarray.

I tried inserting xas_pause()s, but then even bootup crashed on that
VM_BUG_ON_PAGE(): there appears to be a subtle "nextness" implicit in
xas_pause().

xas_next() and xas_pause() are good for use in simple loops, but not in
this one: xas_set() worked well until now, so use xas_set(&xas, index)
explicitly at the head of the loop; and change that VM_BUG_ON_PAGE() not
to need its own xas_set(), and not to interfere with the xa_state (which
would probably stop the crashes from xas_pause(), but I trust that less).

Link: https://lore.kernel.org/linux-mm/f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com/
Fixes: c8a8f3b4a95a ("mm/khugepaged: fix iteration in collapse_file")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
Linus, I'm rushing this directly to you, but not really expecting you
to put it in at this stage, unless you're very comfortable with it,
or perhaps it catches Matthew's eye and gets a quick Ack from him.

The commit being fixed only got in after -rc7, after being held up by my
initial report of this crash; but I had to rescind that when I couldn't
reproduce it at all. Then yesterday morning it hit again on two machines,
and reading XArray Doc reminded me of xas_pause() - seems obvious now.
Patch ran for 14 hours overnight on those two machines without a problem.

 mm/khugepaged.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2d0d58fb4e7f..47b59f2843f6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1918,9 +1918,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 	} while (1);
 
-	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
-		page = xas_next(&xas);
+		xas_set(&xas, index);
+		page = xas_load(&xas);
 
 		VM_BUG_ON(index != xas.xa_index);
 		if (is_shmem) {
@@ -1935,7 +1935,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 						result = SCAN_TRUNCATED;
 						goto xa_locked;
 					}
-					xas_set(&xas, index + 1);
 				}
 				if (!shmem_charge(mapping->host, 1)) {
 					result = SCAN_FAIL;
@@ -2071,7 +2070,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 
 		xas_lock_irq(&xas);
 
-		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
+		VM_BUG_ON_PAGE(page != xa_load(xas.xa, index), page);
 
 		/*
 		 * We control three references to the page:
-- 
2.35.3

