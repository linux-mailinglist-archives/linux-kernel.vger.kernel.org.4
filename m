Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A003695B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBNH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjBNH5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:57:20 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EBA618B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:57:19 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id o8so13850540pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7DfH1WNOVf4t8XjgAEqyor0ieXU0nLmep1VXk+2LuQ=;
        b=JgLu+1vtOkmwsCN3mtGKQep0/DC4S+kayR7D5/h/M9mQWoDn55NSl/pxsmy26Q0iv0
         mZ+yyHegrQKSXmMrSflFTPdrdXHSB97v+65nUUnKidXISbycELbs6KX+KCL4NrJI8VzH
         MTDC30KzrUwl6T5WRf01DC/YAQkaz2oSKCCFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7DfH1WNOVf4t8XjgAEqyor0ieXU0nLmep1VXk+2LuQ=;
        b=RNudJ8vi6EdOiE6Toi8RqR5U5hDoBv4lUwuJhH0PxHY2cC4Vs7i6SSwAVrNla4YiGV
         RfKY+ZKy1xn3ROPwW6WQmY2L8zhC0CqJg/bpRBvH5cmAj+PYozjBkKNAk7Sld+oBeesM
         YytgW8vRWWCSXDtdR0ZgDHtR7D4jZ4Y8G+9cBfdXNyWZhc8lm+sUBirEnMM47YMAx6Cu
         J2Khj9xnTYAb8EdsFDE9X8j/YMfRbY6UORP2y7R/Ec3MgMY2fL6x9I/BT1rrAl10gBSv
         vpoJ7P9WBRv7HNqWEac21L4qj1kjT2C9t0OV4NKj8+lkMF+++1Eb5AIVbQOhQul9esBt
         vLgg==
X-Gm-Message-State: AO0yUKUdWh1349ui5c3pmj2mJ/4+/+wCv0ERIjHMSt97G0pwpMF1CePs
        fZ0+1f/pty9Ea61s5XZ60TSkrw==
X-Google-Smtp-Source: AK7set/nm9XIjLUEwnIUiUfsvq5VxOiZljHMLnHXN1Qe4ILFHTpFYXB0qtXRVUOZTIZdGK5qE4uh0g==
X-Received: by 2002:a17:902:d489:b0:198:e63d:9a4f with SMTP id c9-20020a170902d48900b00198e63d9a4fmr2053058plg.47.1676361439221;
        Mon, 13 Feb 2023 23:57:19 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:45f7:92a0:f546:300f])
        by smtp.gmail.com with UTF8SMTPSA id i6-20020a170902eb4600b0019a7c890c61sm2981446pli.252.2023.02.13.23.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:57:18 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH 1/2] mm/khugepaged: set THP as uptodate earlier for shmem
Date:   Tue, 14 Feb 2023 16:57:09 +0900
Message-Id: <20230214075710.2401855-1-stevensd@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

In collapse_file, mark the THP as up-to-date before inserting it into
the page cache. This fixes a race where folio_seek_hole_data would
mistake the THP for an fallocated but unwritten page. This race is
visible to userspace via data temporarily disappearing from
SEEK_DATA/SEEK_HOLE, which can cause data loss for applications that use
lseek to efficiently snapshot sparse shmem.

Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 mm/khugepaged.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 79be13133322..b648f1053d95 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1779,10 +1779,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	hpage->mapping = mapping;
 
 	/*
-	 * At this point the hpage is locked and not up-to-date.
-	 * It's safe to insert it into the page cache, because nobody would
-	 * be able to map it or use it in another way until we unlock it.
+	 * Mark hpage as up-to-date before inserting it into the page cache to
+	 * prevent it from being mistaken for an fallocated but unwritten page.
+	 * Inserting the unfinished hpage into the page cache is safe because
+	 * it is locked, so nobody can map it or use it in another way until we
+	 * unlock it.
 	 */
+	SetPageUptodate(hpage);
 
 	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
-- 
2.39.1.581.gbfd45094c4-goog

