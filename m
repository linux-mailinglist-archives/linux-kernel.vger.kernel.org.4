Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E787432A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjF3CPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjF3CPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:15:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9C3AB2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 19:14:45 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40339da998eso6315821cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688091285; x=1690683285;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUZYbjHCm+/YwbwkZOc0X7RCCacNSOU2rhmp+KGHioU=;
        b=dLXIZJEqsaltvVJWrk+DUxlcMCIWNkmtkM3z9QdWPyNSmxmGR6Sl4HS692Nz6fj2tF
         UFVqRL+aiiVUb8C+HIj0aAAVaojeZGy/1V8QzYd4dbS6LqBlpbfpw80kJAS7oDa9NeoB
         yTjXXJJJEBBQKzNOJy9zi08aVvlxLYguCjJqFkC2R6hJx8goyHHV9NEMm7JmFncINrNR
         9jaKEqcYO+dqsK7zLcKWLkZ3/bwRA8FaFPF3+ccj5cYYoh/GHQQxAojmolY5OYJ1e1GP
         7S6yVzzmnZx3hTksr3Tsn2HscCJfnfQoZ9/A70K8BU7ffdlFLHB+GtiPJseAwV0zQz7N
         aL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688091285; x=1690683285;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUZYbjHCm+/YwbwkZOc0X7RCCacNSOU2rhmp+KGHioU=;
        b=TVYFouK1A+Dl+rrHq4QBA4XcVSLN9BAfNTvSf7Dsgk1pw8GCXxwFR7Ka02pbIRtoUG
         rv7LSFLhOqsuQzl2mt1lmc61V3vnrC1j2efGaBi9LxuNGfknwZZyPioyHuMCudixZfTc
         eH/tydQGHsmI1ygGoUtoHB3CKOA1gRj9ivYEeiaTH7BNbuIUSxCoPyABvj7MjtxI1OCr
         jg1DYItNzIOm+NdB9dLfJZS5abNMhtC/XZKUFACNzRfIIIYcRFIqSoJxoMqAtI9RmcV6
         xV04zKELJYX2txZEUghSCXV0osIqjbz5qwOtv97ZSEF5yd8cDuJj6dtcaFM/CSytCtd5
         ReMg==
X-Gm-Message-State: AC+VfDyDEa77nsC07sRSrlNzpt35uin3puoLK/n3l7OvTCEig3+os4qe
        fjji3Fv2mMeBYH2aKRCDh6oG
X-Google-Smtp-Source: ACHHUZ5PIWVQz7hcSMJT148Bm7WGYN5KhpIiM+ykhpXIt+hFp+5w6+7YaBG8l5FEzqAWVd722Y5UvA==
X-Received: by 2002:a05:622a:492:b0:400:98e9:fd78 with SMTP id p18-20020a05622a049200b0040098e9fd78mr1697557qtx.40.1688091284833;
        Thu, 29 Jun 2023 19:14:44 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m25-20020aed27d9000000b003f364778b2bsm7907170qtg.4.2023.06.29.19.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:14:44 -0700 (PDT)
Date:   Thu, 29 Jun 2023 22:14:43 -0400
Message-ID: <b09a9753d31dc4b842cc2e058ae01f34.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v12 7/11] LSM: Helpers for attribute names and filling  lsm_ctx
References: <20230629195535.2590-8-casey@schaufler-ca.com>
In-Reply-To: <20230629195535.2590-8-casey@schaufler-ca.com>
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
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
> 
> All are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  include/linux/security.h | 14 +++++++++++++
>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
>  security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index 199db23581f1..72ad7197b2c9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -770,6 +770,50 @@ static int lsm_superblock_alloc(struct super_block *sb)
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

We should drop the sentence above now that alignment is the caller's
responsibility, but since that was largely my fault I can fix this up
during the merge assuming you're okay with that Casey.

> + * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
> + * if memory can't be allocated.
> + */
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags)
> +{
> +	struct lsm_ctx *lctx;
> +	size_t locallen = struct_size(lctx, ctx, context_size);
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
> 2.40.1

--
paul-moore.com
