Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC865BFA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjACMKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbjACMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:10:41 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA51E022;
        Tue,  3 Jan 2023 04:10:40 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id i84so8298964vke.7;
        Tue, 03 Jan 2023 04:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfaW83NGJ0rvdUnRHgSi4+IHmvqlUCSBL7ZpSjvyOw0=;
        b=TZ3l9LHllzPPbmgla+AAsrhXvrAE9cZJnsqF7CK1KEWM9yU3nu48CWpudivVfMax9N
         NbYNR9IqimHMkKpUezHH+Jx2z19328h0rkXl2UuTlKJQ16ZY5PdnIhBm/mWAYiEt5iW9
         CkguWQrnSSx0YPguAKYA2ubWFPCFvCInEVbbCIR9hv5Or1kLsZlMG9UrlzxvYqBjY+E6
         srM9+6uJKsXvbO7w7HQSwtnwotaOuM52c7uho7KPyS3KihIQLIivDjajxMqBshVjBB+1
         P0L33aoGFGdqj9TXwUrlTr1Tp1zYn5aBpOz4RA+Ud9Yvox1TcQl87OXCLaezaDsBIuyg
         5ACw==
X-Gm-Message-State: AFqh2kqKrxvAgi8+nNFYWQspl6b2T7wWSYLuqL0oKTEtZeH9QRjsH3rL
        CT1QVbGTgFrMAVlwwq8/PnW5d0/5+Rzb6g==
X-Google-Smtp-Source: AMrXdXuWjyK2YkuczdB40iHdoO3izZreJyAW4zE3GZ+HJ4WwPPYwf39VJXhGLDLscsYOD1hS623X8Q==
X-Received: by 2002:a1f:18cc:0:b0:3d5:6f50:3fc7 with SMTP id 195-20020a1f18cc000000b003d56f503fc7mr11859066vky.2.1672747839020;
        Tue, 03 Jan 2023 04:10:39 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id y1-20020a37f601000000b006fa2b1c3c1esm21753222qkj.58.2023.01.03.04.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:10:38 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-4a0d6cb12c5so104363427b3.7;
        Tue, 03 Jan 2023 04:10:37 -0800 (PST)
X-Received: by 2002:a05:690c:c02:b0:48d:1334:6e38 with SMTP id
 cl2-20020a05690c0c0200b0048d13346e38mr2403543ywb.316.1672747837138; Tue, 03
 Jan 2023 04:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com> <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
 <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 13:10:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=Kwi80akxRUFUYz4QKQBkSog2xb4tw=DjJApAr-n5Lw@mail.gmail.com>
Message-ID: <CAMuHMdU=Kwi80akxRUFUYz4QKQBkSog2xb4tw=DjJApAr-n5Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Tue, Jan 3, 2023 at 1:05 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Wed, Dec 21, 2022 at 10:09 PM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > The External Power Sequence Controller (PWC) IP (found in the
> > > RZ/V2M SoC) is a controller for external power supplies (regulators
> > > and power switches), and it supports the following features: it
> > > generates a power on/off sequence for external power supplies,
> > > it generates an on/off sequence for the LPDDR4 core power supply
> > > (LPVDD), it comes with General-Purpose Outputs, and it processes
> > > key input signals.
> >
> > Thanks for your patch!
> >
> > > The PWC is basically a Multi-Function Device (MFD), its software
> > > support comes with a core driver, and specialized drivers for
> > > its specific features.
> >
> > I have to admit I'm not such a big fan of MFD.  In this driver,
> > you are not even sharing resources in the MFD cells, just the mapped
> > register base.  So I think you can easily save +100 LoC and reduce
> > maintenance synchronization overhead across subsystems by just having
> > a single non-MFD driver instead.
> >
> > Did you pick MFD because the PWC poweroff feature depends on board
> > wiring, and thus is optional?
>
> I am not a big fan of MFD, either.
> I picked MFD because we were not 100% sure of what the IP could do
> when we started working on it.
> I have received more information regarding the IP now (which I don't
> have the liberty to discuss), I am still not 100% sure that's all
> of it, but basically its support may require expansion later on.
>
> I liked the solution based on syscon and simple-mfd for several reasons,
> but having dropped syscon and simple-mfd due to issues with the dt-bindings
> I have moved on with a core driver to instantiate the required SW support.
> We could of course move to a unified driver if that makes more sense?
> If we were to move to unified driver, under which directory would you
> suggest we put it?

As the GPIO part is larger than the poweroff part, I would put it under
drivers/gpio/.  Although drivers/soc/renesas/ could be an option, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
