Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4143F611803
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJ1Qss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJ1Qsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:48:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC521464C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OhpOuWjeen7QG1He6lXTiBfyZaGo2Ecqc0tyM0FhmYY=; b=v89NSJvDt4HVfbfHi/VcP+62QL
        Ofplk8KUS2qWPd42RjzNexz3DmjfBpg8PzD9c2v5GuTPyzMoFy44N3/Jv78HT3WE/uiilcEzYHUxQ
        o1oc4SaoCnGcCwSKBoeIw6NMgj5gLP3EJ5lWbz+FDcU8raSg+IWRv/Bziz+7+wfnXvw4TVpS0MdY1
        dtIXLR7Od74TtK6+5kQwWuxtbmXh6HJQPaSWikgd4+0OgyQt0R6KNE0swC+qYMfsPZstYOk6ais83
        WwVSMXbUj2Pn3UJaAtcO0IJKnUV+0HGqa9qnyzPNaC56T8Hyd/CkW2lWmXgE8Qn/KGoPmb7VL5vq7
        q/JkKMIg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40014 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ooSWk-00007E-6D; Fri, 28 Oct 2022 17:48:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1ooSWj-000FEM-Jl; Fri, 28 Oct 2022 17:48:13 +0100
In-Reply-To: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: findbit: add unwinder information
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ooSWj-000FEM-Jl@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 Oct 2022 17:48:13 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add unwinder information so oops in the findbit functions can create a
proper backtrace.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/lib/findbit.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 6ec584d16d46..b7ac2d3c0748 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -12,6 +12,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
                 .text
 
 #ifdef __ARMEB__
@@ -22,6 +23,7 @@
 
 		.macro	find_first, endian, set, name
 ENTRY(_find_first_\name\()bit_\endian)
+	UNWIND(	.fnstart)
 		teq	r1, #0
 		beq	3f
 		mov	r2, #0
@@ -41,11 +43,13 @@ ENTRY(_find_first_\name\()bit_\endian)
 		blo	1b
 3:		mov	r0, r1			@ no more bits
 		ret	lr
+	UNWIND(	.fnend)
 ENDPROC(_find_first_\name\()bit_\endian)
 		.endm
 
 		.macro	find_next, endian, set, name
 ENTRY(_find_next_\name\()bit_\endian)
+	UNWIND(	.fnstart)
 		cmp	r2, r1
 		bhs	3b
 		mov	ip, r2, lsr #5		@ word index
@@ -69,6 +73,7 @@ ENTRY(_find_next_\name\()bit_\endian)
 		orr	r2, r2, #31		@ no zero bits
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
+	UNWIND(	.fnend)
 ENDPROC(_find_next_\name\()bit_\endian)
 		.endm
 
@@ -97,6 +102,7 @@ ENDPROC(_find_next_\name\()bit_\endian)
  * One or more bits in the LSB of r3 are assumed to be set.
  */
 .L_found_swab:
+	UNWIND(	.fnstart)
 		rev_l	r3, ip
 .L_found:
 #if __LINUX_ARM_ARCH__ >= 7
@@ -130,4 +136,4 @@ ENDPROC(_find_next_\name\()bit_\endian)
 		cmp	r1, r0			@ Clamp to maxbit
 		movlo	r0, r1
 		ret	lr
-
+	UNWIND(	.fnend)
-- 
2.30.2

