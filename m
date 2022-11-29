Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220C263BF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiK2Lts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiK2Ltp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:49:45 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A46326F4;
        Tue, 29 Nov 2022 03:49:42 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id i12so9475969qvs.2;
        Tue, 29 Nov 2022 03:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwy1vGtxbJANcG7P6mnYEhIP56iYI+V4HEAxAZcQxWs=;
        b=pQ1aLQAFhauo+XAma7nDVu4Xt0RfVR7cz8A/Qs/LKSMd4/AZ1q8rxWopKNc96+EQ3q
         HiB8nUUeviiJu25IWKknDm9eBvmRUZKZXDZMBg97LFdCJIB/t8TqmRatvIcRVjQc4Xjv
         8KLkjbNwBLuN7oGTdSLI9jQ8rpiW6MvGRhkYgT4AUvRQqRbPk8r9FyGQaRaEV3mOEFLg
         B1B5YUL0lp9EDY3tlGx+A1xPyVcWHbTig+38Ut2xd5Bw0AZHzztKAWqm1WuJJuxEbcyL
         10iHEMDqi01hOGfQasAe6pjTb1aQtN0FksIVzR34TXBF/3WC4TXbuushISAIzDrpoh+E
         1IhA==
X-Gm-Message-State: ANoB5pnkJHg9QR4DyV256lR1aOMvkc8NQPnwmdgK+1R9Z83Qe9wvDf40
        6HhnTIRnsJwhsXR5IiXHuVFXBDQOyrnRkQ==
X-Google-Smtp-Source: AA0mqf7TjldwGog/spxeB2DB3pvVNPh5H6VQHXteRqEMFgJZSc/ftztFEM6Rtq6p1dw0FE+VoXMWbg==
X-Received: by 2002:a05:6214:5cf:b0:4c6:f7e6:dee with SMTP id t15-20020a05621405cf00b004c6f7e60deemr13050672qvz.81.1669722581657;
        Tue, 29 Nov 2022 03:49:41 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x2-20020ac87ec2000000b0039a9b55b829sm8387242qtj.29.2022.11.29.03.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 03:49:40 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id e141so17103172ybh.3;
        Tue, 29 Nov 2022 03:49:40 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr27506745ybc.543.1669722579841; Tue, 29
 Nov 2022 03:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221123065946.40415-8-tomi.valkeinen+renesas@ideasonboard.com>
 <Y4VlHIpS9UnvWwt/@pendragon.ideasonboard.com> <d11033df-e103-e33c-c61a-a0725f7098b1@ideasonboard.com>
 <OS0PR01MB59224C2B4F889534922ACFE186129@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59224C2B4F889534922ACFE186129@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Nov 2022 12:49:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXz8ZSge5b4s8v6Oon55gO+3Cu_Uvn7GFV62JCSqNf1Qw@mail.gmail.com>
Message-ID: <CAMuHMdXz8ZSge5b4s8v6Oon55gO+3Cu_Uvn7GFV62JCSqNf1Qw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] drm: rcar-du: dsi: Add r8a779g0 support
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Tue, Nov 29, 2022 at 12:40 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> > On 29/11/2022 03:49, Laurent Pinchart wrote:
> > > On Wed, Nov 23, 2022 at 08:59:46AM +0200, Tomi Valkeinen wrote:
> > >> Add DSI support for r8a779g0. The main differences to r8a779a0 are in
> > >> the PLL and PHTW setups.
> > >>
> > >> Signed-off-by: Tomi Valkeinen
> > >> <tomi.valkeinen+renesas@ideasonboard.com>

> > >> --- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> > >> +++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> > >> @@ -9,6 +9,7 @@
> > >>   #include <linux/delay.h>
> > >>   #include <linux/io.h>
> > >>   #include <linux/iopoll.h>
> > >> +#include <linux/math64.h>
> > >>   #include <linux/module.h>
> > >>   #include <linux/of.h>
> > >>   #include <linux/of_device.h>
> > >> @@ -28,6 +29,20 @@
> > >>   #include "rcar_mipi_dsi.h"
> > >>   #include "rcar_mipi_dsi_regs.h"
> > >>
> > >> +#define MHZ(v) ((v) * 1000000u)
> > >
> > > Isn't the U suffix usually spelled in uppercase ? Same below.
> >
> > I couldn't find any coding style guidelines on that. I like the lower
> > case visually. The suffix stands out much clearer on 10000000u than on
> > 10000000U. But I can change it if you feel otherwise.
>
> https://elixir.bootlin.com/linux/v6.1-rc7/source/include/linux/units.h#L11
>
> Maybe you could add MHZ here??

Or use the existing MEGA? The metric system is soooo nice! ;-)

BTW, looks like the people adding definitions like

    #define MICROHZ_PER_HZ 1000000UL
    #define MILLIHZ_PER_HZ 1000UL

    #define MILLIWATT_PER_WATT 1000UL
    #define MICROWATT_PER_MILLIWATT 1000UL
    #define MICROWATT_PER_WATT 1000000UL

didn't grasp the full power...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
