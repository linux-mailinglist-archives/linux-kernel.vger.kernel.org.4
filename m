Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D474F3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjGKPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjGKPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:36:47 -0400
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE30ED;
        Tue, 11 Jul 2023 08:36:12 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R0lMb0vFQzMrjHK;
        Tue, 11 Jul 2023 15:36:11 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4R0lMZ0YTVz7cB;
        Tue, 11 Jul 2023 17:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689089771;
        bh=NoTEdp3GjH9HjMfzvmEj442sgr0TNG1ORxVYhwwpJT4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iCHCusETwMJ5+VzaMwufKL79d2UdJ7YKy/CYiogESaNE6QLGr1dEgAa3UKKRVy5J3
         bnJHB/3a0/h5DxNNiJUdfSSvnqDuGjJzRuopC42gs4gpYPCdlMs5TsT70gZHs1mXEy
         /31wOhW5OaYjhrwh57c/r82CPAD0dCy1BolMgdc4=
Message-ID: <dde1ce1f-280d-f4b2-4bb0-bc9d8a6894a3@digikod.net>
Date:   Tue, 11 Jul 2023 17:36:09 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v12 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-5-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230629195535.2590-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2023 21:55, Casey Schaufler wrote:
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
> 
> The attribute value is provided in a lsm_ctx structure. The structure
> identifies the size of the attribute, and the attribute value. The format
> of the attribute value is defined by the security module. A flags field
> is included for LSM specific information. It is currently unused and must
> be 0. The total size of the data, including the lsm_ctx structure and any
> padding, is maintained as well.
> 
> struct lsm_ctx {
>          __u64 id;
>          __u64 flags;
>          __u64 len;
>          __u64 ctx_len;
>          __u8 ctx[];
> };
> 
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>   Documentation/userspace-api/lsm.rst |  15 ++++
>   include/linux/lsm_hook_defs.h       |   4 +
>   include/linux/lsm_hooks.h           |   1 +
>   include/linux/security.h            |  19 +++++
>   include/linux/syscalls.h            |   5 ++
>   include/uapi/linux/lsm.h            |  36 +++++++++
>   kernel/sys_ni.c                     |   4 +
>   security/Makefile                   |   1 +
>   security/lsm_syscalls.c             |  55 ++++++++++++++
>   security/security.c                 | 112 ++++++++++++++++++++++++++++
>   10 files changed, 252 insertions(+)
>   create mode 100644 security/lsm_syscalls.c
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index 6ddf5506110b..e6c3f262addc 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -48,6 +48,21 @@ creating socket objects.
>   The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
>   This is supported by the SELinux security module.
>   
> +Kernel interface
> +================
> +
> +Set a security attribute of the current process
> +-----------------------------------------------
> +
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_set_self_attr
> +
> +Get the specified security attributes of the current process
> +------------------------------------------------------------
> +
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_get_self_attr
> +
>   Additional documentation
>   ========================
>   
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 6bb55e61e8e8..f69a7863dbe2 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
>   LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
>   LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
>   	 struct inode *inode)
> +LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
> +	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
> +LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
> +	 struct lsm_ctx __user *ctx, size_t size, u32 flags)
>   LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
>   	 char **value)
>   LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index fba8881d2bb5..9a3ae6b33d7b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -25,6 +25,7 @@
>   #ifndef __LINUX_LSM_HOOKS_H
>   #define __LINUX_LSM_HOOKS_H
>   
> +#include <uapi/linux/lsm.h>
>   #include <linux/security.h>
>   #include <linux/init.h>
>   #include <linux/rculist.h>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 945101b0d404..475d0abfebda 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -60,6 +60,7 @@ struct fs_parameter;
>   enum fs_value_type;
>   struct watch;
>   struct watch_notification;
> +struct lsm_ctx;
>   
>   /* Default (no) options for the capable function */
>   #define CAP_OPT_NONE 0x0
> @@ -470,6 +471,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
>   int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>   			unsigned nsops, int alter);
>   void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t __user *size, u32 flags);
> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t size, u32 flags);
>   int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>   			 char **value);
>   int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
> @@ -1331,6 +1336,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
>   					  struct inode *inode)
>   { }
>   
> +static inline int security_getselfattr(unsigned int attr,
> +				       struct lsm_ctx __user *ctx,
> +				       size_t __user *size, u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int security_setselfattr(unsigned int attr,
> +				       struct lsm_ctx __user *ctx,
> +				       size_t size, u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int security_getprocattr(struct task_struct *p, int lsmid,
>   				       const char *name, char **value)
>   {
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 33a0ee3bcb2e..9a94c31bf6b6 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -71,6 +71,7 @@ struct clone_args;
>   struct open_how;
>   struct mount_attr;
>   struct landlock_ruleset_attr;
> +struct lsm_ctx;
>   enum landlock_rule_type;
>   
>   #include <linux/types.h>
> @@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>   asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>   					    unsigned long home_node,
>   					    unsigned long flags);
> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +				      size_t *size, __u32 flags);
> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +				      size_t size, __u32 flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index f27c9a9cc376..eeda59a77c02 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,36 @@
>   #ifndef _UAPI_LINUX_LSM_H
>   #define _UAPI_LINUX_LSM_H
>   
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context information
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: LSM specific flags
> + * @len: length of the lsm_ctx struct, @ctx and any other data or padding
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context value
> + *
> + * The @len field MUST be equal to the size of the lsm_ctx struct
> + * plus any additional padding and/or data placed after @ctx.
> + *
> + * In all cases @ctx_len MUST be equal to the length of @ctx.
> + * If @ctx is a string value it should be nul terminated with
> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
> + * supported.
> + *
> + * The @flags and @ctx fields SHOULD only be interpreted by the
> + * LSM specified by @id; they MUST be set to zero/0 when not used.
> + */
> +struct lsm_ctx {
> +	__u64 id;
> +	__u64 flags;
> +	__u64 len;
> +	__u64 ctx_len;
> +	__u8 ctx[];
> +};
> +
>   /*
>    * ID tokens to identify Linux Security Modules (LSMs)
>    *
> @@ -51,4 +81,10 @@
>   #define LSM_ATTR_PREV		104
>   #define LSM_ATTR_SOCKCREATE	105
>   
> +/*
> + * LSM_FLAG_XXX definitions identify special handling instructions
> + * for the API.
> + */
> +#define LSM_FLAG_SINGLE	0x0001
> +
>   #endif /* _UAPI_LINUX_LSM_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 860b2dcf3ac4..d03c78ef1562 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -262,6 +262,10 @@ COND_SYSCALL_COMPAT(recvmsg);
>   /* mm/nommu.c, also with MMU */
>   COND_SYSCALL(mremap);
>   
> +/* security/lsm_syscalls.c */
> +COND_SYSCALL(lsm_get_self_attr);
> +COND_SYSCALL(lsm_set_self_attr);
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
> index 000000000000..ee3881159241
> --- /dev/null
> +++ b/security/lsm_syscalls.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * System calls implementing the Linux Security Module API.
> + *
> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + *  Copyright (C) 2022 Intel Corporation
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
> +/**
> + * sys_lsm_set_self_attr - Set current task's security module attribute
> + * @attr: which attribute to set
> + * @ctx: the LSM contexts
> + * @size: size of @ctx

I don't understand why we need the lsm_ctx's size in this argument and 
in the lsm_ctx.len field as well. It makes sense to use the syscall's 
argument to set/get the size but I don't the the point of the "len" field.

I may have miss some explanation but I also don't see the point of the 
ctx_len field if we can infer this information from the size argument.


> + * @flags: reserved for future use
> + *
> + * Sets the calling task's LSM context. On success this function
> + * returns 0. If the attribute specified cannot be set a negative
> + * value indicating the reason for the error is returned.
> + */
> +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> +		ctx, size_t, size, u32, flags)
> +{
> +	return security_setselfattr(attr, ctx, size, flags);

Why not include all this lsm_syscalls.c file into security.c, or 
implement security_setselfattr() here instead? Ditto for other syscalls. 
This would simplify code and avoid duplicating the documentation.


> +}
> +
> +/**
> + * sys_lsm_get_self_attr - Return current task's security module attributes
> + * @attr: which attribute to set
> + * @ctx: the LSM contexts
> + * @size: size of @ctx, updated on return
> + * @flags: reserved for future use
> + *
> + * Returns the calling task's LSM contexts. On success this
> + * function returns the number of @ctx array elements. This value
> + * may be zero if there are no LSM contexts assigned. If @size is
> + * insufficient to contain the return data -E2BIG is returned and
> + * @size is set to the minimum required size. In all other cases

This is not true with selinux_getselfattr() (and without 
LSM_FLAG_SINGLE) at least. -E2BIG is returned without updating *size.


> + * a negative value indicating the error is returned.
> + */
> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> +		ctx, size_t __user *, size, u32, flags)
> +{
> +	return security_getselfattr(attr, ctx, size, flags);
> +}
> diff --git a/security/security.c b/security/security.c
> index d942b0c8e32f..199db23581f1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3798,6 +3798,118 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>   }
>   EXPORT_SYMBOL(security_d_instantiate);
>   
> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @ctx: the user-space destination for the information, or NULL

It would be useful to explain the use case for NULL: to only get the 
number of attributes. Also, LSM_FLAG_SINGLE is incompatible with a NULL 
ctx. It's also a bit weird to still require size to contain a valid 
address. And size is always checked by the hook implementations even if 
ctx is NULL. I suggest to require size to be NULL if ctx is NULL, or 
return -EINVAL otherwise.

I'm not convinced this trick/exception to only get the number of 
attribute is useful though, especially with *size that needs to be large 
enough. Or maybe we should require *size to be zero and return the 
required size to hold all attributes?


> + * @size: pointer to the size of space available to receive the data
> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> + * attributes associated with the LSM identified in the passed @ctx be
> + * reported
> + *
> + * Returns the number of attributes found on success, negative value
> + * on error. @size is reset to the total size of the data.
> + * If @size is insufficient to contain the data -E2BIG is returned.
> + */
> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t __user *size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> +	u8 __user *base = (u8 __user *)ctx;
> +	size_t total = 0;
> +	size_t entrysize;
> +	size_t left;
> +	bool toobig = false;
> +	int count = 0;
> +	int rc;
> +
> +	if (attr == LSM_ATTR_UNDEF)
> +		return -EINVAL;
> +	if (size == NULL)
> +		return -EINVAL;
> +	if (get_user(left, size))
> +		return -EFAULT;
> +
> +	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
> +		if (!ctx)
> +			return -EINVAL;
> +		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
> +			return -EFAULT;
> +		if (lctx.id == LSM_ID_UNDEF)
> +			return -EINVAL;
> +	} else if (flags) {
> +		return -EINVAL;
> +	}
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> +		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
> +			continue;
> +		entrysize = left;
> +		if (base)
> +			ctx = (struct lsm_ctx __user *)(base + total);
> +		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags); > +		if (rc == -EOPNOTSUPP) {
> +			rc = 0;
> +			continue;
> +		}
> +		if (rc == -E2BIG) {
> +			toobig = true;
> +			left = 0;
> +			continue;
> +		}
> +		if (rc < 0)
> +			return rc;
> +
> +		left -= entrysize;
> +		total += entrysize;
> +		count += rc;

Would it make sense for an LSM (e.g. eBPF program) to return more than 
one? If not, we should force 0 or 1, and probably call WARN_ON_ONCE() if 
it is not the case.


> +	}
> +	if (put_user(total, size))

This might be useful to get the required size, but if the original *size 
is not big enough the LSM hook implementations (e.g. 
selinux_getselfattr) currently don't update *size and just return 
-E2BIG, which is then propagated at the end of the syscall, after all 
hook calls.


> +		return -EFAULT;
> +	if (toobig)
> +		return -E2BIG;

This doesn't help because we don't know how much space is required for a 
specific list entries/LSMs.

I'm convinced this syscall should only deal with one LSM attribute at a 
time (i.e. only support LSM_FLAG_SINGLE, but then without this flag). I 
think it's not worth it to handle a list of arbitrary-size elements, 
especially when they have a different semantic.

If we really need such list handling, I think it would be easier to have 
a syscall argument pointing to a header part containing an array of LSM 
IDs (and potentially the flags field)), and another syscall argument 
that contains an array of (simplified) lsm_ctx entries (without len). 
This would look like this:

struct lsm_entry {
	__u64 id;
	__u64 flags;
};

struct lsm_ctx {
	struct lsm_entry entry;
	__u64 ctx_size;
	__u8 ctx[];
};

int security_getselfattr(unsigned int attr, const struct lsm_id __user 
*ids, size_t ids_size, struct lsm_ctx __user *ctx, size_t __user 
*ctx_size, u32 flags);

This enables to use a big buffer of packed lsm_ctx elements because we 
don't need to allocate an array of fixed-size elements anymore. When an 
LSM hook implementation return -E2BIG, the lsm_ctx array filling will 
stop and renturn this error, which enables user space to know the 
problematic entry. In this case, user space can get the required size by 
setting @ctx to NULL and reading the returned *size value.

This types would also enable to use the same lsm_ctx variable as @ids 
and @ctx arguments (with sizeof and real size) to get one element, or 
just fill the buffer with a list of lsm_entry entries and read back a 
list of lsm_ctx entries. Using different syscall arguments makes it well 
defined and documented.

The lsm_ctx type can also be use by the setselfattr syscall, without 
superfluous len field.

I would also prefer to replace the `size_t __user *ctx_size` argument 
with something like `size_t ctx_available_size` and `size_t __user 
*ctx_written_size`, but it I guess it's a matter of taste…

This struct lsm_entry could also be used by the lsm_list_modules() 
syscall to get more informations about LSM using the flags fields.


> +	if (count == 0)
> +		return LSM_RET_DEFAULT(getselfattr);
> +	return count;
> +}
> +
> +/**
> + * security_setselfattr - Set an LSM attribute on the current process.
> + * @attr: which attribute to set
> + * @ctx: the user-space source for the information
> + * @size: the size of the data
> + * @flags: reserved for future use, must be 0
> + *
> + * Set an LSM attribute for the current process. The LSM, attribute
> + * and new value are included in @ctx.
> + *
> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
> + * if the user buffer is inaccessible or an LSM specific failure.
> + */
> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx;
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (size < sizeof(*ctx))
> +		return -EINVAL;
> +	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))

I'd suggest to handle all the user space copy here and pass a kernel 
pointer to each LSM hook calls (and handle kmalloc and kfree here, if 
needed). This single point of copy would make the LSM implementations 
(setselfattr hooks) easier and less error prone. For instance, we could 
limit data copied from user space to PAGE_SIZE (as done for Landlock 
syscalls). If one day this limit is too short, there is always the 
possibility to add a dedicated flag to the syscall or set exceptions 
according to the target LSM.

A global array containing the maximum size of such context per LSM would 
be nice. I guess current LSMs don't accept unlimited attributes 
(strings) size.


> +		return -EFAULT;
> +	if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
> +	    lctx.len < lctx.ctx_len + sizeof(ctx))

It should not be sizeof(ctx) but sizeof(*ctx) or sizeof(lctx). Positive 
and negative tests for these checks would be useful.

Why not `if (size != lctx.ctx_len + sizeof(lctx))` instead? If this is 
correct, ctx_len and len are redundant. Otherwise, a comment should 
explain what is going on, and what is being checked.



> +		return -EINVAL;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx.id)
> +			return hp->hook.setselfattr(attr, ctx, size, flags);
> +
> +	return LSM_RET_DEFAULT(setselfattr);
> +}
> +
>   /**
>    * security_getprocattr() - Read an attribute for a task
>    * @p: the task
