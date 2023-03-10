Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5E16B385A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCJISe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 03:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCJISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:18:30 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FAE3D914;
        Fri, 10 Mar 2023 00:18:28 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id r5so4917612qtp.4;
        Fri, 10 Mar 2023 00:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yspyhPwTEevuTgvrljFgxGQolMO4MrGaHvprikKC5aM=;
        b=iiObsxCrqIQLjm231L19w91Alt5cuo96Iq/qRNifujk6O1mWdvljOumB3+aGe5Cnlr
         md4yIq78NxMirVmF+7k3I0QjhN4sLruimRgIPLQneFX/ylE8Vff7GLa714D3ChylEPlP
         RJDxxDtcbn01M+UE1wbmLAnonuIH2DIeor25qf/h73ilifM8XH5eD72y3BQcGYq4NtqX
         z0+ZC/dllnfwPKkYRQQ9mC+5wmbVJzCnqthQrUpDR/PVwDHf3AOYyBchp1FyeSNuml8U
         6DWqBfF1bPDhivde2VzMx/Rb0/U3A4xVjdb8JKaUOJg95uZnWhC6z2mdnWNnEK/dbl/L
         TnoQ==
X-Gm-Message-State: AO0yUKWunXW8Tp56kHULAU6qHemqmVcOn99w25jWPckBRmXzcC9GLD/O
        pisVQHm/xvjFZRwIPR0NRJ90NxXnuDelVQ==
X-Google-Smtp-Source: AK7set/10Cxoo3LbOg/aWY6ZjdFi5u3QlgRZJ2MrBBGOzvizbJGfS1eonnBM1rVTqXCghyGVCH3g8w==
X-Received: by 2002:a05:622a:1d1:b0:3c0:14ec:bfb2 with SMTP id t17-20020a05622a01d100b003c014ecbfb2mr15773947qtw.20.1678436307794;
        Fri, 10 Mar 2023 00:18:27 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id c4-20020ac86604000000b003bfaae103f6sm949909qtp.89.2023.03.10.00.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:18:27 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-536b7ffdd34so83697827b3.6;
        Fri, 10 Mar 2023 00:18:26 -0800 (PST)
X-Received: by 2002:a81:af4b:0:b0:533:91d2:9d94 with SMTP id
 x11-20020a81af4b000000b0053391d29d94mr16066861ywj.5.1678436306111; Fri, 10
 Mar 2023 00:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20230309160201.5163-1-tzimmermann@suse.de> <20230309160201.5163-62-tzimmermann@suse.de>
In-Reply-To: <20230309160201.5163-62-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 09:18:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUi9s6TCyQMsMwFErmvgb_RppAMHjBuXNSRk7rEAuiGrA@mail.gmail.com>
Message-ID: <CAMuHMdUi9s6TCyQMsMwFErmvgb_RppAMHjBuXNSRk7rEAuiGrA@mail.gmail.com>
Subject: Re: [PATCH v2 061/101] fbdev/ps3fb: Duplicate video-mode option string
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, timur@kernel.org, rdunlap@infradead.org,
        paulus@samba.org, benh@kernel.crashing.org, linux@armlinux.org.uk,
        pjones@redhat.com, adaplas@gmail.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, corbet@lwn.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Mar 9, 2023 at 5:02 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Assume that the driver does not own the option string or its substrings
> and hence duplicate the option string for the video mode. Allocate the
> copy's memory with kstrdup() and free it in the module's exit function.
>
> Done in preparation of switching the driver to struct option_iter and
> constifying the option string.
>
> v2:
>         * replace static memory with kstrdup()/kfree() (Geert)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for the upodate!

> --- a/drivers/video/fbdev/ps3fb.c
> +++ b/drivers/video/fbdev/ps3fb.c
> @@ -260,6 +260,7 @@ static const struct fb_videomode ps3fb_modedb[] = {
>  static int ps3fb_mode;
>  module_param(ps3fb_mode, int, 0);
>
> +static char *mode_option_buf;

Do you really need this variable? It contains the same value
as mode_option below.
This is a common pattern in several patches.

>  static char *mode_option;
>
>  static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
> @@ -1276,8 +1277,11 @@ static int __init ps3fb_setup(void)
>                         continue;
>                 if (!strncmp(this_opt, "mode:", 5))
>                         ps3fb_mode = simple_strtoul(this_opt + 5, NULL, 0);
> -               else
> -                       mode_option = this_opt;
> +               else {
> +                       kfree(mode_option_buf);
> +                       mode_option_buf = kstrdup(this_opt, GFP_KERNEL); // ignore errors
> +                       mode_option = mode_option_buf;
> +               }
>         }
>         return 0;
>  }
> @@ -1294,6 +1298,7 @@ static void __exit ps3fb_exit(void)
>  {
>         pr_debug(" -> %s:%d\n", __func__, __LINE__);
>         ps3_system_bus_driver_unregister(&ps3fb_driver);
> +       kfree(mode_option_buf);
>         pr_debug(" <- %s:%d\n", __func__, __LINE__);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
