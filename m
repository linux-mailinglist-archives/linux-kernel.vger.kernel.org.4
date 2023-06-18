Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB53734530
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjFRG6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjFRG6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:58:38 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C141707
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517bad1b8c5so1961895a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687071507; x=1689663507;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h9MkEXCOECVy+F9lVXmcJqM8lpLvl13EAFxuWhnTpvI=;
        b=Jmn08JRk9haBdTN7W4jKc018AW8wTh5/Vt4hWrG22Ce5WHHa5gH8+MFIzo5RR/XZDq
         /W6Qm/trFt2lkCHmg+/8aK4c3BVvqvUZGoipdn0DwQhEJG0zDsVcqfnYXrvXqWqFMSwB
         cD5AXD9nnEOim2ftXAtIhqlPxnHlllsa63199K3JNAxq5hr4CMKl6vYbDBMBcYoqGoJI
         TojGOAjg6KS0exeu21OEEbX34hPDKOcGV9jJ6KSr7JDko1JBsl94JVx3mVI4VmF+a4zE
         hOk3HCxA72ztJwA4CdUKzWKxOVZY+VQuQRRxrmIiJ5l2lm8iS7CGxZY5s5RVjVkMk7B+
         4BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687071507; x=1689663507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9MkEXCOECVy+F9lVXmcJqM8lpLvl13EAFxuWhnTpvI=;
        b=D8YxhZZllbc6hhbY9GL6VSt/PWsPqex6+wQUbLUeoVlcZoxJXbWLgEP0H7vMs3fg9V
         qx/lIjYNafpyPjruMuTLKYXKHXQ3iqznSDJNUlIK+oC2ulztZopCgjKjbjQz2IKadfMg
         4EHy8xUKW5sCkHVpIY5j4ip+YUihNwMEahh7INDR0pO/olbnqE1wO+GcHoKvZ1eS6ux3
         6TC35oWTH8/mINhbSzg8IRJBmgKsOXEYAna9G8XL9dwaCyxPE+kgtLU2ac8iwApHkFN+
         fQG07QZYwXnYYgp7dNKfdn/Tr2x1HzGDg3x+sUTTw7831g02S5saPcn6z2+GAVsvUOB+
         hNdQ==
X-Gm-Message-State: AC+VfDwGmG23Nut34LTWvUDqAfFfAYtyk3WJUUae2KRlmRfsd5kngW1n
        TWTS4OSLBVTfC0FO+bZVXD5IxcXfHIw2WQNu
X-Google-Smtp-Source: ACHHUZ5g3uocw1m2bEK5IzJLclvW8dC8mH9S0Bf7aD9hPOQWtWFYCu24N61BbV7x9G/xqeRMh6De5y2vc+vaUIqs
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:f106:0:b0:53f:2d21:5a16 with SMTP
 id f6-20020a63f106000000b0053f2d215a16mr450864pgi.10.1687071507411; Sat, 17
 Jun 2023 23:58:27 -0700 (PDT)
Date:   Sun, 18 Jun 2023 06:58:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618065824.1365750-1-yosryahmed@google.com>
Subject: [RFC PATCH 5/5] Revert "mm/migrate: __unmap_and_move() push good
 newpage to LRU"
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c3096e6782b733158bf34f6bbb4567808d4e0740.

That commit made sure we immediately add the new page to the LRU before
remove_migration_ptes() is called in migrate_move_folio() (used to be
__unmap_and_move() back then), such that the rmap walk will rebuild the
correct mlock_count for the page again. This was needed because the
mlock_count was lost when the page is isolated. This is no longer the
case since mlock_count no longer overlays page->lru.

Revert the commit (the code was foliated afterward the commit, so the
revert is updated as such).

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/migrate.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..68f693731865 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1279,19 +1279,6 @@ static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
 	if (unlikely(!is_lru))
 		goto out_unlock_both;
 
-	/*
-	 * When successful, push dst to LRU immediately: so that if it
-	 * turns out to be an mlocked page, remove_migration_ptes() will
-	 * automatically build up the correct dst->mlock_count for it.
-	 *
-	 * We would like to do something similar for the old page, when
-	 * unsuccessful, and other cases when a page has been temporarily
-	 * isolated from the unevictable LRU: but this case is the easiest.
-	 */
-	folio_add_lru(dst);
-	if (page_was_mapped)
-		lru_add_drain();
-
 	if (page_was_mapped)
 		remove_migration_ptes(src, dst, false);
 
@@ -1301,9 +1288,16 @@ static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
 	/*
 	 * If migration is successful, decrease refcount of dst,
 	 * which will not free the page because new page owner increased
-	 * refcounter.
+	 * refcounter. As well, if it is LRU folio, add the folio to LRU
+	 * list in here. Use the old state of the isolated source folio to
+	 * determine if we migrated a LRU folio. dst was already unlocked
+	 * and possibly modified by its owner - don't rely on the folio
+	 * state.
 	 */
-	folio_put(dst);
+	if (unlikely(!is_lru))
+		folio_put(dst);
+	else
+		folio_putback_lru(dst);
 
 	/*
 	 * A folio that has been migrated has all references removed
-- 
2.41.0.162.gfafddb0af9-goog

