Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7868D0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBGHtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:49:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A66812847;
        Mon,  6 Feb 2023 23:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675756152; x=1707292152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vluZuFSkGXbu6xfPDdmoiFX4n+Szt9NgbKjeRxh+kfk=;
  b=XwMcx2mddJaVaITik9PyeUnKaP1foPfjIVN6urInPlkLNgulGgCVgI8j
   VKUdozVy7GWWuuBBN082yEGw6Dxyo7M7MKZm7kkyO74dnb/ItidTvUmGP
   vsjLNKxJYOaV2XXHcd557f3Ulq5MMVRqWP8qxdNYCQ9UyerjY9F0U8k9D
   23sU/59mheqL2qvhO2jgrtwDuo5+YcjxgCDoEpACD7Dh/a3yRVH8mOvui
   hqSTbcW4hUIlxwic5hFeqVrNKDlsT1OszK/lTXmV70JiJ8BAg0Dd0rb08
   y+nxDeiqIURpWHJeGm5eM/BgdtsEzkI4uxuKckFG1LywfkF92O0Y1g4eh
   w==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="195693381"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2023 00:49:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 00:48:57 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Feb 2023 00:48:56 -0700
Date:   Tue, 7 Feb 2023 08:48:56 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix alt mode for ocelot
Message-ID: <20230207074856.2akoi4v65cbolinb@soft-dev3-1>
References: <20230206203720.1177718-1-horatiu.vultur@microchip.com>
 <CAHp75VcVn2=Xy7P4xgiDKkpOkw+YD1zGwMYARpWV6Eiv0fUakw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VcVn2=Xy7P4xgiDKkpOkw+YD1zGwMYARpWV6Eiv0fUakw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 02/06/2023 22:59, Andy Shevchenko wrote:

Hi Andy,

> 
> On Mon, Feb 6, 2023 at 10:37 PM Horatiu Vultur
> <horatiu.vultur@microchip.com> wrote:
> >
> > In case the driver was trying to set an alternate mode for gpio
> > 0 or 32 then the mode was not set correctly. The reason is that
> > there is computation error inside the function ocelot_pinmux_set_mux
> > because in this case it was trying to shift to left by -1.
> > Fix this by actually shifting the function bits and not the position.
> >
> > Fixes: 4b36082e2e09 ("pinctrl: ocelot: fix pinmuxing for pins after 31")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ...
> 
> >         regmap_update_bits(info->map, REG_ALT(0, info, pin->pin),
> >                            BIT(p), f << p);
> >         regmap_update_bits(info->map, REG_ALT(1, info, pin->pin),
> > -                          BIT(p), f << (p - 1));
> > +                          BIT(p), (f >> 1) << p);
> 
> I'm not sure I understand how this doesn't break anything that has a
> bit 0 set in f. Is it not a problem?

I don't think it is a problem. This is similar to the implementation of
'lan966x_pinmux_set_mux', the only difference is that
lan966x_pinmux_set_mux has more GPIOs than ocelot.

If we take an example where f equals 0x1 and p equals 0.
REG_ALT(0): BIT(0) & (0x1 << 0) equals 0x1
REG_ALT(1): BIT(0) & ((0x1 >> 1) << 0)) equals 0x0.

Or am I misunderstood something?

> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
/Horatiu
