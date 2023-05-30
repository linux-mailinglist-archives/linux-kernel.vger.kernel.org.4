Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E07715A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjE3Jqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjE3Jqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:46:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EAC0EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:46:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192C92F4;
        Tue, 30 May 2023 02:47:20 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 199643F663;
        Tue, 30 May 2023 02:46:32 -0700 (PDT)
Date:   Tue, 30 May 2023 10:46:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Eric Chan <ericchancf@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Fix 'lock held when returning to user space'
 lockdep warning
Message-ID: <ZHXF86CioMoyWD1d@FVFF77S0Q05N>
References: <20230526184823.1230974-1-ericchancf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184823.1230974-1-ericchancf@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

The subject line for this patch is misleading, as it makes it sound like we're
currently hitting a warning of the form:

  lock held when returning to user space

... when in actuality this patch is *adding* support for that warning.

This is a missing feature, not a fix (and e.g. doesn't require backporting to
stable).

On Fri, May 26, 2023 at 06:48:23PM +0000, Eric Chan wrote:
> The arm64 architecture lacks support for CONFIG_GENERIC_ENTRY, resulting
> in the failure to report the lockdep warning
> "lock held when returning to user space" when lockdep is enabled.
> 
> Rename the function to align with exit_to_user_mode_prepare in
> kernel/entry/common.c to improve readability.

Considering the point about the commit title, could you please reword this to
be clear that we're adding support for a feature, rather than fixing something
that's broken, e.g.

| arm64: lockdep: enable checks for held locks when returning to userspace
|
| Currently arm64 doesn't use CONFIG_GENERIC_ENTRY and doesn't call
| lockdep_sys_exit() when returning to userspace. This means that lockdep won't
| check for held locks when returning to userspace, which would be useful to
| detect kernel bugs.
|
| Call lockdep_sys_exit() when returning to userspace, enabling checking for
| held locks.
|
| At the same time, rename arm64's prepare_exit_to_user_mode() to
| exit_to_user_mode_prepare() to more clearly align with the naming in the
| generic entry code.

With that wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---
>  arch/arm64/kernel/entry-common.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 3af3c01c93a6..9d6827201b6c 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -126,7 +126,7 @@ static __always_inline void __exit_to_user_mode(void)
>  	lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
> +static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
>  	unsigned long flags;
>  
> @@ -135,11 +135,13 @@ static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
>  	flags = read_thread_flags();
>  	if (unlikely(flags & _TIF_WORK_MASK))
>  		do_notify_resume(regs, flags);
> +
> +	lockdep_sys_exit();
>  }
>  
>  static __always_inline void exit_to_user_mode(struct pt_regs *regs)
>  {
> -	prepare_exit_to_user_mode(regs);
> +	exit_to_user_mode_prepare(regs);
>  	mte_check_tfsr_exit();
>  	__exit_to_user_mode();
>  }
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 
