Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1466F1D86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbjD1Rfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjD1Rfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:35:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16013E69
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:35:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a829a3de0so4557240276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682703337; x=1685295337;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yyTrtR3S5gMM0KVdMQoSGiM4SzOrc6DI1bOXsYT1q/A=;
        b=nQwQyaHpYfL58xtHqqBDwedop7h9GVNhO8im6D5ItL5TT3/jAi7ai9In0/BO8VnFDa
         qkTXUAXDHJ6IqJgFYeuedFEi0Br7UDyk/XAYEoeA3NmhdtOFFHeYWt4LIgKw611NLFHv
         nD98nj14+oDPx/kUoLmUd8k3EcA5cVJjpf/fvjcHBpwbDNHK+hf7n9qTzAhHQ8N4liEL
         ytXu9oXNn1PVAz2Uhqm6BmBU9eZOwscjpuw4sWFTElsrGxlI1w18+V1XmPGPDF86TXbX
         4ZtOJ7muAxfe37u+4e4pa7vBNb6Mplg2RQR1FUWuydhoM5Dxzyw3mnNVGTyRhien6tMA
         gwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703337; x=1685295337;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyTrtR3S5gMM0KVdMQoSGiM4SzOrc6DI1bOXsYT1q/A=;
        b=RrYXmDRh4SVr8DQsMzCQ0O8129T9wskTW13h7Q5Krwd1oxawvcapts5lGkSWjgaSrB
         F4E4hLu2IOc7ZwvCsdpLqpVVNriJo0EsA/XBH4TxWD7YepsF37XAOkiDEs0gzS/eHUeT
         TsJ1baYgkk1aitezEG1ak2B+I66txXMs5xP3uj3DKwoGOUB3fjtLuyuScrcEpL+Gd6+H
         ol1KtspCoZinj23VaP8jCfSxMfCMSmseoxvTAKy5Nfespo9h9F355Otu/PTdLBJ3xBnI
         btGzg8+TvvK/DHGDJT/goEQzWe71vO1+ObfLUItQSgD2XPHb3koJjYtHzMYVC0Hd8FGK
         36vA==
X-Gm-Message-State: AC+VfDypeobE8JYEBZx9A9LU59gG7X4ZdyJwfyP8YwlJyGmJPtPB5MSy
        8D01NuLsMWCSMcTFDHF1R1S0XdXK9A4=
X-Google-Smtp-Source: ACHHUZ6a47311Z3E3ThyzHPQ9KyYllAPKcWDtQk5Fh1wPStyP+ENdM1WFpxyywRRQqPl48Pb/lCint/KSic=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:51d6:764:dc11:ffbd])
 (user=surenb job=sendgmr) by 2002:a25:84d1:0:b0:b9a:76e4:ccd2 with SMTP id
 x17-20020a2584d1000000b00b9a76e4ccd2mr2343098ybm.10.1682703337303; Fri, 28
 Apr 2023 10:35:37 -0700 (PDT)
Date:   Fri, 28 Apr 2023 10:35:33 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428173533.18158-1-surenb@google.com>
Subject: [PATCH 1/1] mm: change per-VMA lock statistics to be disabled by default
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, lstoakes@gmail.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change CONFIG_PER_VMA_LOCK_STATS to be disabled by default, as most
users don't need it. Add configuration help to clarify its usage.

Fixes: 52f238653e45 ("mm: introduce per-VMA lock statistics")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/Kconfig.debug | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 6dae63b46368..a925415b4d10 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -274,6 +274,12 @@ config DEBUG_KMEMLEAK_AUTO_SCAN
 config PER_VMA_LOCK_STATS
 	bool "Statistics for per-vma locks"
 	depends on PER_VMA_LOCK
-	default y
 	help
-	  Statistics for per-vma locks.
+	  Say Y here to enable success, retry and failure counters of page
+	  faults handled under protection of per-vma locks. When enabled, the
+	  counters are exposed in /proc/vmstat. This information is useful for
+	  kernel developers to evaluate effectiveness of per-vma locks and to
+	  identify pathological cases. Counting these events introduces a small
+	  overhead in the page fault path.
+
+	  If in doubt, say N.
-- 
2.40.1.495.gc816e09b53d-goog

