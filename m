Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BBF74F3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjGKPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjGKPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:36:55 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2822198C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:21 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R0lMl6fpzzMrtRL;
        Tue, 11 Jul 2023 15:36:19 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R0lMk6l63zMprwL;
        Tue, 11 Jul 2023 17:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689089779;
        bh=PFT7sFFpiSmtLKRH0sdNO5XstEWvvNs7XJlK7dN0A3U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hw9JulB3TyWx/0SAjSdP7duSaDAWQ7/rP9U89lNJlVITqB1GOq9TaxUPR91w0Eu/b
         j+CrBs+BptCMQlMdpF+axxc9aXcToTbUjO3taVOjuFfy4g48s9R0E7IoR9d0S1XUVZ
         UOSPXomkJPLr8LNBb8sajF2Uh48EUDirusY8/N6A=
Message-ID: <191b9511-b2d7-aced-21bf-0efa68c3a24c@digikod.net>
Date:   Tue, 11 Jul 2023 17:36:18 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v12 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-6-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230629195535.2590-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2023 21:55, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
> 
> The calling application can use this list determine what LSM
> specific actions it might take. That might include choosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>   Documentation/userspace-api/lsm.rst |  3 +++
>   include/linux/syscalls.h            |  1 +
>   kernel/sys_ni.c                     |  1 +
>   security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index e6c3f262addc..9edae18a2688 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -63,6 +63,9 @@ Get the specified security attributes of the current process
>   .. kernel-doc:: security/lsm_syscalls.c
>       :identifiers: sys_lsm_get_self_attr
>   
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_list_modules
> +
>   Additional documentation
>   ========================
>   
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 9a94c31bf6b6..ddbcc333f3c3 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>   				      size_t *size, __u32 flags);
>   asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>   				      size_t size, __u32 flags);
> +asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index d03c78ef1562..ceb3d21a62d0 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
>   /* security/lsm_syscalls.c */
>   COND_SYSCALL(lsm_get_self_attr);
>   COND_SYSCALL(lsm_set_self_attr);
> +COND_SYSCALL(lsm_list_modules);
>   
>   /* security/keys/keyctl.c */
>   COND_SYSCALL(add_key);
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index ee3881159241..f03f2d17ab49 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>   {
>   	return security_getselfattr(attr, ctx, size, flags);
>   }
> +
> +/**
> + * sys_lsm_list_modules - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: pointer to size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,

As explained in patch 4/12, it would be more flexible to return a list of:

struct lsm_entry {
	__u64 id;
	__u64 flags;
};


> +		u32, flags)
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
> +
> +	if (put_user(total_size, size) != 0)
> +		return -EFAULT;
> +
> +	if (usize < total_size)
> +		return -E2BIG;
> +
> +	for (i = 0; i < lsm_active_cnt; i++)
> +		if (put_user(lsm_idlist[i]->id, ids++))

What about putting the returned fixed-size list on the stack and only 
call copy_to_user() once?


> +			return -EFAULT;
> +
> +	return lsm_active_cnt;
> +}
