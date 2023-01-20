Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2585675B31
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjATRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjATRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:24:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD6FA1029;
        Fri, 20 Jan 2023 09:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617ED62024;
        Fri, 20 Jan 2023 17:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79D7C433A1;
        Fri, 20 Jan 2023 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674235431;
        bh=kykmCbV6IRYOFllGzMa92OaZb1qf5DrMRxNjvVxG+9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i6DA1ih7OebsueOAmNKk+5pwlaVjpBJjYuR8ah9s4QzqW97xx1aLlSMQCamtivTaK
         LsGXrMffr9KQbrPV0z4UZE33LXN32yLX198q8c9/iKET2Vb4vXLn3majxYdj+dD2tY
         VgQuSuZs+hAHQvUPrF9wQkvSmpvSnJRDDeuaRJWnowERXGvhFpeUTp2c334vW2SSgU
         3yC5cMYYWvVyxPxmW6QOKpZDgVgJGdUGoJhsR4XFzaCsYxKKdRiFqv6XQk16n51lCU
         gXT+6KiEUUDqPpGA5BIioX/nwvnW7pfhDzJ6IpzBUxalhB05OPgdONIb8SNY95dxut
         3mYV233hdxCow==
Received: by mail-vk1-f173.google.com with SMTP id z190so2865608vka.4;
        Fri, 20 Jan 2023 09:23:51 -0800 (PST)
X-Gm-Message-State: AFqh2krKVd7E2lSyRuz/zwYXX5AY3577EUWosLQX8DtUEPSGjxSjl5Eh
        ytN3lpbm+i5A5HGpdxrsduxCLJrvBGATwOAdEw==
X-Google-Smtp-Source: AMrXdXu2xY8OuzC6ho07U2ZqrqiowfM9QsN/jXfdu+/jSvwpGDFrNsNOjey8R8nuGOLE6Ei3OtZobRWMEK2H9u/Vf3k=
X-Received: by 2002:a1f:edc2:0:b0:3e1:6dc2:d562 with SMTP id
 l185-20020a1fedc2000000b003e16dc2d562mr2141801vkh.35.1674235430676; Fri, 20
 Jan 2023 09:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20230118215045.5551-1-msuchanek@suse.de> <20230119095323.4659-1-msuchanek@suse.de>
In-Reply-To: <20230119095323.4659-1-msuchanek@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Jan 2023 11:23:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKo+mdjA485KDb1ZauJcbOU-FR1G-Z2sYYNu7+Zn32wSA@mail.gmail.com>
Message-ID: <CAL_JsqKo+mdjA485KDb1ZauJcbOU-FR1G-Z2sYYNu7+Zn32wSA@mail.gmail.com>
Subject: Re: [PATCH v2] of: Fix of platform build on powerpc due to bad of
 disaply code
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     "Erhard F." <erhard_f@mailbox.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 3:53 AM Michal Suchanek <msuchanek@suse.de> wrote:
>
> The commit 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> breaks build because of wrong argument to snprintf. That certainly
> avoids the runtime error but is not the intended outcome.
>
> Also use standard device name format of-display.N for all created
> devices.
>
> Fixes: 2d681d6a23a1 ("of: Make of framebuffer devices unique")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: Update the device name format
> ---
>  drivers/of/platform.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index f2a5d679a324..8c1b1de22036 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -525,7 +525,9 @@ static int __init of_platform_default_populate_init(void)
>         if (IS_ENABLED(CONFIG_PPC)) {
>                 struct device_node *boot_display = NULL;
>                 struct platform_device *dev;
> -               int display_number = 1;
> +               int display_number = 0;
> +               char buf[14];
> +               char *of_display_format = "of-display.%d";

static const as suggested and can we just move on please...

>                 int ret;
>
>                 /* Check if we have a MacOS display without a node spec */
> @@ -556,7 +558,10 @@ static int __init of_platform_default_populate_init(void)
>                         if (!of_get_property(node, "linux,opened", NULL) ||
>                             !of_get_property(node, "linux,boot-display", NULL))
>                                 continue;
> -                       dev = of_platform_device_create(node, "of-display", NULL);
> +                       ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);

The boot display is always "of-display.0". Just use the fixed string
here. Then we can get rid of the whole debate around static const.

> +                       if (ret >= sizeof(buf))
> +                               continue;

This only happens if display_number becomes too big. Why continue on?
The next iteration will fail too.

> +                       dev = of_platform_device_create(node, buf, NULL);
>                         if (WARN_ON(!dev))
>                                 return -ENOMEM;
>                         boot_display = node;
> @@ -564,10 +569,9 @@ static int __init of_platform_default_populate_init(void)
>                 }
>
>                 for_each_node_by_type(node, "display") {
> -                       char *buf[14];
>                         if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
>                                 continue;
> -                       ret = snprintf(buf, "of-display-%d", display_number++);
> +                       ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
>                         if (ret >= sizeof(buf))
>                                 continue;

Here too in the original change.

>                         of_platform_device_create(node, buf, NULL);
> --
> 2.35.3
>
