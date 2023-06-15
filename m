Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF57319C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbjFONUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjFONTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:19:55 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E71FEF;
        Thu, 15 Jun 2023 06:19:52 -0700 (PDT)
Received: from jerom (unknown [12.133.101.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 146E75F8;
        Thu, 15 Jun 2023 08:19:47 -0500 (CDT)
Date:   Thu, 15 Jun 2023 08:19:42 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v10 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Message-ID: <ZIsP7rkD1MscMqQ3@jerom>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
 <20230428203417.159874-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428203417.159874-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:34:13PM -0700, Casey Schaufler wrote:
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value. The .len value is padded to a multiple
> of 64 bits for alignment.
> 
> All are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Serge E. Hallyn <serge@hallyn.com>

> ---
>  include/linux/security.h | 13 ++++++++++++
>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
>  security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 806bff425af9..36ace59f9171 100644
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
> +	return LSM_ATTR_UNDEF;
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
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index b89cccb2f123..0b225adfe5f7 100644
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
> +	return LSM_ATTR_UNDEF;
> +}
> +
>  /**
>   * sys_lsm_set_self_attr - Set current task's security module attribute
>   * @attr: which attribute to set
> diff --git a/security/security.c b/security/security.c
> index 94b78bfd06b9..8c877d639cae 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -761,6 +761,50 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
> + * The total length is padded to a multiple of 64 bits to
> + * accomodate possible alignment issues.
> + *
> + * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
> + * if memory can't be allocated.
> + */
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags)
> +{
> +	struct lsm_ctx *lctx;
> +	size_t locallen = ALIGN(struct_size(lctx, ctx, context_size), 8);
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
> +	memcpy(lctx->ctx, context, context_size);
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
