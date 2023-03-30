Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92F16D0633
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjC3NOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjC3NOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CE3AD31;
        Thu, 30 Mar 2023 06:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00AF662071;
        Thu, 30 Mar 2023 13:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD20C433D2;
        Thu, 30 Mar 2023 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680182042;
        bh=KS4LCNe9lQlce8Dp6zV/p0jgbUK0QS/1mjfSUOf8RBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xIYWpBhUmazj7wxv8o64t2zb3BZly6D92vtLeDbjvXe7Bf5Gl51PbVmP1UxRQSfmG
         /cEToTozlmY87a1ixKF9FtsmQdvNZcbkQUxHYVXsscjFGApYGxMS0Ixwc+Mv5oKpjI
         JktmegATsl1EN85wVXOSOZXPlYULCges5fhVq7kE=
Date:   Thu, 30 Mar 2023 15:14:00 +0200
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
Message-ID: <ZCWLGLNxj-02ALA1@kroah.com>
References: <20230323071051.2184-1-tony@atomide.com>
 <ZCQAF-nrrsfBtviT@kroah.com>
 <20230330113231.GR7501@atomide.com>
 <ZCWF_Envuh3Qnaxm@kroah.com>
 <20230330125931.GT7501@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330125931.GT7501@atomide.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:59:31PM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230330 12:52]:
> > On Thu, Mar 30, 2023 at 02:32:31PM +0300, Tony Lindgren wrote:
> > > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230329 09:08]:
> > > > On Thu, Mar 23, 2023 at 09:10:47AM +0200, Tony Lindgren wrote:
> > > > > --- /dev/null
> > > > > +++ b/drivers/tty/serial/serial_base.c
> > > > > @@ -0,0 +1,142 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > 
> > > > Given that the driver core is "GPL-2.0-only", why is this -or-later?
> > > 
> > > Thanks for noticing, the intention was to set it to what serial_core.c has:
> > > 
> > > $ git grep -e SPDX -e MODULE_LICENSE drivers/tty/serial/serial_core.c
> > > drivers/tty/serial/serial_core.c:// SPDX-License-Identifier: GPL-2.0+
> > > drivers/tty/serial/serial_core.c:MODULE_LICENSE("GPL");
> > 
> > Doesn't mean you have to copy it, it's your choice :)
> 
> In this case my preference is to use the same as for serial_core.c. This is
> so folks can start moving serial port specific functions from serial_core.c
> to serial_port.c. And not have to worry about the possible differences with
> various licenses at that point :)

That's great, no objection from me, sorry, but I had to ask, the "no
fun" part of my job...

greg k-h
