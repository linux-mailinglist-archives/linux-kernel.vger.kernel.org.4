Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41E6998EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjBPPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjBPPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:31:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432E3773F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676561470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K37os/T782c+Ji/0fbHlVEJWHAsVkYLkQoth8fPzQm4=;
        b=En86V+lIJBnNG2eualRlQwLIxNbWA8cxZWV9N0yKntGN+0Uy0DSXJlcBFSwS8uYcDZD4eR
        NCvs+U2w1l/2YU74IP/7psSCRdcoMR6thKAsC4LP9L+EDQeBWWto07U/+7j9eY4algne5y
        UpuZ+N1oKNoy3ZQWoJZXwewYz+lmU8A=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-_cr6QjY4OfS9V633-bZIFA-1; Thu, 16 Feb 2023 10:31:07 -0500
X-MC-Unique: _cr6QjY4OfS9V633-bZIFA-1
Received: by mail-il1-f200.google.com with SMTP id j6-20020a056e02014600b003155e564964so1466559ilr.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K37os/T782c+Ji/0fbHlVEJWHAsVkYLkQoth8fPzQm4=;
        b=L9F8HY+YCgrL4MZQkgVuI84U81EUJeZv2vmuQvmtmiCdngFCWxbavgy16DSJbzV3cO
         rbrRQaAVqJ3DuT6H5aM8HE1M4IywcSid7KNyb9pL27/v1z0c+OJuGX0vwNqcoAgbKXUX
         JojGJwL4/ar5cne42/68LWz+Px/GKAbvdEiM/6U5VvNlZDxFgBS/njWc92FDjYvjSHEU
         RUVlD2L11mzKQfrTzf9PjDMGOwh8MOKUrUALnLC9NV8YlZo0QvKsJk+mA7wKyXLhBh21
         xQZJTR+6G7NhtEa/uoFuERyo+uDMznq5zolUulih3KwaZXcwTeg/JXyFKi2Vo35yTH+b
         Xisw==
X-Gm-Message-State: AO0yUKWBupXhmnsMm5uAhsJJFZqXF1aSJxKUPBf/uevA2F9gRP9/oufE
        wOFnVIIYZ4tibVyVdBBiTk5WpnlXjj9iy0TB94n8z7bx455ZYmokwIsY9qalJcayL2LP+AIvRkg
        lUeuBKUoT8CK+Mar1yUWTeKpPSm1MFZdEzmhSJqYTA5Au2EPU23yE3O5w+CyIdrOF7PmS6fP+Zb
        B47gA=
X-Received: by 2002:a05:6e02:1d0b:b0:315:29e8:6ef3 with SMTP id i11-20020a056e021d0b00b0031529e86ef3mr5031467ila.2.1676561465905;
        Thu, 16 Feb 2023 07:31:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/LlCcmK92UMfUs1F3JlPSX2iMzBZGJEL2IhKoQ8a21cfzcIzZTZ385IxNhGrfa0Mp8d7Jo9Q==
X-Received: by 2002:a05:6e02:1d0b:b0:315:29e8:6ef3 with SMTP id i11-20020a056e021d0b00b0031529e86ef3mr5031443ila.2.1676561465541;
        Thu, 16 Feb 2023 07:31:05 -0800 (PST)
Received: from x1n.redhat.com ([70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x11-20020a92060b000000b0031559a28169sm514793ilg.65.2023.02.16.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:31:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        regressions@leemhuis.info, Nick Bowler <nbowler@draconx.ca>
Subject: [PATCH] mm/migrate: Fix wrongly apply write bit after mkdirty on sparc64
Date:   Thu, 16 Feb 2023 10:30:59 -0500
Message-Id: <20230216153059.256739-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Bowler reported another sparc64 breakage after the young/dirty
persistent work for page migration (per "Link:" below).  That's after a
similar report [2].

It turns out page migration was overlooked, and it wasn't failing before
because page migration was not enabled in the initial report test environment.

David proposed another way [2] to fix this from sparc64 side, but that
patch didn't land somehow.  Neither did I check whether there's any other
arch that has similar issues.

Let's fix it for now as simple as moving the write bit handling to be after
dirty, like what we did before.

Note: this is based on mm-unstable, because the breakage was since 6.1 and
we're at a very late stage of 6.2 (-rc8), so I assume for this specific
case we should target this at 6.3.

[1] https://lore.kernel.org/all/20221021160603.GA23307@u164.east.ru/
[2] https://lore.kernel.org/all/20221212130213.136267-1-david@redhat.com/

Cc: regressions@leemhuis.info
Fixes: 2e3468778dbe ("mm: remember young/dirty bit for page migrations")
Link: https://lore.kernel.org/all/CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com/
Reported-by: Nick Bowler <nbowler@draconx.ca>
Tested-by: Nick Bowler <nbowler@draconx.ca>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 6 ++++--
 mm/migrate.c     | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1343a7d88299..4fc43859e59a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3274,8 +3274,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	pmde = mk_huge_pmd(new, READ_ONCE(vma->vm_page_prot));
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
-	if (is_writable_migration_entry(entry))
-		pmde = maybe_pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
 	if (!is_migration_entry_young(entry))
@@ -3283,6 +3281,10 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	/* NOTE: this may contain setting soft-dirty on some archs */
 	if (PageDirty(new) && is_migration_entry_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
+	if (is_writable_migration_entry(entry))
+		pmde = maybe_pmd_mkwrite(pmde, vma);
+	else
+		pmde = pmd_wrprotect(pmde);
 
 	if (PageAnon(new)) {
 		rmap_t rmap_flags = RMAP_COMPOUND;
diff --git a/mm/migrate.c b/mm/migrate.c
index ef68a1aff35c..40c63e77e91f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -225,6 +225,8 @@ static bool remove_migration_pte(struct folio *folio,
 			pte = maybe_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(*pvmw.pte))
 			pte = pte_mkuffd_wp(pte);
+		else
+			pte = pte_wrprotect(pte);
 
 		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
-- 
2.39.1

