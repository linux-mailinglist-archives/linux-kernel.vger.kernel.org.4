Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6495BEE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiITUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiITUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:00:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B163ED69;
        Tue, 20 Sep 2022 13:00:22 -0700 (PDT)
Date:   Tue, 20 Sep 2022 20:00:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663704020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6KfugY/ZF2k+N60z0DOxutQrzRQ1q7GMoUe0LhivhQ=;
        b=zELUirONf6R7vie97BPX9AnZ2VjamZSksRRaV08+zTfKtYk2/Bg/N0zCYxoctMLaHRNwgR
        zqf2SV++qm5sffkAVZE+PcQuBHsONk0Rx7uGF9JOeSY5Ain9WLS9HV4IcdSVE59YGyJjb7
        1GMTXDHBimKOhZKrrROP4DcVfBCDg1jVWabN5RxOT2Ktv+78jZw/suO90wyh2BA507sfhJ
        kpYemMp44QmYb+yb7LkRlRm83vK6q5w9hjHmPVlw83xoPNSk6dQe4mw9B0Rqm6vChvtvAV
        1Eju7NA63+0CRnRlyC/6kgrSALfgi3getdc0k1hHEbf8rNtUGKQrDFxLnKSCYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663704020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6KfugY/ZF2k+N60z0DOxutQrzRQ1q7GMoUe0LhivhQ=;
        b=SSpRiuIfu6l4gPSIBu5IBl+nFPBNA80dxHSF/X64Ig5dnegfDauwjhqthaCZm29Jla2LcE
        HWi8q6N9JChTUcDA==
From:   "tip-bot2 for Vincent Mailhol" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/bitops: Use __builtin_ctzl() to evaluate
 constant expressions
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Message-ID: <166370401862.401.15713055946708670653.tip-bot2@tip-bot2>
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

Commit-ID:     fdb6649ab7c142e497539a471e573c2593b9c923
Gitweb:        https://git.kernel.org/tip/fdb6649ab7c142e497539a471e573c2593b9c923
Author:        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
AuthorDate:    Wed, 07 Sep 2022 18:09:35 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 20 Sep 2022 15:35:37 +02:00

x86/asm/bitops: Use __builtin_ctzl() to evaluate constant expressions

If x is not 0, __ffs(x) is equivalent to:
  (unsigned long)__builtin_ctzl(x)
And if x is not ~0UL, ffz(x) is equivalent to:
  (unsigned long)__builtin_ctzl(~x)
Because __builting_ctzl() returns an int, a cast to (unsigned long) is
necessary to avoid potential warnings on implicit casts.

Concerning the edge cases, __builtin_ctzl(0) is always undefined,
whereas __ffs(0) and ffz(~0UL) may or may not be defined, depending on
the processor. Regardless, for both functions, developers are asked to
check against 0 or ~0UL so replacing __ffs() or ffz() by
__builting_ctzl() is safe.

For x86_64, the current __ffs() and ffz() implementations do not
produce optimized code when called with a constant expression. On the
contrary, the __builtin_ctzl() folds into a single instruction.

However, for non constant expressions, the __ffs() and ffz() asm
versions of the kernel remains slightly better than the code produced
by GCC (it produces a useless instruction to clear eax).

Use __builtin_constant_p() to select between the kernel's
__ffs()/ffz() and the __builtin_ctzl() depending on whether the
argument is constant or not.

** Statistics **

On a allyesconfig, before...:

  $ objdump -d vmlinux.o | grep tzcnt | wc -l
  3607

...and after:

  $ objdump -d vmlinux.o | grep tzcnt | wc -l
  2600

So, roughly 27.9% of the calls to either __ffs() or ffz() were using
constant expressions and could be optimized out.

(tests done on linux v5.18-rc5 x86_64 using GCC 11.2.1)

Note: on x86_64, the BSF instruction produces TZCNT when used with the
REP prefix (which explain the use of `grep tzcnt' instead of `grep bsf'
in above benchmark). c.f. [1]

[1] e26a44a2d618 ("x86: Use REP BSF unconditionally")

  [ bp: Massage commit message. ]

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/20220511160319.1045812-1-mailhol.vincent@wanadoo.fr
---
 arch/x86/include/asm/bitops.h | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 879238e..2edf684 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -247,17 +247,30 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
 					  variable_test_bit(nr, addr);
 }
 
+static __always_inline unsigned long variable__ffs(unsigned long word)
+{
+	asm("rep; bsf %1,%0"
+		: "=r" (word)
+		: "rm" (word));
+	return word;
+}
+
 /**
  * __ffs - find first set bit in word
  * @word: The word to search
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __ffs(unsigned long word)
+#define __ffs(word)				\
+	(__builtin_constant_p(word) ?		\
+	 (unsigned long)__builtin_ctzl(word) :	\
+	 variable__ffs(word))
+
+static __always_inline unsigned long variable_ffz(unsigned long word)
 {
 	asm("rep; bsf %1,%0"
 		: "=r" (word)
-		: "rm" (word));
+		: "r" (~word));
 	return word;
 }
 
@@ -267,13 +280,10 @@ static __always_inline unsigned long __ffs(unsigned long word)
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static __always_inline unsigned long ffz(unsigned long word)
-{
-	asm("rep; bsf %1,%0"
-		: "=r" (word)
-		: "r" (~word));
-	return word;
-}
+#define ffz(word)				\
+	(__builtin_constant_p(word) ?		\
+	 (unsigned long)__builtin_ctzl(~word) :	\
+	 variable_ffz(word))
 
 /*
  * __fls: find last set bit in word
