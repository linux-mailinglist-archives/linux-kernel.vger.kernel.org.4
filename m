Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A672F27F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbjFNCOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFNCO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:14:28 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941019B9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:27 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-56d2b7a9465so2522097b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686708866; x=1689300866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB7c080hmSdFjIvh3R4otuK2wUDYLhoWmLvrdo1yBmw=;
        b=VFW1xJ4gnwv7pBeS0YE65pckiAxPEdYG7lGo7tzZjndkiBhVKufOgxXl+W7IFVCV1K
         4TbG1Zx4rWCcT3BUOPtsNJRgIhIhzvi19CSD5ABbuUFp0TlMJxCpZCiZ3IK27cYBnFKN
         pIwW1L7ZlPC72CTTklcQfY7rNp3B2Vwl3MiRXeNSWX3rfTKX/Fhk7w1Ab1Dty4tE9/Ia
         bjOeYh7/dy+wD/d7slqEbflc1B0mqFOz9DbfxdHnlct6y9OdohNVDIIOe14jv3fF3ti4
         JEJErk19IJ7v9pQnGBNTubxC5/+VB0/N3Qblyz2JDYiEJhghB/zIx2TcFA4TBfMbybhu
         gowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686708866; x=1689300866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB7c080hmSdFjIvh3R4otuK2wUDYLhoWmLvrdo1yBmw=;
        b=OdDzKM3CHtWWDme6iBhUgDcKhkdQvvpwGoS1aw2qLgGQBjLso/Lh7v/hF8td4YoaUP
         EPHR6ZVfuvW8PDYswhIyu8NdaYUxip1ihOp1lwM2UGXc0nuZU7ToBRJCYA2igUCcu6dZ
         x+5LocYfOrPhZr7j2NY7UgFx9T+agceoLX4KyX4y7Bqrx9PAR0EmRVD/PvwTOVcmAI64
         l30mlTaK0n0bNenunf2coRfH6h6471ODygBMaSCzz+kAX55QJItN3ETWzAAF0pWk89NG
         aVtEqnH6hkv4OL84MZJJgPjkck83E/Br4aEnUEzZahO/soOsKC3splMcM8VbxnWvnMQQ
         ZYzg==
X-Gm-Message-State: AC+VfDwqVFVkgJO/RMkOY6t2e8bYmx+sjCkEfHuryvj8IoiSGJZebCYU
        50UjEyuKHqfPniolkD+j0k1h+fvRJco=
X-Google-Smtp-Source: ACHHUZ6D9ogohvWoySXrKmywAvhj/+wxSJub+ieNdKYpjexpUFv0OzYjFADwZblBr9FcPuHAo+i5MA==
X-Received: by 2002:a81:6802:0:b0:559:d1ea:8c7a with SMTP id d2-20020a816802000000b00559d1ea8c7amr39535ywc.1.1686708866473;
        Tue, 13 Jun 2023 19:14:26 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id p3-20020a817403000000b0056d30f1b508sm1463931ywc.107.2023.06.13.19.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:14:26 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 3/5] mm/gup_test.c: Convert verify_dma_pinned() to us folios
Date:   Tue, 13 Jun 2023 19:13:10 -0700
Message-Id: <20230614021312.34085-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614021312.34085-1-vishal.moola@gmail.com>
References: <20230614021312.34085-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

verify_dma_pinned() checks that pages are dma-pinned. We can convert
this to use folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/gup_test.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 8ae7307a1bb6..860b093b4b3e 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -40,24 +40,25 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
 			      unsigned long nr_pages)
 {
 	unsigned long i;
-	struct page *page;
+	struct folio *folio;
 
 	switch (cmd) {
 	case PIN_FAST_BENCHMARK:
 	case PIN_BASIC_TEST:
 	case PIN_LONGTERM_BENCHMARK:
 		for (i = 0; i < nr_pages; i++) {
-			page = pages[i];
-			if (WARN(!page_maybe_dma_pinned(page),
+			folio = page_folio(pages[i]);
+
+			if (WARN(!folio_maybe_dma_pinned(folio),
 				 "pages[%lu] is NOT dma-pinned\n", i)) {
 
-				dump_page(page, "gup_test failure");
+				dump_page(&folio->page, "gup_test failure");
 				break;
 			} else if (cmd == PIN_LONGTERM_BENCHMARK &&
-				WARN(!is_longterm_pinnable_page(page),
+				WARN(!folio_is_longterm_pinnable(folio),
 				     "pages[%lu] is NOT pinnable but pinned\n",
 				     i)) {
-				dump_page(page, "gup_test failure");
+				dump_page(&folio->page, "gup_test failure");
 				break;
 			}
 		}
-- 
2.40.1

