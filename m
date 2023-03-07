Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF516ADD87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjCGLe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCGLel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:34:41 -0500
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94236497CD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:33:35 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWCxm3GfKzMrLKv;
        Tue,  7 Mar 2023 12:33:32 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWCxk2dGMzMsF6k;
        Tue,  7 Mar 2023 12:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1678188812;
        bh=pCML9nu7R/npDpAM9amdFGrWk9nZdMBQ+LSX0iUteFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=w+b5AAJMx6m57HZHWwFOGZVzqTiTftc/35JByv0pR4HWpctkFSisHv2F5/vRnKbFK
         JVHykUJ2dWwuU7bU2t37rkGdXmnNdjKbRT72TX13Jj2WeXqALnb/euYvSG8pY1z7Xx
         1AkJtYe7Y1s6aTmCnFpdo97hSdlV5Nc0KI1Zo7SQ=
Message-ID: <1ca41f67-ffa1-56c2-b4ee-f5deece95130@digikod.net>
Date:   Tue, 7 Mar 2023 12:33:29 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 05/11] LSM: Create lsm_module_list system call
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230222200838.8149-1-casey@schaufler-ca.com>
 <20230222200838.8149-6-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230222200838.8149-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/02/2023 21:08, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
> 
> The calling application can use this list determine what LSM
> specific actions it might take. That might include chosing an

"choosing"

> output format, determining required privilege or bypassing
> security module specific behavior.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   Documentation/userspace-api/lsm.rst |  3 ++
>   include/linux/syscalls.h            |  1 +
>   kernel/sys_ni.c                     |  1 +
>   security/lsm_syscalls.c             | 43 ++++++++++++++++++++++++++++-
>   4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index b45e402302b3..ecdf1acd15b1 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -63,6 +63,9 @@ Get the specified security attributes of the current process
>   .. kernel-doc:: security/lsm_syscalls.c
>       :identifiers: sys_lsm_get_self_attr
>   
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_module_list
> +
>   Additional documentation
>   ========================
>   
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1ef2a3de8ae0..9c947022a411 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1062,6 +1062,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
>   asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
>   				      __u64 flags);
>   asmlinkage long sys_lsm_set_self_attr(struct lsm_ctx *ctx, __u64 flags);
> +asmlinkage long sys_lsm_module_list(u64 *ids, size_t *size, int flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index d03c78ef1562..32784e271fa5 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
>   /* security/lsm_syscalls.c */
>   COND_SYSCALL(lsm_get_self_attr);
>   COND_SYSCALL(lsm_set_self_attr);
> +COND_SYSCALL(lsm_module_list);
>   
>   /* security/keys/keyctl.c */
>   COND_SYSCALL(add_key);
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index b89c4e7d009e..ccd3b236670b 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -19,7 +19,7 @@
>   
>   struct attrs_map {
>   	char *name;
> -	int attrs;
> +	u64 attrs;

Why do we need this change in this patch?


>   };
>   
>   static const struct attrs_map lsm_attr_names[] = {
> @@ -102,3 +102,44 @@ SYSCALL_DEFINE3(lsm_get_self_attr, struct lsm_ctx __user *, ctx,
>   {
>   	return security_getselfattr(flags, ctx, size);
>   }
> +
> +/**
> + * sys_lsm_module_list - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_module_list,

The name of this syscall differ from the two others: there is not "get" 
verb. What about "lsm_get_modules" or "lsm_list_modules"?


> +		u64 __user *, ids,
> +		size_t __user *, size,
> +		u64, flags)

As Arnd said, flags should be a u32.

> +{
> +	size_t total_size = lsm_active_cnt * sizeof(*ids);
> +	size_t usize;
> +	int i;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (get_user(usize, size))
> +		return -EFAULT;

I'm not a fan of using the same pointer to read and write. This avoid 
using const pointers and differentiate between input and output values. 
I suggest using a dedicated argument for each.


> +
> +	if (put_user(total_size, size) != 0)
> +		return -EFAULT;
> +
> +	if (usize < total_size)
> +		return -E2BIG;
> +
> +	for (i = 0; i < lsm_active_cnt; i++)
> +		if (put_user(lsm_idlist[i]->id, ids++))

I'm not sure about it, but it may be better to put the complete list of 
IDs at once. Is it better to set the size before or after?


> +			return -EFAULT;
> +
> +	return lsm_active_cnt;
> +}
