Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C56374814A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGEJpa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGEJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:45:24 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C71710;
        Wed,  5 Jul 2023 02:45:23 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so7208366276.3;
        Wed, 05 Jul 2023 02:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688550323; x=1691142323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcR5Z7bqdCoMamCzC507RnWuaeZOVS+4BY7fdjteDuw=;
        b=YueQH3ygL/3FlI/0jL3KQX5+oHT2QjyRzqAyJ0SAUZ0gzfAqB1s+AStGBOjLUUZ5qn
         +9oiZ9fH9dkya9GSh1TEowARdJVLjWyr9Ypfmxs7Gm9Cbu3w43ojX646thyV4uxdkI5n
         nZ8FF7gzfY1uYO0JrWtPlbkjx6lVH4K6n/6XWCldZM5ALiXOS7J5OSbyDpQJh4HM3GB4
         ehWPyNr9OSpUVykU2vQ21+aESAXF4zW9hxrUrIdHnXqUihV6I0DQHmG1QhhL3QOylTHQ
         H/bxXzI66jgkn5M/8L0ze+QHFUH9CFRPWkQkhCdEQpmfHKWMp7AUxxQ9OHw3bEHXiouo
         6suQ==
X-Gm-Message-State: ABy/qLYL5MU3kxCyONhtcBkLI5f8QP82xd1JnS0uSSU8C2U/RkuohSKQ
        YN0GK89ZOw3LUj7QR8PCY3kkK/mXhASM2A==
X-Google-Smtp-Source: APBJJlFKqCRgYSBH4qLJTRwHBlKGAQM4TrOtFCWFLecDqYiz9RHnvrs7+C22gKBVbyX+OvfI7Jdx9A==
X-Received: by 2002:a25:14d7:0:b0:bd6:8725:2258 with SMTP id 206-20020a2514d7000000b00bd687252258mr12775230ybu.60.1688550322805;
        Wed, 05 Jul 2023 02:45:22 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id ck8-20020a05690218c800b00c389676f3a2sm3142276ybb.40.2023.07.05.02.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:45:22 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bff27026cb0so7204643276.1;
        Wed, 05 Jul 2023 02:45:22 -0700 (PDT)
X-Received: by 2002:a25:344f:0:b0:c64:5116:795 with SMTP id
 b76-20020a25344f000000b00c6451160795mr405835yba.65.1688550322104; Wed, 05 Jul
 2023 02:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <607bd6ab4905b0b1b119a06ef953fa1184505777.1688396717.git.geert+renesas@glider.be>
 <TYWPR01MB87755B1EEDEA676237009CF3C22EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB87755B1EEDEA676237009CF3C22EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 5 Jul 2023 11:45:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmgvzYeHfiK6ZJ8Z2iYe0HOG7udPuAGQ6VCmEk9qJK8w@mail.gmail.com>
Message-ID: <CAMuHMdWmgvzYeHfiK6ZJ8Z2iYe0HOG7udPuAGQ6VCmEk9qJK8w@mail.gmail.com>
Subject: Re: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode names
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Jul 4, 2023 at 5:48 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Subject: [PATCH/RFT] pinctrl: renesas: rzv2m: Handle non-unique subnode
> > names
> >
> > The eMMC and SDHI pin control configuration nodes in DT have subnodes
> > with the same names ("data" and "ctrl").  As the RZ/V2M pin control
> > driver considers only the names of the subnodes, this leads to
> > conflicts:
> >
> >     pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by
> > 85000000.mmc; cannot claim for 85020000.mmc
> >     pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
> >     renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, reverse
> > things back
> >
> > Fix this by constructing unique names from the node names of both the
> > pin control configuration node and its child node, where appropriate.
> >
> > Reported by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Fixes: 92a9b825257614af ("pinctrl: renesas: Add RZ/V2M pin and gpio
> > controller driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Tested-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks, will queue as a fix in renesas-pinctrl-for-v6.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
