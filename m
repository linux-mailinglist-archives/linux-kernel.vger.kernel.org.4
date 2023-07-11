Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944B774F3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjGKPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjGKPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:38:01 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF8C2689
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:37:23 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R0lNy2GG7zMs04V;
        Tue, 11 Jul 2023 15:37:22 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R0lNx1RZdzMpr1n;
        Tue, 11 Jul 2023 17:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689089842;
        bh=5+klZ+ZaD6O2XlHRitUDn9zLGFChGk5e0uMUG9AEz/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tMCu/VdIVdcxXoPqhwqc84MMgOsh8BIci7wkEqDuw7uGIScKWJJiPkaAdpJe8TDad
         /PgPmqW1IsmbbN3VGKDbuR8qo+BH27b7iy9SfhqwKQLMOsXDNDYgAfLd+gEwsn4AE5
         Y0WErKelmNCB8rtKvPd/q+F/4nSE4xgcpvjXTR04=
Message-ID: <794b6381-44be-0a2b-87f0-6db1d41e453e@digikod.net>
Date:   Tue, 11 Jul 2023 17:37:20 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v12 10/11] SELinux: Add selfattr hooks
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, selinux@vger.kernel.org
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-11-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230629195535.2590-11-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2023 21:55, Casey Schaufler wrote:
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> ---
>   security/selinux/hooks.c | 148 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 121 insertions(+), 27 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 49ec74bc006c..a4a536552717 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6226,8 +6226,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
>   		inode_doinit_with_dentry(inode, dentry);
>   }
>   
> -static int selinux_getprocattr(struct task_struct *p,
> -			       const char *name, char **value)
> +static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
> +			       char **value)
>   {
>   	const struct task_security_struct *__tsec;
>   	u32 sid;
> @@ -6244,20 +6244,27 @@ static int selinux_getprocattr(struct task_struct *p,
>   			goto bad;
>   	}
>   
> -	if (!strcmp(name, "current"))
> +	switch (attr) {
> +	case LSM_ATTR_CURRENT:
>   		sid = __tsec->sid;
> -	else if (!strcmp(name, "prev"))
> +		break;
> +	case LSM_ATTR_PREV:
>   		sid = __tsec->osid;
> -	else if (!strcmp(name, "exec"))
> +		break;
> +	case LSM_ATTR_EXEC:
>   		sid = __tsec->exec_sid;
> -	else if (!strcmp(name, "fscreate"))
> +		break;
> +	case LSM_ATTR_FSCREATE:
>   		sid = __tsec->create_sid;
> -	else if (!strcmp(name, "keycreate"))
> +		break;
> +	case LSM_ATTR_KEYCREATE:
>   		sid = __tsec->keycreate_sid;
> -	else if (!strcmp(name, "sockcreate"))
> +		break;
> +	case LSM_ATTR_SOCKCREATE:
>   		sid = __tsec->sockcreate_sid;
> -	else {
> -		error = -EINVAL;
> +		break;
> +	default:
> +		error = -EOPNOTSUPP;
>   		goto bad;
>   	}
>   	rcu_read_unlock();
> @@ -6275,7 +6282,7 @@ static int selinux_getprocattr(struct task_struct *p,
>   	return error;
>   }
>   
> -static int selinux_setprocattr(const char *name, void *value, size_t size)
> +static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>   {
>   	struct task_security_struct *tsec;
>   	struct cred *new;
> @@ -6286,23 +6293,31 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>   	/*
>   	 * Basic control over ability to set these attributes at all.
>   	 */
> -	if (!strcmp(name, "exec"))
> +	switch (attr) {
> +	case LSM_ATTR_EXEC:
>   		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
>   				     PROCESS__SETEXEC, NULL);
> -	else if (!strcmp(name, "fscreate"))
> +		break;
> +	case LSM_ATTR_FSCREATE:
>   		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
>   				     PROCESS__SETFSCREATE, NULL);
> -	else if (!strcmp(name, "keycreate"))
> +		break;
> +	case LSM_ATTR_KEYCREATE:
>   		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
>   				     PROCESS__SETKEYCREATE, NULL);
> -	else if (!strcmp(name, "sockcreate"))
> +		break;
> +	case LSM_ATTR_SOCKCREATE:
>   		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
>   				     PROCESS__SETSOCKCREATE, NULL);
> -	else if (!strcmp(name, "current"))
> +		break;
> +	case LSM_ATTR_CURRENT:
>   		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
>   				     PROCESS__SETCURRENT, NULL);
> -	else
> -		error = -EINVAL;
> +		break;
> +	default:
> +		error = -EOPNOTSUPP;
> +		break;
> +	}
>   	if (error)
>   		return error;
>   
> @@ -6314,13 +6329,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>   		}
>   		error = security_context_to_sid(value, size,
>   						&sid, GFP_KERNEL);
> -		if (error == -EINVAL && !strcmp(name, "fscreate")) {
> +		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
>   			if (!has_cap_mac_admin(true)) {
>   				struct audit_buffer *ab;
>   				size_t audit_size;
>   
> -				/* We strip a nul only if it is at the end, otherwise the
> -				 * context contains a nul and we should audit that */
> +				/* We strip a nul only if it is at the end,
> +				 * otherwise the context contains a nul and
> +				 * we should audit that */
>   				if (str[size - 1] == '\0')
>   					audit_size = size - 1;
>   				else
> @@ -6331,7 +6347,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>   				if (!ab)
>   					return error;
>   				audit_log_format(ab, "op=fscreate invalid_context=");
> -				audit_log_n_untrustedstring(ab, value, audit_size);
> +				audit_log_n_untrustedstring(ab, value,
> +							    audit_size);
>   				audit_log_end(ab);
>   
>   				return error;
> @@ -6354,11 +6371,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>   	   checks and may_create for the file creation checks. The
>   	   operation will then fail if the context is not permitted. */
>   	tsec = selinux_cred(new);
> -	if (!strcmp(name, "exec")) {
> +	if (attr == LSM_ATTR_EXEC) {
>   		tsec->exec_sid = sid;
> -	} else if (!strcmp(name, "fscreate")) {
> +	} else if (attr == LSM_ATTR_FSCREATE) {
>   		tsec->create_sid = sid;
> -	} else if (!strcmp(name, "keycreate")) {
> +	} else if (attr == LSM_ATTR_KEYCREATE) {
>   		if (sid) {
>   			error = avc_has_perm(mysid, sid,
>   					     SECCLASS_KEY, KEY__CREATE, NULL);
> @@ -6366,9 +6383,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>   				goto abort_change;
>   		}
>   		tsec->keycreate_sid = sid;
> -	} else if (!strcmp(name, "sockcreate")) {
> +	} else if (attr == LSM_ATTR_SOCKCREATE) {
>   		tsec->sockcreate_sid = sid;
> -	} else if (!strcmp(name, "current")) {
> +	} else if (attr == LSM_ATTR_CURRENT) {
>   		error = -EINVAL;
>   		if (sid == 0)
>   			goto abort_change;
> @@ -6410,6 +6427,81 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>   	return error;
>   }
>   
> +static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			       size_t *size, u32 flags)
> +{
> +	char *value;
> +	size_t total_len;
> +	int len;
> +	int rc;
> +
> +	len = selinux_lsm_getattr(attr, current, &value);
> +	if (len < 0)
> +		return len;
> +
> +	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
> +
> +	if (total_len > *size)
> +		rc = -E2BIG;
> +	else if (ctx)
> +		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> +	else
> +		rc = 1;
> +
> +	*size = total_len;
> +	if (rc < 0)
> +		return rc;
> +	return 1;
> +}
> +
> +static int selinux_setselfattr(unsigned int __user attr,
> +			       struct lsm_ctx __user *ctx, size_t __user size,
> +			       u32 __user flags)
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

Isn't this check redundant with the ones from security_setselfattr()?

This also applies to AppArmor and Smack patches. It would be simpler to 
move the common code/checks to security_setselfattr().


> +		rc = -EINVAL;

The Smack implementation returns E2BIG instead. It would be a good idea 
to return the same kind of error code, and document it. Again, factoring 
out the common part would help.


> +	else
> +		rc = selinux_lsm_setattr(attr, lctx->ctx, lctx->ctx_len);
> +
> +	kfree(lctx);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +static int selinux_getprocattr(struct task_struct *p,
> +			       const char *name, char **value)
> +{
> +	unsigned int attr = lsm_name_to_attr(name);
> +	int rc;
> +
> +	if (attr) {
> +		rc = selinux_lsm_getattr(attr, p, value);
> +		if (rc != -EOPNOTSUPP)
> +			return rc;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int selinux_setprocattr(const char *name, void *value, size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr)
> +		return selinux_lsm_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>   static int selinux_ismaclabel(const char *name)
>   {
>   	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
> @@ -7041,6 +7133,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>   
>   	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
>   
> +	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
>   	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
>   	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
>   
