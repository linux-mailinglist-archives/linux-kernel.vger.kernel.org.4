Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8096036AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJRXb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRXby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:31:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEFC9DDBD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4B1BB82111
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52988C433D7;
        Tue, 18 Oct 2022 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666135910;
        bh=i7Rf7RuijYT+A1PrKXXj3WcVpmSNBggwpTrcljWZx70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+vz/mWHf1dXlJwO2qkfWQCFvUqf3CCY4IM05lcrxhlnQXcbGYha96wnS51nzXDJV
         mAGjrIZCQGh3Dh5LpLfqI2xwMCe+ORmMac4dlM3MSE+GZPf8Hql9gOsrA4iA4E/fD8
         qOM0eFEJiBn+jOT0MBSrnyTzlmm4+dzsJxlgycJp7NqH6lXmHF4etTlTI25IiwlzwS
         fWyJ+KUdbLyKsOZK7GQ0SDFsNXicQH3CMYWdPoijc5xwf3hV3cJcXO9sjCYakrrfEZ
         URzBQduygsfm4REFTyx+5CWO5ujnP6YnQBMp8q7gXt+HW30CpvvgcWpEgJe1nGD7xJ
         9i4mLpe4Fo3Qg==
Date:   Tue, 18 Oct 2022 16:31:48 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <20221018233148.lgoiis2tws7caw3l@treble>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08E9DgGD0lPB85O@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y08E9DgGD0lPB85O@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:56:36PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 11:09:13AM -0700, Kees Cook wrote:
> > > +config FINEIBT
> > > +	def_bool y
> > > +	depends on X86_KERNEL_IBT && CFI_CLANG
> > > +	select CALL_PADDING
> > 
> > To that end, can we please make this a prompted choice?
> 
> How about something like so instead?
> 
> ---
> Subject: x86/cfi: Boot time selection of CFI scheme
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Oct 18 21:50:54 CEST 2022
> 
> Add the "cfi=" boot parameter to allow users to select a scheme at
> boot time.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c |  103 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 83 insertions(+), 20 deletions(-)
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -702,6 +702,47 @@ void __init_or_module noinline apply_ibt
>  #endif /* CONFIG_X86_KERNEL_IBT */
>  
>  #ifdef CONFIG_FINEIBT
> +
> +enum cfi_mode {
> +	CFI_DEFAULT,
> +	CFI_OFF,
> +	CFI_KCFI,
> +	CFI_FINEIBT,
> +};

Is there a reason not to default to FineIBT if the hardware supports it?

If we're going to give the user choices then my previous rant about
documentation still applies:

  https://lkml.kernel.org/lkml/20220503220244.vyz5flk3gg3y6rbw@treble

-- 
Josh
