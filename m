Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE06560A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiLZHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiLZHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:09:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739EE2626
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:09:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso7116368wmo.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2F81c9AgLyck1wSShCjUojXRC7u44cFLH6IR6oWmN4=;
        b=F4i0E9Wu0NYud28tdJXiEWfYSh10GD22IJXdzIrA/XakhY5Iy9YwrPJDCCKplhFIJM
         UpKqvP2hYOs4H2MRo+xIrANw3FVpLZB3h1Zs2ur8QtHr4IOhP9pD/eMWEgPjUFr/oC2e
         NiQ6eHvO8KfOOv2KdvU44EiLEpNwn1Bx698xA316j4lVjoXs9QuraRsCpkJx/TmYyjKL
         b5qKRX5nyf2FaaPrbtRz/Gl64Pfc3BGxJyU0JncF5xHxdqGlfhGMBpAF4CmeODFz8nRB
         Ub8b07H0VeAnLMipDxeLl7XNrk4T45Qqcf7J/nbXJs8CpDlxBlRlFDgt8pwbT+X3XJvP
         kl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2F81c9AgLyck1wSShCjUojXRC7u44cFLH6IR6oWmN4=;
        b=OvGLaIng9C7VHPfFFOx8I+qjQ740gqFavBG8Uza6NTTixqFMjuu1jkM2/oF+KneLmf
         S3ExUs9BK+eMnw10KQma27ejitoT939qkRcvHw8OncIGaaKMLO1L15luC4pCsTptCdRZ
         /DRrAVc1bDeetoVmifFE5eMhJvwyeXklm3nyzisKJ1OdAMPrr3dn9BQatQ/U8O93jUKm
         +qrF+F/cPDW93XMWd+sqFMb2YtVvS+Xl2XeAgUGU+bSxncklZaFBey1HeRpDeHLaE8o/
         jAo5xDD5XpFp0LTRiWQ0TGuyLjI8TtSGida5JGUWSDqhDKe/AqIFBc1gLoRCPAz1VtpQ
         tTKA==
X-Gm-Message-State: AFqh2kpZj+cjZmrUbq1FYrj/GTUiCJMM7TNEsOT4DFvCaYN/6/VO8nFT
        cqYNi6shogqG/68UcXMsnKc=
X-Google-Smtp-Source: AMrXdXvZCSVjc3Yf5QlYu7hAnys5nckvEYVgPo1bv5CypB6+nBC4XDwiD7UyHjoPk9yO9Qq54Pid/g==
X-Received: by 2002:a05:600c:378c:b0:3d2:1f10:3318 with SMTP id o12-20020a05600c378c00b003d21f103318mr15193927wmr.31.1672038539911;
        Sun, 25 Dec 2022 23:08:59 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm13191456wmq.44.2022.12.25.23.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 23:08:59 -0800 (PST)
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
Subject: [PATCH v2 4/4] Documentation/mm: Update references to __m[un]lock_page() to *_folio()
Date:   Mon, 26 Dec 2022 07:08:47 +0000
Message-Id: <54006f75cb3c03b98e5a3d0968294db8c6889089.1672038314.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672038314.git.lstoakes@gmail.com>
References: <cover.1672038314.git.lstoakes@gmail.com>
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

