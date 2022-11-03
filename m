Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD0617E49
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKCNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKCNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:45:40 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1EF50
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:45:40 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id l18-20020a056402255200b004633509768bso1403470edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ScuUET3Jx3790WWtzDciWGjRGXPi9X8ISFOvBcfPIsI=;
        b=leCGMG1Ihb72GuqEhvKiIBXP3svrLi4GzMCcHOGP9PM8igal8vM5W4lXCqnNucSw3P
         1fnQ15L2ZK8WgXHhy3OiPjE01iUPYRYjn+HLa1puFmYg6oh4P8+TsU59MFP97mWSj9Tp
         /GKp7HOeM/hBv8kUjeXHmP7yGCPjf5B8kOAo47zvM3+0u2Om3tQyaR9nGEpB2MOY4Aqj
         Y52eQAHsh/vMHHfCqhKOhQy4lGBB+wvxc9rt8N02K44QPooSfTBlbkqMBHldPPxcCiIP
         LS9pz4lZ2ruUA+NsjYpnhDCoLsQW3eMQvtR8LhsOJPoSnCydWfm6Zg1Hgi5CiuaqUFhQ
         mYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScuUET3Jx3790WWtzDciWGjRGXPi9X8ISFOvBcfPIsI=;
        b=r/65IbRtuYRA62SZH4/SjMHDHyCO1rT9CY8lv6j340ksAYhJDv5SgzWrb5QwDkEKKv
         2ajteyZpKYrNoLub9c56UIaRoKzGLLFI5+EWrOU2SKcWksuyj9LzYY7rSFc8E90VZjij
         Y5AKx2bxwi606BfzRiudFhC+Hd691NIg2GpREGOtDBOJZznpF2MtE4NNkIbUvdxcwBHk
         dsjg/3qmfIf+oWUDA5o/JwalqfAlEOwJJqkoUKSVAQig3/V3s76uelBM0yT/01TE3qIH
         I2d7JJUFGxMCJS3PyUfmI0+i0TOpHyN7MspYEJ/SPOSQ2exZU19MSYSbcpKjlM8k0TSG
         9L0Q==
X-Gm-Message-State: ACrzQf1yOD+kVa2WA1OQsX+g0o2ErDEY3EARFV9GmHAV48VtF+IyBr73
        CiIeyvYTcRhwTK3EiEFzsgJ41z+IGbo=
X-Google-Smtp-Source: AMsMyM5txHoDUQHV74JbL/I6drhqJzAVd4b0cSj6OCCI9DN1HmElG8LQngrwgUKWVyAIdwt42FAiHVc9R6A=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:f99b:157d:615b:bbd8])
 (user=glider job=sendgmr) by 2002:a17:906:7d8c:b0:7ae:159d:1146 with SMTP id
 v12-20020a1709067d8c00b007ae159d1146mr3887934ejo.528.1667483138558; Thu, 03
 Nov 2022 06:45:38 -0700 (PDT)
Date:   Thu,  3 Nov 2022 14:45:15 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103134515.1934867-1-glider@google.com>
Subject: [PATCH v2] x86/traps: avoid KMSAN bugs originating from handle_bug()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
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

There is a case in exc_invalid_op handler that is executed outside the
irqentry_enter()/irqentry_exit() region when an UD2 instruction is used
to encode a call to __warn().

In that case the `struct pt_regs` passed to the interrupt handler is
never unpoisoned by KMSAN (this is normally done in irqentry_enter()),
which leads to false positives inside handle_bug().

Use kmsan_unpoison_entry_regs() to explicitly unpoison those registers
before using them.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>

---

v2:
 - move the call to kmsan_unpoison_entry_regs() after the
   instrumentation_begin(), as suggested by Peter Zijlstra
---
 arch/x86/kernel/traps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 178015a820f08..66701b4d99acd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -15,6 +15,7 @@
 #include <linux/context_tracking.h>
 #include <linux/interrupt.h>
 #include <linux/kallsyms.h>
+#include <linux/kmsan.h>
 #include <linux/spinlock.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
@@ -308,6 +309,13 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * All lies, just get the WARN/BUG out.
 	 */
 	instrumentation_begin();
+
+	/*
+	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
+	 * is a rare case that uses @regs without passing them to
+	 * irqentry_enter().
+	 */
+	kmsan_unpoison_entry_regs(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
-- 
2.38.1.273.g43a17bfeac-goog

