Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29355665CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjAKNgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbjAKNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:35:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570051B1F7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:34:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t5so10624882wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXEe94MmZGPMMW6utG3JoRma4Dh+hLsL+OKzICtq6dg=;
        b=bXVlqB2gP77kS0Zl/TFPemwO0HjNUvFDjcGx/TeRf/IIOFf8hjTnjri6RfCObLxc/q
         bk3QmTlD0VHp/Yhya9QuhfNhk/opKk9NjxM4A6jmYKOBPq2NfJELaoLko76QUQf8bE1B
         Dhcsw2YpHArTlaVyPE+GvEBf/dUDzlhegkzTp3TvlfZr6HQrrUv1jzC2lqB7O08B96KN
         l2yT6L/HDj49qKe38WVtDyZfY56fqHeqvV7G4eMjEAlfMxnLouxYOOgW8A/r1c+XClPW
         Q5p1m8DM7Q9Vk4CqyZi/g0ooaiFaWEUarISBQ/hkfPvXTF6kESRcTAmnkt4vlfIMn7Dw
         XqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXEe94MmZGPMMW6utG3JoRma4Dh+hLsL+OKzICtq6dg=;
        b=hA1S16VHBCk6WWFbhAetXDYMhmPhdrFC/qJJseLQE7RFgTMPIUFGGPx+2WzjRUfMX8
         EY+y/p7b24fIBEnN1AgrJDnhtqb0gtEZEY3xkHx5A91CLfsuSTityvlUGBdFuSM9pYjz
         eQkLVW/LmChancXFN8H/BYqceknRB6yTq3N1SrsBifKzg8ryq/lgoV4tqLuIxd4t1Wl/
         YPmY+7LloG00iuOqcFnr/XmlOGqyDPfOrnYg3p6rreM7fhUH4bARjhuDtanIeQKaV2+D
         gENK+X81wIIwtn2QspV1WbQtIa6TWlGPQTcfb36HRkYw4HNYHRQTnxm2SrxqnWZVtRsM
         rtag==
X-Gm-Message-State: AFqh2ko5m1XYiBbmSEjbDeIqWHzV5QBk+6Ssq2VZWspXaDmZNWBL6YEz
        OZi+GRGE1akv7iITG+YtFARz/A==
X-Google-Smtp-Source: AMrXdXuOaYorv1fwEINO+93jyv0T6KFgMAJKO8yUaqNeYRqV2arOxo9P+BlA43e1sQiT1juu/H6llw==
X-Received: by 2002:a05:6000:1e0c:b0:2bb:e890:b9c8 with SMTP id bj12-20020a0560001e0c00b002bbe890b9c8mr211734wrb.1.1673444039159;
        Wed, 11 Jan 2023 05:33:59 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:89cb:eee6:2c:ec53])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d62cf000000b002bbedd60a9asm8187914wrv.77.2023.01.11.05.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:33:58 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH] mm/khugepaged: Fix ->anon_vma race
Date:   Wed, 11 Jan 2023 14:33:51 +0100
Message-Id: <20230111133351.807024-1-jannh@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
it to be locked. retract_page_tables() bails out if an ->anon_vma is
attached, but does this check before holding the mmap lock (as the comment
above the check explains).

If we racily merge an existing ->anon_vma (shared with a child process)
from a neighboring VMA, subsequent rmap traversals on pages belonging to
the child will be able to see the page tables that we are concurrently
removing while assuming that nothing else can access them.

Repeat the ->anon_vma check once we hold the mmap lock to ensure that there
really is no concurrent page table access.

Reported-by: Zach O'Keefe <zokeefe@google.com>
Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
zokeefe@ pointed out to me that the current code (after my last round of patches)
can hit a lockdep assert by racing, and after staring at it a bit I've
convinced myself that this is a real, preexisting bug.
(I haven't written a reproducer for it though. One way to hit it might be
something along the lines of:

 - set up a process A with a private-file-mapping VMA V1
 - let A fork() to create process B, thereby copying V1 in A to V1' in B
 - let B extend the end of V1'
 - let B put some anon pages into the extended part of V1'
 - let A map a new private-file-mapping VMA V2 directly behind V1, without
   an anon_vma
[race begins here]
  - in A's thread 1: begin retract_page_tables() on V2, run through first
    ->anon_vma check
  - in A's thread 2: run __anon_vma_prepare() on V2 and ensure that it
    merges the anon_vma of V1 (which implies V1 and V2 must be mapping the
    same file at compatible offsets)
  - in B: trigger rmap traversal on anon page in V1'

 mm/khugepaged.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5cb401aa2b9d..0bfed37f3a3b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1644,7 +1644,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 		 * has higher cost too. It would also probably require locking
 		 * the anon_vma.
 		 */
-		if (vma->anon_vma) {
+		if (READ_ONCE(vma->anon_vma)) {
 			result = SCAN_PAGE_ANON;
 			goto next;
 		}
@@ -1672,6 +1672,18 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 		result = SCAN_PTE_MAPPED_HUGEPAGE;
 		if ((cc->is_khugepaged || is_target) &&
 		    mmap_write_trylock(mm)) {
+			/*
+			 * Re-check whether we have an ->anon_vma, because
+			 * collapse_and_free_pmd() requires that either no
+			 * ->anon_vma exists or the anon_vma is locked.
+			 * We already checked ->anon_vma above, but that check
+			 * is racy because ->anon_vma can be populated under the
+			 * mmap lock in read mode.
+			 */
+			if (vma->anon_vma) {
+				result = SCAN_PAGE_ANON;
+				goto unlock_next;
+			}
 			/*
 			 * When a vma is registered with uffd-wp, we can't
 			 * recycle the pmd pgtable because there can be pte

base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
-- 
2.39.0.314.g84b9a713c41-goog

