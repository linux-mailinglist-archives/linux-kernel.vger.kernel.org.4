Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA69E710BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbjEYMDQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEYMDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:03:14 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB79C;
        Thu, 25 May 2023 05:03:13 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-504d149839bso581234a12.1;
        Thu, 25 May 2023 05:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016192; x=1687608192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9S0ma7iu2Ky/aDiCRE3Nd9h/94aau3Fx7GR6wHQD04=;
        b=FkvJBh+ubyXOHu18AH0c5YwRhJW6JJcwRTsjnuvI7CV8ayQcYCyzdgL8mOkuH1nfjN
         p+UVeaqz+B0LvVV2mmB0UuOi91mrEUKxmsjjXUYTYPh8jE43L0nCnpvmN+h1NaaHpSnt
         udeUC64uMZPtqyEqg4Cs5b4lBD9bwly31gWRJq95A9OmkOpoy1dXb+VM9GWmBIQ4KBO6
         KK3RNjxXkeHS+iJR9OB2giISSn4Hw1OXeydZYNzBN6FC5bJ0La1iQmnSBF4MkTNmFeew
         NoLiehAMW4m9tRoiwiH80Nl18utKL2CA7gzYqrk6Vszh1zCObNG/jKVuoipr3XFFcp7B
         ZleQ==
X-Gm-Message-State: AC+VfDw8rJI8j/baut9QZdk94zG1KV7or4QLoNBtjlRTJ9Be/ti3ecff
        FrSur674s1DciZZfyNLMNOae9BihDFZ5EHfMjjE=
X-Google-Smtp-Source: ACHHUZ7RzuKQg/fIionyFwEoFqR+Eeg3H6bRtfIP3/OhCUcag8qzxwzIimb3MHkAmExHXu9pYSV1F6LGCj5QdYXqwus=
X-Received: by 2002:a05:6402:524e:b0:50d:fd8e:e224 with SMTP id
 t14-20020a056402524e00b0050dfd8ee224mr15510365edd.1.1685016191394; Thu, 25
 May 2023 05:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230522200033.2605-1-mario.limonciello@amd.com>
In-Reply-To: <20230522200033.2605-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 May 2023 14:02:58 +0200
Message-ID: <CAJZ5v0gSDxEGMM02SeKuSMRGJppJwYTbX2_Jy5-ovUOGpKASvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 10:01 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> All uses in the kernel are currently already oriented around
> suspend/resume. As some other parts of the kernel may also use these
> messages in functions that could also be used outside of
> suspend/resume, only enable in suspend/resume path.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  include/linux/suspend.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index d0d4598a7b3f..a40f2e667e09 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -564,7 +564,8 @@ static inline int pm_dyn_debug_messages_on(void)
>  #endif
>  #define __pm_pr_dbg(fmt, ...)                                  \
>         do {                                                    \
> -               if (pm_debug_messages_on)                       \
> +               if (pm_debug_messages_on &&                     \
> +                   pm_suspend_target_state != PM_SUSPEND_ON)   \

Instead of this, I would define a function, say
pm_debug_messages_should_print(), that would do the check and I would
use it also in __pm_deferred_pr_dbg().

>                         printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);  \
>                 else if (pm_dyn_debug_messages_on())            \
>                         pr_debug(fmt, ##__VA_ARGS__);   \
> @@ -589,7 +590,8 @@ static inline int pm_dyn_debug_messages_on(void)
>  /**
>   * pm_pr_dbg - print pm sleep debug messages
>   *
> - * If pm_debug_messages_on is enabled, print message.
> + * If pm_debug_messages_on is enabled and the system is entering/leaving
> + *      suspend, print message.
>   * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
>   *     print message only from instances explicitly enabled on dynamic debug's
>   *     control.
>
> base-commit: 42dfdd08422dec99bfe526072063f65c0b9fb7d2
> --
