Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678CD5B3606
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIILGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIILGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:06:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF34D21CA;
        Fri,  9 Sep 2022 04:06:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1395B824F0;
        Fri,  9 Sep 2022 11:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFB4C433C1;
        Fri,  9 Sep 2022 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662721568;
        bh=3NEzg2EVTYL6D0L+bzYSw8gVTESohGyL9ED7X39zx8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HU5k6uR8qPVfMuxjpDGRdI+N9D1yMcepeX2HGegy4PMObnPCDRR8K5GtT7OuQmMAs
         vXwFDf3X12zECHtFKyXBvTi9vyydPUy0yn5eZNJhWXeZSzKGqpZd5lUfzZBY8q4+kL
         XzO/DAiVs1Vpku7HoApKQqDZ6NEUe1+9QqfgoffM=
Date:   Fri, 9 Sep 2022 13:06:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Message-ID: <YxseGPHVkSVdDnrh@kroah.com>
References: <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
 <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
 <715b40ba-1bcc-4582-bed1-ef41126c7b94@www.fastmail.com>
 <cfd16d53-6aa0-e848-91d0-dce8ff72bb4d@linux.intel.com>
 <YxiONiDgGYp8MGQA@kroah.com>
 <c66f9c98-dcef-27c-d74a-ea826f6a799@linux.intel.com>
 <YxiQVTN/jX8AfO4L@kroah.com>
 <YxiiOWQxGCUz9ktF@shell.armlinux.org.uk>
 <2197faa3-0217-41e0-8ff0-b5396561c623@www.fastmail.com>
 <5feff23c-9458-616c-66ce-13cca5829162@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5feff23c-9458-616c-66ce-13cca5829162@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:53:04PM +0200, Jiri Slaby wrote:
> On 07. 09. 22, 16:56, Arnd Bergmann wrote:
> > On Wed, Sep 7, 2022, at 3:52 PM, Russell King (Oracle) wrote:
> > > On Wed, Sep 07, 2022 at 02:36:37PM +0200, Greg Kroah-Hartman wrote:
> > > 
> > > Of course, it would have been nicer to see the definition of this
> > > macro, because then we can understand what the "ch" argument is to
> > > this macro, and how that relates to the macro argument that is
> > > shown in the example as a writel().
> > 
> > I pulled out the 'ch' variable from the macro to avoid having
> > the macro define local variables that are then passed to the
> > inner expressions.
> 
> Note that I had "port" and "ch" as a part of the macro parameters in [v2],
> but it didn't help the situation much.
> > > Maybe a more complete example would help clear up the confusion?
> > > Arnd?
> > 
> > Here is a patch on top of the series that would implement the
> > uart_port_tx_helper_limited() and uart_port_tx_helper()
> > macros that can be used directly from drivers in place of defining
> > local functions, with the (alphabetically) first two drivers
> > converted to that.
> 
> If there are no objections, I will push the patches this directorin. I like
> this more than [v2] or [v3] (the helper macros). Actually, I mentioned this
> wait_event() style in [v1], but I perhaps simplified the concept too much to
> completely eliminate the need of a wrapper function. And that made it too
> complicated/too hard to understand.
> 
> Except I'd drop the "_helper" part from the name. Originally (in [v1]), I
> had uart_port_tx() and uart_port_tx_limited() functions. In [v2+v3], I added
> _helper to avoid confusion as we were generating a helpers using the macros.
> Yes, technically, uart_port_tx() is still a helper, but I think it's
> superfluous to have it in the name now.

No objection from me, thanks for doing this work!

greg k-h
