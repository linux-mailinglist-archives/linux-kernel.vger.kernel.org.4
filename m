Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9947C7282B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbjFHO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbjFHO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:26:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBED2D68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:26:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-65292f79456so394507b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686234361; x=1688826361;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnoedkoiLsL0tLJYDXF1NYn5Qb4R2gxxmXGm3HjM2kw=;
        b=H7UvU4+Cu5Ls9GovjGu5sw+DLDlo+SEQ7Pj9pFQUXI+arPhcc/rG6cgn/N04MyMs4g
         rNQDDrHeQEAEQhh46HR8VhzW5Rhnff1RzC+72uF/cLXyudXFzJb9cftciLyMcKrEdh0E
         8SAUuyNHD7Jy/w/ZaSbSTczyJaut2ZvBHXUYyfNC75FKC5QUUBNZN14Gd3XVPiZJRq2A
         Jwi4iH766Mw4gDvXULcD2y+YEX28oVJ6pr9BmgruKyukSHrrYnC8Hm6EXnqX/Fz/D+iW
         WnNEEb+LCoRqSwTryWnImZe7fp8L7hUSqa0zOH2FBTCM7VItFk4oGlf78WRkHG150ztx
         pxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234361; x=1688826361;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnoedkoiLsL0tLJYDXF1NYn5Qb4R2gxxmXGm3HjM2kw=;
        b=ZWnIO8JJ2/cDbNdUNFlF+Jau9hCUEKy+pJglVYT4si33XH6ZAx5xH1jI7Fy+3uDEXw
         AfLZEwcWk9U5KsIjiL67uqc9YoCOuhHLjgSQ9bCpllagHsI4YXDwHv7nH99AqDwJRAkE
         zN+FDN8dhpRbLmWYyCQMldkvu9Kt9FTLJUlJR0bWt5b1SHEfVUAg1yuv14iPxwsbbq8o
         DSQOUqG7tUB7Jj/zlC17ASzx1RMuUwRQoNeK5jHlvFw45YDyxre0AX2sfM8RFECqaLY6
         8zqU0xbQKcQERAA/lDNwjm07Dm8OW2C4eIwzP3a0+v3jyxEHhg7m+FTM2ZNFF20T3fch
         EFng==
X-Gm-Message-State: AC+VfDyIGOHpI1s/s/P3rOhD5LxWljp07NwFRzlj11KQGMbRhsvoH81n
        wmfz2vzq2ZtglHZgHsFS/VU=
X-Google-Smtp-Source: ACHHUZ6MOG1Hd2uceavhD8Eb8zbsWGFQuQO+S1FpmJYxHNmRX/oBQu53oSWEWJIECUiRyik1J3RvCQ==
X-Received: by 2002:a17:902:da8c:b0:1b0:5ca0:41a8 with SMTP id j12-20020a170902da8c00b001b05ca041a8mr5134985plx.39.1686234360542;
        Thu, 08 Jun 2023 07:26:00 -0700 (PDT)
Received: from sumitra.com ([117.255.153.95])
        by smtp.gmail.com with ESMTPSA id x21-20020a17090300d500b001a221d14179sm1483052plc.302.2023.06.08.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 07:26:00 -0700 (PDT)
Date:   Thu, 8 Jun 2023 07:25:53 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Deepak R Varma <drv@mailo.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] staging: lib: Use memcpy_to/from_page()
Message-ID: <20230608142553.GA341787@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate kmap() in favor of kmap_local_page() due to high
cost, restricted mapping space, the overhead of a global lock
for synchronization, and making the process sleep in the
absence of free slots.

kmap_local_page() offers thread-local and CPU-local mappings,
take pagefaults in a local kmap region and preserves preemption
by saving the mappings of outgoing task and restoring those of
the incoming one during a context switch.

It is faster than kmap(), and in functions "dmirror_do_read" and
"dmirror_do_write" the mappings are kept local to the thread.

Therefore, replace kmap/mem*()/kunmap pattern with
memcpy_to/from_page() and remove the unused variable "tmp".

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

 lib/test_hmm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 67e6f83fe0f8..cc96dfa54122 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -368,16 +368,13 @@ static int dmirror_do_read(struct dmirror *dmirror, unsigned long start,
 	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
 		void *entry;
 		struct page *page;
-		void *tmp;
 
 		entry = xa_load(&dmirror->pt, pfn);
 		page = xa_untag_pointer(entry);
 		if (!page)
 			return -ENOENT;
 
-		tmp = kmap(page);
-		memcpy(ptr, tmp, PAGE_SIZE);
-		kunmap(page);
+		memcpy_from_page((char *)ptr, page, 0, PAGE_SIZE);
 
 		ptr += PAGE_SIZE;
 		bounce->cpages++;
@@ -437,16 +434,13 @@ static int dmirror_do_write(struct dmirror *dmirror, unsigned long start,
 	for (pfn = start >> PAGE_SHIFT; pfn < (end >> PAGE_SHIFT); pfn++) {
 		void *entry;
 		struct page *page;
-		void *tmp;
 
 		entry = xa_load(&dmirror->pt, pfn);
 		page = xa_untag_pointer(entry);
 		if (!page || xa_pointer_tag(entry) != DPT_XA_TAG_WRITE)
 			return -ENOENT;
 
-		tmp = kmap(page);
-		memcpy(tmp, ptr, PAGE_SIZE);
-		kunmap(page);
+		memcpy_to_page(page, 0, (char *)ptr, PAGE_SIZE);
 
 		ptr += PAGE_SIZE;
 		bounce->cpages++;
-- 
2.25.1

