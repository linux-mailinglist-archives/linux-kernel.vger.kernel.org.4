Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBC6618F3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjAHTzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjAHTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:55:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02854DF69
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 11:55:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 567B21EC01A9;
        Sun,  8 Jan 2023 20:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673207711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l0nCsBNrWj9vAboob2vechNm6FWmLtGGGL1Lz4ZbOTw=;
        b=jEupqBhfuoh0K9NtIt5sp0uwSvH6VI2N16UQtBg5JEUUWEYI1JtaNd/ykMwPP7hgpCs4y0
        EPTr+pmlCEPN8CfZMw4Dcj4o39t3dd9MMwbXcgENzCjy0agunzMES3ftrHrZe2SirPEa5m
        58ueIV1MyxtoTTaHKuCDUWVlBaVAOqU=
Date:   Sun, 8 Jan 2023 20:55:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86: Disable kernel stack offset randomization for !TSC
Message-ID: <Y7sfdxJ5/2DSQK/l@zn.tnic>
References: <alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 07:42:54PM +0000, Maciej W. Rozycki wrote:
> For x86 kernel stack offset randomization uses the RDTSC instruction, 
> which causes an invalid opcode exception with hardware that does not 
> implement this instruction:

Out of pure curiosity, what hw is that?

Also, I guess the fix should be something like this instead:

---
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 117903881fe4..57b372ca6ce7 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -85,7 +85,8 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 * Therefore, final stack offset entropy will be 5 (x86_64) or
 	 * 6 (ia32) bits.
 	 */
-	choose_random_kstack_offset(rdtsc() & 0xFF);
+	if (cpu_feature_enabled(X86_FEATURE_TSC))
+		choose_random_kstack_offset(rdtsc() & 0xFF);
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
