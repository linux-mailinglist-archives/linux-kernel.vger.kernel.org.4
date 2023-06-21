Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C8738EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjFUSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFUSeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:34:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE251716
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6WoaTOxW3/lpjsUxhWz/wpULKurj8E91MSoYUmtuf6U=; b=oOkdrTPmIzr+PlT6Em4uMCIvCB
        YRMwZz9ii7RejEJyudRCYt68Zd3AP/U0qfiLFuqnstxiUz7rzcW7hMuYvk2x+dkCK0B2raWmwgn4M
        dQf/PiC43hhdM9BkXc6dPMDVNSmwcjcJBKkXlXhKpUsK06PbH0EIqkdoqlfqDj5ZCadBxxyi6Izfs
        RJER9FdeUuJOJOgCQTGnK50auR0SHfwohPmWoN67EUdemlRVhuALWNKDSnOvZkEEGz/QYimcx6c6k
        ZxQcvBuQ/pvXOWRymIuXwY/zyVTP6bVoxomR0oKezhFfak8sDp8S4JMatJ4GwUfs1Ai3NnCDKQkIS
        YnEK71Kw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC2eT-00EtHC-HQ; Wed, 21 Jun 2023 18:33:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A34E3002A9;
        Wed, 21 Jun 2023 20:33:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65BCC21440F49; Wed, 21 Jun 2023 20:33:56 +0200 (CEST)
Date:   Wed, 21 Jun 2023 20:33:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
Message-ID: <20230621183356.GP38236@hirez.programming.kicks-ass.net>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.127844423@infradead.org>
 <202306201455.AF16F617A@keescook>
 <20230621085217.GI2046280@hirez.programming.kicks-ass.net>
 <20230621092759.GJ2046280@hirez.programming.kicks-ass.net>
 <202306211107.4D529222C@keescook>
 <20230621181659.GB4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621181659.GB4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:16:59PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 11:08:46AM -0700, Kees Cook wrote:
> 
> > Ah yeah, it should be direct-called only. I keep forgetting about the
> > endbr removal pass.
> > 
> > > I can't seem to manage to have it clobber it's __cfi hash value. Ideally
> > > we'd have an attribute to force the thing to 0 or something.
> > 
> > Doesn't objtool have logic to figure out this is only ever
> > direct-called?
> 
> It does; let me also use that same thing to clobber the kCFI hashes for
> these functions.

Completely untested... gotta go put the kids to bed. I'll try later.

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -778,6 +778,8 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+static void poison_hash(void *addr);
+
 static void __init_or_module poison_endbr(void *addr, bool warn)
 {
 	u32 endbr, poison = gen_endbr_poison();
@@ -802,6 +804,9 @@ static void __init_or_module poison_endb
 
 /*
  * Generated by: objtool --ibt
+ *
+ * Seal the functions for indirect calls by clobbering the ENDBR instructions
+ * and the kCFI hash value.
  */
 void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
 {
@@ -812,7 +817,7 @@ void __init_or_module noinline apply_ibt
 
 		poison_endbr(addr, true);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_endbr(addr - 16, false);
+			poison_hash(addr - 16);
 	}
 }
 
@@ -1193,6 +1198,38 @@ static void __apply_fineibt(s32 *start_r
 	pr_err("Something went horribly wrong trying to rewrite the CFI implementation.\n");
 }
 
+static inline void __poison_hash(void *addr)
+{
+	*(u32 *)hash = 0;
+}
+
+static void poison_hash(void *addr)
+{
+	switch (cfi_mode) {
+	case CFI_FINEIBT:
+		/*
+		 * __cfi_\func:
+		 *	osp nopl (%rax)
+		 *	subl	$0, %r10d
+		 *	jz	1f
+		 *	ud2
+		 * 1:	nop
+		 */
+		poison_endbr(addr, false);
+		__poison_hash(addr + 7);
+		break;
+
+	case CFI_KCFI:
+		/*
+		 * __cfi_\func:
+		 *	movl	$0, %eax
+		 *	.skip	11, 0x90
+		 */
+		__poison_hash(addr + 1);
+		break;
+	}
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
@@ -1200,6 +1237,8 @@ static void __apply_fineibt(s32 *start_r
 {
 }
 
+static void poison_hash(void *addr) { }
+
 #endif
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
