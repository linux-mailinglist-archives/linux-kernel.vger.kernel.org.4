Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4E62378C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiKIXfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiKIXfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:35:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED602E9DF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:35:09 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s206so252047oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qq8crRA49byhvbqo3AsTYVWlVFPHxse2O1PzauO0pJ0=;
        b=lRuKgOhL1twVfKy7p+XiqTFSge+bCJe8FgxK56/gAzursYxWm6YS6fZEi0zBTWbnUZ
         VFa0x6lJUejrfCjcd0YNGh0lb1rLQIXvJm6f1k4crkAvR6AH+/6uOwncekHAE9NuwrAZ
         3uqBcMQo1RL1H/m+vOXK5qtvC2dMNi6MhqZ9jwobmqbDikIWdtola1ctxZ1dr3T5l4BU
         +BCHWPYhmngtOIF2900rClpYurUPe0lCFt+cTUWSEi2HytKEXFdFGpNYYo/qxRVXCF0I
         lAPMUadLdeh2ci9VQcdpFnTvie1NtvKJVcnq5paoihGWbhtJqNDxgkqbt+T3Sz1XQr3A
         Vwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qq8crRA49byhvbqo3AsTYVWlVFPHxse2O1PzauO0pJ0=;
        b=3ZenXR+ogH8J0AEK1wkztWfc7AxX7wRjmPsLMnmhsn6fSEK9h3MHiduEk5oRQD/mU8
         imTPBG9bFiYx9XaqR5kWJPx2aoufHwDPM6/NuBrKmHLGWp7XS+nqi2KRfQqr4yM0+ort
         7psMWbEf2iaWSXDGDT2pY202jup7eaOld2pKhsDLlDQbTt6km/+Il//b6NE0RqBMxECX
         QRY82na/jolm7Aa4LPPykO66g+cukGteCPNVNV5KatyGxcqx3g7T9q1agJ7TBbWzVpbB
         XhiiTrBZQNoyXAC5ZGaB8rw3lAtvfapzcTBlKrLOP/AotIzB23t5Q5moIOpn86Gx7aQj
         83Bg==
X-Gm-Message-State: ACrzQf0lQ+YJ/Wtx5oHkwWtBrDKe/VE/qdEYqonkPuZVqMPSfnhKOqyS
        pN6YXwAHS3QO7ziRjJl7zLlYzVQ0wzDSTcxZ166Z
X-Google-Smtp-Source: AMsMyM6H0PfBQZzUkHm9R/V/QznmXAdsUOj3VBAEyNrGYjmtkPXi5HhdNcTzoTlnT3z0W0btZetP5jMyYSGY6Tw9Ikk=
X-Received: by 2002:a05:6808:1525:b0:35a:57ef:83b0 with SMTP id
 u37-20020a056808152500b0035a57ef83b0mr761481oiw.172.1668036908647; Wed, 09
 Nov 2022 15:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com> <20221025184519.13231-7-casey@schaufler-ca.com>
In-Reply-To: <20221025184519.13231-7-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:34:57 -0500
Message-ID: <CAHC9VhQ039=X+0edudy64-fpw4C2SwWV_MucbYfXwFKduwnbWA@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Create a system call lsm_self_attr() to provide the security
> module maintained attributes of the current process. Historically
> these attributes have been exposed to user space via entries in
> procfs under /proc/self/attr.
>
> Attributes are provided as a collection of lsm_ctx structures
> which are placed into a user supplied buffer. Each structure
> identifys the security module providing the attribute, which
> of the possible attributes is provided, the size of the
> attribute, and finally the attribute value. The format of the
> attribute value is defined by the security module, but will
> always be \0 terminated. The ctx_len value will be larger than
> strlen(ctx).
>
>         ------------------------------
>         | unsigned int id            |
>         ------------------------------
>         | unsigned int flags         |
>         ------------------------------
>         | __kernel_size_t ctx_len    |
>         ------------------------------
>         | unsigned char ctx[ctx_len] |
>         ------------------------------
>         | unsigned int id            |
>         ------------------------------
>         | unsigned int flags         |
>         ------------------------------
>         | __kernel_size_t ctx_len    |
>         ------------------------------
>         | unsigned char ctx[ctx_len] |
>         ------------------------------
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/syscalls.h |   2 +
>  include/uapi/linux/lsm.h |  21 ++++++
>  kernel/sys_ni.c          |   3 +
>  security/Makefile        |   1 +
>  security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 183 insertions(+)
>  create mode 100644 security/lsm_syscalls.c

...

> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 61e13b1b9ece..1d27fb5b7746 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,27 @@
>  #ifndef _UAPI_LINUX_LSM_H
>  #define _UAPI_LINUX_LSM_H
>
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: context specifier and LSM specific flags
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context, a nul terminated string
> + *
> + * @ctx in a nul terminated string.
> + *     (strlen(@ctx) < @ctx_len) is always true.
> + *     (strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> + */

We can do better than this, or rather we *should* do better than this.
One of the big advantages of creating a new API is we can fix some of
the silly things we have had to do in the past, including the
"sometimes" NUL terminator on strings.  For this LSM syscalls let's
make a promise that all human readable strings will be properly NUL
terminated; currently this includes all LSM contexts, and likely will
remain that way forever for various reasons, but let's leave the door
open for arbitrary blobs (see the "special" LSM ID discussion from
earlier in the patchset).  With that in mind I might suggest the
following:

  /**
   * struct lsm_ctx - LSM context
   * @id: the LSM id number, see LSM_ID_XXX
   * @flags: context specifier and LSM specific flags
   * @ctx_len: the size of @ctx
   * @ctx: the LSM context, see description
   *
   * For LSMs which provide human readable contexts @ctx will be a nul
   * terminated string and @ctx_len will include the size of the string
   * and the nul terminator, e.g. 'ctx_len == strlen(ctx) + 1'.  For LSMs
   * which provide binary-only contexts @cts will be a binary blob with
   * @ctx_len being the exact value of the blob.  The type of the @ctx,
   * human readable string or binary, can be determined by inspecting
   * both @id and @flags.
   *
   * If a given LSM @id does not define a set of values for use in the
   * @flags field, @flags MUST be set to zero.
   */
  struct lsm_ctx {
    __u32 id;
    __U32 flags;
    __kernel_size_t ctx_len;
    __u8 ctx[];
  };

> +struct lsm_ctx {
> +       unsigned int            id;
> +       unsigned int            flags;
> +       __kernel_size_t         ctx_len;
> +       unsigned char           ctx[];
> +};

I agree with Greg, we should be explicit about variable sizing, let's
make sure everything in the UAPI header is defined in terms of
__uXX/__sXX.  This includes strings as __u8 arrays.

Also, I sorta despite the 'let's line all the struct fields up
horizontally!' approach in struct/variable definitions.  I personally
think it looks horrible and it clutters up future patches.  Please
don't do this unless the individual file already does it, and since we
are creating this new please don't :)

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> new file mode 100644
> index 000000000000..da0fab7065e2
> --- /dev/null
> +++ b/security/lsm_syscalls.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * System calls implementing the Linux Security Module API.
> + *
> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + *  Copyright (C) Intel Corporation
> + */
> +
> +#include <asm/current.h>
> +#include <linux/compiler_types.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/security.h>
> +#include <linux/stddef.h>
> +#include <linux/syscalls.h>
> +#include <linux/types.h>
> +#include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> +
> +struct feature_map {
> +       char *name;
> +       int feature;
> +};
> +
> +static const struct feature_map lsm_attr_names[] = {
> +       { .name = "current",    .feature = LSM_ATTR_CURRENT, },
> +       { .name = "exec",       .feature = LSM_ATTR_EXEC, },
> +       { .name = "fscreate",   .feature = LSM_ATTR_FSCREATE, },
> +       { .name = "keycreate",  .feature = LSM_ATTR_KEYCREATE, },
> +       { .name = "prev",       .feature = LSM_ATTR_PREV, },
> +       { .name = "sockcreate", .feature = LSM_ATTR_SOCKCREATE, },
> +};
> +
> +/**
> + * lsm_self_attr - Return current task's security module attributes
> + * @ctx: the LSM contexts
> + * @size: size of @ctx, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns the calling task's LSM contexts. On success this
> + * function returns the number of @ctx array elements. This value
> + * may be zero if there are no LSM contexts assigned. If @size is
> + * insufficient to contain the return data -E2BIG is returned and
> + * @size is set to the minimum required size. In all other cases
> + * a negative value indicating the error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_self_attr,
> +              struct lsm_ctx __user *, ctx,
> +              size_t __user *, size,
> +              int, flags)

See my comments above about UAPI types, let's change this to something
like this:

[NOTE: I'm assuming it is safe to use __XXX types in syscall declarations?]

  SYSCALL_DEFINE3(lsm_self_attr,
                 struct lsm_ctx __user *, ctx,
                 __kernel_size_t __user *, size,
                 __u32, flags)

> +{
> +       struct lsm_ctx *final = NULL;
> +       struct lsm_ctx *interum;
> +       struct lsm_ctx *ip;
> +       void *curr;
> +       char **interum_ctx;
> +       char *cp;
> +       size_t total_size = 0;
> +       int count = 0;
> +       int attr;
> +       int len;
> +       int rc = 0;
> +       int i;

Ungh, reverse christmas trees ... I kinda hate it from a style
perspective, enough to mention it here, but I'm not going to be petty
enough to say "change it".

However, if you did want to flip it upside down (normal christmas
tree?) during the respin I would be grateful ;)

--
paul-moore.com
