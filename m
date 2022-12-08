Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0E064775A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiLHUfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiLHUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:35:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6AF862C4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:35:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2751742pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=Ii3vt0qJdv0V25/feuGUMH7PzkflNrD7g8L2x6z6/EYO9gzRto4zD8ZTJENpqeU8XP
         gLmydlYQJhHXfGq9y5BeriBDQ11jeq2TYMS4ysPrNZ9lPX61JatrrzxhNPq8b43OY+1j
         ptjf++BriBBDjvyJBWStE5HuQ96Co+07MfQnvCs2OW/l8Fnd4dMK7S3wmVg9uQ10eoQe
         daaPLy51OxzLCvTwyZhN2Miw3T/m5LTvMPAIzD6bUUY+4EQQU/bJ69w/ZA8Q6XpK5xLy
         SxVqHOiUx+drkxy5pADNtrFlAQV+RXgMmv1emA5DGz0XXWcWdkZMZTar5/QzNUuvgqaX
         Bdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=wW6aerC7mH30USWPjCeg/CdCbWsf9B3EUmf32Z6o5J7knUo0KD7g7DwQDv4afteo+H
         sq53hCZmyitRvd9FWf9gYx9nCqFKF8kZlydZV1l4VaDbB2juybMBWUWpCyd+x+yV2uPn
         eHvg6zMhAX3NrALaGHXOOaYlUJpMq1cFlJ2Bd95+AhGsPTN27Jk7bEeuttGMVE4oooFp
         h6a5wMnsvb0/m6Xz+5HBThipgxlQttrIsoN4tyyBkoFJO+VhzZfrQgzNiACjePTZXF3f
         22A+9tB9nQ21xXYIXaR3JU5ByvULmy159IQ25Pp5SsAONIbbS/QgxbpD2gsaW6jpDAAn
         JGGw==
X-Gm-Message-State: ANoB5pnCBklSmuf1yRoQjttX44SIPAyWt/08FZZexCWKkkUsECWiLQoc
        p5tFbwn6zNQs1bQpsrM1ZsdIybEpC8w=
X-Google-Smtp-Source: AA0mqf4+5Zv1Qu99xU00p+xkeABzV897h+Xfstc+913jbdXvjz2pIi2b+ZYYSdFCNInv+po5xPqf2w==
X-Received: by 2002:a17:902:e806:b0:185:4421:72e5 with SMTP id u6-20020a170902e80600b00185442172e5mr3989355plg.42.1670531709851;
        Thu, 08 Dec 2022 12:35:09 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f5-20020a170902860500b00189951514c4sm16954349plo.206.2022.12.08.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:35:09 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 3/4] mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date:   Thu,  8 Dec 2022 12:35:02 -0800
Message-Id: <20221208203503.20665-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208203503.20665-1-vishal.moola@gmail.com>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
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
folio_deactivate().

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

