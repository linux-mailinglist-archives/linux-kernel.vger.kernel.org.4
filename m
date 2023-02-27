Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218BC6A4C51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjB0UiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB0UiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:38:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DCBB8D;
        Mon, 27 Feb 2023 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677530290; x=1709066290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e0rEma/8NxRjcJ/XXGqWUkv2FRQzidKFGmIOSWLjrtQ=;
  b=xeJV5G+Udr3mNcWjmhMhaKEYhEWNjmxxaeSCUCa4TdA2xSYPYGbI/iHL
   Up2yASdpMpPWDhdl8YZk06kDcN6WA6QP3fZxcsloipNVPOqKf4RSjxD0B
   IF19I9hIHONSXlEqF93rd9PeXuPynj1JtH7FxN8Ekjso1Y4dxzTxSuEue
   pd2OSc7BG9L18ytsk0Q/J2N0b/fiR7RCHd7vdp6WB+bdpMX7mVhYnm7sJ
   RpbtuFYqT1LdrRovf6nPweiThOoLGUgOJjpJ8hQWXVfKMPyBxI/E+IjoJ
   bq4TEiiUD8gkVK7Q8ob8yfoWPYHQuMP+ejoUTblFQZgrUwEepmC3GA1Xw
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673938800"; 
   d="scan'208";a="213892655"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 13:38:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 13:38:09 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Mon, 27 Feb 2023 13:38:09 -0700
Date:   Mon, 27 Feb 2023 21:38:08 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix alt mode for ocelot
Message-ID: <20230227203808.eqa5xmmldnx4lhop@soft-dev3-1>
References: <20230206203720.1177718-1-horatiu.vultur@microchip.com>
 <CAHp75VcVn2=Xy7P4xgiDKkpOkw+YD1zGwMYARpWV6Eiv0fUakw@mail.gmail.com>
 <20230207074856.2akoi4v65cbolinb@soft-dev3-1>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230207074856.2akoi4v65cbolinb@soft-dev3-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 02/07/2023 08:48, Horatiu Vultur wrote:
> The 02/06/2023 22:59, Andy Shevchenko wrote:

Hi,

Just a gentle ping about this patch.

I don't see anything that I should do, please let me know otherwise.
Thanks.

> 
> Hi Andy,
> 
> > 
> > On Mon, Feb 6, 2023 at 10:37 PM Horatiu Vultur
> > <horatiu.vultur@microchip.com> wrote:
> > >
> > > In case the driver was trying to set an alternate mode for gpio
> > > 0 or 32 then the mode was not set correctly. The reason is that
> > > there is computation error inside the function ocelot_pinmux_set_mux
> > > because in this case it was trying to shift to left by -1.
> > > Fix this by actually shifting the function bits and not the position.
> > >
> > > Fixes: 4b36082e2e09 ("pinctrl: ocelot: fix pinmuxing for pins after 31")
> > > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > 
> > ...
> > 
> > >         regmap_update_bits(info->map, REG_ALT(0, info, pin->pin),
> > >                            BIT(p), f << p);
> > >         regmap_update_bits(info->map, REG_ALT(1, info, pin->pin),
> > > -                          BIT(p), f << (p - 1));
> > > +                          BIT(p), (f >> 1) << p);
> > 
> > I'm not sure I understand how this doesn't break anything that has a
> > bit 0 set in f. Is it not a problem?
> 
> I don't think it is a problem. This is similar to the implementation of
> 'lan966x_pinmux_set_mux', the only difference is that
> lan966x_pinmux_set_mux has more GPIOs than ocelot.
> 
> If we take an example where f equals 0x1 and p equals 0.
> REG_ALT(0): BIT(0) & (0x1 << 0) equals 0x1
> REG_ALT(1): BIT(0) & ((0x1 >> 1) << 0)) equals 0x0.
> 
> Or am I misunderstood something?
> 
> > 
> > --
> > With Best Regards,
> > Andy Shevchenko
> 
> -- 
> /Horatiu

-- 
/Horatiu
