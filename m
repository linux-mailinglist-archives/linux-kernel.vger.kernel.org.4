Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFB72ECC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbjFMUT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbjFMUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:18:55 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD41BE3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b162fa87d8so3295040a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686687515; x=1689279515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo5mmyxvl0eErY9pWIIhlP2v8r+RpR3JWxAmafCgaaA=;
        b=mq+xPQwaOKwXksJ8eIOgdN3s569QJ0hElDZw9QHnYu3dnpIe0Od4y3M6EvPuXCbYcW
         0PCN59K8kIoHsrBj9GKTgCoqWqxEo1BJpDu82hVYNvrIXokkvOlwvl6qRQC8sus+P6g/
         ezx6HULqCegZHyQwScdJYf7E+SlqcD6XLy/1xMzHxMinGkOLKi01dQe2/NKQO/hJPRPj
         oH1arSzrLT6pfQ73f4Ay/jE7vGARCFLtpJMd3sSd8TNqL4owBma2eW+iaryCuuvtKVib
         GFPFMn5bRjH7YA5iJyJT7x6df7yBL/bNziEY1Jv8CK+8aC+6sK6L5ZgtrbGx/ClhN8vr
         6Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687515; x=1689279515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo5mmyxvl0eErY9pWIIhlP2v8r+RpR3JWxAmafCgaaA=;
        b=Lolkin1mDHciPFzWyWXAC7sd801C/On5Pi+TcsiFOiY0mW9dHAkwtWuSNTf1Gea23v
         93PjWLviBUTz8fEe7pVLUsthgTjOFNacMXaV+rIw8N69PL8A1Z/fFNvDqi42HjmoePUX
         BGVCuZIASoFgq9qCy5+ouSzuLMCf2ToyQVdr8mGKSeJee9cGvlHbwMw/eLC+PvCNVVmH
         2yR3KkxIais1FnCal2AK9mfMXhEqYtdLtYz6iKNYumiI3yvHdp5d8Qo0Ng+b92RCQB20
         s9U2QXypyz7MjhbrsRej6PEwq3zCn25o2F2PBEwhFz8r8RO/45b0mxPtlwpK4se/hBvf
         6PPQ==
X-Gm-Message-State: AC+VfDzV9R5acNwr/6V2vIZt27mqKkiAKw6itkq5VbjfiiWamnz+4GVO
        NI15F3HjLrBfCwkFX4xEJZg=
X-Google-Smtp-Source: ACHHUZ4A3AFdIj6lVST9fewNM+pv7wUenff8RHRSL727C8ic8PZIP1u1DM/DgsJ4NorS0Iqg0KUB7g==
X-Received: by 2002:a05:6358:9dac:b0:129:cf11:6b2a with SMTP id d44-20020a0563589dac00b00129cf116b2amr3722960rwo.3.1686687514875;
        Tue, 13 Jun 2023 13:18:34 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::e])
        by smtp.googlemail.com with ESMTPSA id b72-20020a0dd94b000000b0056cea0480c6sm2509985ywe.2.2023.06.13.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:18:34 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/5] mm/gup_test.c: Convert verify_dma_pinned() to us folios
Date:   Tue, 13 Jun 2023 13:18:25 -0700
Message-Id: <20230613201827.9441-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613201827.9441-1-vishal.moola@gmail.com>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
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

