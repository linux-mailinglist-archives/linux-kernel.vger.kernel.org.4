Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46029737DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjFUITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFUITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:19:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF44DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jVkiflIGIDxM+UWWexk9yHyzCk/IgaWy2uux2hNvwlM=; b=LLh3ZQZVs6yBQGINFenjPn1w7s
        HXOzfaJAyYuQ2HaVKi3UVLGSC9rnuVSxjyRsjV/AcCPl0ehtLtaPwQPI3lW+QdCPLMY4g1t6vrC61
        uepo4Y+JpcYDFUDFATB1n8Bu3f2Na1wMvGFuhLH6d6AfXQBMBY2ZIFWdHSsNX54tEr8ZM9CuilXd0
        r/E6SVEIWj1OE3RQlIuHazAjSFYeam+P3AxlKRY95eJUHaCosDqGRywhWBly4cSnlFDb+PDxzTJ1u
        s2K051FVbru8b5iLOwdbYCm2VEuqcRbrdQYaqCmbEiovXgU3xQXBYFFN60xCMxBf5v2GS8jsQvekY
        +/qAvloQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBt3K-00HJMp-0T;
        Wed, 21 Jun 2023 08:18:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45D9C300222;
        Wed, 21 Jun 2023 10:18:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31B6920825AFA; Wed, 21 Jun 2023 10:18:57 +0200 (CEST)
Date:   Wed, 21 Jun 2023 10:18:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] x86/fineibt: Poison ENDBR at +0
Message-ID: <20230621081857.GG2046280@hirez.programming.kicks-ass.net>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.194131053@infradead.org>
 <202306201454.0A2E875F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306201454.0A2E875F@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:55:10PM -0700, Kees Cook wrote:
> On Thu, Jun 15, 2023 at 09:35:48PM +0200, Peter Zijlstra wrote:
> > Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
> > booting on IBT enabled hardware obtain FineIBT, the indirect functions
> > look like:
> > 
> >   __cfi_foo:
> > 	endbr64
> > 	subl	$hash, %r10d
> > 	jz	1f
> > 	ud2
> > 	nop
> >   1:
> >   foo:
> > 	endbr64
> > 
> > This is because clang currently does not supress ENDBR emission for
> > functions it provides a __cfi prologue symbol for.
> 
> Should this be considered a bug in Clang?

No, I don't think so. I was going to say this is perhaps insufficiently
explored space, but upon more consideration I think this is actually
correct behaviour (and I need to write a better Changelog).

The issue is that the compiler generates code for kCFI+IBT, it doesn't
know about FineIBT *at*all*. Additionally, one can inhibit patching of
FineIBT by booting with 'cfi=kcfi' on IBT enabled hardware.

And in that case (kCFI+IBT), we'll do the caller hash check and still
jump to +0, so there really must be an ENDBR there.

Only if we were to dis-allow this combination could we say the ENDBR at
+0 becomes superfluous and should find means for the compiler not emit
it.

> > Having this second ENDBR however makes it possible to elide the CFI
> > check. Therefore, we should poison this second ENDBR (if present) when
> > switching to FineIBT mode.
> > 
> > Fixes: 931ab63664f0 ("x86/ibt: Implement FineIBT")
> > Reported-by: "Milburn, Alyssa" <alyssa.milburn@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Looks like a good work-around.
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks!
