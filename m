Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0340C6187C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKCSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCSjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:42 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F408100;
        Thu,  3 Nov 2022 11:39:41 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id k4so1733834qkj.8;
        Thu, 03 Nov 2022 11:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzoAaszO4H5feq9ifFyoUO4g382Xi213Yx0rSxYlkkk=;
        b=zo9a38LNwQu+3Og3PUQQGnfg+OUM8ZJOzUvV8adbbZdwM5CFXa1Z9wc+b9FLQq199b
         3HmuFX0vXmV52jdGBpjaAQoV4EfkioXiEwGGFPtYHFmIslMWvTtWgTxhro+49z1PrI9N
         WV7N3NaL8q1I5I4+qMIa1Dcue4xQHbTXtjvXbHQBYKPyYj+Xr92NjTL+sP0QQQuzdcua
         WNeqXQS3dQiY5T249Hkg7+o2XHuJTrx9qd0rx9dMdh8z1hFSh0Jq7OLPeRDWSFs8r1cA
         M0K+/AVfPyzgO799cwE16dcmOf9L/PKK2O+j1y5SkXCMA9JRcgmccwAhy6v5V2UNVB+b
         xdtg==
X-Gm-Message-State: ACrzQf1NeCDzHfcnQCFHTDThd5Qm51J7se3JX3MuyG8lA8Q5aHQL1Fo4
        qzcv9zI0QqKCOjU/EqQIWLgf8KkRxo8hwpO9ZaE=
X-Google-Smtp-Source: AMsMyM6h+nd034u171sGJIo0kMJVTuQtZWkzxVeBridmsJRx5IuuFc8gdtf2RwlsqaRBnYO0BBU432GqNNR63++MGA8=
X-Received: by 2002:a37:b1c2:0:b0:6fa:1185:4dbf with SMTP id
 a185-20020a37b1c2000000b006fa11854dbfmr22071519qkf.764.1667500780650; Thu, 03
 Nov 2022 11:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr> <652abbd70fca17977135754901135a6dad5d636c.1667336095.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <652abbd70fca17977135754901135a6dad5d636c.1667336095.git.christophe.jaillet@wanadoo.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:39:29 +0100
Message-ID: <CAJZ5v0iy8UfC_9rsUGObgGQ=6_Ts17E0rTn_LSbYhbGNrvq4FQ@mail.gmail.com>
Subject: Re: [PATCH 14/30] powercap: Use kstrtobool() instead of strtobool()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 10:15 PM Christophe JAILLET
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
>  drivers/powercap/powercap_sys.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index f0654a932b37..1f968353d479 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/kstrtox.h>
>  #include <linux/slab.h>
>  #include <linux/powercap.h>
>
> @@ -446,7 +447,7 @@ static ssize_t enabled_store(struct device *dev,
>  {
>         bool mode;
>
> -       if (strtobool(buf, &mode))
> +       if (kstrtobool(buf, &mode))
>                 return -EINVAL;
>         if (dev->parent) {
>                 struct powercap_zone *power_zone = to_powercap_zone(dev);
> --

Applied as 6.2 material, thanks!
