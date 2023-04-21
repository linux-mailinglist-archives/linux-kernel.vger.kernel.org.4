Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8476EB24D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjDUTg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjDUTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:36:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31D52702
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:36:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a66911f5faso22596545ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682105778; x=1684697778;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LRtySaibFOhSgSz5ERGfzArB1lGVxhdRgk7Szmf1/X8=;
        b=XhWSeGAmk/JTflByy+pHgty/rNkoHNWwPL6UJKWOpHTM1z5ihwsjBXvVJVXKIbPVIr
         4by7HkuEdhW9t8F+2xom9fheYqrfMHo3UsA1NPLw5wdTmQHfx14EvKXVEZfSBbRWA32v
         kpa1TBPOBn4l8tb/t72DVNiWUzzPBBgc5rHQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105778; x=1684697778;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRtySaibFOhSgSz5ERGfzArB1lGVxhdRgk7Szmf1/X8=;
        b=cPAYG4NHHQzPAAlrZbGdQeBN2Sfr9MlmmGmS8s6LYhzWLEDFVVuC66M7Pe3LHsM34l
         Qo0SPFNUAkh81pur2Z7ekwC7qo4DaRy4i+NMCb15hrj8G7DnhX05M1GExAZT3dsDFuTw
         Mm99X9gwiIIVeOK4F1xDlh7X2/muR/eaJK0af5T2r0RD/1OZhmalTot2mRZCeUMADx5P
         hWyOgjqqMM0kU+/tztl92KJS6c5zt7ij7koVmbIQUqeZQv917v8bF9pG6wrnkggn98Ux
         xoRSXN4kNlCtfyy5QDt/I/tLgYIw4ym0La6HZGj55IUOQnTbAvGXRYn97FmQJmXDeFrE
         ScxA==
X-Gm-Message-State: AAQBX9fgsKTEoQtwUgIm4W2sVYY57nmzTyn+Io8MSd0O2vRwii0nh/M/
        MjvvUOxNd5s1IZliXYJFyfY8hA==
X-Google-Smtp-Source: AKy350bjGJ26YztXTiyjglSm0tzdYxKXXBK7VcoBm/zisy+/Nshrua4VpgJO/odm0YlafszmSwR8dg==
X-Received: by 2002:a17:902:e886:b0:1a8:13fc:a654 with SMTP id w6-20020a170902e88600b001a813fca654mr7118123plg.25.1682105778367;
        Fri, 21 Apr 2023 12:36:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bg12-20020a1709028e8c00b001a9567dc731sm446192plb.24.2023.04.21.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:36:17 -0700 (PDT)
Message-ID: <6442e5b1.170a0220.9215c.16b7@mx.google.com>
X-Google-Original-Message-ID: <202304211224.@keescook>
Date:   Fri, 21 Apr 2023 12:36:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 04/11] LSM: syscalls for current process attributes
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:52AM -0700, Casey Schaufler wrote:
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
>         __u64 id;
>         __u64 flags;
>         __u64 len;
>         __u64 ctx_len;
>         __u8 ctx[];
> };
> 
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Nits/questions below...

> ---
>  Documentation/userspace-api/lsm.rst |  15 ++++
>  include/linux/lsm_hook_defs.h       |   4 +
>  include/linux/lsm_hooks.h           |   9 +++
>  include/linux/security.h            |  19 +++++
>  include/linux/syscalls.h            |   5 ++
>  include/uapi/linux/lsm.h            |  36 +++++++++
>  kernel/sys_ni.c                     |   4 +
>  security/Makefile                   |   1 +
>  security/lsm_syscalls.c             |  55 ++++++++++++++
>  security/security.c                 | 110 ++++++++++++++++++++++++++++
>  10 files changed, 258 insertions(+)
>  create mode 100644 security/lsm_syscalls.c
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index 6ddf5506110b..b45e402302b3 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -48,6 +48,21 @@ creating socket objects.
>  The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
>  This is supported by the SELinux security module.
>  
> +Kernel interface
> +================
> +
> +Set a security attribute of the current process
> +--------------------------------------------------
> +
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_set_self_attr
> +
> +Get the specified security attributes of the current process
> +--------------------------------------------------
> +
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_get_self_attr
> +
>  Additional documentation
>  ========================
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 094b76dc7164..7177d9554f4a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
>  LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
>  LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
>  	 struct inode *inode)
> +LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int __user attr,
> +	 struct lsm_ctx __user *ctx, size_t *size, u32 __user flags)
> +LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int __user attr,
> +	 struct lsm_ctx __user *ctx, size_t size, u32 __user flags)
>  LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
>  	 char **value)
>  LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 8e6ba0a9896e..ed38ad5eb444 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -25,6 +25,7 @@
>  #ifndef __LINUX_LSM_HOOKS_H
>  #define __LINUX_LSM_HOOKS_H
>  
> +#include <uapi/linux/lsm.h>
>  #include <linux/security.h>
>  #include <linux/init.h>
>  #include <linux/rculist.h>
> @@ -503,6 +504,14 @@
>   *	and writing the xattrs as this hook is merely a filter.
>   * @d_instantiate:
>   *	Fill in @inode security information for a @dentry if allowed.
> + * @getselfattr:
> + *	Read attribute @attr for the current process and store it into @ctx.
> + *	Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
> + *	or another negative value otherwise.
> + * @setselfattr:
> + *	Set attribute @attr for the current process.
> + *	Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
> + *	or another negative value otherwise.
>   * @getprocattr:
>   *	Read attribute @name for process @p and store it into @value if allowed.
>   *	Return the length of @value on success, a negative value otherwise.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 8faed81fc3b4..f7292890b6a2 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -60,6 +60,7 @@ struct fs_parameter;
>  enum fs_value_type;
>  struct watch;
>  struct watch_notification;
> +struct lsm_ctx;
>  
>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
> @@ -473,6 +474,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
>  int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>  			unsigned nsops, int alter);
>  void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,

Scalar values aren't marked with "__user": this is for address space
markings (i.e. only on pointers).

> +			 size_t __user *size, u32 __user flags);
> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
> +			 size_t __user size, u32 __user flags);
>  int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>  			 char **value);
>  int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
> @@ -1343,6 +1348,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
>  					  struct inode *inode)
>  { }
>  
> +static inline int security_getselfattr(unsigned int __user attr,
> +				       struct lsm_ctx __user *ctx,
> +				       size_t __user *size, u32 __user flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int security_setselfattr(unsigned int __user attr,
> +				       struct lsm_ctx __user *ctx,
> +				       size_t __user size, u32 __user flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int security_getprocattr(struct task_struct *p, int lsmid,
>  				       const char *name, char **value)
>  {
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 33a0ee3bcb2e..9a94c31bf6b6 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -71,6 +71,7 @@ struct clone_args;
>  struct open_how;
>  struct mount_attr;
>  struct landlock_ruleset_attr;
> +struct lsm_ctx;
>  enum landlock_rule_type;
>  
>  #include <linux/types.h>
> @@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +				      size_t *size, __u32 flags);
> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +				      size_t size, __u32 flags);

It'd be nice if these syscalls could stick to the "verionable" syscall
conventions (like openat2) as much as possible. Is "flags" needed here
if we this is only ever going to be 1 LSM at a time?

>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index f27c9a9cc376..eeda59a77c02 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,36 @@
>  #ifndef _UAPI_LINUX_LSM_H
>  #define _UAPI_LINUX_LSM_H
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
>  /*
>   * ID tokens to identify Linux Security Modules (LSMs)
>   *
> @@ -51,4 +81,10 @@
>  #define LSM_ATTR_PREV		104
>  #define LSM_ATTR_SOCKCREATE	105
>  
> +/*
> + * LSM_FLAG_XXX definitions identify special handling instructions
> + * for the API.
> + */
> +#define LSM_FLAG_SINGLE	0x0001
> +
>  #endif /* _UAPI_LINUX_LSM_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 860b2dcf3ac4..d03c78ef1562 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -262,6 +262,10 @@ COND_SYSCALL_COMPAT(recvmsg);
>  /* mm/nommu.c, also with MMU */
>  COND_SYSCALL(mremap);
>  
> +/* security/lsm_syscalls.c */
> +COND_SYSCALL(lsm_get_self_attr);
> +COND_SYSCALL(lsm_set_self_attr);
> +
>  /* security/keys/keyctl.c */
>  COND_SYSCALL(add_key);
>  COND_SYSCALL(request_key);
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..59f238490665 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> +obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
>  obj-$(CONFIG_MMU)			+= min_addr.o
>  
>  # Object file lists
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> new file mode 100644
> index 000000000000..feee31600219
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
> + * @flags: reserved for future use
> + *
> + * Sets the calling task's LSM context. On success this function
> + * returns 0. If the attribute specified cannot be set a negative
> + * value indicating the reason for the error is returned.
> + */
> +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> +		ctx, size_t __user, size, u32, flags)
> +{
> +	return security_setselfattr(attr, ctx, size, flags);
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
> + * a negative value indicating the error is returned.
> + */
> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> +		ctx, size_t __user *, size, u32, flags)
> +{
> +	return security_getselfattr(attr, ctx, size, flags);
> +}
> diff --git a/security/security.c b/security/security.c
> index 38ca0e646cac..bc3f166b4bff 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2167,6 +2167,116 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>  
> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @ctx: the user-space destination for the information, or NULL
> + * @size: the size of space available to receive the data
> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> + * attributes associated with the LSM identified in the passed @ctx be
> + * reported
> + *
> + * Returns the number of attributes found on success, negative value
> + * on error. @size is reset to the total size of the data.
> + * If @size is insufficient to contain the data -E2BIG is returned.
> + */
> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
> +			 size_t __user *size, u32 __user flags)
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
> +	if (attr == 0)
> +		return -EINVAL;
> +	if (size == NULL)
> +		return -EINVAL;
> +	if (get_user(left, size))
> +		return -EFAULT;
> +
> +	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
> +		if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
> +			return -EFAULT;
> +		if (lctx.id == LSM_ID_UNDEF)
> +			return -EINVAL;
> +	} else if (flags) {
> +		return -EINVAL;
> +	}

Can this use copy_struct_from_user() instead? It would be nice to reuse
that here.

> +
> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> +		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
> +			continue;
> +		entrysize = left;
> +		if (base)
> +			ctx = (struct lsm_ctx __user *)(base + total);
> +		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
> +		if (rc == -EOPNOTSUPP) {
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
> +	}
> +	if (put_user(total, size))
> +		return -EFAULT;
> +	if (toobig)
> +		return -E2BIG;
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
> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
> +			 size_t __user size, u32 __user flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx;
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (size < sizeof(*ctx))
> +		return -EINVAL;
> +	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
> +		return -EFAULT;
> +	if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
> +	    lctx.len < lctx.ctx_len + sizeof(ctx))
> +		return -EINVAL;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx.id)
> +			return hp->hook.setselfattr(attr, ctx, size, flags);
> +
> +	return LSM_RET_DEFAULT(setselfattr);
> +}
> +
>  int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>  			 char **value)
>  {
> -- 
> 2.39.2
> 

-- 
Kees Cook
