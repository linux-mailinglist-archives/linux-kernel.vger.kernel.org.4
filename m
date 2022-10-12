Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213CD5FCCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJLVRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJLVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:16:59 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E0118748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:16:57 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MnlpH3CZNzMqV3s;
        Wed, 12 Oct 2022 23:16:55 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MnlpG31zlzMpnPt;
        Wed, 12 Oct 2022 23:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665609415;
        bh=ETpGIDwDZ1VczeNJhkVub0ci9cCJnEts48EafFn6u0E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H0TX6S99fdQYPzsqwbemASQYVS+kMs5V6aN0kBVwJeCIjvgE6mpcx3W8oXgjYJ2f6
         wVWZx7fqGVNn7zwehU+lvrdR/2RW9Yg2BzGzo8jiFcZzpYXJRXIuX0pM/ySJ3VX373
         GoAnpyi6J9qruVQP6/D3Aw+WLwWcJh43ca1pApgM=
Message-ID: <81627924-7ec6-6fed-5ee9-5473bad41bf5@digikod.net>
Date:   Wed, 12 Oct 2022 23:16:53 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v38 06/39] LSM: lsm_self_attr syscall for LSM self
 attributes
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-7-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220927195421.14713-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least linux-api@vger.kernel.org should be in Cc for new syscalls.

You need a dedicated patch to wire this syscall with all architectures. 
It will help a lot dealing with merge conflicts because of other new 
syscalls. You can take a look at the Landlock syscall implementations: 
https://git.kernel.org/c/torvalds/a49f4f81cb48925e8d7cbd9e59068f516e984144

About the name, I'd suggest using a verb, something like lsm_get_self_attr.


On 27/09/2022 21:53, Casey Schaufler wrote:
> Create a system call lsm_self_attr() to provide the security
> module maintained attributes of the current process. Historically
> these attributes have been exposed to user space via entries in
> procfs under /proc/self/attr.

I think this paragraph is not enough to justify a new syscall. We should 
highlight what is not possible (or difficult) to do with the filesystem: 
e.g.
- usable in a sandbox which may not have access to the filesystem (but 
is that a good thing here?);
- clearly defined ABI/format;
- …?

What is the goal of this syscall? How will it be used? By who?


> 
> Attributes are provided as a collection of lsm_ctx structures
> which are placed into a user supplied buffer. Each structure
> identifys the security module providing the attribute, which

"identifies"


> of the possible attributes is provided, the size of the
> attribute, and finally the attribute value. The format of the
> attribute value is defined by the security module, but will
> always be \0 terminated. The ctx_len value will be larger than
> strlen(ctx).
> 
> 	------------------------------
> 	| unsigned int id            |
> 	------------------------------
> 	| unsigned int flags         |
> 	------------------------------
> 	| __kernel_size_t ctx_len    |
> 	------------------------------
> 	| unsigned char ctx[ctx_len] |
> 	------------------------------
> 	| unsigned int id            |
> 	------------------------------
> 	| unsigned int flags         |
> 	------------------------------
> 	| __kernel_size_t ctx_len    |
> 	------------------------------
> 	| unsigned char ctx[ctx_len] |
> 	------------------------------
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>   include/linux/syscalls.h               |   1 +
>   include/uapi/asm-generic/unistd.h      |   5 +-
>   include/uapi/linux/lsm.h               |  21 ++++
>   kernel/sys_ni.c                        |   3 +
>   security/Makefile                      |   1 +
>   security/lsm_syscalls.c                | 156 +++++++++++++++++++++++++
>   7 files changed, 187 insertions(+), 1 deletion(-)
>   create mode 100644 security/lsm_syscalls.c
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..56d5c5202fd0 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>   448	common	process_mrelease	sys_process_mrelease
>   449	common	futex_waitv		sys_futex_waitv
>   450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	common	lsm_self_attr		sys_lsm_self_attr
>   
>   #
>   # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..7f87ef8be546 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>   asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>   					    unsigned long home_node,
>   					    unsigned long flags);
> +asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 45fa180cc56a..aa66718e1b48 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>   #define __NR_set_mempolicy_home_node 450
>   __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>   
> +#define __NR_lsm_self_attr 451
> +__SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
> +
>   #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452

This need to move to a dedicated "wire syscall" patch.


>   
>   /*
>    * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 4bb692b84a28..5acd791f82a9 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,27 @@
>   #ifndef _UAPI_LINUX_LSM_H
>   #define _UAPI_LINUX_LSM_H
>   
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: context specifier and LSM specific flags
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context, a nul terminated string
> + *
> + * @ctx in a nul terminated string.

"NULL-terminated"?


> + *	(strlen(@ctx) < @ctx_len) is always true.
> + *	(strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> + */
> +struct lsm_ctx {
> +	unsigned int		id;

I suggest using __u32 instead of unsigned int.

> +	unsigned int		flags;

What could be the use case for these flags?


> +	__kernel_size_t		ctx_len;
> +	unsigned char		ctx[];
> +};

To avoid holes in this struct, you might want to use 
__attribute__((packed)).


> +
>   /*
>    * ID values to identify security modules.
>    * A system may use more than one security module.
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 860b2dcf3ac4..0fdb0341251d 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -262,6 +262,9 @@ COND_SYSCALL_COMPAT(recvmsg);
>   /* mm/nommu.c, also with MMU */
>   COND_SYSCALL(mremap);
>   
> +/* security/lsm_syscalls.c */
> +COND_SYSCALL(lsm_self_attr);
> +
>   /* security/keys/keyctl.c */
>   COND_SYSCALL(add_key);
>   COND_SYSCALL(request_key);
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..59f238490665 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
>   
>   # always enable default capabilities
>   obj-y					+= commoncap.o
> +obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
>   obj-$(CONFIG_MMU)			+= min_addr.o
>   
>   # Object file lists
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> new file mode 100644
> index 000000000000..da0fab7065e2
> --- /dev/null
> +++ b/security/lsm_syscalls.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * System calls implementing the Linux Security Module API.
> + *
> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + *  Copyright (C) Intel Corporation
> + */
> +
> +#include <asm/current.h>
> +#include <linux/compiler_types.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/security.h>
> +#include <linux/stddef.h>
> +#include <linux/syscalls.h>
> +#include <linux/types.h>
> +#include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> +
> +struct feature_map {
> +	char *name;
> +	int feature;
> +};
> +
> +static const struct feature_map lsm_attr_names[] = {
> +	{ .name = "current",	.feature = LSM_ATTR_CURRENT, },
> +	{ .name = "exec",	.feature = LSM_ATTR_EXEC, },
> +	{ .name = "fscreate",	.feature = LSM_ATTR_FSCREATE, },
> +	{ .name = "keycreate",	.feature = LSM_ATTR_KEYCREATE, },
> +	{ .name = "prev",	.feature = LSM_ATTR_PREV, },
> +	{ .name = "sockcreate",	.feature = LSM_ATTR_SOCKCREATE, },
> +};
> +
> +/**
> + * lsm_self_attr - Return current task's security module attributes
> + * @ctx: the LSM contexts
> + * @size: size of @ctx, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns the calling task's LSM contexts. On success this
> + * function returns the number of @ctx array elements. This value
> + * may be zero if there are no LSM contexts assigned.


> If @size is
> + * insufficient to contain the return data -E2BIG is returned and
> + * @size is set to the minimum required size.

I'd prefer @size to not be a pointer but a value, and then only be read 
to get the context size.

Because lazy userspace only reading the top
If the ctx buffer is not big enough,


> In all other cases
> + * a negative value indicating the error is returned.



lsm_module_list() already returns the enabled LSM IDs. It would be much 
simpler to only returns the properties of a specified LSM.
The syscall could then look like this:
lsm_get_self_attr(__u32 lsm_id, char *attr, size_t size, __u32 flags)



> + */
> +SYSCALL_DEFINE3(lsm_self_attr,
> +	       struct lsm_ctx __user *, ctx,
> +	       size_t __user *, size,
> +	       int, flags)
> +{
> +	struct lsm_ctx *final = NULL;
> +	struct lsm_ctx *interum;
> +	struct lsm_ctx *ip;
> +	void *curr;
> +	char **interum_ctx;
> +	char *cp;
> +	size_t total_size = 0;
> +	int count = 0;
> +	int attr;
> +	int len;
> +	int rc = 0;
> +	int i;
> +
> +	interum = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_id *
> +			  sizeof(*interum), GFP_KERNEL);
> +	if (interum == NULL)
> +		return -ENOMEM;
> +	ip = interum;
> +
> +	interum_ctx = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_id *
> +			      sizeof(*interum_ctx), GFP_KERNEL);
> +	if (interum_ctx == NULL) {
> +		kfree(interum);
> +		return -ENOMEM;
> +	}
> +
> +	for (attr = 0; attr < ARRAY_SIZE(lsm_attr_names); attr++) {
> +		for (i = 0; i < lsm_id; i++) {
> +			if ((lsm_idlist[i]->features &
> +			     lsm_attr_names[attr].feature) == 0)
> +				continue;
> +
> +			len = security_getprocattr(current, lsm_idlist[i]->id,
> +						   lsm_attr_names[attr].name,
> +						   &cp);
> +			if (len <= 0)
> +				continue;
> +
> +			ip->id = lsm_idlist[i]->id;
> +			ip->flags = lsm_attr_names[attr].feature;
> +			/* space for terminating \0 is allocated below */
> +			ip->ctx_len = len + 1;
> +			interum_ctx[count] = cp;
> +			/*
> +			 * Security modules have been inconsistent about
> +			 * including the \0 terminator in the size. The
> +			 * context len has been adjusted to ensure there
> +			 * is one.
> +			 * At least one security module adds a \n at the
> +			 * end of a context to make it look nicer. Change
> +			 * that to a \0 so that user space doesn't have to
> +			 * work around it. Because of this meddling it is
> +			 * safe to assume that lsm_ctx.name is terminated
> +			 * and that strlen(lsm_ctx.name) < lsm.ctx_len.
> +			 */
> +			total_size += sizeof(*interum) + ip->ctx_len;
> +			cp = strnchr(cp, len, '\n');
> +			if (cp != NULL)
> +				*cp = '\0';
> +			ip++;
> +			count++;
> +		}
> +	}
> +
> +	if (count == 0)
> +		goto free_out;
> +
> +	final = kzalloc(total_size, GFP_KERNEL);
> +	if (final == NULL) {
> +		rc = -ENOMEM;
> +		goto free_out;
> +	}
> +
> +	curr = final;
> +	ip = interum;
> +	for (i = 0; i < count; i++) {
> +		memcpy(curr, ip, sizeof(*interum));
> +		curr += sizeof(*interum);
> +		memcpy(curr, interum_ctx[i], ip->ctx_len);
> +		curr += ip->ctx_len;
> +		ip++;
> +	}
> +
> +	if (get_user(len, size)) {
> +		rc = -EFAULT;
> +		goto free_out;
> +	}
> +	if (total_size > len) {
> +		rc = -ERANGE;
> +		goto free_out;
> +	}
> +	if (copy_to_user(ctx, final, total_size) != 0 ||
> +	    put_user(total_size, size) != 0)
> +		rc = -EFAULT;
> +	else
> +		rc = count;
> +
> +free_out:
> +	for (i = 0; i < count; i++)
> +		kfree(interum_ctx[i]);
> +	kfree(interum_ctx);
> +	kfree(interum);
> +	kfree(final);
> +	return rc;
> +}
