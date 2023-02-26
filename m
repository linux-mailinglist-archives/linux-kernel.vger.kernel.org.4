Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3B6A2D19
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBZCJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZCJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:09:15 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A611041C;
        Sat, 25 Feb 2023 18:09:14 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id f14so1214263iow.5;
        Sat, 25 Feb 2023 18:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zOiw7v4d0b1KPpG9R/9yiqx5BWikVuJtMLZ9Bzv3kSo=;
        b=k+yMM7OX2Vq1cfpvwqtoq1c2EUROQBBVjl3ijtcoyhwuSOIBRGGC4N+G3mnkyTuLGR
         DCbHX2YI/bH0kNvM8g2nLmO8kV3h4WGNmQIdqLXI8C/5MqTd/zGJwh6T0F0YiYSkDxqR
         HrAixy5lA+PS6Z+hMXrB5ZQUSlpWE2ptOTd23u3NBHIQ1Psr3/kSAHVkLsS9KC19IbzQ
         U7O436YrEHzpxwSlUmW1Kx4oOZQ8Tov54qKH1/PDhy/wHfFrLbHMKgovXSN8JxpJDIr1
         GNENh4oT94YSVAOSzlY1WTNbCuwR2xKH4ImghicSABzEge7lnX66moQnucgURb5j9U5j
         q72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOiw7v4d0b1KPpG9R/9yiqx5BWikVuJtMLZ9Bzv3kSo=;
        b=ULmB8JlkKBXa/NKO0/yg5//syzDJj0bvNBX9R8RpwZYcSVKFS6x5bdmxXZBUgHiy2z
         fQUAIodN0BUKPCT5tMZL1zVna85H3LylBlIC0RsafoxeHnQJwfJ0p9wNnUGgWsFkzv9B
         ySikpi+9JFpbVCEXUcb01s8tptfFxq1in0SJJ/+yFUbvEWgubPoqUffW32qj9i5w5IWi
         IwhCHNRj6fRGSbQdOXV/cMolhFGloimaNTBvoT58OmfOoFXIyObxUjiGLA1zAqujuXsz
         0NorbXC7o4ZiN9xw3AZ6zHyj4Tefcwv/o/GZP6lK8KoAE1c7bpFm7frC29iH5JzZwRZi
         DtvQ==
X-Gm-Message-State: AO0yUKWwymZ8fa/nm4Os7fNH9XfnyE/O5w9KRvm8C2advbLA2FeXl6R1
        N5rDu9JHaKHazTgTjf5DhfDnosuSJ2Pn48URXvPqHoa8XrEOIrgG
X-Google-Smtp-Source: AK7set/CAIQiJKl/9sFKTHtLe+J96h6rAxuX1mBEyeygUXcd0YNkvyyyyO+qiU5URQMYF7lDmYcLSIB4aXSMQMhoeWM=
X-Received: by 2002:a05:6602:399c:b0:74c:deb9:538 with SMTP id
 bw28-20020a056602399c00b0074cdeb90538mr398320iob.0.1677377353864; Sat, 25 Feb
 2023 18:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20211213185625.546358-1-colin.i.king@gmail.com>
In-Reply-To: <20211213185625.546358-1-colin.i.king@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:09:02 -0500
Message-ID: <CAEdQ38GpkM8mZJ2oiADjCgKfEmavCrq9mcYErqPf-CHvWZX84g@mail.gmail.com>
Subject: Re: [PATCH] alpha: osf_sys: reduce kernel log spamming on invalid
 osf_mount call typenr
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:58 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Calling the osf_mount system call with an invalid typenr value will
> spam the kernel log with error messages. Reduce the spamming by making
> it a ratelimited printk.  Issue found when exercising with the stress-ng
> enosys system call stressor.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/alpha/kernel/osf_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index 8bbeebb73cf0..2367a385d726 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -521,7 +521,7 @@ SYSCALL_DEFINE4(osf_mount, unsigned long, typenr, const char __user *, path,
>                 break;
>         default:
>                 retval = -EINVAL;
> -               printk("osf_mount(%ld, %x)\n", typenr, flag);
> +               printk_ratelimited("osf_mount(%ld, %x)\n", typenr, flag);
>         }
>
>         return retval;
> --
> 2.33.1
>

Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
