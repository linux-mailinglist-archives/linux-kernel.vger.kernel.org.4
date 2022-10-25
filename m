Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDC60D2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiJYRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJYRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:47:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068BEEA8D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p3g8pdZnfBkL1COikUpm6nl0PSwwuUfjSMk8qlWdfKU=; b=ZR0oSUyWJI0Ho1UjES4e/zw3OM
        P2ksiGArSki+LnZV2ocDoaZfvXVAUcZ5IrZjknBTcFt4Q6CfkQcgklqpKRvDj5yRvXYDVUtZq+u45
        47hFRnef0mrtJFklnK7WaYY799CC5W7o0tcjf+V8HRqwbVKOVKzXI0hANNblpgZ61wqVZub+TJjz6
        0TbpuEGpoYeuIIMBQ0lb/yY7ynXLIXd3HrhXF+0Bf6pCpDXKEflaU2Dz81RcHygb4gIooeCCYG0Ls
        wPDBjZMB6JJU20hmyyeWabfc3Hh4OaxUlTl/gPyDL/gyNK6RCTgD0S/PAcwJKyL3YBsVlJpxrLM5i
        gPYfJNdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onO1s-00GR7j-Pb; Tue, 25 Oct 2022 17:47:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3E4C300169;
        Tue, 25 Oct 2022 19:47:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84E702C45000F; Tue, 25 Oct 2022 19:47:50 +0200 (CEST)
Date:   Tue, 25 Oct 2022 19:47:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <Y1ghRheOJeAfJvdY@hirez.programming.kicks-ass.net>
References: <20221024114536.44686c83@gandalf.local.home>
 <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
 <20221024145250.08cfc147@gandalf.local.home>
 <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
 <Y1eu2wFVp1zcLg5b@hirez.programming.kicks-ass.net>
 <Y1e3i3RJRxOHTcJS@hirez.programming.kicks-ass.net>
 <CAHk-=wjwjWAhPD=C7sW7804eOTSQRnpSrrQh44PFYpVjn8SjKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwjWAhPD=C7sW7804eOTSQRnpSrrQh44PFYpVjn8SjKg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 09:53:27AM -0700, Linus Torvalds wrote:
> On Tue, Oct 25, 2022 at 3:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > This seems to boot...
> 
> This looks much better, thanks.
> 
> But this:
> 
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > @@ -801,8 +803,9 @@ void __init poking_init(void)
> >         spinlock_t *ptl;
> >         pte_t *ptep;
> >
> > -       poking_mm = copy_init_mm();
> > -       BUG_ON(!poking_mm);
> > +       __poking_mm = init_mm;
> > +       mm_init(&__poking_mm, NULL, __poking_mm.user_ns);
> > +       poking_mm = &__poking_mm;
> 
> Should probably be just
> 
>         poking_mm = mm_alloc();
> 
> because we shouldn't be messing with 'mm_init()' in places like this,
> and we shouldn't be exporting it either:

mm_alloc() uses allocate_mm() which requires a kmem_cache to be set-up.
Using the static storage and instead calling mm_init() on it avoids
that.

So I think we can have:

static struct mm_struct __poking_mm;

	mm_init(&__poking_mm, NULL, init_mm.user_ns);

and leave out the assignment from init_mm.
