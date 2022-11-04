Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF16193EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKDJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKDJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:56:24 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7263233AF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:56:23 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2A49tesY459569
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 4 Nov 2022 02:55:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2A49tesY459569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1667555742;
        bh=GMykekS6UT+64FHMnJytNF1rVJ41762+wMQF3coXt5w=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=cCP1BfDlsLy/7X1UhKle+R1Nf9QUSB1VEcFwPlbDIMoZHDKIPMa/do+ZfC+IemQ3G
         fA95HmQaVdnoATfgmSoKC0HD7JuhkDwO3PuYrOnvoQdqb//CXm0FPCUErxgjuwKpLI
         v/6/3zK3N6RpBKO3xazx8Lqm7SMzUtU1G1qdytJRwq00DIcGIVwng1eEHKX5efAz8e
         n21kvyl573MEB/1NkndR/GbTU0LkUhLKM+OOx5N7rcg441998/XUu1Lty7QRWVLLhQ
         FrNFUlSIuaKeeatNGQPXDof3dR4RyR08KMGyt188T4yPaLiLkd4g5ZLUdBO159AWis
         GyLr0cDrk0Cfg==
Date:   Fri, 04 Nov 2022 02:55:37 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Huang Rui <ray.huang@amd.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-team@android.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/msr-index: make SPEC_CTRL_IBRS assembler-portable
User-Agent: K-9 Mail for Android
In-Reply-To: <20221103210748.1343090-1-ndesaulniers@google.com>
References: <20221103210748.1343090-1-ndesaulniers@google.com>
Message-ID: <94597E96-D4FB-4312-8F8B-473AAC0503F7@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 3, 2022 2:07:48 PM PDT, Nick Desaulniers <ndesaulniers@google=
=2Ecom> wrote:
>GNU binutils' assembler (GAS) didn't support L suffixes on immediates
>until binutils 2=2E28 release=2E Building arch/x86/entry/entry_64=2ES wit=
h GAS
>v2=2E27 will produce the following assembler errors:
>
>  arch/x86/entry/entry_64=2ES: Assembler messages:
>  arch/x86/entry/entry_64=2ES:308: Error: found 'L', expected: ')'
>  arch/x86/entry/entry_64=2ES:308: Error: found 'L', expected: ')'
>  arch/x86/entry/entry_64=2ES:308: Error: junk `L<<(0)))' after expressio=
n
>  arch/x86/entry/entry_64=2ES:596: Error: found 'L', expected: ')'
>  arch/x86/entry/entry_64=2ES:596: Error: found 'L', expected: ')'
>  arch/x86/entry/entry_64=2ES:596: Error: junk `L<<(0)))' after expressio=
n
>
>These come from the use of the preprocessor defined SPEC_CTRL_IBRS in
>the IBRS_ENTER and IBRS_EXIT assembler macros=2E SPEC_CTRL_IBRS was using
>the BIT macros from include/linux/bits=2Eh which are only portable betwee=
n
>C and assembler for assemblers such as GAS v2=2E28 (or newer) or clang
>because they use the L suffixes for immediate operands, which older GAS
>releases cannot parse=2E The kernel still supports GAS v2=2E23 and newer
>(and older for branches of stable)=2E Let's expand the value of
>SPEC_CTRL_IBRS in place so that assemblers don't have issues parsing the
>value=2E
>
>Fixes: 2dbb887e875b ("x86/entry: Add kernel IBRS implementation")
>Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google=2Ecom>
>---
>Some other ideas considered:
>* Use U64_C from include/asm-generic/int-ll64=2Eh rather than BIT for the
>  value of SPEC_CTRL_IBRS=2E
>  * Do so for the entirety of arch/x86/include/asm/msr-index=2Eh or just
>    SPEC_CTRL_IBRS? include/asm-generic/int-ll64=2Eh doesn't define a UL
>    suffix; add one?
>* Make include/linux/bits=2Eh assembler-portable (for older assemblers)
>  via the use of include/asm-generic/int-ll64=2Eh=2E
>
> arch/x86/include/asm/msr-index=2Eh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/msr-index=2Eh b/arch/x86/include/asm/ms=
r-index=2Eh
>index 10ac52705892=2E=2E0192d853136c 100644
>--- a/arch/x86/include/asm/msr-index=2Eh
>+++ b/arch/x86/include/asm/msr-index=2Eh
>@@ -46,7 +46,7 @@
> #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DE=
TECT_BIT)
>=20
> #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
>-#define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Specula=
tion */
>+#define SPEC_CTRL_IBRS			1	   /* Indirect Branch Restricted Speculation =
*/
> #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Pre=
dictor (STIBP) bit */
> #define SPEC_CTRL_STIBP			BIT(SPEC_CTRL_STIBP_SHIFT)	/* STIBP mask */
> #define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable b=
it */

Let's fix the macro instead=2E
