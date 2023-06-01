Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673DD71F3E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjFAUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjFAUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:31:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B05E42;
        Thu,  1 Jun 2023 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3vdVcpDDqjYKJw5ak8ynV4DjOPhUS8HxP0LDWIL1igw=; b=Uwmub2azMCaIbjuHuFLLx5IvzQ
        eFOI326Kms4l4wmTXrlpVawriFra0lmkqkO6HGD533NRRq8Rsq3sGtqpsJNn14UpGdrbCJqWHARMN
        1U932RMwU0NTrCtfYn+xcheb7TrYzKfVTyTHKMQdZZW/bknEVOzdPPpBwqCCRTx4l2bJQxguoesXy
        3eW3jBZYLpzlTZBX7pdoQw6P83tHrzlCk1Bqnxmt4oELtM0sncWIi7ilTUQmULRj7Lxqt9wX0JjPP
        ywsU5vCcI4xl1efroIVCmzrp2xMnhUhzAq92tfhNZ8w26T6SgZSd8g4O8rC2d+ACle1c218DwB+mK
        CZHkw23A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4oxF-008fu5-R0; Thu, 01 Jun 2023 20:31:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1310A300220;
        Thu,  1 Jun 2023 22:31:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2A16202F9541; Thu,  1 Jun 2023 22:31:27 +0200 (CEST)
Date:   Thu, 1 Jun 2023 22:31:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Noonan <steven@uplinklabs.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
Message-ID: <20230601203127.GY4253@hirez.programming.kicks-ass.net>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <87mt1jeax1.ffs@tglx>
 <87h6rrdoy0.ffs@tglx>
 <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 07:07:38PM +0000, Steven Noonan wrote:
> One issue is how much overhead it has. This is an instruction that
> normally executes in roughly 50 clock cycles (RDTSC) to 100 clock
> cycles (RDTSCP) on Zen 3. Based on a proof-of-concept I wrote, the
> overhead of trapping and emulating with a signal handler is roughly
> 100x. On my Zen 3 system, it goes up to around 10000 clock cycles per
> trapped read of RDTSCP.

What about kernel based emulation? You could tie it into user_dispatch
and have a user_dispatch tsc offset.

So regular kernel emulation simply returns the native value (keeps the
VDSO working for one), but then from a user_dispatch range, it returns
+offset.

That is; how slow is the below?

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58b1f208eff5..18175b45db1f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -645,6 +645,25 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
 	return true;
 }
=20
+static bool fixup_rdtsc_exception(struct pt_regs *regs)
+{
+	unsigned short bytes;
+	u32 eax, edx;
+
+	if (get_user(bytes, (const short __user *)ip))
+		return false;
+
+	if (bytes !=3D 0x0f31)
+		return false;
+
+	asm volatile ("rdtsc", "=3Da" (eax), "=3Dd" (edx));
+	regs->ax =3D eax;
+	regs->dx =3D edx;
+
+	regs->ip +=3D 2;
+	return true;
+}
+
 /*
  * The unprivileged ENQCMD instruction generates #GPs if the
  * IA32_PASID MSR has not been populated.  If possible, populate
@@ -752,6 +771,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_iopl_exception(regs))
 			goto exit;
=20
+		if (fixup_rdtsc_exception(regs))
+			goto exit;
+
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
=20
