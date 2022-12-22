Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020236546E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiLVTtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVTsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:48:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FAC183AC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i7so2681195wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2F81c9AgLyck1wSShCjUojXRC7u44cFLH6IR6oWmN4=;
        b=kSlZyEuZcFe3XKq6gnldT7ZyYLU+Awg8l/XPuFUO6xWtYw2ql8CF2LrYCXZh+rLhpa
         5AxuhZlgHyNYEFINeAHMf5n203LqWTNZnbPtsuL1cCbkHKpI/jcw7ADkXOCsfPfoyT2N
         5Oz1QSJ0EFDUDuFRZQdw4VKokCQwLWCPmIjb76j42aHzWO13v65n6CUhnmHQ/jcj8pVW
         lI+Y9QO/g+vozwln/Eiq+pDvUEk86SJxIjVd3UUrCrRJdP3RbXSNo3nRqNm3CiDxZ5eO
         /829JKee1x2sONrCsGazWVX92jRgfQiH3jq76ofawUgUnCgeXLgzC3ERx62TFVQ602hc
         LkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2F81c9AgLyck1wSShCjUojXRC7u44cFLH6IR6oWmN4=;
        b=nNb2+j3R9y1KPZi3eJZvGk4Hu3P8J4fGMGdIlMKlLiSyBHromG5SRdQ2PTst1EcML+
         VaIMhbnz0oTfrja6XmSQMLLw38YbfRPOmKLH2qscCXD+agf/dcVgIEWeYR1Fsj/QfDVr
         deYr4hoMjeAY5gRFNwWS7lTKENYvuznBrDpyux3bLwfK4+Cf2qxKL2jRYEk91C/tI9dh
         XHLW5y9O443T2fCuUwbtv7c5mcUygT006RXK/B5uk3nlB639Onn6EF7fCLuNnAR7MT6R
         vf8UbKy/JXNUSMQVGb8nOu53rhl0+vYeulJIywKdtGUjGF7JemgjicwFWznHmA6pRtaZ
         RwbQ==
X-Gm-Message-State: AFqh2kodqP5cC14hDd5j9OZTNzgCF7gYa+Z2vUaaiD+G8gmnYnI0zkM7
        /UW8PCc0p2Zt6UVZna/jt2o=
X-Google-Smtp-Source: AMrXdXspmFuBlfR7gc2dyZfjSGXzAUYJQsYI7d+BPRPXgeycabrEGMA3kSnSuTF+GM0HYPE8veGWIg==
X-Received: by 2002:a5d:61ce:0:b0:242:fd7:285c with SMTP id q14-20020a5d61ce000000b002420fd7285cmr4337447wrv.48.1671738525359;
        Thu, 22 Dec 2022 11:48:45 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id i1-20020adfb641000000b002425787c5easm1349317wre.96.2022.12.22.11.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:48:44 -0800 (PST)
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
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 4/4] Documentation/mm: Update references to __m[un]lock_page() to *_folio()
Date:   Thu, 22 Dec 2022 19:48:33 +0000
Message-Id: <c0d134f9ef47d803d27c08e347e5133227ca07bf.1671738120.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671738120.git.lstoakes@gmail.com>
References: <cover.1671738120.git.lstoakes@gmail.com>
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

