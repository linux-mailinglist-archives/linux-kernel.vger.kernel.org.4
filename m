Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7C7271C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjFGWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjFGWdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:33:03 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BFE173B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:33:00 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-62b6af3822fso210636d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686177179; x=1688769179;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t9by4qHftkkIV9Dk+LEK7WmI/x+RI+VPrc+0RTrcbSE=;
        b=ajwy+j036eXsYFXblwjoEB6Aw6OYAH1T+vWl1PD2S4FA48pMWXcuQKY6N9JS7YBGjf
         1oJt9AhWoSXHs/cHV/yJu/2zFme+hAEFalbyMQCjYxXbxYPfLfMUuXAsxh0QngcDpKt1
         qBuxMtrQ2tRjZjaOZx1HUc1wmaGpZSpO3dQgXpzgIQbZ5P0PHZallhvi3h/A50nVhyin
         R1aPZoe5W9qz8UmY9Icgql9muuNPAEIttcC8/+xr3+ttCz5+p6MhAiq6HqsDrLhgktzx
         UqQpclTpEaVZmBM5WifFpsySrLBbfReTiNxXVQj5itXBKRbLeyNnN3N3NphVqX/2WwX7
         99yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177179; x=1688769179;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9by4qHftkkIV9Dk+LEK7WmI/x+RI+VPrc+0RTrcbSE=;
        b=HbJrY3zyF/2Nzg40aFnuq3KaWneXGxflaWnoj5F4YLU/DDY0B4zo/ICxp3utx30bFT
         2TxQ372H1SfvRnRIR4C8TYMN37yu2DjXTZCvMEYNE0ttxRpucYiUioNcT1rpsKeAl6CR
         rfmCecLXWQ+euKCFOCDAtG0cotCkcIqEZsH2fws8SXLXTkgvLhqeOKJ9SfO6yJX9ch9U
         nOFVkBFeTSPGp/j0Ce7/+V9aBoIBYvJB0oXbs78h6GK8KmhxsoC7GmqeJnF3bdrqHkjX
         N05OXm3jbNpP/ZuRyyNkjqf5PKYN1FzsW38G88FoGwjsEC4XJWkSLFNEliOsMbBOEwI0
         pEiw==
X-Gm-Message-State: AC+VfDyKSXEyPH+r3imC9Ty7dD+IY3qqxBbkLtGRCDtvKrx8VeRBDWEJ
        8syZjTOmPjqJNxqRgRr3btPF
X-Google-Smtp-Source: ACHHUZ4ewnwuAf75MX7qtYNX8ySyhllpz6opxYtjHAmuUfwHeN4bTSuQYtfKgtbd9TlUj5MRrofMow==
X-Received: by 2002:ad4:5c84:0:b0:625:b67c:919c with SMTP id o4-20020ad45c84000000b00625b67c919cmr6170358qvh.21.1686177179508;
        Wed, 07 Jun 2023 15:32:59 -0700 (PDT)
Received: from localhost (static-96-237-115-254.bstnma.fios.verizon.net. [96.237.115.254])
        by smtp.gmail.com with ESMTPSA id s12-20020a0ce30c000000b00623813aa1d5sm229915qvl.89.2023.06.07.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:32:59 -0700 (PDT)
Date:   Wed, 07 Jun 2023 18:32:58 -0400
Message-ID: <30166d8a65c734af1c36b15f01501903.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v10 7/11] LSM: Helpers for attribute names and filling  lsm_ctx
References: <20230428203417.159874-8-casey@schaufler-ca.com>
In-Reply-To: <20230428203417.159874-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 28, 2023 kernel test robot <lkp@intel.com> wrote:
> 
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
> ---
>  include/linux/security.h | 13 ++++++++++++
>  security/lsm_syscalls.c  | 24 ++++++++++++++++++++++
>  security/security.c      | 44 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)

...

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

See my comment in 7/11 regarding the alignment calculation here.

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

--
paul-moore.com
