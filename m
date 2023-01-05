Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262D065EA7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjAEMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjAEMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:13:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB150F43
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:13:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m3so18959901wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgl7lCzy0fcZtaK+lkwZBHklZitpcOstbG01qdR2KPE=;
        b=E0K7GY3LauMdBhdg8e375K14Ps81Gy+DwAunQwhLcFF24JhpuJPs4WHmO7ctqg/YKJ
         S+6IncMgFdib1OeYnpStU2E2/i0SUch2tYqB5cA0IIFB5CLXUrPsLYxmdU6gjdFEv32e
         hpQZVX2GgsOraqvc4d7ow8CiiF3QeKWvcUdq7I5go18NotiXE1g0hwTRShuLo9x+jtKV
         UA4JaKPaZlFEH+mMdhwwrxNF6V2tMcoysAnOloEkKsBuIYijxiiLs13jPgf71m1f5K1s
         rWKYSWxuLBWlv4BAZhaSONW0+FniWl5q1adR/vNiUmaJmDCdggHBBgxzVXJ6nV1bkXGd
         h+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgl7lCzy0fcZtaK+lkwZBHklZitpcOstbG01qdR2KPE=;
        b=6gHTdZhRPmCfy8eXvpu38OAKpF5urQD5ZPLnc8nOcjqU+PJ8UwCh/O7VXPxWAvZGGa
         zdpKm8PXz/eADVe6YJNshQwuDFJuBopdbdsSn1Z2YpH+RUUSV4PMEU5/f9Nksuf8s9Fg
         2uIIP4jWUHmouLmFdfDMo99ocEWX+N1OSLx6geOQQDN0qoufJ8Y4DDB5AU23ONiH0uzS
         ntMR38ow0MOAqF0mIF2nwnYQI+mFStlulTzVX9/Z78C1h6vMKyFVkV54t1rzjywnkS+5
         IF8c1VydjBvZ7xlF5mgowyOz0NyDuOM3q574/jpb53l/6wvaABpJnnMJ8lrPImzSOyUe
         NopQ==
X-Gm-Message-State: AFqh2krjaBNGCyw1SHIntZabAijukH0ZQ8U9KNvKdStq/DYbdC0dGx36
        Mhk2JJTHrSrQuRcBYvD+Z8E=
X-Google-Smtp-Source: AMrXdXvjA44M76uZ8vub2wPPTD8bsIukqwDDsqi8bl1bKN9XZDsZAYOYPKbea7NpzYGuzmFKeJusYA==
X-Received: by 2002:a05:600c:3844:b0:3cf:7dc1:f424 with SMTP id s4-20020a05600c384400b003cf7dc1f424mr35446278wmr.3.1672920790613;
        Thu, 05 Jan 2023 04:13:10 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id k4-20020adff284000000b00289bdda07b7sm21826473wro.92.2023.01.05.04.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:13:09 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] mm: Fix two spelling mistakes in highmem.h
Date:   Thu,  5 Jan 2023 13:13:05 +0100
Message-Id: <20230105121305.30714-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Substitute two occurrencies of "higmem" with "highmem" in highmem.h.

Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 7b0085a61e67..ae1670ccdf45 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -86,7 +86,7 @@ static inline void kmap_flush_unused(void);
  * virtual address of the direct mapping. Only real highmem pages are
  * temporarily mapped.
  *
- * While it is significantly faster than kmap() for the higmem case it
+ * While it is significantly faster than kmap() for the highmem case it
  * comes with restrictions about the pointer validity.
  *
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
@@ -119,7 +119,7 @@ static inline void *kmap_local_page(struct page *page);
  * virtual address of the direct mapping. Only real highmem pages are
  * temporarily mapped.
  *
- * While it is significantly faster than kmap() for the higmem case it
+ * While it is significantly faster than kmap() for the highmem case it
  * comes with restrictions about the pointer validity.
  *
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
-- 
2.39.0

