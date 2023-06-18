Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFC73452F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFRG6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFRG6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:58:33 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3783E199F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:21 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666edb72db2so525021b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687071501; x=1689663501;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YwXvQVSaypElesS3BE3qysx5jmIbVwSYC6z5eyt8hE4=;
        b=zOwV/CaHWAn0TdbeDv0YfetFHRqhjLbNtZofZk8gp1jhdDbApFYwHWaoGhfGloU8t/
         ctAcxIf0+30pNej07lmQ6104qhnz655nV+5zO6qi9UaMQMboL93K3xQAOKbTh0qcXfl/
         P09cWxqA2MK8VXEwo8LNT6A51QrppTROyxHRMUQFGJG6bHXe3KtwKdaPWg/jzyZxx6YD
         aCddrawGZdXnqKrbBY9qI0k68VFyjmbA4lyB+fCnMkH9IzjnjE9A9xiPEkbrWKosrxjF
         Fgyv7OpKDc1wOIhAVWrCmDBwHFHKObEurJqiCKO2a33jGe1yoE8KeFMDSuxwH8vwhDb9
         RB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687071501; x=1689663501;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YwXvQVSaypElesS3BE3qysx5jmIbVwSYC6z5eyt8hE4=;
        b=eajPJSzLlfk+1JVMYxvJTsTLNU/oEM5pPRZceq93IKoZHXiAB+m3tXijtmB9x/j/NW
         n8iVgYnzHA9x+IgG4zP41hadvx7yfzHtyafAtwMxUMFWb+OtGup6xwAlwSxExiZ6s26W
         k0Q3eoyqqpMjGyIOP+2bC19Ui/5srMEL9r2VXAxzB7aU59Pg3EHqIMXbYVwz9mt4Op2I
         QTzDmIZeFN53YAZFN8te1rKpd22tTOLe0zlputEBHsIRjHTunQDg7iwvAPp5qYWbbGaS
         WPMx3nsv/1Y0lxCDddeO6/h/8TTLEe3+oF5DVc662iSp8VPAFNiJM5maMN0XkEWq2iHt
         iz4g==
X-Gm-Message-State: AC+VfDyOTGZM2gNZa620X/eHIhPuBaBvdFVl7HXv32bvoLbkH7P3hWXI
        Xl+f5LmA3krCrs0B5cyh6v7S3wikcsDmPPng
X-Google-Smtp-Source: ACHHUZ53HYo999vjmhrDC3s4hj57OygGWtz6Njl0zOWvVSrpTvDyQH1suL+U7VFBl2xQC7vNyDLGLfbC/tTModWT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:aa7:8882:0:b0:652:b76e:43d2 with SMTP
 id z2-20020aa78882000000b00652b76e43d2mr1980763pfe.6.1687071500739; Sat, 17
 Jun 2023 23:58:20 -0700 (PDT)
Date:   Sun, 18 Jun 2023 06:58:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618065816.1365301-1-yosryahmed@google.com>
Subject: [RFC PATCH 4/5] mm/vmscan: revive the unevictable LRU
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

Now that mlock_count no longer overlays page->lru, revive the
unevictable LRU. No need to special case it when adding/removing a folio
to the LRUs. This also enables future work that will use the LRUs to
find all user folios charged to a memcg, having the unevictable LRU
makes sure we are not missing a significant chunk of those.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/mm_inline.h | 11 +++--------
 mm/huge_memory.c          |  3 +--
 mm/mmzone.c               |  8 --------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 0e1d239a882c..203b8db6b4a2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -319,8 +319,7 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
-	if (lru != LRU_UNEVICTABLE)
-		list_add(&folio->lru, &lruvec->lists[lru]);
+	list_add(&folio->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline void add_page_to_lru_list(struct page *page,
@@ -339,21 +338,17 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 
 	update_lru_size(lruvec, lru, folio_zonenum(folio),
 			folio_nr_pages(folio));
-	/* This is not expected to be used on LRU_UNEVICTABLE */
 	list_add_tail(&folio->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline
 void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
-	enum lru_list lru = folio_lru_list(folio);
-
 	if (lru_gen_del_folio(lruvec, folio, false))
 		return;
 
-	if (lru != LRU_UNEVICTABLE)
-		list_del(&folio->lru);
-	update_lru_size(lruvec, lru, folio_zonenum(folio),
+	list_del(&folio->lru);
+	update_lru_size(lruvec, folio_lru_list(folio), folio_zonenum(folio),
 			-folio_nr_pages(folio));
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e5b58ca603f..4aa2f4ad8da7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2407,8 +2407,7 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 	} else {
 		/* head is still on lru (and we have it frozen) */
 		VM_WARN_ON(!PageLRU(head));
-		if (!PageUnevictable(tail))
-			list_add_tail(&tail->lru, &head->lru);
+		list_add_tail(&tail->lru, &head->lru);
 		SetPageLRU(tail);
 	}
 }
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12d..7678177bd639 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -81,14 +81,6 @@ void lruvec_init(struct lruvec *lruvec)
 
 	for_each_lru(lru)
 		INIT_LIST_HEAD(&lruvec->lists[lru]);
-	/*
-	 * The "Unevictable LRU" is imaginary: though its size is maintained,
-	 * it is never scanned, and unevictable pages are not threaded on it
-	 * (so that their lru fields can be reused to hold mlock_count).
-	 * Poison its list head, so that any operations on it would crash.
-	 */
-	list_del(&lruvec->lists[LRU_UNEVICTABLE]);
-
 	lru_gen_init_lruvec(lruvec);
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

