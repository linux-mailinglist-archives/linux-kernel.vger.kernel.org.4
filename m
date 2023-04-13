Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F76E0CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDMLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDMLie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:38:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CEF26BA;
        Thu, 13 Apr 2023 04:38:33 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:38:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681385910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ar4P6FOes/2YqnqLR0lx/fCeGnBoUm/0XcPCZjCuPDI=;
        b=X2BwM+WYYjCLXeQhRGcKuv25IH9qr8T2hmdJtA5KgXfFpgUAQghyxvFrNxZZeqmIiK5dl7
        ji8RmGmNjmYytUpbbQTdlQgtRCFxafq91tSv+xYkXdG3qrelqIk3pKl7VCjfuQgJly5RJN
        /gL38NwXAheptmPtC6T+xDzJ2Q0o3dvHX83z9V7xeMP7AIWuOtYfbBTDBaEHnEGziOkvUA
        SW6AUPzCZoda5hFZCyA/NPIqWvlT5DNcQqueff23BJf++S1Od2UC4plNh6NKVoqq5vBY5C
        /46sL6NpPPQQi7NDN28wzEhpp1xp/LkGg1bj59cYOeaFoiRRzy3HgP/qVvNnWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681385910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ar4P6FOes/2YqnqLR0lx/fCeGnBoUm/0XcPCZjCuPDI=;
        b=tNFuxR8m1Gheh3StghczXrgNQnGDsUyt3qNGkkDWQe9b2CGMhLyp5Vzt96hGX5f8lR1icY
        ZyFcv5+rhn9VMnCQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/x86: Define arch_try_cmpxchg_local
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230405141710.3551-5-ubizjak@gmail.com>
References: <20230405141710.3551-5-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <168138590988.404.12145354091229728137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     561b081f19655a46a9690e868fa4aa516ff1b62c
Gitweb:        https://git.kernel.org/tip/561b081f19655a46a9690e868fa4aa516ff1b62c
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 05 Apr 2023 16:17:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 Apr 2023 16:46:35 +02:00

locking/x86: Define arch_try_cmpxchg_local

Define target specific arch_try_cmpxchg_local. This
definition overrides the generic arch_try_cmpxchg_local
fallback definition and enables target-specific
implementation of try_cmpxchg_local.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230405141710.3551-5-ubizjak@gmail.com
---
 arch/x86/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 94fbe6a..540573f 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,9 +221,15 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
+#define __try_cmpxchg_local(ptr, pold, new, size)			\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
+
 #define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+#define arch_try_cmpxchg_local(ptr, pold, new)				\
+	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
+
 /*
  * xadd() adds "inc" to "*ptr" and atomically returns the previous
  * value of "*ptr".
