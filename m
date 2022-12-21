Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3B16535E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiLUSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiLUSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:10:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD12252AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:10:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d15so16303653pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV2WgQnkGF47aHXwNmitYREK9VpntY4pGASooxA0vsY=;
        b=Kg1XMQEXGj1P5eOMqXh9QBRNWX72E0HNrH5TCgKFnOpXQ2PKPJ/sz6VxqwbRyP/31V
         MEmCQ6M7lOfXMYadzVs6SjgDmAss0zjsmJK+uqicKnmQ9sdkMbv2Ozm+wTTKQB8ApVST
         qq80B8WfhDV5+VU0L4rDCOu8K1aHQgwVp4S65V4p5WDwKqRzhkAxDvZFe797MPsGnHxP
         Ju6eeykfM32/T1VluTLvZsUJWDesdEtZMnarwoMvG+YbjVXTJM3LBa7W/XXgkEshQssx
         +VSCbILH93R98OybhCiHIVOpLPyUmZHjaoADCn3LxYw9gPFLuWf1FUY6p2QDR1t71LWv
         W+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV2WgQnkGF47aHXwNmitYREK9VpntY4pGASooxA0vsY=;
        b=U6xi2wecfRe0B5NInEK+Xtj6UIeSvT5IcM9C5Y6Ii18G/O59HgyK/nKHuOgeeK97lX
         AwOB4WSK9pquoUPso+dnHnMPWkiznkSE/gf0BLiC3aMmMcTOhHC1WmKJIZEESv0+PgXm
         /n6DMEN4sbgZosdTTJPAxq2GV8GbUrjNP+ZnUxjhiQFfkcS59XyvvzvR7mADGp+wPHUD
         FQcqTKvqEAkCSJOeejpLQjQpneo9B0/KKKa3QkAE+nwLGPg8lbHK07lv5S0nWjZpPJJo
         pfPx69WnzsVo673bgzI/ZXcfWi+ppPZ2Vd4pfovo10X2uXn4TWKG9cFVQuOVnR3dRPzh
         ebSg==
X-Gm-Message-State: AFqh2koKm0lD08nHDbeKvq/UqZAXnttuG6vkBmEiAuKVWNSx4jk3TrtC
        F/jz1NfTt/oMcbVODtLwsbQ=
X-Google-Smtp-Source: AMrXdXu5VDOIqKGM3A+JT0KCVz3Bkip3v+cF2w+L6Cyr9LUNlLEY5S39vnlLyv1Nvgic1ZQTYgvR9Q==
X-Received: by 2002:a05:6a20:d38c:b0:af:a276:2f94 with SMTP id iq12-20020a056a20d38c00b000afa2762f94mr3868375pzb.35.1671646201070;
        Wed, 21 Dec 2022 10:10:01 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id e26-20020a63745a000000b00477bfac06b7sm10110732pgn.34.2022.12.21.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 10:10:00 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org, willy@infradead.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 3/4] mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date:   Wed, 21 Dec 2022 10:08:47 -0800
Message-Id: <20221221180848.20774-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221180848.20774-1-vishal.moola@gmail.com>
References: <20221221180848.20774-1-vishal.moola@gmail.com>
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

This change replaces 2 calls to compound_head() from put_page() and 1 call
from mark_page_accessed() with one from page_folio(). This is in
preparation for the conversion of deactivate_page() to
folio_deactivate().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/damon/paddr.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index ebd1905eed6f..884c8bf18b12 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -283,21 +283,23 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct page *page = damon_get_page(PHYS_PFN(addr));
+		struct folio *folio;
 
 		if (!page)
 			continue;
+		folio = page_folio(page);
 
-		if (damos_pa_filter_out(s, page)) {
-			put_page(page);
+		if (damos_pa_filter_out(s, &folio->page)) {
+			folio_put(folio);
 			continue;
 		}
 
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

