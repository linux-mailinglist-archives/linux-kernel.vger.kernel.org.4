Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3270E230
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbjEWQgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjEWQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A8CE4B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5B863463
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD67C433EF;
        Tue, 23 May 2023 16:36:03 +0000 (UTC)
Date:   Tue, 23 May 2023 17:36:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
Message-ID: <ZGzrcOeXc/slVpCY@arm.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-5-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517150321.2890206-5-revest@chromium.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:03:20PM +0200, Florent Revest wrote:
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 0ee96ea7a0e9..11f5e3dacb4e 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -91,4 +91,14 @@ static inline int get_dumpable(struct mm_struct *mm)
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
>  
>  #define MMF_VM_MERGE_ANY	29
> +#define MMF_HAS_MDWE_NO_INHERIT	30
> +
> +#define MMF_INIT_FLAGS(flags)	({					\
> +	unsigned long new_flags = flags;				\
> +	if (new_flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))		\
> +		new_flags &= ~((1UL << MMF_HAS_MDWE) |			\
> +				(1UL << MMF_HAS_MDWE_NO_INHERIT));	\
> +	new_flags & MMF_INIT_MASK;					\
> +})

A function is better indeed, not sure who came up with this macro idea ;).

> diff --git a/kernel/sys.c b/kernel/sys.c
> index 339fee3eff6a..320eae3b12ab 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2368,9 +2368,25 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
>  	if (arg3 || arg4 || arg5)
>  		return -EINVAL;
>  
> -	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
> +	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
>  		return -EINVAL;
>  
> +	/* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
> +	if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
> +		return -EINVAL;
> +
> +	/* Can't gain NO_INHERIT from !NO_INHERIT */
> +	if (bits & PR_MDWE_NO_INHERIT &&
> +	    test_bit(MMF_HAS_MDWE, &current->mm->flags) &&
> +	    !test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
> +		return -EPERM;
> +
> +	if (bits & PR_MDWE_NO_INHERIT)
> +		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
> +	else if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags)
> +		 && !(bits & PR_MDWE_REFUSE_EXEC_GAIN))
> +		return -EPERM; /* Cannot unset the flag */

Is this about not unsetting the MMF_HAS_MDWE bit? We already have a
check further down that covers this case.

Related to this, do we want to allow unsetting MMF_HAS_MDWE_NO_INHERIT?
It looks like it can't be unset but no error either. The above check,
IIUC, looks more like ensuring we don't clear MMF_HAS_MDWE.

Maybe we should tighten the logic here a bit and not allow any changes
after the initial flag setting:

current->mm->flags == 0, we allow:
	bits == 0 or
	bits == PR_MDWE_REFUSE_EXEC_GAIN or
	bits == PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT

current->mm->flags != 0 (some bits were set), we only allow the exactly
the same bit combination or -EPERM.

So basically build the flags based on the PR_* input bits and compare
them with current->mm->flags when not 0, return -EPERM if different. I
think this preserves the ABI as we only have a single bit currently and
hopefully makes the logic here easier to parse.

> +
>  	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
>  		set_bit(MMF_HAS_MDWE, &current->mm->flags);
>  	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> @@ -2385,8 +2401,10 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
>  	if (arg2 || arg3 || arg4 || arg5)
>  		return -EINVAL;
>  
> -	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> -		PR_MDWE_REFUSE_EXEC_GAIN : 0;
> +	return (test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> +		PR_MDWE_REFUSE_EXEC_GAIN : 0) |
> +		(test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags) ?
> +		PR_MDWE_NO_INHERIT : 0);
>  }

Just personal preference, use explicit 'if' blocks and add bits to a
local variable variable than multiple ternary operators.

-- 
Catalin
