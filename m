Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB22F66571C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbjAKJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbjAKJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:14:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F1BC17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uKH7RdVENw3RLiAjTEDH9D/8mvYYWQIYWy15IOfkE7I=; b=sMKkrBx7B+eEUcYtyWs34je/3J
        v8TnxPVubc9Ry+CaPUWnfcr6Jx2Xc3ODUBE1MznjFJY0Xo+z59f34FDGI/wed81tHzxerckmSIxmO
        cFcgU8MUNiiWE2fLT7A2FKs4AMjumQsHQXHNv46kE5hPgwcPbfpN4Gk/erojpSsdnX+KMu2DFaGK6
        XVSh6Q0QbKlyOZiIBfMfKiStabUYlpejhWUKa1gQ0j28X0T3gtNL7mlaC7OfHJNZecvqRmT4D8jCo
        Yyu/ilEkzRLCG7UOqiBuoBxm7CuUz0nwyteVSLEOe2tTLP/sj/GAqIgWUkIl/nk5JsNYMT0Ulnkob
        j9zHoAbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFX84-003yvY-0F; Wed, 11 Jan 2023 09:10:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA57330006D;
        Wed, 11 Jan 2023 10:10:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 927CE20575A14; Wed, 11 Jan 2023 10:10:24 +0100 (CET)
Date:   Wed, 11 Jan 2023 10:10:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Chen, Yian" <yian.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Message-ID: <Y759AJ/0N9fqwDED@hirez.programming.kicks-ass.net>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <Y73S56t/wDIGEPlK@hirez.programming.kicks-ass.net>
 <34600873-3716-eedd-84d0-dada88dc1a70@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34600873-3716-eedd-84d0-dada88dc1a70@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 05:01:59PM -0800, Chen, Yian wrote:

> > > +/* Deactivate/activate LASS via AC bit in EFLAGS register */
> > > +static __always_inline void low_addr_access_begin(void)
> > > +{
> > > +	/* Note: a barrier is implicit in alternative() */
> > > +	alternative("", __ASM_STAC, X86_FEATURE_LASS);
> > > +}
> > > +
> > > +static __always_inline void low_addr_access_end(void)
> > > +{
> > > +	/* Note: a barrier is implicit in alternative() */
> > > +	alternative("", __ASM_CLAC, X86_FEATURE_LASS);
> > > +}
> > 
> > Can't say I like the name.
> Indeed, there are alternative ways to name the functions. for example,
> enable_kernel_lass()/disable_kernel_lass(), or simply keep no change to use
> stac()/clac().
> 
> I choose this name because it is straight forward to the purpose and helps
> in understanding when to use the functions.

Given we normally refer to the kernel address space as negative, it is
somewhat confusing.

  lass_access_{begin,end}()

or something might be better names.

> Also if you look at bit 63 as a sign bit,
> > it's actively wrong since -1 is lower than 0.
> This could be a trade-off choice. While considering address manipulation
> and calculation, it is likely an unsigned. I would be happy to get input for
> better naming.

Note that Documentation/x86/x86_64/mm.rst likes to refer to the kernel
range as negative.

Also things like making a canonical address use sign-extention.

> > This is horrific tinkering :/
> > 
> This part seems difficult to have a perfect solution since function call or
> function pointer inside the guard of instruction stac and clac will trigger
> objtool warning (stated the reasons in the commit msg)

Yeah, I'm familiar with that objtool warning, I wrote that particular check :-)

Still, this is a horrific solution. Adding something like
__inline_mem{set,cpy}() is a much saner option.

Something a little like the completely untested below.

---
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 888731ccf1f6..f43fc2d9b182 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -23,6 +23,16 @@ extern void *memcpy(void *to, const void *from, size_t len);
 #endif
 extern void *__memcpy(void *to, const void *from, size_t len);
 
+static __always_inline void *__inline_memcpy(void *to, const void *from, size_t len)
+{
+	void *ret = to;
+
+	asm volatile ("rep movsb"
+		      : "+D" (to), "+S" (from), "+c" (len)
+		      : : "memory");
+	return ret;
+}
+
 #define __HAVE_ARCH_MEMSET
 #if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
 extern void *__msan_memset(void *s, int c, size_t n);
@@ -33,6 +43,17 @@ void *memset(void *s, int c, size_t n);
 #endif
 void *__memset(void *s, int c, size_t n);
 
+static __always_inline void *__inline_memset(void *s, int v, size_t n)
+{
+	void *ret = s;
+
+	asm volatile("rep stosb"
+		     : "+D" (s), "+c" (n)
+		     : "a" ((uint8_t)v)
+		     : "memory");
+	return ret;
+}
+
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
