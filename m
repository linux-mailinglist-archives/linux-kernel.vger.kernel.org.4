Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E8E612265
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2Laj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2Lah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:30:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8EB543F4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IOOGV+YZbiG9s8YpR/YS2ukn7chj0NJsXzKMc/v56f4=; b=mLyE3ocmDDL0jx3P2OzXzqpFyj
        iALrtmTQl5V6sUeOP8TEqCENUstxuZbDpMrI9u/DlBcB6hXcoQKHm/qPLSbP5ugCndwZMx1+iFiGs
        +P79xZ/Hf3jfSAHjsF4YZlHVin5ZNpJYegmDEZ1CzpmlGkry2kZofjztzTW3Ood/HMJlXPZRUkhbu
        KnPLcNmo4Kfh+Z7n9WhFViM+6jtOODINZc7+YtvE6YwmcXh3hxGAglzMAcRLn/Qr2IrYVpVu3dz9V
        Tbhz+qAzwqWQbJXGDH6UL7bTYCzvGdI1vjXihHVQMukKsMjXlDW7o3ukb5tedpEZB0GNeu9wT7DB3
        vC4XPRMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ook2h-0022Lp-FK; Sat, 29 Oct 2022 11:30:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3C333001CB;
        Sat, 29 Oct 2022 13:30:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8555C203D9A1B; Sat, 29 Oct 2022 13:30:16 +0200 (CEST)
Date:   Sat, 29 Oct 2022 13:30:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rostedt@goodmis.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: Re: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
Message-ID: <Y10OyLCLAAS6rsZv@hirez.programming.kicks-ass.net>
References: <20221025200656.951281799@infradead.org>
 <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
 <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net>
 <CAHk-=wjaoB+9pJ1ouLbKuqgadqDxdhyCHi0rO-u-5bOi1qUv=w@mail.gmail.com>
 <Y1osYVoLrpCabNrR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1osYVoLrpCabNrR@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:59:45AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 26, 2022 at 10:59:29AM -0700, Linus Torvalds wrote:
> 
> > Maybe you meant to do that, and this patch was just prep-work for the
> > arch code being the second stage?
> 
> Yeah; also, since this is cross arch, we need a fallback. Anyway;
> robots hated on me for missing a few includes. I'll go prod at this
> more.

Got around to it; I added the below patch on top and things seem to
still boot so it must be good :-)

---
Subject: x86/mm: Implement native set_memory_rox()
From: Peter Zijlstra <peterz@infradead.org>
Date: Sat Oct 29 13:19:31 CEST 2022

Provide a native implementation of set_memory_rox(), avoiding the
double set_memory_ro();set_memory_x(); calls.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/set_memory.h |    3 +++
 arch/x86/mm/pat/set_memory.c      |   10 ++++++++++
 include/linux/set_memory.h        |    2 ++
 3 files changed, 15 insertions(+)

--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -6,6 +6,9 @@
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
+#define set_memory_rox set_memory_rox
+int set_memory_rox(unsigned long addr, int numpages);
+
 /*
  * The set_memory_* API can be used to change various attributes of a virtual
  * address range. The attributes include:
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2025,6 +2025,16 @@ int set_memory_ro(unsigned long addr, in
 	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
 }
 
+int set_memory_rox(unsigned long addr, int numpages)
+{
+	pgprot_t clr = __pgprot(_PAGE_RW);
+
+	if (__supported_pte_mask & _PAGE_NX)
+		clr.pgprot |= _PAGE_NX;
+
+	return change_page_attr_clear(&addr, numpages, clr, 0);
+}
+
 int set_memory_rw(unsigned long addr, int numpages)
 {
 	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_RW), 0);
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -14,6 +14,7 @@ static inline int set_memory_x(unsigned
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#ifndef set_memory_rox
 static inline int set_memory_rox(unsigned long addr, int numpages)
 {
 	int ret = set_memory_ro(addr, numpages);
@@ -21,6 +22,7 @@ static inline int set_memory_rox(unsigne
 		return ret;
 	return set_memory_x(addr, numpages);
 }
+#endif
 
 #ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
 static inline int set_direct_map_invalid_noflush(struct page *page)
