Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD2266B4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 00:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAOXtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 18:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjAOXtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 18:49:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA2F13533
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 15:49:48 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FF941EC01B7;
        Mon, 16 Jan 2023 00:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673826587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GR2HeCNj42FRs6f2h43Pa5yl6tcSUMkF7M500xNovcM=;
        b=X0CttyEoozJA+Pn3mKkueusKy5WNvIWCBU3HBYFEQ5bawDBcr8IEQ2aaLii9L+WW+ZXJWR
        0SVFczdTFuzGUl+grCYcNOSqZ6+yImxwntvbzlzHASzBWRXWxyomsXreDhltUy5W1hn5V/
        Og7OBeI+rcgAvC0MRr1BLD1kMIOelnc=
Date:   Mon, 16 Jan 2023 00:49:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Verkamp <dverkamp@chromium.org>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: combine memmove FSRM and ERMS alternatives
Message-ID: <Y8SREz5Aamcwsli5@zn.tnic>
References: <20230113203427.1111689-1-dverkamp@chromium.org>
 <Y8KE2h8LSKsrkJhX@zn.tnic>
 <Y8LVmIeUP4cw0oJS@zn.tnic>
 <Y8MVPcgWLZspXJxq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8MVPcgWLZspXJxq@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 09:49:01PM +0100, Borislav Petkov wrote:
> The more and more I think about it, the more I like the copy_user_generic() idea
> but lemme see how ugly it gets...

Something like this. It doesn't build yet but it is supposed to show what I mean
more concretely.

I definitely like the removal of the grafted ALTERNATIVEs in the asm code...

---

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 888731ccf1f6..0b48ebd74e2a 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -76,8 +76,17 @@ void *__msan_memmove(void *dest, const void *src, size_t len);
 #define memmove __msan_memmove
 #else
 void *memmove(void *dest, const void *src, size_t count);
+void *__memmove_fsrm(void *dest, const void *src, size_t count);
+void *__memmove_erms(void *dest, void *src, size_t count);
 #endif
-void *__memmove(void *dest, const void *src, size_t count);
+static __always_inline void *__memmove(void *dest, const void *src, size_t count)
+{
+	alternative_call_2(__memmove_fsrm,
+			   __memmove_erms, ALT_NOT(X86_FEATURE_FSRM),
+			   ___memmove, ALT_NOT(X86_FEATURE_ERMS));
+
+	return dest;
+}
 
 int memcmp(const void *cs, const void *ct, size_t count);
 size_t strlen(const char *s);
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 4f1a40a86534..039139fa5228 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -70,7 +70,7 @@ ifneq ($(CONFIG_GENERIC_CSUM),y)
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
 endif
         lib-y += clear_page_64.o copy_page_64.o
-        lib-y += memmove_64.o memset_64.o
+        lib-y += memmove_64.o memmove.o memset_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
 endif
diff --git a/arch/x86/lib/memmove.c b/arch/x86/lib/memmove.c
new file mode 100644
index 000000000000..70dbf85dbd35
--- /dev/null
+++ b/arch/x86/lib/memmove.c
@@ -0,0 +1,18 @@
+void *__memmove_fsrm(void *dest, const void *src, size_t count)
+{
+	if (dest < src)
+		return __memmove(dest, src, count);
+
+	asm volatile("rep; movsb\n\t"
+		    : "+D" (dest), "+S" (src), "c" (count));
+
+	return dest;
+}
+
+void *__memmove_erms(void *dest, void *src, size_t count)
+{
+	if (size < 32)
+		return __memmove(dest, src, count);
+
+	return __memmove_fsrm(dest, src, count);
+}
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 02661861e5dd..81a89bd146a1 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -26,9 +26,12 @@
  * Output:
  * rax: dest
  */
-SYM_FUNC_START(__memmove)
+SYM_FUNC_START(___memmove)
 
+	/* Handle more 32 bytes in loop */
 	mov %rdi, %rax
+	cmp $0x20, %rdx
+	jb	1f
 
 	/* Decide forward/backward copy mode */
 	cmp %rdi, %rsi
@@ -38,10 +41,7 @@ SYM_FUNC_START(__memmove)
 	cmp %rdi, %r8
 	jg 2f
 
-	/* FSRM implies ERMS => no length checks, do the copy directly */
 .Lmemmove_begin_forward:
-	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
-	ALTERNATIVE "", "jmp .Lmemmove_erms", X86_FEATURE_ERMS
 
 	/*
 	 * movsq instruction have many startup latency
@@ -207,13 +207,5 @@ SYM_FUNC_START(__memmove)
 	movb %r11b, (%rdi)
 13:
 	RET
-
-.Lmemmove_erms:
-	movq %rdx, %rcx
-	rep movsb
-	RET
-SYM_FUNC_END(__memmove)
-EXPORT_SYMBOL(__memmove)
-
-SYM_FUNC_ALIAS(memmove, __memmove)
-EXPORT_SYMBOL(memmove)
+SYM_FUNC_END(___memmove)
+EXPORT_SYMBOL(___memmove)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
