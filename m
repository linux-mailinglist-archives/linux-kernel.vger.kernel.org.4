Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA963A567
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiK1JvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiK1JvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:51:04 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657FE193C3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:51:02 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id b47-20020a05600c4aaf00b003d031aeb1b6so8335761wmp.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cct04cXs5K6Oma9vXfMm60p6i+CfzdxpxLX+V58OiqQ=;
        b=F8rWO4eEUv81PuSKtmYCtH6WPMr3pJLLQVDBUG+mf3OIy/GgnIfAfRBTjQOuF0NZgI
         rQCvXESuwjsM+T6ALxE15HiEcWvtzdF69PXuMMgl9Gp8SOqnwRANXg4WM8IESG8AGx+s
         edceQgh2LwiydLOf165rabsPFjFB86SOAH4c/BT53evJVpZn4lRm6K5ImDhjrnhFx4Of
         XIQSsEb6/zUJG5A4gX+KMJ0FUtrijmXIqWZFaH/WZmcDXYjJU491FhbK5snqi54h7p/V
         37ylxNxeU1MNJLXAM5OGWTPcUV0xqWEL7LQAoqOZ4ol27gM4g+vEdJinXsOfbPbuXFPD
         MJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cct04cXs5K6Oma9vXfMm60p6i+CfzdxpxLX+V58OiqQ=;
        b=mGDmE/ZIzLmbxq/WzHItTaSBBn/U36ekDff7uWyEG96Nr1ha1AUzmy/p46yiVpxkic
         RtQDGqm3qYefO617r9Ge+TP6ltc2+Be81Kp2UINc3esTLFnisFfEUfLgla9YNGUqX4bE
         JUzuua/De4CoKe2wUct8riYzNm8nLNknxDlQYC5Eh5FDvxQEjGecU/hI2xKX7lJJn2I7
         0CfIPDTpHWP0YKzKnof1W1uBIu9uF4peJc4Op+HLvN8hYBzvQoLT4zLDOxdtKKoHpAv2
         YTAH7LQ1Wo78+RVQpOB1KIWXv4tAzpm9d5RNfyYVfGCQqyxpcKZ6IJju3m1fXiGtLIDz
         8frA==
X-Gm-Message-State: ANoB5plbZ0qfPQIbqS/xP4QsUvvm0+Fjd7aQYwZcJJO5LjwBFBqh9zPJ
        E4zLgbCUtq8fTimailr0RxkAJv+6b2M=
X-Google-Smtp-Source: AA0mqf47reGLvqtfhUicf3SwZLCRiQSU8ElrY3uGc5tGFXHC/qU5NVNZWlAkGfegPCyHFwdpnlPxg1K7kmE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:dc07:26e3:1eb7:b279])
 (user=glider job=sendgmr) by 2002:a5d:6dcf:0:b0:236:78b7:87c9 with SMTP id
 d15-20020a5d6dcf000000b0023678b787c9mr30120679wrz.556.1669629060947; Mon, 28
 Nov 2022 01:51:00 -0800 (PST)
Date:   Mon, 28 Nov 2022 10:45:41 +0100
In-Reply-To: <20221128094541.2645890-1-glider@google.com>
Mime-Version: 1.0
References: <20221128094541.2645890-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128094541.2645890-2-glider@google.com>
Subject: [PATCH 2/2] kmsan: allow using __msan_instrument_asm_store() inside runtime
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        elver@google.com, dvyukov@google.com, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
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

In certain cases (e.g. when handling a softirq)
__msan_instrument_asm_store(&var, sizeof(var)) may be called with
from within KMSAN runtime, but later the value of @var is used
with !kmsan_in_runtime(), leading to false positives.

Because kmsan_internal_unpoison_memory() doesn't take locks, it should
be fine to call it without kmsan_in_runtime() checks, which fixes the
mentioned false positives.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/instrumentation.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
index 271f135f97a16..770fe02904f36 100644
--- a/mm/kmsan/instrumentation.c
+++ b/mm/kmsan/instrumentation.c
@@ -81,12 +81,16 @@ DECLARE_METADATA_PTR_GETTER(8);
  * Handle a memory store performed by inline assembly. KMSAN conservatively
  * attempts to unpoison the outputs of asm() directives to prevent false
  * positives caused by missed stores.
+ *
+ * __msan_instrument_asm_store() may be called for inline assembly code when
+ * entering or leaving IRQ. We omit the check for kmsan_in_runtime() to ensure
+ * the memory written to in these cases is also marked as initialized.
  */
 void __msan_instrument_asm_store(void *addr, uintptr_t size)
 {
 	unsigned long ua_flags;
 
-	if (!kmsan_enabled || kmsan_in_runtime())
+	if (!kmsan_enabled)
 		return;
 
 	ua_flags = user_access_save();
@@ -103,10 +107,8 @@ void __msan_instrument_asm_store(void *addr, uintptr_t size)
 		user_access_restore(ua_flags);
 		return;
 	}
-	kmsan_enter_runtime();
 	/* Unpoisoning the memory on best effort. */
 	kmsan_internal_unpoison_memory(addr, size, /*checked*/ false);
-	kmsan_leave_runtime();
 	user_access_restore(ua_flags);
 }
 EXPORT_SYMBOL(__msan_instrument_asm_store);
-- 
2.38.1.584.g0f3c55d4c2-goog

