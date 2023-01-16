Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1AA66C7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjAPQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjAPQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:34:38 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B423DBF;
        Mon, 16 Jan 2023 08:22:32 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id x5so1365026qti.3;
        Mon, 16 Jan 2023 08:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFslTO9Xsj1Mi5kjcW6WB1C1HG+qwEGGcinlnuagMLY=;
        b=uGrBzbM56KZv3vd0fAENEKo1sWwp53BlKM/AK+PwKOMzNwI9WV/X5QY6I0O8P9Lmnt
         N547wXDqlkqgEGGU6LYaZeOpF10IL60J8cfIJRTA2TGCM3xt3Y3WSchHdTuFTURba+c/
         1TZsucM/lVpo4HJXlWhkFoi+HEvEV0du7n6w48E9pJsVLn+Li5N+DMi8qmRXkSbOQq4a
         kh4wK14LUuO6awF4d7DPTjXWhgvX6u+TIw3Tr79ezVq9SYYPPSCsb5JWLZ3gOKrvL9IV
         /1Sm6+w/lXhngUe9izJ54mrltZfoNSCScl9B84ipLWgO/MaMBCPBOI/1/2NVcpldft80
         YZog==
X-Gm-Message-State: AFqh2kpjINthGNHsX5/9W9nJun2HrmpWnUbTuVuqJlt2NQdIogUhgReA
        uywtsg3AgZa2SSCSHClNXLYmtEJYvLw/wA==
X-Google-Smtp-Source: AMrXdXuyBsLxJ9ioLKbYTUo6GI7QVZQZHB5atFY7TtQx44fMfptR3YC8Lo8O04G0yBKgjyEI0I40xw==
X-Received: by 2002:a05:622a:4c88:b0:3a8:649:8d0a with SMTP id ez8-20020a05622a4c8800b003a806498d0amr140373277qtb.30.1673886151398;
        Mon, 16 Jan 2023 08:22:31 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id b1-20020ac844c1000000b003b34650039bsm4775953qto.76.2023.01.16.08.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:22:31 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id c124so30779713ybb.13;
        Mon, 16 Jan 2023 08:22:30 -0800 (PST)
X-Received: by 2002:a05:6902:543:b0:7c1:b2e9:7e71 with SMTP id
 z3-20020a056902054300b007c1b2e97e71mr17477ybs.604.1673886150316; Mon, 16 Jan
 2023 08:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-3-fabrizio.castro.jz@renesas.com> <CAMuHMdUzkAjF=v__r2vJrYugBuDt13LnToCW66n-5r-jcVV+8A@mail.gmail.com>
 <TYWPR01MB877570EB023D2ECEB7896F84C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB877570EB023D2ECEB7896F84C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 17:22:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxri6GgGxJy9WC-ktM_zoXDkzRz-6yBqQcikVe3DPShg@mail.gmail.com>
Message-ID: <CAMuHMdXxri6GgGxJy9WC-ktM_zoXDkzRz-6yBqQcikVe3DPShg@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Mon, Jan 16, 2023 at 5:18 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > On Thu, Nov 17, 2022 at 12:49 PM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > As per section 48.4 of the HW User Manual, IPs in the RZ/V2M
> > > SoC need either a TYPE-A reset sequence or a TYPE-B reset
> > > sequence. More specifically, the watchdog IP needs a TYPE-B
> > > reset sequence.
> > >
> > > If the proper reset sequence isn't implemented, then resetting
> > > IPs may lead to undesired behaviour. In the restart callback of
> > > the watchdog driver the reset has basically no effect on the
> > > desired funcionality, as the register writes following the reset
> > > happen before the IP manages to come out of reset.
> > >
> > > Implement the TYPE-B reset sequence in the watchdog driver to
> > > address the issues with the restart callback on RZ/V2M.
> > >
> > > Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Perhaps this logic can be incorporated into the RZ/V2M reset controller
> > driver later, so reset consumers don't have to care about TYPE-A and
> > TYPE-B reset, but can just call reset_control_reset()?
> > I understand that's not gonna be easy, as it needs to know about the
> > relation between resets and clocks, and how to handle both cases (clock
> > (not) switched off) for TYPE-B resets.
>
> Yeah, we have been thinking about dealing with this in the reset controller
> driver, but as you pointed out it's not going to be simple, and therefore
> it'll take some time. This change will guarantee the correct behaviour of
> the watchdog for now, we'll tackle the larger issue later on, if that's okay
> with you.

Fine for me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
