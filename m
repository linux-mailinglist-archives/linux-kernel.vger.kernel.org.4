Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12251645049
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLGAWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLGAWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:22:14 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A470A4B98F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:22:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o12so16030329pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cFy10fUQvAp0c5CDE+pRKnURMHNPhPlaSgCKw+V2Qs=;
        b=YHl28cpdsLfmOjfipvqjWtXAOa0AMP8kDcueiJ2N/YI83AXK8AqWr/PutrLcLlXgWJ
         6+oMgPZlwTZh56uWh1rOpt8mEc1ZKR5Y0LX4C1FdfryzT1T1yTtNZ1my5/TzolFCJPGj
         8AMBoHbKNuHITSlPhfWgrrjoRrPaAkSr07h69DbLlVEoMAbBdKq5YyTT67xyp5jauvLQ
         imF0VJ4E31XeS909T0Ldb2JbgeDlNv45Jjr4N6f2BuVNBMf80lbVAcHnzhMKW4/Hcy3g
         3I6djJdxa4FDRbQumuumNsGYUIgLJxYdme/OkCtciK0AFWkjDy3HYydVxd6qwRzG52Av
         2EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cFy10fUQvAp0c5CDE+pRKnURMHNPhPlaSgCKw+V2Qs=;
        b=AUuZPhl+s2PdBAFnqDsjh+Het+Nrddl6L5o9uxzvEh6XP+uzhZXtCSC5KkXbRUsTL/
         DDONgY2ZG5RrR+niP/dcSgjr8vLWIjMpuhqcNjJdOnge9r4UOTtOzA22W4LdwMnj+osQ
         cB4irTZoGflVtRSscinlezTwCyNReWcZlUVLCDvR2BDPIFmLMTFnmK9/ioophRKeWUw0
         VHDAVNqCer/56lKO25njgJ69/VB2F8WjuKlUu3vUj4P0y0WXu8eHS6hQ685V/hHr4w+b
         4a145w1mW4m8i5ZTNJ5d3Op3+teIRe+7ZvK5bLbtGXRiS7fUoG91rrtXnXm2j0KwoFKS
         6a5w==
X-Gm-Message-State: ANoB5pmMVjOmMvZdmurGBsKKIaL9+HbJAfqhN0sdp1VzQMmArHr3n7Lb
        uudKJ31Q9ABgMPQIxm1m4Q8=
X-Google-Smtp-Source: AA0mqf4U7jtXadsQFblEfRvObGZVDvFuMgI1hcOxiUE1ZCQI629UmVFG5eKkyUOBNlVLoCV4mPWkgA==
X-Received: by 2002:a17:90a:5787:b0:218:8398:5846 with SMTP id g7-20020a17090a578700b0021883985846mr93924762pji.241.1670372532129;
        Tue, 06 Dec 2022 16:22:12 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm13369459pjc.6.2022.12.06.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:22:11 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/3] damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date:   Tue,  6 Dec 2022 16:21:57 -0800
Message-Id: <20221207002158.418789-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207002158.418789-1-vishal.moola@gmail.com>
References: <20221207002158.418789-1-vishal.moola@gmail.com>
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

This change replaces 2 calls to compound_head() with one. This is in
preparation for the conversion of deactivate_page() to
deactivate_folio().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/damon/paddr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e1a4315c4be6..73548bc82297 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -238,15 +238,18 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct page *page = damon_get_page(PHYS_PFN(addr));
+		struct folio *folio;
 
 		if (!page)
 			continue;
+		folio = page_folio(page);
+
 		if (mark_accessed)
-			mark_page_accessed(page);
+			folio_mark_accessed(folio);
 		else
-			deactivate_page(page);
-		put_page(page);
-		applied++;
+			deactivate_page(&folio->page);
+		folio_put(folio);
+		applied += folio_nr_pages(folio);
 	}
 	return applied * PAGE_SIZE;
 }
-- 
2.38.1

