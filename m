Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6EF61A71A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKEC7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKEC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:59:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC0419B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 19:58:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a13so10171864edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 19:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDDAW4bfixZV9jxCbkjO/hz8g7Y57vtJ/LbWD2zWZg0=;
        b=aBYv502mu5ffMnm/ju1VA5lVoHbMZd1zLNmKFIYeyVqluZxcQKGuLTGYcvb4TNYZ+c
         S5WL8awJiq5PFIfb7bg3Jhx9mEa4UU5S8CasjXmZASxieB3+IiJPizYBrOkrsVOEuc7t
         eIlcm6UnRaDRjIXpgrqfn1ICHw9+OYnY4LqBdtTG1TafgUOsdWYeRULs1LHtVuuN6ltO
         vKSgcGXivF32sOK6XR2dndvN1WtQMxg7+V+5PBvWM4uPpYj8XIdZ07a3mRBl8EYPYRG6
         fOaNoI8OsZ367sJefgVdXHz+Va62zPqMz4pa0BRVDEle2kjiJfZJ2Ny4XMlRh5GrBCyf
         pIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDDAW4bfixZV9jxCbkjO/hz8g7Y57vtJ/LbWD2zWZg0=;
        b=szs0PuSyAxjzaZRLhtJ7JjgF/gDXTlQEr5Ob+Gx/5jpT0IM0IOqL4/mQWNVsCIGrDE
         7vQGWhSdXq029hgFwtsCVHqerJN4Hn3pI7+Od9vLcaUc5wT/cr1h/GsJaXqDjWlbtzhZ
         4UPbXuZXaRluiSj2Q1CC8KgbOJjwr3JYG/mXe7ATbTRpA/cwWa7Hxiq3AeiSQkkkDjZV
         f2CttyZD+4ZHVmkpgEaID0mMHXetuoTyHb4I4g+6Vkx4jnrhCZ6NDwr4LamMeS/jm2xt
         KC5vEmyylqyVaJU+uIiQnYM8KP3Prhh9PvYTZBQ4rcIVqfswmFiRHZmYX6ekLXf/dy7X
         s2Og==
X-Gm-Message-State: ACrzQf0UlDcyTWFmGB4nDdsK6bgrWgGtAruMLwRkNSa4k2lU++uokjb9
        q/SfFVzW/Rj83zIbyig7PURW7uzvVpXK9EWS7GfY1w==
X-Google-Smtp-Source: AMsMyM4/G+GGwu/XWb7PryL7j0Ob5S/pX6DTxOjBIX9oRf9pcoBvcDWaB2iq48g4djXsLr6PkXjNCVNKoQCGxSwdmuo=
X-Received: by 2002:a05:6402:2025:b0:464:67fd:e5d3 with SMTP id
 ay5-20020a056402202500b0046467fde5d3mr6533366edb.59.1667617138320; Fri, 04
 Nov 2022 19:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr> <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <03f9401a6c8b87a1c786a2138d16b048f8d0eb53.1667336095.git.christophe.jaillet@wanadoo.fr>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Nov 2022 22:58:20 -0400
Message-ID: <CA+CK2bDJjYuO8Xk_8cP874hxDKA5LFhpdbZ+s0SE6bgFPpMg3w@mail.gmail.com>
Subject: Re: [PATCH 21/30] mm: Use kstrtobool() instead of strtobool()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 5:15 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
>
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
>
> While at it, include the corresponding header file (<linux/kstrtox.h>)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
>
> The last patch of the serie removes the definition of strtobool().
>
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
>
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> ---
>  mm/page_table_check.c | 3 ++-
>  mm/usercopy.c         | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 433dbce13fe1..93e633c1d587 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2021, Google LLC.
>   * Pasha Tatashin <pasha.tatashin@soleen.com>
>   */
> +#include <linux/kstrtox.h>
>  #include <linux/mm.h>
>  #include <linux/page_table_check.h>
>
> @@ -23,7 +24,7 @@ EXPORT_SYMBOL(page_table_check_disabled);
>
>  static int __init early_page_table_check_param(char *buf)
>  {
> -       return strtobool(buf, &__page_table_check_enabled);
> +       return kstrtobool(buf, &__page_table_check_enabled);
>  }

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

>
>  early_param("page_table_check", early_page_table_check_param);
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index c1ee15a98633..4c3164beacec 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> +#include <linux/kstrtox.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task.h>
> @@ -258,7 +259,7 @@ static bool enable_checks __initdata = true;
>
>  static int __init parse_hardened_usercopy(char *str)
>  {
> -       if (strtobool(str, &enable_checks))
> +       if (kstrtobool(str, &enable_checks))
>                 pr_warn("Invalid option string for hardened_usercopy: '%s'\n",
>                         str);
>         return 1;
> --
> 2.34.1
>
