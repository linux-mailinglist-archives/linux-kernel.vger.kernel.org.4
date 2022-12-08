Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E5647776
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLHUou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:44:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01701AF33;
        Thu,  8 Dec 2022 12:44:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61DB8B825E5;
        Thu,  8 Dec 2022 20:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE2C43398;
        Thu,  8 Dec 2022 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670532284;
        bh=Op3UYf+6olBgWrruca2+4Cw44tWd/dJqwafFuHi8BuQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TzZk98Sm7iHP5ggszXg7OSQVOGQWmechaPq8sdWf6iN8A8VkpGD4NQDM06bssaYaN
         lgWc9vcIcmS6g+dsTZ/1ykRw3u6RG+Fg9/2sFyQhj2ilkoUszIPR7GUwMfYbHGofAm
         j17lqnYNJok5WR1ys0ih3OZlds6Dy28ib/oZubk70FfQWd02vSqrFQlxmcl1MIdJZj
         GmiUrnYKWGJjellgBWsKNJpZltUqi4nlu09jAQVueDNlfoaGhzcRIaeZ+lV6LMtmBW
         hajdN19eK7yyFNHS/V16wBGnRt3VSGa+q5PONKJViCXbo20GWmxcEv2RwLEgNoNAZz
         9qoWk3T7xXZ/g==
Received: by mail-ua1-f50.google.com with SMTP id m5so772987uah.3;
        Thu, 08 Dec 2022 12:44:44 -0800 (PST)
X-Gm-Message-State: ANoB5pk3s4dy/5FRocmvte06X+ULIi0ycfzRFK6pffIsoS3/8pGfZNbS
        ozDYP1ODQo/dWFNkHQrh1Agqy6zvL07c01jr2w==
X-Google-Smtp-Source: AA0mqf4ma8F1BT0uBQEYiHxBjiJL0Ol47jNJrTLDn/AAI8VlbTaGwaiuMSNkRkY2hh2jshSQyk61IDhlm1kZOsxD1n0=
X-Received: by 2002:a9f:22c7:0:b0:3d6:45ee:7efc with SMTP id
 65-20020a9f22c7000000b003d645ee7efcmr44640221uan.86.1670532282914; Thu, 08
 Dec 2022 12:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
 <CAL_JsqJiZU=sHVPc92nDNoqUjm7FUb=u0izGYa+irkUW1XmA_w@mail.gmail.com> <20221208092439.6170cf5e@bootlin.com>
In-Reply-To: <20221208092439.6170cf5e@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Dec 2022 14:44:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLjD=DbKJRrmn2GmbAwmVyE=gVcz-fZfNJ_xAup6GReSA@mail.gmail.com>
Message-ID: <CAL_JsqLjD=DbKJRrmn2GmbAwmVyE=gVcz-fZfNJ_xAup6GReSA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add the Renesas USBF controller support
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 2:24 AM Herve Codina <herve.codina@bootlin.com> wrote:
>
> Hi Rob,
>
> On Wed, 7 Dec 2022 16:19:42 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
>
> > On Wed, Dec 7, 2022 at 10:24 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > >
> > > Hi,
> > >
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

That sounds like you just need some platform level initialization and
you are working around the desire to not have platform level
initialization.

Why doesn't/can't the bootloader initialize this? Seems like it might
want to use PCI or USB too.

> At sysctrl level, the bit is set during the probe() call.
> The property 'depends-on' aim is to ensure the probe() calls
> order between provider (sysctrl) and consumers (USBF and PCI
> bridge).
>
> regmap and syscon are used to export registers from one device
> to an other and the probe() calls order is not ensured by the
> core or regmap infrastructure. Indeed, the regmap provider
> probe() will not be called if the regmap provider was not probed
> before the consumer ask for the regmap.
>   https://elixir.bootlin.com/linux/latest/source/drivers/mfd/syscon.c#L152
>   https://elixir.bootlin.com/linux/latest/source/drivers/mfd/syscon.c#L43
> No specific action synchronisation are done with regmap/syscon
> other than the regmap creation itself.

Oh right. That's in place of course to avoid probe ordering issues...

> I don't think the regmap/syscon will help in our case.
>
> >
> > We also have cases of of_find_compatible_node(NULL, NULL,
> > "foo-bar-syscon") which is a dependency expressed in the driver, but
> > not DT. In either case, adding 'depends-on' would be an ABI break as
> > you are requiring a DT change.
>
> In order to avoid the DT change, I can keep the 'depends-on'
> optional in the PCI bridge binding.
> This will be functionnal as sysctrl is already used in this node
> (power-domain = <&sysctrl>). The relationship is already present
> with this power-domain link.
>
> If ok, I will do this change in v4 series.

I agree with Geert that this shouldn't be needed.

Rob
