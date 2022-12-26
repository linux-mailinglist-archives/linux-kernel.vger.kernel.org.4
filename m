Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87FD65613C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiLZIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiLZIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:44:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574ABC1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d4so1570384wrw.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2F81c9AgLyck1wSShCjUojXRC7u44cFLH6IR6oWmN4=;
        b=Luutk8sTmkcPaV2HE6ZSm09yMDd6aFg37OB1rbF+z6MNMKyYZIy2EhVaJ8oIYCBjnB
         B2oixh9MFvf2UtOfNsPSuzO8f2ANjFTV351U8BHT/q5eP9Ez5aZX9Ye4Kes1fANH3IBw
         mY+LkVCPLJc7lShfS6oBJIYoYmg3vR5HaJLNL+Sg7dcIOIZ12GPP0t4NBD7Lhd8jDYUg
         FISQC4Bl8cJoalEFXhStA10T82XA5bxFIr2Tg/leWqa0KvSgdTOyhzfSKJU1cWfwPZmM
         hhqvoAJ7NSgYcTdwT7BF25IR2P/c8k7I5HPpbw7bVTOqkOOn7yAeEmhIk7lf5Q8hRHuD
         KnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2F81c9AgLyck1wSShCjUojXRC7u44cFLH6IR6oWmN4=;
        b=F0EzqQ9Cejgv/A8pu7NNtpHwPdMPCIAoPJjYNAsvy/RIVwTv5Z3YPe3VIdN9LT4IVs
         Pm7SjbYWq26qDQ/Wygc+RRZij2IUrn9SpeKyn+1zGOBUoXC+xL9HABPXbuw4F8ObsTdk
         zxMXCvZFmYtti1Ro9+Y6IVMur7/PWToLrL04nx2B+J3fBvQVqadfnqIg6AGQKdtlD1f7
         75moH/xuC2RnKHABe2QCvCa9mqpEN5C7p7WExwOYWLieSWmBeKkSSZ9exqBJq3AkZRTd
         grGOhwSqAnqXb0u83mFDiEQ5qbqRJ5wBYN0wQdVjLfnYqWIb740eYKZWg10lbQ3GSbwu
         MhzA==
X-Gm-Message-State: AFqh2kp7AjjL8I/NHGwmkXXesfb9yjyRCzNpqvug68PDoupVzl+Lg716
        GkVmluJccJVtbSB6kAk7apk=
X-Google-Smtp-Source: AMrXdXssR55KbgMxEr7dJwad4zliU0tQ0fJwRlDzhgMpGzuioR1wo/Z5xOzvgxOdHsStnOtIPiN1VA==
X-Received: by 2002:a5d:65c4:0:b0:281:24c5:a533 with SMTP id e4-20020a5d65c4000000b0028124c5a533mr220616wrw.23.1672044273841;
        Mon, 26 Dec 2022 00:44:33 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm10593253wrs.82.2022.12.26.00.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 00:44:33 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 5/5] Documentation/mm: Update references to __m[un]lock_page() to *_folio()
Date:   Mon, 26 Dec 2022 08:44:23 +0000
Message-Id: <cf3c5615d98f4e690dad46b074933024b8469d37.1672043615.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672043615.git.lstoakes@gmail.com>
References: <cover.1672043615.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now pass folios to these functions, so update the documentation
accordingly.

Additionally, correct the outdated reference to __pagevec_lru_add_fn(), the
referenced action occurs in __munlock_folio() directly now.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 Documentation/mm/unevictable-lru.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 4a0e158aa9ce..153629e0c100 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -308,22 +308,22 @@ do end up getting faulted into this VM_LOCKED VMA, they will be handled in the
 fault path - which is also how mlock2()'s MLOCK_ONFAULT areas are handled.
 
 For each PTE (or PMD) being faulted into a VMA, the page add rmap function
-calls mlock_vma_page(), which calls mlock_page() when the VMA is VM_LOCKED
+calls mlock_vma_page(), which calls mlock_folio() when the VMA is VM_LOCKED
 (unless it is a PTE mapping of a part of a transparent huge page).  Or when
 it is a newly allocated anonymous page, lru_cache_add_inactive_or_unevictable()
-calls mlock_new_page() instead: similar to mlock_page(), but can make better
+calls mlock_new_folio() instead: similar to mlock_folio(), but can make better
 judgments, since this page is held exclusively and known not to be on LRU yet.
 
-mlock_page() sets PageMlocked immediately, then places the page on the CPU's
-mlock pagevec, to batch up the rest of the work to be done under lru_lock by
-__mlock_page().  __mlock_page() sets PageUnevictable, initializes mlock_count
+mlock_folio() sets PageMlocked immediately, then places the page on the CPU's
+mlock folio batch, to batch up the rest of the work to be done under lru_lock by
+__mlock_folio().  __mlock_folio() sets PageUnevictable, initializes mlock_count
 and moves the page to unevictable state ("the unevictable LRU", but with
 mlock_count in place of LRU threading).  Or if the page was already PageLRU
 and PageUnevictable and PageMlocked, it simply increments the mlock_count.
 
 But in practice that may not work ideally: the page may not yet be on an LRU, or
 it may have been temporarily isolated from LRU.  In such cases the mlock_count
-field cannot be touched, but will be set to 0 later when __pagevec_lru_add_fn()
+field cannot be touched, but will be set to 0 later when __munlock_folio()
 returns the page to "LRU".  Races prohibit mlock_count from being set to 1 then:
 rather than risk stranding a page indefinitely as unevictable, always err with
 mlock_count on the low side, so that when munlocked the page will be rescued to
-- 
2.39.0

