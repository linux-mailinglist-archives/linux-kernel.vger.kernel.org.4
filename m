Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01963ECC9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiLAJp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiLAJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:45:24 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE77B4A4;
        Thu,  1 Dec 2022 01:45:20 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id h16so628497qtu.2;
        Thu, 01 Dec 2022 01:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVLegIJETL5mJ+MPOGcfKwPn4HailtVISKdkup4URCc=;
        b=LUOi+ZtofvpxQ7JFuY5JPcsihQQKgdkay8QtqlexLH/+uJkB/xmk27aM/ji8PcFmdA
         z4EW4KuGqHS9U5l4WJGNPqZDjfvLOBD1UDKGS5jHU9RWyPnyvk8qGqbi3LtuWDj7bL2F
         YMtrssB1r8ZfKV6TywIBNZoOyW6SYYZvtrHHMZqkYNV1yDJ96IzbWdyX5vMbevdtyEAu
         X53oKBqXRP0FaBR9xZTa6HjD1xFCC9GC1+vmKsWLctxTquPBOfkC03G2+rbylqRUNw0l
         X7mf3D4ISDSvOd5TobaR3u1KOStgHzB6qMHClXSTB5wSZNXz6yBbx/RuMV2z9u+x75Kn
         DgCA==
X-Gm-Message-State: ANoB5pmD3JVucS9CYBGN+Y5FQxgLi9emOhM0Owgmes5P98bqIoqI6L54
        4YX840ZQzbF9Rq4DddQP9MKkxPAuPARVkA==
X-Google-Smtp-Source: AA0mqf5MxrKtSxFAacdifBrfjPdLEin/kLJVnYi7As9J4xMdL6ayMCGTuhRtSHkmnz+UgnCCSpJoEg==
X-Received: by 2002:ac8:6793:0:b0:3a5:8416:696a with SMTP id b19-20020ac86793000000b003a58416696amr43029320qtp.634.1669887919371;
        Thu, 01 Dec 2022 01:45:19 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id z10-20020ac86b8a000000b00398a7c860c2sm2286778qts.4.2022.12.01.01.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 01:45:17 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3b56782b3f6so11285487b3.13;
        Thu, 01 Dec 2022 01:45:17 -0800 (PST)
X-Received: by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr59315565ywm.283.1669887917015; Thu, 01
 Dec 2022 01:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221123065946.40415-4-tomi.valkeinen+renesas@ideasonboard.com>
 <CAMuHMdUjCS6q44XmTanu=R68GyuVECLa0B-1AFg1CUD_oV4DuA@mail.gmail.com> <5598c7f8-b47e-338d-e2e3-f62a44903634@ideasonboard.com>
In-Reply-To: <5598c7f8-b47e-338d-e2e3-f62a44903634@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Dec 2022 10:45:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbnPZSxGjk=9GXRj7mxqbNoaJ_jtiJHEq5cLwMshy3uw@mail.gmail.com>
Message-ID: <CAMuHMdXbnPZSxGjk=9GXRj7mxqbNoaJ_jtiJHEq5cLwMshy3uw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] clk: renesas: r8a779g0: Add display related clocks
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Thu, Dec 1, 2022 at 10:26 AM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> On 30/11/2022 21:18, Geert Uytterhoeven wrote:
> > On Wed, Nov 23, 2022 at 8:00 AM Tomi Valkeinen
> > <tomi.valkeinen+renesas@ideasonboard.com> wrote:
> >> Add clocks related to display which are needed to get the DSI output
> >> working.
> >>
> >> Extracted from Renesas BSP tree.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >> --- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> >> +++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c

> >> +       DEF_MOD("dis0",                 411,    R8A779G0_CLK_S0D3),
> >
> > I doubt this parent clock is correct.
> > Based on Table 8.1.4e ("Lists of CPG clocks generated from PLL5"),
> > this should be one of the VIOBUS clocks.
> > VIOBUSD2 has the same rate as S0D3, so I'd use that one.
> >
> >> +       DEF_MOD("dsitxlink0",           415,    R8A779G0_CLK_DSIREF),
> >> +       DEF_MOD("dsitxlink1",           416,    R8A779G0_CLK_DSIREF),
>
> Now that you started questioning about the clocks, I started to wonder
> about the DSI clocks. They don't quite make sense to me, but here also I
> just assumed it's "fine" as I copied it and it works.
>
> The VIOBUS & VIOBUSD2 are marked to as going to the DSI. But we don't
> actually mark any of the DSI clocks as coming from those sources.
>
> DSIREF is quite clear, it's the source for DSI PLL.
>
> DSIEXT goes to the DSI PHY and is also marked to be used for LP-TX.
>
> In the DT we have now:
>
> clocks = <&cpg CPG_MOD 415>,
>          <&cpg CPG_CORE R8A779G0_CLK_DSIEXT>,
>          <&cpg CPG_CORE R8A779G0_CLK_DSIREF>;
> clock-names = "fck", "dsi", "pll";
>
> The "dsi" clock name is a bit vague, but maybe it's "not fclk, not pll,
> but still needed for dsi"? =)
>
> Is it ok to refer to DSIEXT & DSIREF like that, or should they be in the

Sounds fine to me.

> r8a779g0_mod_clks list? Or is that list for fclks only?

That list is only for clocks which have a bit in an MSTPCR (module
stop control register, Section 9.2.3).  These are typically controlled
through the Clock Domain and Runtime PM (but not for the DU, as there
is always only a single node in DT, even when the DU has multiple module
clocks on R-Car Gen2/3).

Actually our abstraction may be a bit off: sometimes that bit may gate
multiple clocks leading to the module, but as that was never documented
well, we settled on a single functional clock only, which is the most
common case.

> So the fclk in the dts is mod clock 415 (416 for the second dsi), which
> is dsitxlink0 or dsitxlink1. Well, those names don't quite make sense if
> it's a fclk.
>
> I would rename those clocks to "dsi0" and "dsi1", and source them from
> R8A779G0_CLK_VIOBUSD2, similarly to the other video clocks.
>
> Does the above make sense?

Please keep the names, as that's how they are called in Section 9.2.3.5
("Module Stop Control Register 4 (MSTPCR4)").

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
