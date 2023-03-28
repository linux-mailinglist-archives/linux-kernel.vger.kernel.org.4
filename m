Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9DD6CBBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjC1J7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjC1J7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:59:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453CB6E8E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:59:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso14616354pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679997539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9z+2OKezgBl6Xq8s4/uft3FH4lHgs0F/FglMYKuxZE=;
        b=VsNWH6wbabZBW09E5p1rywOaT5p8dwv3DVQF4JxvKy8pAkOwOWTmSR3v5YYbHdOVIH
         o9LpPW7UeEmwFT8bwKYV0uifRm0n7p6iEYBMeiwyTvcS/TasidJuyj7P88eL57v1KTDd
         tI7u4PDJStX8H8gJLJrbqJ2Kof9xiRkHbs+wEsWSrPnUYYMPFzysTbud6J24HgyFWNpP
         x/6rvB/nHTaJWJCevltlgD8XQOccc/yfD7VHMVUS6y71oqY16doN1wfGwwkfO74aIK1P
         TXfWcZDvSIRMhEA4BilI3L6ew7QAaPregsJwYg77jDT/Rie9uRJd+pu1GfBpPZf028JJ
         BL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9z+2OKezgBl6Xq8s4/uft3FH4lHgs0F/FglMYKuxZE=;
        b=LXQhbmv074VmdwOfaHR8Iv7UwbvY8hoIDYiw4RYUJaihZwWSinfjnkgvXQNL4zX/xm
         yUX1DAVRzuV2uhVOABOoBX+4Hjo9lcCyKg6YIrK/v8yAIghoiFcpNKGSttWS7oJi/Wis
         mNvq75i1lyb3LZJgLcuDUZSln6sr5q0TIckMOO1PHUFU7rE9sJQbc3t1TwHMRmRu25sv
         8lcyd3u32szqptcEHr7LyBoVDPEdI02wKdyfoDa/nekYeAyebvAFgOPWvcnBvUL2L8so
         3lphDEGAOFz1u2Cy0lSepIfji2j+xasPa4CyrSO+9J5pSB0/J56gbYF7AhANweYqxGFm
         WbSg==
X-Gm-Message-State: AO0yUKUDlikUitfj/AIYnUq1abfs03WKGc3vZ5d7QGueUZIXaLPoDWYJ
        mlcQZHRgoogOtTSZU12m1knrzw==
X-Google-Smtp-Source: AK7set+sSOqvm7BhrGFyb5OKdu0ZTvBWUBOT2Bfsk23ttc/ateaVqwe3xWklthmOX72MppMUmuO5pA==
X-Received: by 2002:a05:6a20:6aa0:b0:d9:2d4e:c08c with SMTP id bi32-20020a056a206aa000b000d92d4ec08cmr12797492pzb.61.1679997539764;
        Tue, 28 Mar 2023 02:58:59 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b005a8a5be96b2sm17207556pfa.104.2023.03.28.02.58.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Mar 2023 02:58:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 6/6] mm: kfence: replace ALIGN_DOWN(x, PAGE_SIZE) with PAGE_ALIGN_DOWN(x)
Date:   Tue, 28 Mar 2023 17:58:07 +0800
Message-Id: <20230328095807.7014-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230328095807.7014-1-songmuchun@bytedance.com>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ALIGN_DOWN(x, PAGE_SIZE) with PAGE_ALIGN_DOWN(x) to simplify
the code a bit.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/kfence/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index f205b860f460..dbfb79a4d624 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -230,17 +230,17 @@ static bool alloc_covered_contains(u32 alloc_stack_hash)
 
 static inline void kfence_protect(unsigned long addr)
 {
-	kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true);
+	kfence_protect_page(PAGE_ALIGN_DOWN(addr), true);
 }
 
 static inline void kfence_unprotect(unsigned long addr)
 {
-	kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), false);
+	kfence_protect_page(PAGE_ALIGN_DOWN(addr), false);
 }
 
 static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
 {
-	return ALIGN_DOWN(meta->addr, PAGE_SIZE);
+	return PAGE_ALIGN_DOWN(meta->addr);
 }
 
 /*
@@ -308,7 +308,7 @@ static inline bool check_canary_byte(u8 *addr)
 /* __always_inline this to ensure we won't do an indirect call to fn. */
 static __always_inline void for_each_canary(const struct kfence_metadata *meta, bool (*fn)(u8 *))
 {
-	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
+	const unsigned long pageaddr = PAGE_ALIGN_DOWN(meta->addr);
 	unsigned long addr;
 
 	/*
@@ -455,7 +455,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 	}
 
 	/* Detect racy use-after-free, or incorrect reallocation of this page by KFENCE. */
-	kcsan_begin_scoped_access((void *)ALIGN_DOWN((unsigned long)addr, PAGE_SIZE), PAGE_SIZE,
+	kcsan_begin_scoped_access((void *)PAGE_ALIGN_DOWN((unsigned long)addr), PAGE_SIZE,
 				  KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT,
 				  &assert_page_exclusive);
 
@@ -464,7 +464,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 
 	/* Restore page protection if there was an OOB access. */
 	if (meta->unprotected_page) {
-		memzero_explicit((void *)ALIGN_DOWN(meta->unprotected_page, PAGE_SIZE), PAGE_SIZE);
+		memzero_explicit((void *)PAGE_ALIGN_DOWN(meta->unprotected_page), PAGE_SIZE);
 		kfence_protect(meta->unprotected_page);
 		meta->unprotected_page = 0;
 	}
-- 
2.11.0

