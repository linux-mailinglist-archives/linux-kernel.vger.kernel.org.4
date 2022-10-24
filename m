Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C560BC02
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiJXVWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiJXVWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:22:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB9DA7ABB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E826B81031
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E06C433C1;
        Mon, 24 Oct 2022 19:26:46 +0000 (UTC)
Date:   Mon, 24 Oct 2022 15:26:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <20221024152656.3b0cfa21@gandalf.local.home>
In-Reply-To: <b772127d-8729-553a-000c-27cf4ddbf926@intel.com>
References: <20221024114536.44686c83@gandalf.local.home>
        <b772127d-8729-553a-000c-27cf4ddbf926@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 09:14:45 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 10/24/22 08:45, Steven Rostedt wrote:
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -587,6 +587,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> >  {
> >  	unsigned long end;
> >  
> > +	/* Kernel text is rw at boot up */
> > +	if (system_state == SYSTEM_BOOTING)
> > +		return new;  
> 
> Hi Steven,
> 
> Thanks for the report and the patch.  That seems reasonable, but I'm a
> bit worried that it opens up a big hole (boot time) when a W+X mapping
> could be created *anywhere*.
> 
> Could we restrict this bypass to *only* kernel text addresses during
> boot?  Maybe something like this:
> 
> 	if ((system_state == SYSTEM_BOOTING) &&
> 	    __kernel_text_address(start))
> 		return new;
> 
> That would be safe because we know that kernel_text_address() addresses
> will be made read-only by the time userspace shows up and that
> is_kernel_inittext() addresses will be freed.
> 
> Long-term, I wonder if we could teach the early patching code that it
> can't just use memcpy().
> 

This is hacky, and I agree with Linus, that ideally, we can get text_poke()
working better and remove all theses "special cases", but in case we
struggle to do so, the below patch also works.

It only looks at the one case that ftrace is setting up its trampoline at
early boot up.

-- Steve


diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 908d99b127d3..41b3ecd23a08 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -25,6 +25,8 @@
 #ifndef __ASSEMBLY__
 extern void __fentry__(void);
 
+extern long ftrace_updated_trampoline;
+
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	/*
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index bd165004776d..e2a1fc7bbe7a 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -417,7 +417,11 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	if (likely(system_state != SYSTEM_BOOTING))
 		set_memory_ro((unsigned long)trampoline, npages);
+	else
+		ftrace_updated_trampoline = trampoline;
 	set_memory_x((unsigned long)trampoline, npages);
+	ftrace_updated_trampoline = 0;
+
 	return (unsigned long)trampoline;
 fail:
 	tramp_free(trampoline);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 97342c42dda8..3fd3a45cafe8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -32,6 +32,7 @@
 #include <asm/memtype.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/ftrace.h>
 
 #include "../mm_internal.h"
 
@@ -579,6 +580,8 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
 	return __pgprot(pgprot_val(prot) & ~forbidden);
 }
 
+long ftrace_updated_trampoline;
+
 /*
  * Validate strict W^X semantics.
  */
@@ -587,6 +590,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 {
 	unsigned long end;
 
+	/* Kernel text is rw at boot up */
+	if (system_state == SYSTEM_BOOTING && ftrace_updated_trampoline == start)
+		return new;
+
 	/*
 	 * 32-bit has some unfixable W+X issues, like EFI code
 	 * and writeable data being in the same page.  Disable
