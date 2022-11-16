Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47B62B67B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiKPJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiKPJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:26:53 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1126389;
        Wed, 16 Nov 2022 01:26:51 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id j6so11506015qvn.12;
        Wed, 16 Nov 2022 01:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGSh9ezbCO5Cs+0MRBpsxP1k4L0kzxgW9LPRl1yAGr0=;
        b=aM9QqSWGeOYDmyN8URcMvMR54HYgT1P0VvS7/MjVpF9mtIvl2J8j/YVV7pRwStmXzD
         5x/vuh63SElEqPyxY1dP9w/wY4+OmVGxiW/JjNScbLluVLIZQL6mZYcFLhE1p8ks4Opw
         vExf2bbMMEyQcSWllO2Dmhw75zvw2JdM22IiyUv3tlvkfeBnFs61kEj/TNhrwhFwRdeg
         nS58D86MGBXpZjajwn6CaBT+fVeZPYqkfsgwctKHUPQDoRJd75XAgxLpuGoO4fXI7B39
         q7ZXuGxUa1hLgcdhS0nYTysal14THY4mJtaJBKlOlS0Dg1+O8TnznIKyobvv4hk3M1OW
         EevQ==
X-Gm-Message-State: ANoB5pljt6Uvqx/DGS+SyXLVM3JU/fjadLxY/bPw3Zd7fA/ccV5n5yVe
        o+56g0EhSlWcSBi7/0GT1U3MGXMb98JxyA==
X-Google-Smtp-Source: AA0mqf6fBAwvGqt56oKbe3Lz4ohnPt2TdWkor/DN4WZjNpawqRlRfRgXloX01JLyjKy/pv73ajKMQw==
X-Received: by 2002:a05:6214:10c1:b0:4bb:e74a:f640 with SMTP id r1-20020a05621410c100b004bbe74af640mr20131742qvs.36.1668590809921;
        Wed, 16 Nov 2022 01:26:49 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id k1-20020ac81401000000b0035cf31005e2sm8431011qtj.73.2022.11.16.01.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:26:49 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 63so20278654ybq.4;
        Wed, 16 Nov 2022 01:26:48 -0800 (PST)
X-Received: by 2002:a25:844b:0:b0:6de:6c43:3991 with SMTP id
 r11-20020a25844b000000b006de6c433991mr19268568ybm.604.1668590808744; Wed, 16
 Nov 2022 01:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3OgSAnst0qt5WSk@wendy> <CA+V-a8vL5r-xMeCiYRax-dM2Uo0ghgzRiyY99nNn089CjJwoBg@mail.gmail.com>
In-Reply-To: <CA+V-a8vL5r-xMeCiYRax-dM2Uo0ghgzRiyY99nNn089CjJwoBg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Nov 2022 10:26:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXquU632vu37WkewmashjSxV8f8J6WGawAD4uL3B=6pHA@mail.gmail.com>
Message-ID: <CAMuHMdXquU632vu37WkewmashjSxV8f8J6WGawAD4uL3B=6pHA@mail.gmail.com>
Subject: Re: [PATCH 0/3] RZ/Five: Enable ADC/CANFD/I2C/OPP/Thermal Zones/TSU
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 7:23 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Nov 15, 2022 at 2:21 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> > On Tue, Nov 15, 2022 at 10:51:32AM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Hi All,
> > >
> > > This patch series aims to enable support for below blocks
> > > on RZ/Five SoC/SMARC EVK:
> > > - ADC
> > > - CANFD
> > > - I2C
> > > - OPP
> > > - Thermal Zones
> > > - TSU
> > >
> > > Note, patches apply on top of [0].
> > >
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-riscv-dt-for-v6.2
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > Lad Prabhakar (3):
> > >   riscv: Kconfig: Enable cpufreq kconfig menu
> > >   riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
> > >     ADC/OPP/Thermal Zones/TSU
> > >   riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
> >
> > I know ~nothing about your SoC so idk if the values are correct, but I
> > did give it a go earlier to see if it did anything warning wise. Seeing
> > that it didn't cause any I am curious - how come these didn't land in
> > the original dts? Just waiting for driver stuff to land to support it?
> >
> I wanted bare minimal stuff in the initial patchset.
>
> > Anyway, no new warnings which is what I care about - I suppose that
> > makes it an acked-by?
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Can include that tag if you like. Either way, nice to see some of the
> > /delete-node/s etc being removed.
> >
> Thanks, Geert should pick the tag while picking the DTS/I patches.
>
> For the Kconfig patch it needs to go via the RISCV tree or can that be
> picked by Geert too with the rest of the other patches?

IMHO the Kconfig patch (or Conor's earlier version) should go through
the RISCV tree, as there is no hard dependency.

Yes, I can take it with an Acked-by, if all else fails, but the soc deadline
is near.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
