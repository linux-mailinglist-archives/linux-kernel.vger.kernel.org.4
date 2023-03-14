Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467B96B9686
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCNNlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCNNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:40:44 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE5933CE22;
        Tue, 14 Mar 2023 06:38:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D033D80C1;
        Tue, 14 Mar 2023 13:38:11 +0000 (UTC)
Date:   Tue, 14 Mar 2023 15:38:10 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230314133810.GM7501@atomide.com>
References: <20230314073603.42279-1-tony@atomide.com>
 <ZBB1h12WHIGo4NX8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBB1h12WHIGo4NX8@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230314 13:25]:
> On Tue, Mar 14, 2023 at 09:35:59AM +0200, Tony Lindgren wrote:
> > +	/* Increment the runtime PM usage count for the active check below */
> > +	err = pm_runtime_get(port_dev);
> 
> The question here is why don't we need to actually turn on the device immediately
> (sync) if it's not already powered?

Doing it would require the use of pm_runtime_irq_safe() at least currently.

> > +	if (err < 0) {
> > +		pm_runtime_put_noidle(port_dev);
> > +		return;
> > +	}
> 
> > +	/*
> > +	 * Start TX if enabled, and kick runtime PM. Otherwise we must
> > +	 * wait for a retry. See also serial_port.c for runtime PM
> > +	 * autosuspend timeout.
> > +	 */
> 
> I.o.w. does the start_tx() require device to be powered on at this point?

Yes. And if the device is not enabled, serial_port.c runtime_resume()
calls this function again after the hardware is enabled.

> > +	if (pm_runtime_active(port_dev))
> >  		port->ops->start_tx(port);
> > +	pm_runtime_mark_last_busy(port_dev);
> > +	pm_runtime_put_autosuspend(port_dev);

For your other comments, I'll take a look thanks.

Tony
