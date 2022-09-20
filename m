Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC035BEE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiITUAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiITUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:00:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8240BF2;
        Tue, 20 Sep 2022 13:00:22 -0700 (PDT)
Date:   Tue, 20 Sep 2022 20:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663704021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=td/0Lmoinj5QP/RSW+m2L52+twM1EDigUVdjwGaT5EQ=;
        b=NxkDySEsXZryEsfWdfAl+vc/sosE0IWQwkHHxySO5r3Xy0tFoAIXFhN0UktjUcK4H/CIum
        22XxdPb9zhvAAtutMmbE83Q75mRD8C2flwqLR8fXQz7u9+jiocj3L4pG72Oz/ZaYttGqnO
        Wn8FHwe3U5wFuatzd1+usLfHewUzKYCnwJn77VH5qu/f2gCcmAl6QIbDqmrmc3lDAH+QXH
        K08i6rKuFqJiLWZuRnY1bjvjhgATR9Quz3PX9RWvV5sSHGVPA0hKQxoof8tqlVhFgAhpWU
        BeYq6kwWnbul4NoIx2zTkTVR0b7Websldrjnc5SbbtD2TWFj5ymN+MESiUGBpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663704021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=td/0Lmoinj5QP/RSW+m2L52+twM1EDigUVdjwGaT5EQ=;
        b=ABA6KXS2pHFFYv2/aCc/wGXC1WCdKD1YlLRLDafGrbT1BZFDxMWIas65sz5atL60gomCVY
        iX3LDCTzGQUl7VCw==
From:   "tip-bot2 for Vincent Mailhol" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/bitops: Use __builtin_ffs() to evaluate
 constant expressions
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Message-ID: <166370401997.401.11967078990556002751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     146034fed6ee75ec09cf8f996165e2296ceae0bb
Gitweb:        https://git.kernel.org/tip/146034fed6ee75ec09cf8f996165e2296ceae0bb
Author:        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
AuthorDate:    Wed, 07 Sep 2022 18:09:34 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 20 Sep 2022 15:31:17 +02:00

x86/asm/bitops: Use __builtin_ffs() to evaluate constant expressions

For x86_64, the current ffs() implementation does not produce optimized
code when called with a constant expression. On the contrary, the
__builtin_ffs() functions of both GCC and clang are able to fold the
expression into a single instruction.

** Example **

Consider two dummy functions foo() and bar() as below:

  #include <linux/bitops.h>
  #define CONST 0x01000000

  unsigned int foo(void)
  {
  	return ffs(CONST);
  }

  unsigned int bar(void)
  {
  	return __builtin_ffs(CONST);
  }

GCC would produce below assembly code:

  0000000000000000 <foo>:
     0:	ba 00 00 00 01       	mov    $0x1000000,%edx
     5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a:	0f bc c2             	bsf    %edx,%eax
     d:	83 c0 01             	add    $0x1,%eax
    10:	c3                   	ret
  <Instructions after ret and before next function were redacted>

  0000000000000020 <bar>:
    20:	b8 19 00 00 00       	mov    $0x19,%eax
    25:	c3                   	ret

And clang would produce:

  0000000000000000 <foo>:
     0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5:	0f bc 05 00 00 00 00 	bsf    0x0(%rip),%eax        # c <foo+0xc>
     c:	83 c0 01             	add    $0x1,%eax
     f:	c3                   	ret

  0000000000000010 <bar>:
    10:	b8 19 00 00 00       	mov    $0x19,%eax
    15:	c3                   	ret

Both examples clearly demonstrate the benefit of using __builtin_ffs()
instead of the kernel's asm implementation for constant expressions.

However, for non constant expressions, the kernel's ffs() asm version
remains better for x86_64 because, contrary to GCC, it doesn't emit the
CMOV assembly instruction, c.f. [1] (noticeably, clang is able optimize
out the CMOV call).

Use __builtin_constant_p() to select between the kernel's ffs() and
the __builtin_ffs() depending on whether the argument is constant or
not.

As a side benefit, replacing the ffs() function declaration by a macro
also removes below -Wshadow warning:

  ./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs' shadows a built-in function [-Wshadow]
    283 | static __always_inline int ffs(int x)

** Statistics **

On a allyesconfig, before...:

  $ objdump -d vmlinux.o | grep bsf | wc -l
  1081

...and after:

  $ objdump -d vmlinux.o | grep bsf | wc -l
  792

So, roughly 26.7% of the calls to ffs() were using constant
expressions and could be optimized out.

(tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)

[1] commit ca3d30cc02f7 ("x86_64, asm: Optimise fls(), ffs() and fls64()")

  [ bp: Massage commit message. ]

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/20220511160319.1045812-1-mailhol.vincent@wanadoo.fr
---
 arch/x86/include/asm/bitops.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 0fe9de5..879238e 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -292,18 +292,7 @@ static __always_inline unsigned long __fls(unsigned long word)
 #undef ADDR
 
 #ifdef __KERNEL__
-/**
- * ffs - find first set bit in word
- * @x: the word to search
- *
- * This is defined the same way as the libc and compiler builtin ffs
- * routines, therefore differs in spirit from the other bitops.
- *
- * ffs(value) returns 0 if value is 0 or the position of the first
- * set bit if value is nonzero. The first (least significant) bit
- * is at position 1.
- */
-static __always_inline int ffs(int x)
+static __always_inline int variable_ffs(int x)
 {
 	int r;
 
@@ -334,6 +323,19 @@ static __always_inline int ffs(int x)
 }
 
 /**
+ * ffs - find first set bit in word
+ * @x: the word to search
+ *
+ * This is defined the same way as the libc and compiler builtin ffs
+ * routines, therefore differs in spirit from the other bitops.
+ *
+ * ffs(value) returns 0 if value is 0 or the position of the first
+ * set bit if value is nonzero. The first (least significant) bit
+ * is at position 1.
+ */
+#define ffs(x) (__builtin_constant_p(x) ? __builtin_ffs(x) : variable_ffs(x))
+
+/**
  * fls - find last set bit in word
  * @x: the word to search
  *
