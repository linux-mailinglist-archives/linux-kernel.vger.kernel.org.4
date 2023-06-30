Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80C37432A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjF3CPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjF3CPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:15:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACED3588
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 19:14:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76731802203so122406185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688091285; x=1690683285;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CYjOJQzczNCrKegpSzD/qpaJvwPv5v+9dxljoRuBmPU=;
        b=XPnusK+xZumPpWK+TnAUlS47hwJecS+UZpSGGpkyFUq32PVtnnKC82N2AS0o564c5O
         nCG0afUQzhNi/f32vRMZykfQK5ZDJFAAgPGwuAw/LgvF9RGhChAfFFpd2UGIO3J0Brcm
         OzoQAihWKqpHn3BCuMB6LS1cYSDeTDNjDnRtKAB0SW3gg/svki+1zf0K1jedKFOwPyUx
         UkQbZ5mL1eVUD7rTZbJPtNgot4q7aND0dI7qK1OGixnQam0BN5M0VB0SyKlJeWmb2pST
         ZZamZP6AH+4dtMu2rIvCu8GUtFWVYcae2aJnB7UpPfC+yIUoy1PS2yFv0XQblexyNq7S
         4KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688091285; x=1690683285;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYjOJQzczNCrKegpSzD/qpaJvwPv5v+9dxljoRuBmPU=;
        b=Qk/VHnR3Y75peF5NdsTASPgrCYg59w3r+9J4dNegM8+Fr2WGF3cqdRorP1PG5Tft3q
         FJqRKEvD1gelqqgs4t5wBPTf9zlZrlAYFNOTdYjvuinrNT32g863vO2uLqQlCWfd5Rwc
         5IhCp4OiAGDZVV/9bPselbvNDTih9SDnVF+DL3idMQqtEKMzaEI9lhc/tSspwtmKz/y3
         Ak9dKeRZG0hUatf2Fkw87MN2pBo/GeWYPQepmF0FyYkJx7gPzVj0EUQcc/BVc+Oo1gfG
         oonJtpSuNdR9cORTStG9ACtsfe2jVH2fcCrFMDmWaieIMKkpPCg8JM22w4aYl/XVaMgZ
         Am2Q==
X-Gm-Message-State: ABy/qLau4tLautZl9O3mANdn1GYmOjnijBqQgZyW5QFsBjyWIkNzDUTu
        snkx95PIaxTIgwSkTPFY+S/g
X-Google-Smtp-Source: APBJJlEYmTkp0TWIhcE/1Q/1btQ6Nkp1941nU8UvOANXQNCODPFIXEE7Vp24aTqcnPqDySPvgwLkKw==
X-Received: by 2002:a05:6214:cc7:b0:636:277f:4155 with SMTP id 7-20020a0562140cc700b00636277f4155mr2111822qvx.15.1688091285696;
        Thu, 29 Jun 2023 19:14:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ep8-20020a05621418e800b00630182f0191sm7551322qvb.1.2023.06.29.19.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:14:45 -0700 (PDT)
Date:   Thu, 29 Jun 2023 22:14:44 -0400
Message-ID: <d1283a1078fd30a2e45915416ae968d2.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v12 8/11] Smack: implement setselfattr and getselfattr  hooks
References: <20230629195535.2590-9-casey@schaufler-ca.com>
In-Reply-To: <20230629195535.2590-9-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 29, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Implement Smack support for security_[gs]etselfattr.
> Refactor the setprocattr hook to avoid code duplication.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack_lsm.c | 106 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cf847cfe5ed8..4a84639e9db9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c

...

> @@ -3629,6 +3668,61 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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
> +		rc = -E2BIG;
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
> +	if (attr == LSM_ATTR_UNDEF)

That should be '(attr != LSM_ATTR_UNDEF)', right?

> +		return do_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>  /**
>   * smack_unix_stream_connect - Smack access on UDS
>   * @sock: one sock
> @@ -4939,6 +5033,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>  
>  	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
>  
> +	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
>  	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
>  
> -- 
> 2.40.1

--
paul-moore.com
