Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE54611A75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJ1SvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJ1SvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:51:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9F41E045B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:51:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m6so5549883pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMU6V+YcH4ukBoEbLPKiWb3S35i7aUV/tDRo942hx/4=;
        b=ckSBi3R3ipSYt/dNocpIUPw8wWKgdwhswWhq+4IdKYBPdFsTQhHxHBVqXQJl5Hjg7Z
         dDvzl/jj4kEMmDG2mjQwQZqqThnqV/M3PAZfEA3bXrA7Eme4Upg5RBqn69+Tz/uyp2aU
         5B7Ry/+2FnCiki8R4KMYdvoxt9gaVLcqvySLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMU6V+YcH4ukBoEbLPKiWb3S35i7aUV/tDRo942hx/4=;
        b=aiOS+skROITcsKmQ59kiTFvruZnBTj/CxTDj0h269qna7buXtMhYdCF0bWbqHmISKK
         xSW7jCvRzAyjp/q9R1A5L9WHZxNlOen6vSDsuNTtbC0UCPWgM7G6kj1N9MmE2v08tsbZ
         Pb6WPeLWlrYn8F/gfWNjHZnNsyIXLAKZUewk3XjLN4vCDgGdN3lHygSlcySQyQ44w2m+
         mGi0SwO8FjTALsvsnWVGuAXjw8+CLj6IqHsQQe0npc96SID7LO5TNutKz8U/r08xh74r
         y+NT3Jg9AXkGknpJqOjFotjaSHYFLM2Yg2G/dbZPNC9tJWWfHSpUEC70gGYYHQmVdV0B
         RO/g==
X-Gm-Message-State: ACrzQf08umAUAH30jqyULDTgEys5REL5HrdWRl6LfhWvdvRp+a6b+mvg
        hClWfIgpA6DbzpJMtuMRTpFmQw==
X-Google-Smtp-Source: AMsMyM76K+Tt+2VvFerE4W7oIP3TVzPfxzR08NsBhaM2NBteuJkg6NN5KlCM9KlxfUE5bCqQB2yoDQ==
X-Received: by 2002:a63:26c3:0:b0:46b:1dab:fd88 with SMTP id m186-20020a6326c3000000b0046b1dabfd88mr795674pgm.251.1666983062645;
        Fri, 28 Oct 2022 11:51:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0e8100b002009db534d1sm2869201pjx.24.2022.10.28.11.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:51:01 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:51:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 1/2] mm: Implement memory-deny-write-execute as a prctl
Message-ID: <202210281053.904BE2F@keescook>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-2-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026150457.36957-2-joey.gouly@arm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 04:04:56PM +0100, Joey Gouly wrote:
> The aim of such policy is to prevent a user task from creating an
> executable mapping that is also writeable.
> 
> An example of mmap() returning -EACCESS if the policy is enabled:
> 
> 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
> 
> Similarly, mprotect() would return -EACCESS below:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
> 
> The BPF filter that systemd MDWE uses is stateless, and disallows
> mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC to
> be enabled if it was already PROT_EXEC, which allows the following case:
> 
> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> 
> where PROT_BTI enables branch tracking identification on arm64.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/mman.h           | 15 +++++++++++++++
>  include/linux/sched/coredump.h |  6 +++++-
>  include/uapi/linux/prctl.h     |  6 ++++++
>  kernel/sys.c                   | 18 ++++++++++++++++++
>  mm/mmap.c                      |  3 +++
>  mm/mprotect.c                  |  5 +++++
>  6 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 58b3abd457a3..d84fdeab6b5e 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -156,4 +156,19 @@ calc_vm_flag_bits(unsigned long flags)
>  }
>  
>  unsigned long vm_commit_limit(void);
> +
> +static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)

Traditionally, it is easier to write these in the positive instead of
needing to parse a double-negative.

static inline bool allow_write_exec(...)

> +{
> +	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +		return false;
> +
> +	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
> +		return true;
> +
> +	if (vma && !(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
> +		return true;
> +
> +	return false;
> +}

Since this is implementation "2" from the earlier discussion[1], I think
some comments in here are good to have. (e.g. to explain to people
reading this code why there is a vma test, etc.) Perhaps even explicit
repeat the implementation expectations.

Restating from that thread:

  2. "is not already PROT_EXEC":

     a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails

     b)	mmap(PROT_READ|PROT_EXEC);
	mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// passes

     c)	mmap(PROT_READ);
	mprotect(PROT_READ|PROT_EXEC);		// fails

     d)	mmap(PROT_READ|PROT_WRITE);
	mprotect(PROT_READ);
	mprotect(PROT_READ|PROT_EXEC);		// fails

[1] https://lore.kernel.org/linux-arm-kernel/YmGjYYlcSVz38rOe@arm.com/

>  #endif /* _LINUX_MMAN_H */
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 8270ad7ae14c..0e17ae7fbfd3 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -81,9 +81,13 @@ static inline int get_dumpable(struct mm_struct *mm)
>   * lifecycle of this mm, just for simplicity.
>   */
>  #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
> +
> +#define MMF_HAS_MDWE		28
> +#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
> +
>  #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>  
>  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> -				 MMF_DISABLE_THP_MASK)
> +				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)

Good, yes, new "live forever" bit here. Perhaps bikeshedding over the
name, see below.

>  
>  #endif /* _LINUX_SCHED_COREDUMP_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index a5e06dcbba13..ab9db1e86230 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -281,6 +281,12 @@ struct prctl_mm_map {
>  # define PR_SME_VL_LEN_MASK		0xffff
>  # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
>  
> +/* Memory deny write / execute */
> +#define PR_SET_MDWE			65
> +# define PR_MDWE_FLAG_MMAP		1
> +
> +#define PR_GET_MDWE			66
> +
>  #define PR_SET_VMA		0x53564d41
>  # define PR_SET_VMA_ANON_NAME		0
>  
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 5fd54bf0e886..08e1dd6d2533 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2348,6 +2348,18 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
>  }
>  #endif /* CONFIG_ANON_VMA_NAME */
>  
> +static inline int prctl_set_mdwe(void)
> +{
> +	set_bit(MMF_HAS_MDWE, &current->mm->flags);
> +
> +	return 0;
> +}
> +
> +static inline int prctl_get_mdwe(void)
> +{
> +	return test_bit(MMF_HAS_MDWE, &current->mm->flags);
> +}

These will need to change -- the aren't constructed for future expansion
at all. At the very least, all the arguments need to passed to be
checked that they are zero. e.g.:

int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
		   unsigned long arg4, unsigned long arg5)
{
	if (arg3 || arg4 || arg5)
		return -EINVAL;

	...

	return 0;
}

Otherwise, there's no way to add arguments in the future because old
userspace may have been sending arbitrary junk on the stack, etc.

And regardless, I think we'll need some explicit flag bits here, since
we can see there has been a long history of various other desired
features that may end up living in here. For now, a single bit is fine.
The intended behavior is the inability to _add_ PROT_EXEC to an existing
vma, and to deny the creating of a W+X vma to begin with, so perhaps
this bit can be named MDWE_FLAG_REFUSE_EXEC_GAIN?

Then the above "..." becomes:

	if (bits & ~(MDWE_FLAG_REFUSE_EXEC_GAIN))
		return -EINVAL;

	if (bits & MDWE_FLAG_REFUSE_EXEC_GAIN)
		set_bit(MMF_HAS_MDWE, &current->mm->flags);
	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
		return -EPERM; /* Cannot unset the flag */

And prctl_get_mdwe() becomes:

int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
		   unsigned long arg4, unsigned long arg5)
{
	if (arg2 || arg3 || arg4 || arg5)
		return -EINVAL;
	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
		MDWE_FLAG_REFUSE_EXEC_GAIN : 0;
}

> +
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2623,6 +2635,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
>  		break;
>  #endif
> +	case PR_SET_MDWE:
> +		error = prctl_set_mdwe();
> +		break;
> +	case PR_GET_MDWE:
> +		error = prctl_get_mdwe();
> +		break;
>  	case PR_SET_VMA:
>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>  		break;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 099468aee4d8..42eaf6683216 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1409,6 +1409,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  			vm_flags |= VM_NORESERVE;
>  	}
>  
> +	if (map_deny_write_exec(NULL, vm_flags))
> +		return -EACCES;
> +

This seems like the wrong place to do the check -- that the vma argument
is a hard-coded "NULL" is evidence that something is wrong. Shouldn't
it live in mmap_region()? What happens with MAP_FIXED, when there is
an underlying vma? i.e. an MAP_FIXED will, I think, bypass the intended
check. For example, we had "c" above:

     c)	mmap(PROT_READ);
	mprotect(PROT_READ|PROT_EXEC);		// fails

But this would allow another case:

     e)	addr = mmap(..., PROT_READ, ...);
	mmap(addr, ..., PROT_READ | PROT_EXEC, MAP_FIXED, ...);	// passes


>  	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
>  	if (!IS_ERR_VALUE(addr) &&
>  	    ((vm_flags & VM_LOCKED) ||
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 8d770855b591..af71ef0788fd 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -766,6 +766,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
>  			break;
>  		}
>  
> +		if (map_deny_write_exec(vma, newflags)) {
> +			error = -EACCES;
> +			goto out;
> +		}
> +

This looks like the right place. Any rationale for why it's before
arch_validate_flags()?

>  		/* Allow architectures to sanity-check the new flags */
>  		if (!arch_validate_flags(newflags)) {
>  			error = -EINVAL;

-Kees

-- 
Kees Cook
