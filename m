Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F050E6ADFA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCGNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCGNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:02:14 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460715897
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:01:58 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6694F40755C7;
        Tue,  7 Mar 2023 13:01:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6694F40755C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678194116;
        bh=AKCjKTaxUUsa39GQN/5BMtwccNM4QcWUniulUge0zMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K/14OrBKulhFdjws2zI0VGt4mLkF2GD2ETq+vH6Iv79kn4U8hQgwHrJ018ID32nxE
         znZABhJwys/ABulkO5dOLRVU2aaiYhvDN8XZvlETKTiDOBRdOb+b8zfxNfVUVSPv55
         9eTjYwyWwVFNmtEm9EHqPqMOKICPJXp46XuDhH2U=
MIME-Version: 1.0
Date:   Tue, 07 Mar 2023 16:01:56 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
In-Reply-To: <20230119160344.54358-2-joey.gouly@arm.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <8408d8901e9d7ee6b78db4c6cba04b78@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-19 19:03, Joey Gouly wrote:
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
> mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC 
> to
> be enabled if it was already PROT_EXEC, which allows the following 
> case:
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
>  include/linux/mman.h           | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/sched/coredump.h |  6 +++++-
>  include/uapi/linux/prctl.h     |  6 ++++++
>  kernel/sys.c                   | 33 +++++++++++++++++++++++++++++++++
>  mm/mmap.c                      | 10 ++++++++++
>  mm/mprotect.c                  |  5 +++++
>  6 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 58b3abd457a3..cee1e4b566d8 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
>  }
> 
>  unsigned long vm_commit_limit(void);
> +
> +/*
> + * Denies creating a writable executable mapping or gaining
> executable permissions.
> + *
> + * This denies the following:
> + *
> + * 	a)	mmap(PROT_WRITE | PROT_EXEC)
> + *
> + *	b)	mmap(PROT_WRITE)
> + *		mprotect(PROT_EXEC)
> + *
> + *	c)	mmap(PROT_WRITE)
> + *		mprotect(PROT_READ)
> + *		mprotect(PROT_EXEC)
> + *
> + * But allows the following:
> + *
> + *	d)	mmap(PROT_READ | PROT_EXEC)
> + *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
> + */
> +static inline bool map_deny_write_exec(struct vm_area_struct *vma,
> unsigned long vm_flags)
> +{
> +	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +		return false;
> +
> +	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
> +		return true;
> +
> +	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
> +		return true;
> +
> +	return false;
> +}
> +
>  #endif /* _LINUX_MMAN_H */
> diff --git a/include/linux/sched/coredump.h 
> b/include/linux/sched/coredump.h
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
> 
>  #endif /* _LINUX_SCHED_COREDUMP_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index a5e06dcbba13..1312a137f7fb 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -281,6 +281,12 @@ struct prctl_mm_map {
>  # define PR_SME_VL_LEN_MASK		0xffff
>  # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
> 
> +/* Memory deny write / execute */
> +#define PR_SET_MDWE			65
> +# define PR_MDWE_REFUSE_EXEC_GAIN	1
> +
> +#define PR_GET_MDWE			66
> +
>  #define PR_SET_VMA		0x53564d41
>  # define PR_SET_VMA_ANON_NAME		0
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 5fd54bf0e886..b3cab94545ed 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2348,6 +2348,33 @@ static int prctl_set_vma(unsigned long opt,
> unsigned long start,
>  }
>  #endif /* CONFIG_ANON_VMA_NAME */
> 
> +static inline int prctl_set_mdwe(unsigned long bits, unsigned long 
> arg3,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	if (arg3 || arg4 || arg5)
> +		return -EINVAL;
> +
> +	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
> +		return -EINVAL;
> +
> +	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
> +		set_bit(MMF_HAS_MDWE, &current->mm->flags);
> +	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +		return -EPERM; /* Cannot unset the flag */
> +
> +	return 0;
> +}
> +
> +static inline int prctl_get_mdwe(unsigned long arg2, unsigned long 
> arg3,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	if (arg2 || arg3 || arg4 || arg5)
> +		return -EINVAL;
> +
> +	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> +		PR_MDWE_REFUSE_EXEC_GAIN : 0;
> +}
> +
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned 
> long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2623,6 +2650,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned
> long, arg2, unsigned long, arg3,
>  		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
>  		break;
>  #endif
> +	case PR_SET_MDWE:
> +		error = prctl_set_mdwe(arg2, arg3, arg4, arg5);
> +		break;
> +	case PR_GET_MDWE:
> +		error = prctl_get_mdwe(arg2, arg3, arg4, arg5);
> +		break;
>  	case PR_SET_VMA:
>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>  		break;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 87d929316d57..99a4d9e2b0d8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2665,6 +2665,16 @@ unsigned long mmap_region(struct file *file,
> unsigned long addr,
>  		vma_set_anonymous(vma);
>  	}
> 
> +	if (map_deny_write_exec(vma, vma->vm_flags)) {
> +		error = -EACCES;
> +		if (file)
> +			goto close_and_free_vma;
> +		else if (vma->vm_file)
> +			goto unmap_and_free_vma;
> +		else
> +			goto free_vma;
> +	}
> +

Why is the cleanup dispatch logic duplicated here, instead of simply 
doing "goto close_and_free_vma" (where basically the same dispatch is 
done)?

>  	/* Allow architectures to sanity-check the vm_flags */
>  	if (!arch_validate_flags(vma->vm_flags)) {
>  		error = -EINVAL;
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 908df12caa26..bc0587df042f 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -762,6 +762,11 @@ static int do_mprotect_pkey(unsigned long start,
> size_t len,
>  			break;
>  		}
> 
> +		if (map_deny_write_exec(vma, newflags)) {
> +			error = -EACCES;
> +			goto out;
> +		}
> +

Why does this check use "goto out", thereby skipping post-loop cleanup, 
instead of "break" like all other checks? This looks like a bug to me.

Alexey
>  		/* Allow architectures to sanity-check the new flags */
>  		if (!arch_validate_flags(newflags)) {
>  			error = -EINVAL;
