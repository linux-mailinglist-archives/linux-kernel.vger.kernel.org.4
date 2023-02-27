Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9E46A3FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjB0KuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0KuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:50:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0735CA2A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:49:59 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 464391EC053F;
        Mon, 27 Feb 2023 11:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677494998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VqxU85nvGdlx9Pi4HtTodVA4yIqLoYPSlLVaoO/N2Do=;
        b=YmX/FITrS7OKTjO5iWm0Xz43PAzyZO3N9tb7SIfyeq1my5m2M0pobMDlLoO9Y+O5M69eQn
        DMl6VmppzespU/nATIM9qvOoCoRwhSFBMQ2g4dEoi+aUEVQw+nnfNyE83BdTor3gdmm8Om
        bG17rgBYIjGv6nICrZZESboE91Jcq6I=
Date:   Mon, 27 Feb 2023 11:49:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, Andrew.Cooper3@citrix.com,
        jpoimboe@redhat.com, Daniel Verkamp <dverkamp@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/lib/memmove: Decouple ERMS from FSRM
Message-ID: <Y/yK0dyzI0MMdTie@zn.tnic>
References: <20230208171050.490809180@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208171050.490809180@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:10:50PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> This version is fully tested and includes a few NOP twiddles inspired by the
> objtool patches I'll post separately.
> 
> Also available at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/core

Ontop of the first two:

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Sun, 26 Feb 2023 21:04:26 +0100
Subject: [PATCH] x86/lib/memmove: Decouple ERMS from FSRM

Up until now it was perceived that FSRM is an improvement to ERMS and
thus it was made dependent on latter.

However, there are AMD BIOSes out there which allow for disabling of
either features and this preventing kernels from booting due to the CMP
disappearing and thus breaking the logic in the memmove() function.

Similar observation happens on some VM migration scenarios.

Patch the proper sequences depending on which feature is enabled.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reported-by: Daniel Verkamp <dverkamp@chromium.org>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
---
 arch/x86/lib/memmove_64.S | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 02661861e5dd..0559b206fb11 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -38,10 +38,12 @@ SYM_FUNC_START(__memmove)
 	cmp %rdi, %r8
 	jg 2f
 
-	/* FSRM implies ERMS => no length checks, do the copy directly */
+#define CHECK_LEN	cmp $0x20, %rdx; jb 1f
+#define MEMMOVE_BYTES	movq %rdx, %rcx; rep movsb; RET
 .Lmemmove_begin_forward:
-	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
-	ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
+	ALTERNATIVE_2 __stringify(CHECK_LEN), \
+		      __stringify(CHECK_LEN; MEMMOVE_BYTES), X86_FEATURE_ERMS, \
+		      __stringify(MEMMOVE_BYTES), X86_FEATURE_FSRM
 
 	/*
 	 * movsq instruction have many startup latency
@@ -207,11 +209,6 @@ SYM_FUNC_START(__memmove)
 	movb %r11b, (%rdi)
 13:
 	RET
-
-.Lmemmove_erms:
-	movq %rdx, %rcx
-	rep movsb
-	RET
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
