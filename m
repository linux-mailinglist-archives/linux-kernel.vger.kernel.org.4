Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14866EB28D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjDUTyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjDUTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:54:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79392680
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:54:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so2307960b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682106866; x=1684698866;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=63R8ea5mngVlhApm/fe+uwiFMxVrBYHDwyTzM2XzUzA=;
        b=FB4mvmml/Iuz8fFPL7k5/XSy9IKIDoZANys+UmOOZeHBHoIKEYAIF1fmqGX9mP5as+
         0x4zdozjExJLOx2XTuYJd9dilSSPVJx7RWz4lEswVEOdHIUd5QPa2A3Lvj/5W5WXWtIJ
         uIT73pdvcbuFdNy5xIF/vylmo4A8v/I/dSxoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106866; x=1684698866;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63R8ea5mngVlhApm/fe+uwiFMxVrBYHDwyTzM2XzUzA=;
        b=JW3nHyivpRlDsnGCatlj2perSjAxMJVCC2KM6kkx0WXz6l3+Y6Ko0RMBpwtRz/xNxm
         aNzgSv4UMQCxzn7iDeY5kN1vyMpxgnQhDTxy6lAUUpVuSseLLnlnryJUmEVustHRP1zj
         7rtuZ3hz1IpOPYZkYyTiiWzGETuVa3BZ0TpUFU+0dln9UCoUU8+5xGOeWmRNewksB5oQ
         kzpuiui8HHEbj55MbBjhJn/izZxeUwknSPblAOWad+MtlNAqXkwKmOLT1JXSNqOwBdXp
         70JfDDT34qFPWDzscz9WGP/SI6FA42ttsEDwewqG9BYhBtWXUR8dwigQ0zZZLL+iH5nk
         3Kuw==
X-Gm-Message-State: AAQBX9fBo876ceg7yUlXzOmvT+B+ok4woMcMtZM9Mjep0g34fAp29wgm
        OfhwUJAKnRRwo6jzthp4EtcHCw==
X-Google-Smtp-Source: AKy350bMA0QHsqbCfpP7WJGBBlD/O9CUYFo/24ULdKXjwAxtBWxlXcrqs7+VA2MUx9ZScgG0NctT0A==
X-Received: by 2002:a05:6a20:729c:b0:d6:ba0b:c82c with SMTP id o28-20020a056a20729c00b000d6ba0bc82cmr9116912pzk.38.1682106865860;
        Fri, 21 Apr 2023 12:54:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b00627fafe49f9sm3361023pfe.106.2023.04.21.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:54:25 -0700 (PDT)
Message-ID: <6442e9f1.050a0220.3353e.77fb@mx.google.com>
X-Google-Original-Message-ID: <202304211250.@keescook>
Date:   Fri, 21 Apr 2023 12:54:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 09/11] AppArmor: Add selfattr hooks
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-10-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-10-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:57AM -0700, Casey Schaufler wrote:
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: John Johansen <john.johansen@canonical.com>
> ---
>  security/apparmor/include/procattr.h |  2 +-
>  security/apparmor/lsm.c              | 96 ++++++++++++++++++++++++++--
>  security/apparmor/procattr.c         | 11 +++-
>  3 files changed, 99 insertions(+), 10 deletions(-)
> 
> diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
> index 31689437e0e1..03dbfdb2f2c0 100644
> --- a/security/apparmor/include/procattr.h
> +++ b/security/apparmor/include/procattr.h
> @@ -11,7 +11,7 @@
>  #ifndef __AA_PROCATTR_H
>  #define __AA_PROCATTR_H
>  
> -int aa_getprocattr(struct aa_label *label, char **string);
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline);
>  int aa_setprocattr_changehat(char *args, size_t size, int flags);
>  
>  #endif /* __AA_PROCATTR_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index ce6ccb7e06ec..bdaa8bac0404 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -630,6 +630,45 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
>  	return error;
>  }
>  
> +static int apparmor_getselfattr(unsigned int __user attr,
> +				struct lsm_ctx __user *lx, size_t *size,
> +				u32 __user flags)
> +{
> +	int error = -ENOENT;
> +	struct aa_task_ctx *ctx = task_ctx(current);
> +	struct aa_label *label = NULL;
> +	size_t total_len;
> +	char *value;
> +
> +	if (attr == LSM_ATTR_CURRENT)
> +		label = aa_get_newest_label(cred_label(current_cred()));
> +	else if (attr == LSM_ATTR_PREV && ctx->previous)
> +		label = aa_get_newest_label(ctx->previous);
> +	else if (attr == LSM_ATTR_EXEC && ctx->onexec)
> +		label = aa_get_newest_label(ctx->onexec);
> +	else
> +		error = -EOPNOTSUPP;

Is "-EOPNOTSUPP" correct for LSM_ATTR_PREV when !ctx->previous? That
seems like it should be -EINVAL? I think this would be better served as
a switch statement.

> +
> +	if (label) {
> +		error = aa_getprocattr(label, &value, false);
> +		if (error > 0) {
> +			total_len = ALIGN(error + sizeof(*ctx), 8);
> +			if (total_len > *size)
> +				error = -E2BIG;
> +			else
> +				lsm_fill_user_ctx(lx, value, error,
> +						  LSM_ID_APPARMOR, 0);
> +		}
> +	}
> +
> +	aa_put_label(label);
> +
> +	*size = total_len;
> +	if (error > 0)
> +		return 1;
> +	return error;
> +}
> +
>  static int apparmor_getprocattr(struct task_struct *task, const char *name,
>  				char **value)
>  {
> @@ -649,7 +688,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
>  		error = -EINVAL;
>  
>  	if (label)
> -		error = aa_getprocattr(label, value);
> +		error = aa_getprocattr(label, value, true);
>  
>  	aa_put_label(label);
>  	put_cred(cred);
> @@ -657,8 +696,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
>  	return error;
>  }
>  
> -static int apparmor_setprocattr(const char *name, void *value,
> -				size_t size)
> +static int do_setattr(u64 attr, void *value, size_t size)
>  {
>  	char *command, *largs = NULL, *args = value;
>  	size_t arg_size;
> @@ -689,7 +727,7 @@ static int apparmor_setprocattr(const char *name, void *value,
>  		goto out;
>  
>  	arg_size = size - (args - (largs ? largs : (char *) value));
> -	if (strcmp(name, "current") == 0) {
> +	if (attr == LSM_ATTR_CURRENT) {
>  		if (strcmp(command, "changehat") == 0) {
>  			error = aa_setprocattr_changehat(args, arg_size,
>  							 AA_CHANGE_NOFLAGS);
> @@ -704,7 +742,7 @@ static int apparmor_setprocattr(const char *name, void *value,
>  			error = aa_change_profile(args, AA_CHANGE_STACK);
>  		} else
>  			goto fail;
> -	} else if (strcmp(name, "exec") == 0) {
> +	} else if (attr == LSM_ATTR_EXEC) {
>  		if (strcmp(command, "exec") == 0)
>  			error = aa_change_profile(args, AA_CHANGE_ONEXEC);
>  		else if (strcmp(command, "stack") == 0)
> @@ -724,13 +762,57 @@ static int apparmor_setprocattr(const char *name, void *value,
>  
>  fail:
>  	aad(&sa)->label = begin_current_label_crit_section();
> -	aad(&sa)->info = name;
> +	if (attr == LSM_ATTR_CURRENT)
> +		aad(&sa)->info = "current";
> +	else if (attr == LSM_ATTR_EXEC)
> +		aad(&sa)->info = "exec";
> +	else
> +		aad(&sa)->info = "invalid";
>  	aad(&sa)->error = error = -EINVAL;
>  	aa_audit_msg(AUDIT_APPARMOR_DENIED, &sa, NULL);
>  	end_current_label_crit_section(aad(&sa)->label);
>  	goto out;
>  }
>  
> +static int apparmor_setselfattr(unsigned int __user attr,
> +				struct lsm_ctx __user *ctx, size_t __user size,
> +				u32 __user flags)
> +{
> +	struct lsm_ctx *lctx;
> +	void *context;
> +	int rc;
> +
> +	if (attr != LSM_ATTR_CURRENT && attr != LSM_ATTR_EXEC)
> +		return -EOPNOTSUPP;
> +
> +	context = kmalloc(size, GFP_KERNEL);
> +	if (context == NULL)
> +		return -ENOMEM;
> +
> +	lctx = (struct lsm_ctx *)context;
> +	if (copy_from_user(context, ctx, size))
> +		rc = -EFAULT;
> +	else if (lctx->ctx_len > size)
> +		rc = -EINVAL;
> +	else
> +		rc = do_setattr(attr, lctx + 1, lctx->ctx_len);
> +
> +	kfree(context);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +static int apparmor_setprocattr(const char *name, void *value,
> +				size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr)
> +		return do_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>  /**
>   * apparmor_bprm_committing_creds - do task cleanup on committing new creds
>   * @bprm: binprm for the exec  (NOT NULL)
> @@ -1253,6 +1335,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
>  	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
>  
> +	LSM_HOOK_INIT(getselfattr, apparmor_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, apparmor_setselfattr),
>  	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
>  
> diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
> index 197d41f9c32b..196f319aa3b2 100644
> --- a/security/apparmor/procattr.c
> +++ b/security/apparmor/procattr.c
> @@ -20,6 +20,7 @@
>   * aa_getprocattr - Return the label information for @label
>   * @label: the label to print label info about  (NOT NULL)
>   * @string: Returns - string containing the label info (NOT NULL)
> + * @newline: indicates that a newline should be added
>   *
>   * Requires: label != NULL && string != NULL
>   *
> @@ -27,7 +28,7 @@
>   *
>   * Returns: size of string placed in @string else error code on failure
>   */
> -int aa_getprocattr(struct aa_label *label, char **string)
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline)
>  {
>  	struct aa_ns *ns = labels_ns(label);
>  	struct aa_ns *current_ns = aa_get_current_ns();
> @@ -57,10 +58,14 @@ int aa_getprocattr(struct aa_label *label, char **string)
>  		return len;
>  	}
>  
> -	(*string)[len] = '\n';
> -	(*string)[len + 1] = 0;
> +	if (newline)
> +		(*string)[len++] = '\n';
> +	(*string)[len] = 0;
>  
>  	aa_put_ns(current_ns);
> +
> +	if (newline)
> +		return len;
>  	return len + 1;
>  }

This is returning the count including trailing %NUL, yes? Why is this
not always just "return len"? i.e.:

	if (newline)
		(*string)[len++] = '\n';
	(*string)[len++] = 0;

	aa_put_ns(current_ns);
	return len;


>  
> -- 
> 2.39.2
> 

-- 
Kees Cook
