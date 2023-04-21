Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912726EB26C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjDUTq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjDUTqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:46:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4267C198B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:46:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a920d484bdso22546335ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682106413; x=1684698413;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GWJ1G4KIGJZHUPonaz/BvWE3RJa28JgHMAwPZpSHSy4=;
        b=kgIejzwv2XgumhZFygCgW4eeWN5RZVcB6z9ZCdjLBr5PQl8kdEKHoP5xDh+cOnAY9N
         QBxxIxVX1tq8fIhuRf4brfHqNpawuo1dkwhLSH6cbUjejqcVQz3haQt/C3MiM5f3R2+D
         05W07QuifK15I60q/HWY3UOFWkkc1vzB3gJm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106413; x=1684698413;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWJ1G4KIGJZHUPonaz/BvWE3RJa28JgHMAwPZpSHSy4=;
        b=hMbjKA6Ipl/cyi8S/3ceAEbwq9DXGDr8Z9BKdtj7/Lj/np/4+zXMY4HKXygXuloZe5
         44/f8LpspqtWxwZRZHlbKCDfw8AhLlgM9nnJ0Vrg/vOxk0BP84k60znc4/Jd9EPfWcqd
         btLAKvogt3M8wDD2+0P/h5qDNb21Yoq7JsonW4B6lKW1xAHc+sYvHwxIZwox4g6i6rlg
         IFIPBpagYooaU3WTH2xiLmLK1KXi4DvsIX7DAFzAsrITpAITN3n1lg0U4W/h/n9nbpJm
         NtITmOh7n/H8dhXDgbEHdJL49xivMghrQyQBHtgJu5CUlSJOqWlM1QepnvXoOIX95Ffo
         BEKA==
X-Gm-Message-State: AAQBX9c6wUUOdMEPXb2Ea2L6OvRMJ1cdZVPvvMIb8P61xibiOO4I6w+E
        3RnsG7I61y+bWiRdbgV9IAXixA==
X-Google-Smtp-Source: AKy350bQEYOYVWnsAwD8pg3hzyMjDL7X+FAY8Lgny8p0sII36RnZCyLj6W72YiyvBcENN+YMKc1yOg==
X-Received: by 2002:a17:902:c74a:b0:1a5:a1b:bbd8 with SMTP id q10-20020a170902c74a00b001a50a1bbbd8mr5135894plq.45.1682106412705;
        Fri, 21 Apr 2023 12:46:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902969400b001a6e9d170b8sm2893676plp.265.2023.04.21.12.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:46:52 -0700 (PDT)
Message-ID: <6442e82c.170a0220.ac293.63bf@mx.google.com>
X-Google-Original-Message-ID: <202304211239.@keescook>
Date:   Fri, 21 Apr 2023 12:46:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:55AM -0700, Casey Schaufler wrote:
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value. The .len value is padded to a multiple
> of 64 bits
> 
> All are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 13 ++++++++++++
>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
>  security/security.c      | 43 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index f7292890b6a2..c96fb56159e3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -263,6 +263,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>  /* prototypes */
>  extern int security_init(void);
>  extern int early_security_init(void);
> +extern u64 lsm_name_to_attr(const char *name);
>  
>  /* Security operations */
>  int security_binder_set_context_mgr(const struct cred *mgr);
> @@ -491,6 +492,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>  int security_locked_down(enum lockdown_reason what);
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -508,6 +511,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
>  	return 0;
>  }
>  
> +static inline u64 lsm_name_to_attr(const char *name)
> +{
> +	return 0;

I think this should return LSM_ATTR_UNDEF instead of literal 0.

> +}
> +
>  static inline void security_free_mnt_opts(void **mnt_opts)
>  {
>  }
> @@ -1420,6 +1428,11 @@ static inline int security_locked_down(enum lockdown_reason what)
>  {
>  	return 0;
>  }
> +static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +				    size_t context_size, u64 id, u64 flags)
> +{
> +	return 0;

Shouldn't this either error or fill in an empty context?

> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 6efbe244d304..67106f642422 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,30 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>  
> +/**
> + * lsm_name_to_attr - map an LSM attribute name to its ID
> + * @name: name of the attribute
> + *
> + * Returns the LSM attribute value associated with @name, or 0 if
> + * there is no mapping.
> + */
> +u64 lsm_name_to_attr(const char *name)
> +{
> +	if (!strcmp(name, "current"))
> +		return LSM_ATTR_CURRENT;
> +	if (!strcmp(name, "exec"))
> +		return LSM_ATTR_EXEC;
> +	if (!strcmp(name, "fscreate"))
> +		return LSM_ATTR_FSCREATE;
> +	if (!strcmp(name, "keycreate"))
> +		return LSM_ATTR_KEYCREATE;
> +	if (!strcmp(name, "prev"))
> +		return LSM_ATTR_PREV;
> +	if (!strcmp(name, "sockcreate"))
> +		return LSM_ATTR_SOCKCREATE;
> +	return 0;

LSM_ATTR_UNDEF again?

> +}
> +
>  /**
>   * sys_lsm_set_self_attr - Set current task's security module attribute
>   * @attr: which attribute to set
> diff --git a/security/security.c b/security/security.c
> index bc3f166b4bff..759f3d977d2e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -752,6 +752,49 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  	return 0;
>  }
>  
> +/**
> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> + * @ctx: an LSM context to be filled
> + * @context: the new context value
> + * @context_size: the size of the new context value
> + * @id: LSM id
> + * @flags: LSM defined flags
> + *
> + * Fill all of the fields in a user space lsm_ctx structure.
> + * Caller is assumed to have verified that @ctx has enough space
> + * for @context.
> + *
> + * The total length is padded to a multiple of 64 bits.

Why?

> + *
> + * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
> + * if memory can't be allocated.
> + */
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags)
> +{
> +	struct lsm_ctx *lctx;
> +	size_t locallen = ALIGN(context_size + sizeof(*lctx), 8);

Instead of the open-coded addition, since you're dealing with a flexible
array structure:

	size_t locallen = ALIGN(struct_size(lctx, ctx, context_size), 8);

> +	int rc = 0;
> +
> +	lctx = kzalloc(locallen, GFP_KERNEL);
> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	lctx->id = id;
> +	lctx->flags = flags;
> +	lctx->ctx_len = context_size;
> +	lctx->len = locallen;
> +
> +	memcpy(&lctx[1], context, context_size);

Eek, no: there is no "second struct lsm_ctx" -- this may trip memcpy
overflow checks under certain conditions. You're wanting to copy to
the flexible array at the end, so this should be explicitly performed so
the compiler knows what's going on:

	memcpy(lctx->ctx, context, context_size);

> +
> +	if (copy_to_user(ctx, lctx, locallen))
> +		rc = -EFAULT;
> +
> +	kfree(lctx);
> +
> +	return rc;
> +}
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> -- 
> 2.39.2
> 

-- 
Kees Cook
