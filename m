Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462A46D4411
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjDCMEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjDCMEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:04:24 -0400
X-Greylist: delayed 7752 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 05:04:20 PDT
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A64A191F0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:04:19 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PqqLp2htDzMqPqb;
        Mon,  3 Apr 2023 14:04:18 +0200 (CEST)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PqqLn4NJQzMshJ2;
        Mon,  3 Apr 2023 14:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1680523458;
        bh=jiEgV09ZxpturQGxYanx9HktEhQLY4SgnzRX9VY/dII=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YDwa5HChOaAgS6R3O4WAgSQ8WrsbrhpxDAC5n7dwVGyp55iIYNlL341+dTpjeHsNG
         O+n2NPIHZL0FjVB5dGl4VMJLyOeqYD46nRwBZpJ1VPaxVEkAc5f/jM23YSuX9HirVS
         nk/xy1xDEEMyA1fEf41n8n/UF92KNq6xCpFr6cq4=
Message-ID: <80cd055f-3bd9-b89a-029b-7a63924b5bde@digikod.net>
Date:   Mon, 3 Apr 2023 14:04:17 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-6-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230315224704.2672-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like you missed my preview reviews on these patches.

On 15/03/2023 23:46, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
> 
> The calling application can use this list determine what LSM
> specific actions it might take. That might include chosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   Documentation/userspace-api/lsm.rst |  3 +++
>   include/linux/syscalls.h            |  1 +
>   kernel/sys_ni.c                     |  1 +
>   security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index b45e402302b3..a86e3817f062 100644
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
> index 3feca00cb0c1..f755c583f949 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>   				      size_t *size, __u64 flags);
>   asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>   				      __u64 flags);
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
> index feee31600219..6efbe244d304 100644
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
> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
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
> +			return -EFAULT;
> +
> +	return lsm_active_cnt;
> +}
