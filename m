Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEFB6FC640
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjEIM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjEIM0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:26:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3654201;
        Tue,  9 May 2023 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683635150; x=1715171150;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=upRdd3SMsO3dE9kZLhoq1cDgJaHqitqd/ygcALdoe24=;
  b=hDWpXuFP3GIewLqwVmTr4CzVkohhHbGsObijiW9N3+3kU4s2MRJbqN4E
   WRvpcv8Y/BXxXZemD2Ni7dS7YcODRf1D7XK9+/I+o+3ym8GVZ3j6dvHbF
   L5qJteul69CzNeonPZjYj+nivq1J5lIo1BM+m0R23B/O+2uwhe4hXxsE4
   BCBcEm1vaN1BBDM6uPSt/fYCbyCrZKyB2yQayuphDDq7tD2V616mP3aLE
   N5UJlWamnxa/KWJjyreP+57Waba2TgBXgA9ZNtaGVxejyRCT5lX+vzY2M
   vULgKFmNWhQUVxuBjOG7kTMQS/wDB6RAmbh4KNM3fThXInbx1K5t20YnQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="352973445"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="352973445"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788505129"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="788505129"
Received: from mbrdon-mobl.ger.corp.intel.com ([10.251.219.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 05:25:44 -0700
Date:   Tue, 9 May 2023 15:25:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Jacky Huang <ychuang570808@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v10 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
In-Reply-To: <eeeaf258-8f2b-436a-aba0-b32dc90b359f@app.fastmail.com>
Message-ID: <b9573562-d4d7-3535-fb4d-f2bc694f2a4@linux.intel.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com> <20230508025936.36776-11-ychuang570808@gmail.com> <2ba483e9-267f-2159-1ea8-75a2618fcdf9@linux.intel.com> <eeeaf258-8f2b-436a-aba0-b32dc90b359f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1414178471-1683634754=:2036"
Content-ID: <9bb37169-6cc8-9ecf-9c75-4d17151c32d@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1414178471-1683634754=:2036
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ba1258be-c4c9-856b-c814-9cd42d1740c8@linux.intel.com>

On Tue, 9 May 2023, Arnd Bergmann wrote:

> On Tue, May 9, 2023, at 12:17, Ilpo Järvinen wrote:
> > On Mon, 8 May 2023, Jacky Huang wrote:
> >> +
> >> +#define UART_NR			17
> >> +
> >> +#define UART_REG_RBR		0x00
> >> +#define UART_REG_THR		0x00
> >> +#define UART_REG_IER		0x04
> >> +#define UART_REG_FCR		0x08
> >> +#define UART_REG_LCR		0x0C
> >> +#define UART_REG_MCR		0x10
> >
> > These duplicate include/uapi/linux/serial_reg.h ones, use the std ones 
> > directly.
> >
> > Setup regshift too and use it in serial_in.
> 
> I think this came up in previous reviews, but it turned out that
> only the first six registers are compatible, while the later
> ones are all different, and it's not 8250 compatible.

So use the normal name for compatible ones and HW specific names for the 
others?

It might not be compatible in everything but surely 8250 influence is 
visible here and there.

> It might be helpful to rename the registers to something
> with a prefix other than UART_REG_*, to avoid the confusion
> and possible namespace clash.

That is what I also suggested for the rest of the registers.

-- 
 i.

> >> +/* UART_REG_IER - Interrupt Enable Register */
> >> +#define IER_RDA_IEN		BIT(0)  /* RBR Available Interrupt Enable */
> >> +#define IER_THRE_IEN		BIT(1)  /* THR Empty Interrupt Enable */
> >> +#define IER_RLS_IEN		BIT(2)  /* RX Line Status Interrupt Enable */
> >
> > These look same as UART_IER bits, use the std ones.
> ...
> > Are these same as UART_FCR_CLEAR_* functionality wise? If they're use std 
> > ones.
> 
> Again, I'd think we're better off having a distinct naming for
> them than trying to share the definitions with 8250.
> 
> >> +static struct uart_driver ma35d1serial_reg = {
> >> +	.owner        = THIS_MODULE,
> >> +	.driver_name  = "serial",
> >> +	.dev_name     = "ttyS",
> >> +	.major        = TTY_MAJOR,
> >> +	.minor        = 64,
> >> +	.cons         = MA35D1SERIAL_CONSOLE,
> >> +	.nr           = UART_NR,
> >> +};
> >
> > This doesn't seem necessary, 8250 core will have the uart_driver for you
> > and most of the console stuff too. You just need to setup a few things 
> > correctly (see the setup functions in 8250_early for ideas/examples).
> >...
> >> +
> >> +	ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
> >
> > For 8250, you should be using serial8250_register_8250_port(). See the 
> > other drivers how to setup the console functions.
> 
> Consequently, this should also be kept separate from the serial8250
> driver, I don't see a way to fit the nuvoton code into the existing
> driver without making the resulting driver worse for everyone.
> 
> There is one thing that absolutely needs to be changed though:
> the driver_name/dev_name/major/minor fields all clash with the
> 8250 driver, so you cannot have a kernel that has both drivers
> built-in. All of these should change to get out of the way of the
> existing drivers.
> 
>         Arnd
> 
--8323329-1414178471-1683634754=:2036--
