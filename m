Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598A4646BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiLHJMu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 04:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiLHJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:12:13 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DC1BE9E;
        Thu,  8 Dec 2022 01:12:12 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id fu10so614443qtb.0;
        Thu, 08 Dec 2022 01:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpQvrAB2oc4zmgpT3/OeCT7uadErbvigMwWG7EBC7G8=;
        b=0wHCLLnTABo76zTkxFeCetyaiphjJPnwO8D/9e3DipOAMKFOiliLt4wY/bozTCG0r5
         55LB38EWtkh+PBifeMIO5dMyMVD/lwlhgc52xqh3KW5GO3ZXTfl9uuHnxEBkhpWjTP0H
         DWu7hkpTXsoEwE810VHPLldMB+ThMOEoVlT0fV7l4vC8rbsI+g563V9/JwFNusfEUocn
         Yup3s6z68BEREYBe9y6kuN574WzyfJ0VAPeE7StvMl8cDpvaOXwGWP+oe6ajlLhcsnWZ
         WvyD1rcfwS5ErjzmGlDYDvPmpNOB/j4JSeaKo/WpzhXwS1uR1X2zwC3r7EvA95EIFPas
         1Vig==
X-Gm-Message-State: ANoB5pkEh2DBBtmH2ze3TMZzabrUaYzW0lN2wB0BUxcHe0/Yt2a3AJUT
        UhDQfwMF4R3Xfw2lRANks24lglXRDsBl4Q==
X-Google-Smtp-Source: AA0mqf7Qw/7WqYxXiNrVVnUREv8KOdKFjPWk/62yJ00e2mU6rzzZ43wrSsrCuoC8a7hr4XLPRniuew==
X-Received: by 2002:ac8:51cc:0:b0:3a6:9de4:b60e with SMTP id d12-20020ac851cc000000b003a69de4b60emr21129626qtn.391.1670490731394;
        Thu, 08 Dec 2022 01:12:11 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006fc5a1d9cd4sm18862280qko.34.2022.12.08.01.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:12:11 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id s11so914665ybe.2;
        Thu, 08 Dec 2022 01:12:10 -0800 (PST)
X-Received: by 2002:a25:d655:0:b0:6fc:1c96:c9fe with SMTP id
 n82-20020a25d655000000b006fc1c96c9femr29925093ybg.36.1670490730512; Thu, 08
 Dec 2022 01:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
 <CAL_JsqJiZU=sHVPc92nDNoqUjm7FUb=u0izGYa+irkUW1XmA_w@mail.gmail.com> <20221208092439.6170cf5e@bootlin.com>
In-Reply-To: <20221208092439.6170cf5e@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Dec 2022 10:11:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4YMmAtZE6XRgaLpqeq1Q6RPX4gE6og3QfY9T9Arw=6A@mail.gmail.com>
Message-ID: <CAMuHMdU4YMmAtZE6XRgaLpqeq1Q6RPX4gE6og3QfY9T9Arw=6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add the Renesas USBF controller support
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Thu, Dec 8, 2022 at 9:24 AM Herve Codina <herve.codina@bootlin.com> wrote:
> On Wed, 7 Dec 2022 16:19:42 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
> > On Wed, Dec 7, 2022 at 10:24 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > > This series add support for the Renesas USBF controller (USB Device
> > > Controller) available in the Renesas RZ/N1 SoC.
> > >
> > > Based on previous review:
> > >   https://lore.kernel.org/all/20221114111513.1436165-3-herve.codina@bootlin.com/
> > >
> > > A new strategy is proposed to handle the H2MODE bit from CFG_USB
> > > register compared to the previous versions on the series. As a
> > > reminder, H2MODE bit allows to configure the internal USB Port
> > > interface for two hosts or one host and one device.
> >
> > Is this case any different from all the phandle properties we have in
> > bindings that point to some misc registers somewhere else you need to
> > poke? If so, I'm not really a fan of duplicating the information.
>
> Our case is that there is a bit in a register that affect several
> devices. This bit must be set before the devices are started.
> If this bit is changed while affected devices are running, system
> hangs can occurs (datasheet).
>
> So, in order to do that we need the device in charge to set
> this bit (sysctrl) to set this bit before other devices (USBF
> and PCI bridge) were started.
>
> At sysctrl level, the bit is set during the probe() call.
> The property 'depends-on' aim is to ensure the probe() calls
> order between provider (sysctrl) and consumers (USBF and PCI
> bridge).

This order is already guaranteed (twice), through the clocks and
power-domains properties in the USB host and device nodes,
all pointing to sysctrl.

So IMHO none of this is needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
