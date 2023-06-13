Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BFB72EB73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbjFMTC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjFMTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:02:54 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEB1BEE;
        Tue, 13 Jun 2023 12:02:51 -0700 (PDT)
Received: from jerom (99-112-204-245.lightspeed.hstntx.sbcglobal.net [99.112.204.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 9EAF77BD;
        Tue, 13 Jun 2023 14:02:47 -0500 (CDT)
Date:   Tue, 13 Jun 2023 14:02:45 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v10 05/11] LSM: Create lsm_list_modules system call
Message-ID: <ZIi9VUlrkT8fIMUj@jerom>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
 <20230428203417.159874-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428203417.159874-6-casey@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:34:11PM -0700, Casey Schaufler wrote:
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

One comment below, but

Reviewed-by: Serge E. Hallyn <serge@hallyn.com>

> ---
>  Documentation/userspace-api/lsm.rst |  3 +++
>  include/linux/syscalls.h            |  1 +
>  kernel/sys_ni.c                     |  1 +
>  security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index e6c3f262addc..9edae18a2688 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -63,6 +63,9 @@ Get the specified security attributes of the current process
>  .. kernel-doc:: security/lsm_syscalls.c
>      :identifiers: sys_lsm_get_self_attr
>  
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_list_modules
> +
>  Additional documentation
>  ========================
>  
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 9a94c31bf6b6..ddbcc333f3c3 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>  				      size_t *size, __u32 flags);
>  asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>  				      size_t size, __u32 flags);
> +asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index d03c78ef1562..ceb3d21a62d0 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
>  /* security/lsm_syscalls.c */
>  COND_SYSCALL(lsm_get_self_attr);
>  COND_SYSCALL(lsm_set_self_attr);
> +COND_SYSCALL(lsm_list_modules);
>  
>  /* security/keys/keyctl.c */
>  COND_SYSCALL(add_key);
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index ee3881159241..b89cccb2f123 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>  {
>  	return security_getselfattr(attr, ctx, size, flags);
>  }
> +
> +/**
> + * sys_lsm_list_modules - Return a list of the active security modules
> + * @ids: the LSM module ids

Again, I would say "pointer to size"

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
> -- 
> 2.39.2
> 
