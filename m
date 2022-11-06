Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2832A61E16A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKFJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKFJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:51:27 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F0E017
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:51:26 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e129so8003643pgc.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnyJavHPkbHwX7+XS5T05mPkmW2Gv1owKlEwtY5yB8s=;
        b=EGDlpI4moUq2A6m7KudPbv/MhIVZ8nGbetGSacPWCapDt+bJN5bWh0NvT2KzL05wAW
         dHj2IK70k94AuZwQl1YZqgHBWP8Xak6m4PV128avPnBPcH6CzVgxADpz2Yi+u3N7jsbU
         LoDwwNUnurtjlEap0kie2cdbx+9s3cFGUQmt+MQBVRlDjicQ7p6Ix102pirz9Oeu5/Aj
         EKaPKKmsO7ywKz6Fn2Fr9V16xXqSXYlCM0gTrSB+K3VFEOKAOMzUAaMidUsjO8kgylIu
         icFbRlz9pQFjRgoIYZJzPKg93ukIgWp9rcrUqImfhOcRMouj2duI9ViSNqsUFFRlUQOn
         ossA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tnyJavHPkbHwX7+XS5T05mPkmW2Gv1owKlEwtY5yB8s=;
        b=5GJmTM4YO/BWRI4ZKoz0vkXDwG/vVxqeuJcrWqe9wC/mZoJJt2NUnfCtJn/Dw48Ei0
         XsoEAa4pXh/4Xn83wBId8kMGmcf8h668qIJALreS4OTSkLWfVW32LnBGaK0rkE4Bw5H4
         GRGKcJTHZSsTKhZEPW3hwGIRtqxDJUsm7mO+d0s5l3h60bGbeHMwbQMbQfvmfYdfGUFW
         GxApMmI2NvyvxyeEKRSb7eMApaQTaWqNUVsh4TR5pRiHcWJvvlAWy7be6F2+cFXKtNwv
         gFYaaS5AABUqBoI6xELAgUf5UO8IHBYTDvrknDcWUU6+RvRgTPeLZA00y2R+VE6RWcyC
         rcBQ==
X-Gm-Message-State: ACrzQf2+p9qyfyuGZFyFl/pWaAQo9GC5l/WWpwhdJ0zihQJHGOV6fm50
        Lh61DtNXjrBAWQwEGA/ks54=
X-Google-Smtp-Source: AMsMyM5r+Qz3YMVoETdR7h+aMmGAf6v1oaUetjL66GCctHuEVrvNmFzQ3T7P6YAkiFrbVQ6k7rkG8A==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr44307387pfb.43.1667728286198;
        Sun, 06 Nov 2022 01:51:26 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id b5-20020aa79505000000b0056bfd4a2702sm2368677pfp.45.2022.11.06.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:51:25 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v1 1/2] x86/asm/bitops: Replace __fls() by its generic builtin implementation
Date:   Sun,  6 Nov 2022 18:51:05 +0900
Message-Id: <20221106095106.849154-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below snippet:

  #include <linux/bitops.h>

  unsigned int foo(unsigned long word)
  {
  	return __fls(word);
  }

produces this on GCC 12.1.0:

  0000000000000000 <foo>:
     0:	f3 0f 1e fa          	endbr64
     4:	e8 00 00 00 00       	call   9 <foo+0x9>
     9:	53                   	push   %rbx
     a:	48 89 fb             	mov    %rdi,%rbx
     d:	e8 00 00 00 00       	call   12 <foo+0x12>
    12:	48 0f bd c3          	bsr    %rbx,%rax
    16:	5b                   	pop    %rbx
    17:	31 ff                	xor    %edi,%edi
    19:	e9 00 00 00 00       	jmp    1e <foo+0x1e>

and that on clang 14.0.6:

  0000000000000000 <foo>:
     0:	f3 0f 1e fa          	endbr64
     4:	e8 00 00 00 00       	call   9 <foo+0x9>
     9:	53                   	push   %rbx
     a:	50                   	push   %rax
     b:	48 89 fb             	mov    %rdi,%rbx
     e:	e8 00 00 00 00       	call   13 <foo+0x13>
    13:	48 89 1c 24          	mov    %rbx,(%rsp)
    17:	48 0f bd 04 24       	bsr    (%rsp),%rax
    1c:	48 83 c4 08          	add    $0x8,%rsp
    20:	5b                   	pop    %rbx
    21:	c3                   	ret

The implementation from <asm-generic/bitops/builtin-__fls.h> [1]
produces the exact same code on GCC and below code on clang:

  0000000000000000 <foo>:
     0:	f3 0f 1e fa          	endbr64
     4:	e8 00 00 00 00       	call   9 <foo+0x9>
     9:	53                   	push   %rbx
     a:	48 89 fb             	mov    %rdi,%rbx
     d:	e8 00 00 00 00       	call   12 <foo+0x12>
    12:	48 0f bd c3          	bsr    %rbx,%rax
    16:	5b                   	pop    %rbx
    17:	c3                   	ret

The builtin implementation is better for two reasons:

  1/ it saves two instructions on clang (a push and a stack pointer
     decrement) because of a useless tentative to save rax.

  2/ when used on constant expressions, the compiler is only able to
     fold the builtin version (c.f. [2]).

For those two reasons, replace the assembly implementation by its
builtin counterpart.

[1] https://elixir.bootlin.com/linux/v6.0/source/include/asm-generic/bitops/builtin-__fls.h

[2] commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate constant expressions")

CC: Borislav Petkov <bp@suse.de>
CC: Nick Desaulniers <ndesaulniers@google.com>
CC: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 arch/x86/include/asm/bitops.h | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 2edf68475fec..a31453d7686d 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -285,19 +285,7 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
 	 (unsigned long)__builtin_ctzl(~word) :	\
 	 variable_ffz(word))
 
-/*
- * __fls: find last set bit in word
- * @word: The word to search
- *
- * Undefined if no set bit exists, so code should check against 0 first.
- */
-static __always_inline unsigned long __fls(unsigned long word)
-{
-	asm("bsr %1,%0"
-	    : "=r" (word)
-	    : "rm" (word));
-	return word;
-}
+#include <asm-generic/bitops/builtin-__fls.h>
 
 #undef ADDR
 
-- 
2.37.4

