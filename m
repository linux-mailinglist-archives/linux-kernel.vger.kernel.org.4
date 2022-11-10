Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019C9624183
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiKJLf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKJLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:35:56 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811FD657CD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:35:55 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id sc40-20020a1709078a2800b007ae024e5e82so1031476ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jpQdIr8MN/KQIwACigO7iQHcDhsbP3Ee3zIRpQPEK1o=;
        b=BdS5DojXBcJ/OgCf0l8c6arc3q1OeaTAXv3Uy1ty5TVvDwC0HX7pEDsrLLPvPBxy8Q
         6tiW59sC/5j+SR3TzXGB6Pgz9sQpaerOtslUi/ofYKiyqHZX7/b16DDBPR0g2zkPft1I
         gKxPQedEpYMCI6GODG0p718Pxs2BoIyzTBXMH96j23FpxFb6jIIjU6dZLx7KkfiLh7ZK
         AG0CDGs67AgDIodUuACO2cWPs/CvG/y2GQHpf7is6flgF1JyWN9MCctmL/JOMnqI/fzh
         htO6DEwe7xL4MmovUHgjG9Mvaup+R3yyVzhif4Dt4g3OKhJNf/BiKZrLDPkYhhFA0DjN
         zeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpQdIr8MN/KQIwACigO7iQHcDhsbP3Ee3zIRpQPEK1o=;
        b=D9w0o7/kTNHrL6UrrJKLkAaDWsh1Hv8wZeQO0etnB8PFANvVCwGkMupD96QWw6GsHp
         H7FMA6pccd8Md5rWQwVYULVdn2m6LCFOiWfWaohLMpL++KExJ5NOJkoFlA1xYNfjNqTM
         jFKefILec34EZEzrS9UXCpIyNzdkw+wAirbNBE4vDqbX0X98wv5JPXAANsOySrUdvjyb
         VCo9++96NEQuZCliiDtzaIQ9oBMSEL4GEUli2abPBGTw/9UJqkazd7rA/Bb3y4Mqe0bF
         G9p3jkP+mrJwOIwUwU5HTX0wqqLjzKnnX/xLSa7txpxdSgLKHosS+mExMGJHGCVllxsw
         uhWw==
X-Gm-Message-State: ACrzQf2Day2Yq72EkMuNVdMvvg0BHgccyulLPuAZexZi1qQ2H2hFqN9Z
        BJlvK5mQATmnHOTv8jg2YFYaC90dYy4=
X-Google-Smtp-Source: AMsMyM5Wpq2hYUAuqWz1ozYNLgSCBs+6jjnjdfEkyB5OqXM4JKPfTlL3B70CVuNWA/k5s1z6YFE8U8wsLKw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4f3e:16fb:f499:bb9d])
 (user=glider job=sendgmr) by 2002:aa7:ccd2:0:b0:462:73bd:3acb with SMTP id
 y18-20020aa7ccd2000000b0046273bd3acbmr62699894edt.378.1668080154037; Thu, 10
 Nov 2022 03:35:54 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:35:41 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110113541.1844156-1-glider@google.com>
Subject: [PATCH] Revert "kmsan: unpoison @tlb in arch_tlb_gather_mmu()"
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ac801e7e252c5588325e3c983c7d4167fc68c024.

The patch in question was picked to -mm from the KMSAN v6 patch series
(https://lore.kernel.org/linux-mm/20220905122452.2258262-1-glider@google.com/)
and sneaked into mainline despite its removal from the v7 series
(https://lore.kernel.org/linux-mm/20220915150417.722975-1-glider@google.com/)

Currently KMSAN does not warn about origin chains hitting the maximum
depth, so keeping @tlb poisoned won't result in any inconveniences.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/mmu_gather.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index add4244e5790d..a71924bd38c0d 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -1,7 +1,6 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
-#include <linux/kmsan-checks.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/mm_inline.h>
@@ -266,15 +265,6 @@ void tlb_flush_mmu(struct mmu_gather *tlb)
 static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 			     bool fullmm)
 {
-	/*
-	 * struct mmu_gather contains 7 1-bit fields packed into a 32-bit
-	 * unsigned int value. The remaining 25 bits remain uninitialized
-	 * and are never used, but KMSAN updates the origin for them in
-	 * zap_pXX_range() in mm/memory.c, thus creating very long origin
-	 * chains. This is technically correct, but consumes too much memory.
-	 * Unpoisoning the whole structure will prevent creating such chains.
-	 */
-	kmsan_unpoison_memory(tlb, sizeof(*tlb));
 	tlb->mm = mm;
 	tlb->fullmm = fullmm;
 
-- 
2.38.1.431.g37b22c650d-goog

