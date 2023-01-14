Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3366AC90
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjANQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjANQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:17:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEEC83DD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:17:35 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DCC61EC050B;
        Sat, 14 Jan 2023 17:17:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673713054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tCppwdAyk0xCDR6yNSq4nEzTRHs/1KkFCfDo0KrtlWk=;
        b=LesZi11kzjR5X1Ruh9qvR1UHcYHvlUeAHNI6IsqqrhnGzrbfrBhykuqAY0JNjLSfijjCdG
        sd1MUmHlv4dhzIbYdgrXuZXX5vZ/0ZLciFQ3Z1E8U3Yj2xeAGkToFEFCV9uDHSuFbjTJR7
        cb2WpBUOe7TpnbRMG5tspHtz0yGZa1I=
Date:   Sat, 14 Jan 2023 17:17:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: combine memmove FSRM and ERMS alternatives
Message-ID: <Y8LVmIeUP4cw0oJS@zn.tnic>
References: <20230113203427.1111689-1-dverkamp@chromium.org>
 <Y8KE2h8LSKsrkJhX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8KE2h8LSKsrkJhX@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 11:42:13AM +0100, Borislav Petkov wrote:
> Or, altenatively (pun intended), you can do what copy_user_generic() does and
> move all that logic into C and inline asm. Which I'd prefer, actually, instead of
> doing ugly asm hacks. Depends on how ugly it gets...

Alternatively #2, you can do the below as a minimal fix for stable along with
explaining what we're doing there and why and then do the other things I
suggested - if you'd like, that is - later and with no pressure.

Thx.

---
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 02661861e5dd..d6ffb4164cdb 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -38,10 +38,9 @@ SYM_FUNC_START(__memmove)
 	cmp %rdi, %r8
 	jg 2f
 
-	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
 	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
-	ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
+	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
 
 	/*
 	 * movsq instruction have many startup latency


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
