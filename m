Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D413F731CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbjFOPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbjFOPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:30:42 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00CB30F8;
        Thu, 15 Jun 2023 08:30:16 -0700 (PDT)
Received: from jerom (unknown [12.133.101.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id E10D4DD;
        Thu, 15 Jun 2023 10:29:41 -0500 (CDT)
Date:   Thu, 15 Jun 2023 10:29:36 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v10 08/11] Smack: implement setselfattr and getselfattr
 hooks
Message-ID: <ZIsuYBRMAhpoP/2r@jerom>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
 <20230428203417.159874-9-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428203417.159874-9-casey@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:34:14PM -0700, Casey Schaufler wrote:
> Implement Smack support for security_[gs]etselfattr.
> Refactor the setprocattr hook to avoid code duplication.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack_lsm.c | 106 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0b466d3b31b7..def13357156a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3552,6 +3552,45 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  	return;
>  }
>  
> +/**
> + * smack_getselfattr - Smack current process attribute
> + * @attr: which attribute to fetch
> + * @ctx: buffer to receive the result
> + * @size: available size in, actual size out
> + * @flags: unused
> + *
> + * Fill the passed user space @ctx with the details of the requested
> + * attribute.
> + *
> + * Returns 1, the number of attributes, on success, an error code otherwise.
> + */
> +static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			     size_t *size, u32 flags)
> +{
> +	struct smack_known *skp = smk_of_current();
> +	int total;
> +	int slen;
> +	int rc;
> +
> +	if (attr != LSM_ATTR_CURRENT)
> +		return -EOPNOTSUPP;
> +
> +	slen = strlen(skp->smk_known) + 1;
> +	total = ALIGN(slen + sizeof(*ctx), 8);
> +	if (total > *size)
> +		rc = -E2BIG;
> +	else if (ctx)
> +		rc = lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK,
> +				       0);
> +	else
> +		rc = 1;
> +
> +	*size = total;
> +	if (rc >= 0)
> +		return 1;
> +	return rc;
> +}
> +
>  /**
>   * smack_getprocattr - Smack process attribute access
>   * @p: the object task
> @@ -3581,8 +3620,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>  }
>  
>  /**
> - * smack_setprocattr - Smack process attribute setting
> - * @name: the name of the attribute in /proc/.../attr
> + * do_setattr - Smack process attribute setting
> + * @attr: the ID of the attribute
>   * @value: the value to set
>   * @size: the size of the value
>   *
> @@ -3591,7 +3630,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>   *
>   * Returns the length of the smack label or an error code
>   */
> -static int smack_setprocattr(const char *name, void *value, size_t size)
> +static int do_setattr(u64 attr, void *value, size_t size)
>  {
>  	struct task_smack *tsp = smack_cred(current_cred());
>  	struct cred *new;
> @@ -3605,8 +3644,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
>  		return -EINVAL;
>  
> -	if (strcmp(name, "current") != 0)
> -		return -EINVAL;
> +	if (attr != LSM_ATTR_CURRENT)
> +		return -EOPNOTSUPP;
>  
>  	skp = smk_import_entry(value, size);
>  	if (IS_ERR(skp))
> @@ -3645,6 +3684,61 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	return size;
>  }
>  
> +/**
> + * smack_setselfattr - Set a Smack process attribute
> + * @attr: which attribute to set
> + * @ctx: buffer containing the data
> + * @size: size of @ctx
> + * @flags: unused
> + *
> + * Fill the passed user space @ctx with the details of the requested
> + * attribute.
> + *
> + * Returns 0 on success, an error code otherwise.
> + */
> +static int smack_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			     size_t size, u32 flags)
> +{
> +	struct lsm_ctx *lctx;
> +	int rc;
> +
> +	lctx = kmalloc(size, GFP_KERNEL);
> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(lctx, ctx, size))
> +		rc = -EFAULT;
> +	else if (lctx->ctx_len > size)

Did you want to do E2BIG instead here?  Or is that really seen as
invalid usage?

> +		rc = -EINVAL;
> +	else
> +		rc = do_setattr(attr, lctx->ctx, lctx->ctx_len);
> +
> +	kfree(lctx);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +/**
> + * smack_setprocattr - Smack process attribute setting
> + * @name: the name of the attribute in /proc/.../attr
> + * @value: the value to set
> + * @size: the size of the value
> + *
> + * Sets the Smack value of the task. Only setting self
> + * is permitted and only with privilege
> + *
> + * Returns the length of the smack label or an error code
> + */
> +static int smack_setprocattr(const char *name, void *value, size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr)

If someone one day gets the brilliant idea to change LSM_ATTR_UNDEF to
-1, this won't work, so I would suggest changing to either "if (attr !=
LSM_ATTR_UNDEF)" or defining a valid_lsm_attr() helper and checking its
bool return value.

> +		return do_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>  /**
>   * smack_unix_stream_connect - Smack access on UDS
>   * @sock: one sock
> @@ -4955,6 +5049,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  
>  	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
>  
> +	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
>  	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
>  
> -- 
> 2.39.2
> 
