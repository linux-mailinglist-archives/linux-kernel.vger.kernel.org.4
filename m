Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB05F6266
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiJFIQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJFIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:16:04 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E60F7539B;
        Thu,  6 Oct 2022 01:16:02 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id i3so578655qkl.3;
        Thu, 06 Oct 2022 01:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R5B71qPqaTjwjXY7p5kJrtkSEz4tsM7zjyMB/6HdHbo=;
        b=nPmlVO+hZE7OOuT0AM0usRmfUQRHMSc3wzVuV8N7GZ9+Z/vtraSH4BgwO+JGv5zR9V
         sagAUiY1FYDikkYLuEPf9VuJmq9KVLOh4XWBhh0JGcDh+eB2sTh8Z0QncUnqbaZIm4us
         RsULE3/eKroR8/JbGfkuyPrQoqB22v1yvZgMNeQjC3OgqKQG3GdxiVzEDHAyaRDfw58y
         zHMWK5C2uL370nAQGA4obs4Sww06bNj2WwA3ejxdBCZO7M7V65YnJZOl6vQkjXq+wwCB
         7VHT+pePeoF3yFNkW9BJ/00WmynaGBv5Q6vjn5Oh0eTwb50qomafowtY74D8Sw6ZoLHv
         PJSg==
X-Gm-Message-State: ACrzQf1Ji4fb0RKtOuzP0Iyyy03O0AG6P3gOBiqAQf7Mp5E5BvVh0Xpc
        Tkj1Qfj5PIHExNshQ0xF9biniGOD1pllkQ==
X-Google-Smtp-Source: AMsMyM56fI3hb2c+GtnH2R7j8bZsHFw0XqP+rtSRsKTsv+A1uMTd05vV2pDEIAlk8/g9g8JAJPjfnw==
X-Received: by 2002:a37:9144:0:b0:6cf:5dc3:417c with SMTP id t65-20020a379144000000b006cf5dc3417cmr2240451qkd.213.1665044161354;
        Thu, 06 Oct 2022 01:16:01 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006bb8b5b79efsm20822915qkl.129.2022.10.06.01.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:16:00 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 207so1398141ybn.1;
        Thu, 06 Oct 2022 01:16:00 -0700 (PDT)
X-Received: by 2002:a05:6902:45:b0:6ae:ce15:a08d with SMTP id
 m5-20020a056902004500b006aece15a08dmr3586685ybh.380.1665044159991; Thu, 06
 Oct 2022 01:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
 <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8utdkb61v_1=G85O6OCtQDv-+5YuyFy4r7BW+fR2E=WkQ@mail.gmail.com>
 <OS0PR01MB592278FB3E443C84130FCA7D864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922DAA91FFD18FD52FEC916865D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8uNhM92ezEX3iCcP2zp3Er9EPDy1Z-4L3gQfe=xU8O1bw@mail.gmail.com>
In-Reply-To: <CA+V-a8uNhM92ezEX3iCcP2zp3Er9EPDy1Z-4L3gQfe=xU8O1bw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Oct 2022 10:15:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0BSByCZynkdhDQNcQ+7UT=YgZLe_YNVR4d=dS=2mX=g@mail.gmail.com>
Message-ID: <CAMuHMdU0BSByCZynkdhDQNcQ+7UT=YgZLe_YNVR4d=dS=2mX=g@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar, Biju,

On Wed, Oct 5, 2022 at 2:56 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Oct 5, 2022 at 9:27 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > On Mon, Sep 19, 2022 at 2:52 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > > On Mon, Sep 19, 2022 at 2:35 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > > From: Lad Prabhakar <prabhakar.mahadev-
> > > lad.rj@bp.renesas.com>
> > > > > > > > Add the WDT2 clocks to r9a07g044_crit_mod_clks[] list as WDT CH2 is
> > > > > > > > specifically to check the operation of Cortex-M33 CPU on the
> > > > > > > > RZ/{G2L, G2LC, V2L} SoCs and we dont want to turn off the clocks of
> > > > > > > > WDT2 if it isn't enabled by Cortex-A55.
> > > > > > > >
> > > > > > > > This patch is in preparation to disable WDT CH2 from the RZ/G2L
> > > > > > > > (alike
> > > > > > > > SoCs) DTS/I by default.
> > > > > > > >
> > > > > > > > Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > I got confirmation that that using WDT2 from CA55 is prohibited.
> > WDT2 is only for CM33.
> >
> > With CPG register, we can select whether CM33 to trigger CM33 cpu reset, or trigger system reset
> > when WDT2 overflows.
> >
> > If WDT2 is used by CA55, it may result in unexpected behaviour.
> >
> Thanks.
>
> > So we may need to take WDT2 entries from binding + dtsi + clock table??
> >
> > Or
> >
> > Added it to critical clock list, to avoid changes in binding + dtsi + clock table
> > at the expense of turning on the WDT2 clk unnecessarily.

... plus still risking to interfere with the CM33.

> I'm in favour of option#1 except that we keep WDT2 entries in binding.

Agreed (bindings are append-only).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
