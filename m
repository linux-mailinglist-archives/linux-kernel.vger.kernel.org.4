Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3AB5B6A66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiIMJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiIMJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:12:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBCA57247
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f24so11184173plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=EMAhRQenL2hUdqt4UEMSUYn6VhBs6usk5YM+b/UiubY=;
        b=QR4h9rBbXfMXwSfowuM29Txd3PECeQyRU2zLkwirxu6Xu2abQFq5FtiBLdiUVEddii
         +8A5gWBwuLdtY9/rQSRIdnxCGqq1RncDjqrwQFgQaM4jQp5e+M+amJh53VGIK2l2wmbG
         WOD3z7A+y5uJMimOycIJqQ+zbL03kHZSc8BkgNyjh/PPa0RcIneNj0IMPEfoY0/cHbBL
         nz0vVzqbxGqoO41lcKrh7cZYZWJRPU535kszr+rvh+Q15W4gTBRCS9bgyi+zeHnNlyfH
         4dG1O1MXN/VO2WYWptHTfHKe+EpupAHhZJl/0MnGquj1wi+eJ8nds4FKPXGNcUtR0EtO
         s45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EMAhRQenL2hUdqt4UEMSUYn6VhBs6usk5YM+b/UiubY=;
        b=JcVqeS8WSekDZdlGezNLCA7m36CPcUwQubmmYtoqFVFvSd6Nxzp/dEjkarvwuQj9Z8
         rUbvDqbKKIqvFW02nHqFHqUF8gglNeoyriNzqT+uXlb9PnZLfCEx9+8SS5Fbtjz1Vbph
         IocDGLpCfZvEG1hV9/BJBU/Hi+cx3/joZMZfFFSH7nXJbmE5be1ZnCkr8c0VFC2GBxtd
         avBLJa5DZz+qTRYA+Vnr4A7dGXJuJR2i5IV0rBcXnM8nSw7hIoihXBB/I6A/YUOtRWhN
         Fs4LcojLBWiDNiERz9nmYJVE8J9Vppi1An+Gp6yu51T7ImH9GDmon9iRCTLCK7zDoE9O
         XX9A==
X-Gm-Message-State: ACgBeo13i42P4Bh4EuH6KVamG3/hCImYANUiNZiJW9tIOzy7V+dhwvXH
        nngjEtbdW0P364V4i8gfiQ==
X-Google-Smtp-Source: AA6agR5DxXSkOSzxyXwhhv9jgg+SwSheGvcNYeAQI3G+qRh9y7ZtRQmO490kndDSfsv/LAIvKJD3Fw==
X-Received: by 2002:a17:90b:3ec2:b0:202:b123:29cc with SMTP id rm2-20020a17090b3ec200b00202b12329ccmr2974074pjb.167.1663060349560;
        Tue, 13 Sep 2022 02:12:29 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:28 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 1/4] mm/damon: simplify the parameter passing for 'prepare_access_checks'
Date:   Tue, 13 Sep 2022 17:11:24 +0800
Message-Id: <1663060287-30201-2-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_ctx *ctx' isn't used in the functions
__damon_{p,v}a_prepare_access_check(), so we can remove it and
simplify the parameter passing.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/paddr.c | 5 ++---
 mm/damon/vaddr.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6b0d9e6aa677..f00cbe74a00e 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -63,8 +63,7 @@ static void damon_pa_mkold(unsigned long paddr)
 	folio_put(folio);
 }
 
-static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
-					    struct damon_region *r)
+static void __damon_pa_prepare_access_check(struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
@@ -78,7 +77,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t)
-			__damon_pa_prepare_access_check(ctx, r);
+			__damon_pa_prepare_access_check(r);
 	}
 }
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c2c08c1b316b..39ea48d9cc15 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -397,8 +397,8 @@ static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
  * Functions for the access checking of the regions
  */
 
-static void __damon_va_prepare_access_check(struct damon_ctx *ctx,
-			struct mm_struct *mm, struct damon_region *r)
+static void __damon_va_prepare_access_check(struct mm_struct *mm,
+					struct damon_region *r)
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
@@ -416,7 +416,7 @@ static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t)
-			__damon_va_prepare_access_check(ctx, mm, r);
+			__damon_va_prepare_access_check(mm, r);
 		mmput(mm);
 	}
 }
-- 
2.27.0

