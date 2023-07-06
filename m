Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A237496D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjGFHxW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGFHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:53:20 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C5121
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:53:20 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso395264276.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688629999; x=1691221999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLFxQ4JHG9tvjlmQac1kJ2yw4Iq48iBlz2d7dmbQkwM=;
        b=Xmv8nu2NisZ1/cDKLFN9JzF+WIMGDSnW5CijkRATou4msOFbKP++x2uEGn0dEIfKuY
         uizBcoKrtaU7y8mCko9EqzQTSYYoFlBGp5qDbMc3SZV1qVI0JECpOkeaYZKAWif0G6EL
         jeJcocnU4um8TjF5y1bowI8oQ5uiHof2bRgUURv1bs6v5yN8zCavrzVmIf14EVvUVEuv
         CyqVwcKXUoOKJgGj34jYD+EASMEbSL6e75YerS1OB8apSB8lYyzvcINv90HLuXh04CI0
         e3t2OLUWEwcaIf2xNjytUZ+YfKYpqlkgu8jY4vJtRdr4k8gpwVezvGpitQyaiFHWPp+y
         sCjw==
X-Gm-Message-State: ABy/qLYQz/avAoQvsGIv2SQcSq/GlUqTOMN5nWVR4DI5vfw3m1E1YOpN
        LCJrEUXskQZbyH1OsWe9vACJj4Eto9HBZw==
X-Google-Smtp-Source: APBJJlHZLt2Ka2h8cc2EgLmHwGyAwQIf3gR5GbAoyR+46wZoBTZd8p+D8kUUm2LvQGnwEUe8JpxIxA==
X-Received: by 2002:a25:becd:0:b0:c64:5116:795 with SMTP id k13-20020a25becd000000b00c6451160795mr1065525ybm.65.1688629999206;
        Thu, 06 Jul 2023 00:53:19 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id u9-20020a25f809000000b00c64ff4e745bsm188001ybd.51.2023.07.06.00.53.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:53:19 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so381043276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:53:17 -0700 (PDT)
X-Received: by 2002:a25:7804:0:b0:bd6:8725:2258 with SMTP id
 t4-20020a257804000000b00bd687252258mr1002406ybc.60.1688629997542; Thu, 06 Jul
 2023 00:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230706071310.38388-1-luhongfei@vivo.com> <CAMuHMdV1TTKYMQfnZ_6H1Vee9NcYtN1TK0wNesqsjiKwBHZz=A@mail.gmail.com>
In-Reply-To: <CAMuHMdV1TTKYMQfnZ_6H1Vee9NcYtN1TK0wNesqsjiKwBHZz=A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jul 2023 09:53:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWG01LNa2Umgzcv6knAtbPnRSQYs71bwh3yL9W9XN=CFw@mail.gmail.com>
Message-ID: <CAMuHMdWG01LNa2Umgzcv6knAtbPnRSQYs71bwh3yL9W9XN=CFw@mail.gmail.com>
Subject: Re: [PATCH] drivers: bus: Fix resource leaks in for_each_available_child_of_node
 loop
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
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

On Thu, Jul 6, 2023 at 9:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jul 6, 2023 at 9:13 AM Lu Hongfei <luhongfei@vivo.com> wrote:
> > Ensure child node references are decremented properly in
> > the error path.
>
> Which error path?
>
> >
> > Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> > ---
> >  drivers/bus/imx-weim.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> > index 52a5d0447390..d05472f7c20f 100644
> > --- a/drivers/bus/imx-weim.c
> > +++ b/drivers/bus/imx-weim.c
> > @@ -251,6 +251,7 @@ static int weim_parse_dt(struct platform_device *pdev)
> >                 else
> >                         have_child = 1;
> >         }
> > +       of_node_put(child);
>
> This is not an error path.
>
> for_each_available_child_of_node() walks a list, getting a reference
> to each child, and releasing the reference afterwards.

FTR, calling of_node_put() manually is only needed when breaking
out of for_each_available_child_of_node().

>
> Have you tested this patch?
> I expect the of_node_put() to trigger a refcount underflow error
> message on the console.
>
> >
> >         if (have_child)
> >                 ret = of_platform_default_populate(pdev->dev.of_node,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
