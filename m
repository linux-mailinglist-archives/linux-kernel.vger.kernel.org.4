Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A646C6D054F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjC3MwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC3MwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D5CA6;
        Thu, 30 Mar 2023 05:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9699B62067;
        Thu, 30 Mar 2023 12:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADA8C433D2;
        Thu, 30 Mar 2023 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680180740;
        bh=wefoDpNYgcLHplZv9DQcoycKi5+6BysKBqZMWUs93Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOryz61/oPm1GWi2ELshR3m0eOKapazc271eNA7l1yAMbClMvM+eI9pQ+GUSFb9p4
         VxxOp97NUwcM/VxrX1msGxxIdLr3oVMUw6N2tJCOpa3np6EDfddc8eGu8E+f5xOzZZ
         GPocO1wIRDOxHEWT3Ez0u/DkwONTAUnGeqnKf2kM=
Date:   Thu, 30 Mar 2023 14:52:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZCWF_Envuh3Qnaxm@kroah.com>
References: <20230323071051.2184-1-tony@atomide.com>
 <ZCQAF-nrrsfBtviT@kroah.com>
 <20230330113231.GR7501@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330113231.GR7501@atomide.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 02:32:31PM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230329 09:08]:
> > On Thu, Mar 23, 2023 at 09:10:47AM +0200, Tony Lindgren wrote:
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/serial_base.c
> > > @@ -0,0 +1,142 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > 
> > Given that the driver core is "GPL-2.0-only", why is this -or-later?
> 
> Thanks for noticing, the intention was to set it to what serial_core.c has:
> 
> $ git grep -e SPDX -e MODULE_LICENSE drivers/tty/serial/serial_core.c
> drivers/tty/serial/serial_core.c:// SPDX-License-Identifier: GPL-2.0+
> drivers/tty/serial/serial_core.c:MODULE_LICENSE("GPL");

Doesn't mean you have to copy it, it's your choice :)

thanks,

greg k-h
