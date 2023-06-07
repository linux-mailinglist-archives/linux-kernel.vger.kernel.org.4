Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C51726198
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbjFGNpS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbjFGNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:45:15 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0319BF;
        Wed,  7 Jun 2023 06:45:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bb3d122a19fso1530335276.0;
        Wed, 07 Jun 2023 06:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145513; x=1688737513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89KRlV/r+fdosLxqMDM4AtIM18bITUmtBR0bjcUA6Gw=;
        b=dVt7Mmy24Jnr1w5AHw+yYvTMZC9HH2AQR1BCM66kBO7lMKj73cGg1nFEjeQpcs28Rr
         LKSs8WHhipL5MdzZREjVd+N4MURmc/4EMwSoDyMsJImRCkgCeeFAiqCyrM7bIM0xiakt
         CJlX9jWMnsBAO6zaaHf+TKCh8MK/mpRJnPVW0XLYBpcXrargQLz3Pb8DHYTrFaxgowB6
         ojcIu+0hldIl/YT78NDZY96K4UI8quV1UcY+Ez57d1kbWVGPx82R0RELud7WxjM6L+sG
         6TtYAeQ/p3ef4M65yqvNiLzdrBbJDiv39q43pYjiHHkqteUU1v41bR7oC1HBmXmQAdRF
         HOJw==
X-Gm-Message-State: AC+VfDwxNfoUg+Ygxh9DU2d5+x4/D8pj2Iz9KHkx5YVOiG7ujAzVS3hp
        7+0of8G5EsG3J6oXUP9/KdfAABvU3kygKQ==
X-Google-Smtp-Source: ACHHUZ7kIhsE9/1CUUMEq3Q32FQchYhWgrQP6VG9GQo67SUM/r/XaA+VBXILaIqR44Q88gyrlqhTjQ==
X-Received: by 2002:a25:6086:0:b0:bb3:8945:d6fd with SMTP id u128-20020a256086000000b00bb38945d6fdmr5060140ybb.12.1686145510547;
        Wed, 07 Jun 2023 06:45:10 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id e66-20020a25e745000000b00ba6ffc7ef35sm3834778ybh.65.2023.06.07.06.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:45:09 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bacf9edc87bso8672364276.1;
        Wed, 07 Jun 2023 06:45:09 -0700 (PDT)
X-Received: by 2002:a25:3289:0:b0:ba8:2473:bb4c with SMTP id
 y131-20020a253289000000b00ba82473bb4cmr5294364yby.31.1686145509569; Wed, 07
 Jun 2023 06:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230530112050.5635-1-aford173@gmail.com> <20230530112050.5635-3-aford173@gmail.com>
 <CAMuHMdXJaZCSN18aB1yBvhuTk=DQoe4B6aVHgoZvyLsZcRfrDA@mail.gmail.com> <CAHCN7xJbi4ej2s6SOvC7o7aMcjv2awztKkNoAZTiVFn4GJRVXw@mail.gmail.com>
In-Reply-To: <CAHCN7xJbi4ej2s6SOvC7o7aMcjv2awztKkNoAZTiVFn4GJRVXw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jun 2023 15:44:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX9vrnwZ5cA1_u9MtRetME-wt+BaaU=JX=Yc4jeJb9H9g@mail.gmail.com>
Message-ID: <CAMuHMdX9vrnwZ5cA1_u9MtRetME-wt+BaaU=JX=Yc4jeJb9H9g@mail.gmail.com>
Subject: Re: [RFC 3/3] arm64: dts: renesas: r8a774a1: Add GPU Node
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        marek.vasut+renesas@gmail.com, cstevens@beaconembedded.com,
        aford@beaconembedded.com, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Wed, Jun 7, 2023 at 3:31 PM Adam Ford <aford173@gmail.com> wrote:
> On Wed, Jun 7, 2023 at 8:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, May 30, 2023 at 1:21 PM Adam Ford <aford173@gmail.com> wrote:
> > > With the 3dge and ZG clocks now available, the generic GPU node can
> > > be added.  Until proper firmware is made, it is not usable.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > This is based on the assumption that the Rogue 6250 could use
> > > generic driver [1] and firmware [2] being implemebted by the Mesa group
> > > and others.  In practice, the firmware isn't really compatible since
> > > the 6250 in the RZ/G2M appears to be a different variant.
> > >
> > > [1] - https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/powervr-next
> > > [2] - https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/powervr/powervr
> >
> > Thanks for your patch!
> >
> > > --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > @@ -226,6 +226,27 @@ extalr_clk: extalr {
> > >                 clock-frequency = <0>;
> > >         };
> > >
> > > +       gpu_opp_table: opp-table {
> > > +               compatible = "operating-points-v2";
> > > +
> > > +               opp-200000000 {
> > > +                       opp-hz = /bits/ 64 <200000000>;
> > > +                       opp-microvolt = <830000>;
> > > +               };
> > > +               opp-300000000 {
> > > +                       opp-hz = /bits/ 64 <300000000>;
> > > +                       opp-microvolt = <830000>;
> > > +               };
> > > +               opp-400000000 {
> > > +                       opp-hz = /bits/ 64 <400000000>;
> > > +                       opp-microvolt = <830000>;
> > > +               };
> > > +               opp-600000000 {
> > > +                       opp-hz = /bits/ 64 <600000000>;
> > > +                       opp-microvolt = <830000>;
> > > +               };
> > > +       };
> > > +
> > >         /* External PCIe clock - can be overridden by the board */
> > >         pcie_bus_clk: pcie_bus {
> > >                 compatible = "fixed-clock";
> > > @@ -2347,6 +2368,18 @@ gic: interrupt-controller@f1010000 {
> > >                         resets = <&cpg 408>;
> > >                 };
> > >
> > > +               gpu@fd000000 {
> > > +                       compatible = "img,powervr-series6xt";
> > > +                       reg = <0 0xfd000000 0 0x40000>;
> > > +                       interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> > > +                       clocks = <&cpg CPG_MOD 112>, <&cpg CPG_MOD 112>,<&cpg CPG_MOD 112>;
> > > +                       clock-names = "core", "mem", "sys";
> > > +                       interrupt-names = "gpu";
> > > +                       operating-points-v2 = <&gpu_opp_table>;
> > > +                       power-domains = <&sysc R8A774A1_PD_3DG_B>;
> > > +                       resets = <&cpg 112>;
> > > +               };
> > > +
> > >                 pciec0: pcie@fe000000 {
> > >                         compatible = "renesas,pcie-r8a774a1",
> > >                                      "renesas,pcie-rcar-gen3";
> >
> > LGTM.  But obviously I cannot take this as-is, as there are no DT bindings
> > for this device, and it didn't work for you...
>
> It was mostly to follow up to the previous ones with links for the
> mainline Rogue video driver in the hopes that someone from Renesas
> might have some input on whether or not Renesas might be able to
> support this and have a discussion.  I knew when I submitted it that
> it wouldn't be accepted which is why I posted it as an RFC.
> If I address concerns you have in the previous patches, would you be
> OK with me submitting then as a formal patch to at least get the rest
> of the system ready in the event the GPU driver/firmware becomes
> available?  It seems harmless, but I also see the argument that it's
> dead code without the GPU node.

The clock patches are almost there, and I'm happy to accept them
when the last rough edges have been removed.

> If not, I'll shelve this for now, and hope to get some responses from Renesas.

Good luck! ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
