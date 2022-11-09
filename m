Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76D623790
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKIXfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiKIXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:35:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA12E9EF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:35:34 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n205so263207oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 15:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shy1bSg5ln0S2oADqhwWw8EsMzx5HDdKaMPKkyMf+gs=;
        b=HIa78ftndFCy7LJ6aLzwGXh4jG/89gIZ8W+9hUOfwDK+w0NqtyNwkcOGWvBJLENdRJ
         WRNfCtX+lYc6L/KxD7wiKwkkJzJmlCKSXiEKD7eEIA0rgvazFLoo2ORVYbcvCBKlu9Sc
         zBB2441tuvg2ps+NP7JFxP3mzKZf2dC12AGMomip8SW2vMODOk5eZmIeHuaI94WnwayM
         sJ5sVZweeOd+qOEGnKMI+4IAhLTKnxMwQ5kN7LNVuGU8wpwkZReb6YkOTsw2Mqgl6s83
         he233b6EBjO+h+l2GBibExBY8Rh2Xelvjbo6G7OuP7J3vnEa5ZJWXCBhueNi0UflExtV
         +e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shy1bSg5ln0S2oADqhwWw8EsMzx5HDdKaMPKkyMf+gs=;
        b=Pl4PyMlsNtwIMiB11/IlXGubO0+S0uiyVK9Qt+mjhASvazZ074yWtK5zw0uX5Jh8Z7
         Ygizsmpy+MNexApbNe+HtKGn85/wIU4B1ADbnheAZt94RSwtikVp3b+nzdgVaW23BrRs
         ZN22k9h2LpQgHP2rGefQQk/iTCjP6DSqONV5z2oYFQQ4IMxAqsk6VjN66BSd+HRq0irP
         ZUicEAeocLbF85Ki8B8YVdaLIVUtDLN9a347jBXImyt0N1SVvazgC4Jx7zX8TpaMBALu
         BTcMPQMuRacFFhLM23w37bHYs8DJcLQU6IDXdw0GD1vLcwo6pUYuSI/MoP10qs4ZJ0b8
         vDGQ==
X-Gm-Message-State: ACrzQf1vmPpuGl9OW2aw6M6xVk8t8e1HvbZVJnZV6ypEoGd3Xunhwbm+
        /1cD0LQSTm+yQGw70OA4Bsjcp45S8l8toYJn58xE
X-Google-Smtp-Source: AMsMyM6Ynx4zzeC51isR9kHn9lxVD7jUvWH20IzPJ5yVXl4cEzR3M3wOItJzn73/yBJ+RiLCwVZcXKowSVoizK7R+6A=
X-Received: by 2002:a05:6808:1525:b0:35a:57ef:83b0 with SMTP id
 u37-20020a056808152500b0035a57ef83b0mr761763oiw.172.1668036933664; Wed, 09
 Nov 2022 15:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com> <20221025184519.13231-8-casey@schaufler-ca.com>
In-Reply-To: <20221025184519.13231-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:35:22 -0500
Message-ID: <CAHC9VhQ5Jrt3Ns+m7DFZ+_pP81AWqSx588HMZR+7MUuMfSZoig@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] LSM: Create lsm_module_list system call
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
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
>
> The calling application can use this list determine what LSM
> specific actions it might take. That might include chosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/syscalls.h |  1 +
>  kernel/sys_ni.c          |  1 +
>  security/lsm_syscalls.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)

...

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index da0fab7065e2..cd5db370b974 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -154,3 +154,41 @@ SYSCALL_DEFINE3(lsm_self_attr,
>         kfree(final);
>         return rc;
>  }
> +
> +/**
> + * lsm_module_list - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */

Let's make a promise that for this syscall we will order the LSM IDs
in the array in the same order as which they are configured/executed.
I'm doubtful that only a *very* small number of applications will care
about this (if any), but this is something we can do so let's do it
now while we can.

> +SYSCALL_DEFINE3(lsm_module_list,
> +               unsigned int __user *, ids,
> +               size_t __user *, size,
> +               unsigned int, flags)

--
paul-moore.com
