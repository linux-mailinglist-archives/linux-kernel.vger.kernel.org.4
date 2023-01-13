Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9F669A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAMOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjAMOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:32:12 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9D165C8;
        Fri, 13 Jan 2023 06:25:59 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id i12so14919390qvs.2;
        Fri, 13 Jan 2023 06:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVCg8ljMsbkxW/FHrWpYOSqcPZvIl1vMULYriuOARbg=;
        b=EhPGO+NrUbscf7KGP4sD6/n3CAI7ABfZDxRgXkdu4cubuOHcPryyiIsQPwy5dgSquO
         b06jroDpqySAqVxe3Wznm5ygyvleEWd96T0z5JPwiWW5azmcBptdoeafbXNUVRhhHH7x
         OukrrLH6Y60aytb4SSTPgAtQ3ww418ikZKNPpmJ6im4nqgEBt3u3lbQTbSJCd3rbh4ME
         GxCpTZ/gSygh41qoRm53Xi5AwZENecCvJgBcC+nk1EUIOPVTqGQvujoyARyU948+3ODz
         lcplJMuBkVkT1+b5ejZERqjukp6lS8VW+kdS5ioGfLMkHmgarQ/+hpOq+/a4bktGRrWD
         pNXg==
X-Gm-Message-State: AFqh2kpEu549nAiwU6Lo5imA3+UCuCyWBm4Q+RndDChCcL7zQ1TyGApx
        WAiAvrFmq5QDXNlpKbQ8Ok4alStMDf7yxQ==
X-Google-Smtp-Source: AMrXdXs8n71OOWUS5lCbaDQ7L7N3KntfmOihbUsqSpVDUOQojZwceJBG7V1D2tC6HfV7Dl8nE+22mA==
X-Received: by 2002:a05:6214:154e:b0:534:6da3:d35e with SMTP id t14-20020a056214154e00b005346da3d35emr7533792qvw.25.1673619957992;
        Fri, 13 Jan 2023 06:25:57 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006faf76e7c9asm12880962qkl.115.2023.01.13.06.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 06:25:57 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-4a263c4ddbaso287119917b3.0;
        Fri, 13 Jan 2023 06:25:57 -0800 (PST)
X-Received: by 2002:a81:91cc:0:b0:48d:1334:6e38 with SMTP id
 i195-20020a8191cc000000b0048d13346e38mr625392ywg.316.1673619956861; Fri, 13
 Jan 2023 06:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com> <CAMuHMdWuE4L6K4ULdVLZKeLwd3xYfzkyBNrf6s7Qc2kf9b-_Cg@mail.gmail.com>
 <CAHCN7xKJRE7mrRgpKiEEgpkH1NLR8uGcc3mr5Khp3sWjxEtbdQ@mail.gmail.com> <CAHCN7xLSgrzxL0W0ue7wi8DBCH-EB574QtS6wsyrVNpHDFiE6Q@mail.gmail.com>
In-Reply-To: <CAHCN7xLSgrzxL0W0ue7wi8DBCH-EB574QtS6wsyrVNpHDFiE6Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Jan 2023 15:25:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2eGVRdOtOtbF1SG8qqe9ZAa4D8dotA77sCoaTw4c-TA@mail.gmail.com>
Message-ID: <CAMuHMdV2eGVRdOtOtbF1SG8qqe9ZAa4D8dotA77sCoaTw4c-TA@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: beacon-renesom: Fix gpio expander reference
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Adam,

On Fri, Jan 13, 2023 at 2:17 PM Adam Ford <aford173@gmail.com> wrote:
> On Wed, Jan 11, 2023 at 11:05 AM Adam Ford <aford173@gmail.com> wrote:
> > On Wed, Jan 11, 2023 at 10:29 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, Jan 4, 2023 at 3:12 PM Adam Ford <aford173@gmail.com> wrote:
> > > > The board used to originally introduce the Beacon Embedded
> > > > RZ/G2[M/N/H] boards had a GPIO expander with address 20, but
> > > > this was change when the final board went to production.
> > > >
> > > > The production boards changed both the part itself and
> > > > the address.  With the incorrect address, the LCD cannot
> > > > come up.  If the LCD fails, the rcar-du driver fails to come up,
> > > > and that also breaks HDMI.
> > > >
> > > > Pre-release board were not shipped to the general public, so it
> > > > should be safe to push this as a fix.  Anyone with a production
> > > > board would have video fail due to this GPIO expander change.
> > > >
> > > > Fixes: a1d8a344f1ca ("arm64: dts: renesas: Introduce r8a774a1-beacon-rzg2m-kit")
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>

> > > > --- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > > > +++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > > > @@ -437,20 +437,6 @@ wm8962_endpoint: endpoint {
> > > >                 };
> > > >         };
> > > >
> > > > -       /* 0 - lcd_reset */
> > > > -       /* 1 - lcd_pwr */
> > > > -       /* 2 - lcd_select */
> > > > -       /* 3 - backlight-enable */
> > > > -       /* 4 - Touch_shdwn */
> > > > -       /* 5 - LCD_H_pol */
> > > > -       /* 6 - lcd_V_pol */
> > > > -       gpio_exp1: gpio@20 {
> > > > -               compatible = "onnn,pca9654";
> > > > -               reg = <0x20>;
> > > > -               gpio-controller;
> > > > -               #gpio-cells = <2>;
> > > > -       };
> > > > -
> > > >         touchscreen@26 {
> > > >                 compatible = "ilitek,ili2117";
> > > >                 reg = <0x26>;
> > > > @@ -482,6 +468,21 @@ hd3ss3220_out_ep: endpoint {
> > > >                         };
> > > >                 };
> > > >         };
> > > > +
> > > > +       gpio_exp1: gpio@70 {
> > > > +               compatible = "onnn,pca9654";
> > >
> > > According to the patch description, the actual part was changed, too?
>
> After a bit of some investigation, the part was changed to
> nxp,pca9538.  It appears to be the same driver and the same ".data"
> structure is used.  This probably explains why I didn't see any issues
> when I was testing this.  Unfortunately, the hardware engineer who
> made this hardware change is not around to ask why the change was
> made.

Yeah, there are lots of compatible parts.

> I'll do a V2 since, I don't see this in renesas-devel.

Correct, I was waiting for clarification.
Looking forward to v2...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
