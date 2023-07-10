Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B274CE01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGJHKs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGJHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:10:42 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9311B;
        Mon, 10 Jul 2023 00:10:41 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6348a8045a2so27743706d6.1;
        Mon, 10 Jul 2023 00:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688973040; x=1691565040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NvmjpSWvN0CjEUDELfk+DsRk9SKm69LdatvFeM24C8=;
        b=PDAshxf1ynIBiMd2N1vKxgNlc3vn5Q5baZVYbtj84C8AdiRZ0sRuTw8D55Isz+axUH
         xXPOntYcJGtqXtRY7PzZ1Sf+Eq2imMujfR1iUeLkuZIgLb053alM93eg0R0S3MzvaNbd
         KJ9uFY/2rLW2wVW7YySoU5g0OY/54O+U4QV34UO1ZoKO6D0JDFSW/puhisQa3adDAOWi
         0/q9WznfFEFUCekszZHn5vFMoI5Dff85sA3hqksN8AZ5E7IOQnbWQcc68g52fpTC2b9u
         nxBM/ajOStyrlL+dIXwb19gUwBcPC5dJrVTL765rH5F7JfUBHHpYjOq56EK4TZFsNNaT
         /7Ig==
X-Gm-Message-State: ABy/qLbIAlRUHAJqlsp7vQXjSDPsgR5gf2JVLbo72AmVguOk4NLolVwv
        KDgL4iEsDOnMRyHa+G0VEFu1coMBigOo4g==
X-Google-Smtp-Source: APBJJlEsC5z9hmVcXRHCZs0fm7ZUVZTSRno11os/GxDTN+p1haC6xywc1Yqcjej2yVxnW2PWI1NyDA==
X-Received: by 2002:a0c:8e8a:0:b0:635:dda5:bb8e with SMTP id x10-20020a0c8e8a000000b00635dda5bb8emr10030441qvb.22.1688973040689;
        Mon, 10 Jul 2023 00:10:40 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id x10-20020a0ce24a000000b0063659410b04sm5220740qvl.107.2023.07.10.00.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:10:39 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-40339da998eso33939641cf.0;
        Mon, 10 Jul 2023 00:10:39 -0700 (PDT)
X-Received: by 2002:ac8:7dc8:0:b0:403:aa35:ef8c with SMTP id
 c8-20020ac87dc8000000b00403aa35ef8cmr4637283qte.34.1688973039444; Mon, 10 Jul
 2023 00:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230704093652.18191-1-frank.li@vivo.com>
In-Reply-To: <20230704093652.18191-1-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 09:10:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrBY1+JDuwODyqLrwJJivt=ewCOKfK41xq+0Hpaf8akQ@mail.gmail.com>
Message-ID: <CAMuHMdWrBY1+JDuwODyqLrwJJivt=ewCOKfK41xq+0Hpaf8akQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: imxfb: Convert to devm_platform_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Helge Deller <deller@gmx.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Tue, Jul 4, 2023 at 11:38 AM Yangtao Li <frank.li@vivo.com> wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks for your patch, which is now commit c1cd7a7a231a26c6 ("fbdev:
imxfb: Convert to devm_platform_ioremap_resource()") in fbdev/for-next

> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -868,7 +868,6 @@ static int imxfb_probe(struct platform_device *pdev)
>         struct imxfb_info *fbi;
>         struct lcd_device *lcd;
>         struct fb_info *info;
> -       struct resource *res;
>         struct imx_fb_videomode *m;
>         const struct of_device_id *of_id;
>         struct device_node *display_np;
> @@ -885,10 +884,6 @@ static int imxfb_probe(struct platform_device *pdev)
>         if (of_id)
>                 pdev->id_entry = of_id->data;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -ENODEV;
> -
>         info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
>         if (!info)
>                 return -ENOMEM;
> @@ -970,7 +965,7 @@ static int imxfb_probe(struct platform_device *pdev)
>                 goto failed_getclock;
>         }
>
> -       fbi->regs = devm_ioremap_resource(&pdev->dev, res);
> +       fbi->regs = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(fbi->regs)) {
>                 ret = PTR_ERR(fbi->regs);
>                 goto failed_ioremap;
> @@ -1043,7 +1038,6 @@ static int imxfb_probe(struct platform_device *pdev)
>  failed_map:
>  failed_ioremap:
>  failed_getclock:
> -       release_mem_region(res->start, resource_size(res));

This part is not directly related, but a bug fix for commit
b083c22d51148f3d ("video: fbdev: imxfb: Convert request_mem_region +
ioremap to devm_ioremap_resource") in v6.0.

Please do not mix bug fixes with other changes.
The stable teams want to backport only bugfixes .

>  failed_of_parse:
>         kfree(info->pseudo_palette);
>  failed_init:
> --
> 2.39.0

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
