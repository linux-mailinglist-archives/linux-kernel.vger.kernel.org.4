Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB274CEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGJHl3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGJHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:41:27 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDB95;
        Mon, 10 Jul 2023 00:41:26 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so3968072276.0;
        Mon, 10 Jul 2023 00:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974885; x=1691566885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaG+dxGLhC0WVqrix8l2g6lvQOz/XURDuBAw1AOu2T0=;
        b=JSV576iGL+LjlEi7x/FjJ7R6oh+YMyVM6ymT+hlAlBcmTQTbl7n1UWBfINtv76RCxb
         UhIscFgrwcgQ5kwB5C82WK292i/PnclkuHDbaqK8o5MS358any6rlpW+Z5Scv2694WLp
         B2hvfevT2wwXuE8sseTuqR6YKHHHEuhMqVnBwceKl3KweZZVko3Y0/XN6IP7Nop/hvhx
         KqSfok8fmiWcpP1A96+le7Paxp8FmO3aHHjOou2mRQdG70CyFGZz5lEoy7go6w+gHCZo
         BTbu22a9MZUn0hoX+d7TMMJmx7lwu0Uq+3HBlSIgnubm4tpzcoz0Pxt39PQxNzNL6Zua
         kjYA==
X-Gm-Message-State: ABy/qLaAp2yjvFAfUdS5S5QAQJsiiq76Ml1amO2N1SbwRBMemZJuDb/i
        NIhHYDPlWMAPxCTPNFgP/pQ9UpKZ8/HEaA==
X-Google-Smtp-Source: APBJJlGygztoZvB/+etWk8ncAjr5Udq2kibn/Ngcnba2E10FRhYuH3lF6olZ2F74lqaLNcv7itp8sg==
X-Received: by 2002:a0d:cad6:0:b0:576:94e1:efec with SMTP id m205-20020a0dcad6000000b0057694e1efecmr13282688ywd.33.1688974885422;
        Mon, 10 Jul 2023 00:41:25 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id u13-20020a0deb0d000000b0057a79da2009sm1058122ywe.16.2023.07.10.00.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:41:24 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so3968040276.0;
        Mon, 10 Jul 2023 00:41:24 -0700 (PDT)
X-Received: by 2002:a25:4c07:0:b0:bc6:5d71:f820 with SMTP id
 z7-20020a254c07000000b00bc65d71f820mr10395845yba.55.1688974884151; Mon, 10
 Jul 2023 00:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230704093652.18191-1-frank.li@vivo.com> <CAMuHMdWrBY1+JDuwODyqLrwJJivt=ewCOKfK41xq+0Hpaf8akQ@mail.gmail.com>
 <da543602-f88e-45ee-d7fd-8fddd0b0ac56@vivo.com>
In-Reply-To: <da543602-f88e-45ee-d7fd-8fddd0b0ac56@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 09:41:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVa3RmtFouTYk_rPoxO1EswGzTtt855-eFcvtTYObgUCA@mail.gmail.com>
Message-ID: <CAMuHMdVa3RmtFouTYk_rPoxO1EswGzTtt855-eFcvtTYObgUCA@mail.gmail.com>
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

On Mon, Jul 10, 2023 at 9:25 AM Yangtao Li <frank.li@vivo.com> wrote:
> On 2023/7/10 15:10, Geert Uytterhoeven wrote:
> > [你通常不会收到来自 geert@linux-m68k.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
> > On Tue, Jul 4, 2023 at 11:38 AM Yangtao Li <frank.li@vivo.com> wrote:
> >> Use devm_platform_ioremap_resource() to simplify code.
> >>
> >> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > Thanks for your patch, which is now commit c1cd7a7a231a26c6 ("fbdev:
> > imxfb: Convert to devm_platform_ioremap_resource()") in fbdev/for-next
> >
> >> --- a/drivers/video/fbdev/imxfb.c
> >> +++ b/drivers/video/fbdev/imxfb.c
> >> @@ -868,7 +868,6 @@ static int imxfb_probe(struct platform_device *pdev)
> >>          struct imxfb_info *fbi;
> >>          struct lcd_device *lcd;
> >>          struct fb_info *info;
> >> -       struct resource *res;
> >>          struct imx_fb_videomode *m;
> >>          const struct of_device_id *of_id;
> >>          struct device_node *display_np;
> >> @@ -885,10 +884,6 @@ static int imxfb_probe(struct platform_device *pdev)
> >>          if (of_id)
> >>                  pdev->id_entry = of_id->data;
> >>
> >> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> -       if (!res)
> >> -               return -ENODEV;
> >> -
> >>          info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
> >>          if (!info)
> >>                  return -ENOMEM;
> >> @@ -970,7 +965,7 @@ static int imxfb_probe(struct platform_device *pdev)
> >>                  goto failed_getclock;
> >>          }
> >>
> >> -       fbi->regs = devm_ioremap_resource(&pdev->dev, res);
> >> +       fbi->regs = devm_platform_ioremap_resource(pdev, 0);
> >>          if (IS_ERR(fbi->regs)) {
> >>                  ret = PTR_ERR(fbi->regs);
> >>                  goto failed_ioremap;
> >> @@ -1043,7 +1038,6 @@ static int imxfb_probe(struct platform_device *pdev)
> >>   failed_map:
> >>   failed_ioremap:
> >>   failed_getclock:
> >> -       release_mem_region(res->start, resource_size(res));
> > This part is not directly related, but a bug fix for commit
> > b083c22d51148f3d ("video: fbdev: imxfb: Convert request_mem_region +
> > ioremap to devm_ioremap_resource") in v6.0.
>
>
> IIUC, split this patch into two, remove release_mem_region in one and
>
> mark it as Fixes: b083c22d51148f3d ("video: fbdev: imxfb: Convert
> request_mem_region +
>
> ioremap to devm_ioremap_resource")?

Exactly.  But as Helge has already applied this patch to his tree, we have
to check with him if this is still feasible...

> > Please do not mix bug fixes with other changes.
> > The stable teams want to backport only bugfixes .
> >
> >>   failed_of_parse:
> >>          kfree(info->pseudo_palette);
> >>   failed_init:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
