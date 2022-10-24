Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A660B88A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiJXTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiJXTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6A2A973
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1E66151F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B5DC433C1;
        Mon, 24 Oct 2022 18:13:18 +0000 (UTC)
Date:   Mon, 24 Oct 2022 14:13:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <20221024141329.71a7431a@gandalf.local.home>
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

Actually, that brings back the warning, as ftrace creates a trampoline, but
text_poke() will still use memcpy on it at early boot up.

The trampolines are set to ro at the end of boot up by:

59566b0b622e3 ("x86/ftrace: Have ftrace trampolines turn read-only at the end of system boot up")

Which was added because of text_poke() doing the memcpy().

> 
> That would be safe because we know that kernel_text_address() addresses
> will be made read-only by the time userspace shows up and that
> is_kernel_inittext() addresses will be freed.
> 
> Long-term, I wonder if we could teach the early patching code that it
> can't just use memcpy().
> 

Maybe.

-- Steve

