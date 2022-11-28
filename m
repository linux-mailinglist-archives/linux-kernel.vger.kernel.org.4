Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA663A17A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiK1GpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiK1GpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:45:12 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83F0E60DF;
        Sun, 27 Nov 2022 22:45:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7D82280C1;
        Mon, 28 Nov 2022 06:45:10 +0000 (UTC)
Date:   Mon, 28 Nov 2022 08:45:09 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <Y4RY9XxkK6hHEur4@atomide.com>
References: <20221123082825.32820-1-tony@atomide.com>
 <e6922dd6-8968-b54-afbc-d5ad969f64@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6922dd6-8968-b54-afbc-d5ad969f64@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221125 14:02]:
> On Wed, 23 Nov 2022, Tony Lindgren wrote:
> > +	/*
> > +	 * Keep the port device enabled unless autosuspend is supported.
> > +	 * Released on port shutdown.
> > +	 */
> > +	if (!controller->supports_autosuspend) {
> > +		ret = pm_runtime_resume_and_get(dev);
> 
> Should this be done regardless of autosuspend if the port is console?

Well hopefully no need to check anything here for the console unless
enabled state needs to be inherited from the early console.

Note that with what Jiri is proposing, we can just unconditionally do the
pm_runtime_resume_and_get() here on the generic serial port controller
struct device. We can also leave out the tinkering of the serial port
hardware struct device.

The hardware serial port controller drivers that do support autosuspend
can just decrement the runtime PM usage count for the generic serial port
controller child device as needed to enable aggressive PM.

> There's a problem in the current place where this being called from 
> though, uart_console_enabled() doesn't return the correct value with at 
> least some devices this early:
> 
> https://lore.kernel.org/linux-serial/AS8PR04MB84047F39CD10C00CEE29213F92219@AS8PR04MB8404.eurprd04.prod.outlook.com/

OK. Seems the issues with the boot console and early serial port struct
device or whatever might be missing are there even without runtime PM.

Regards,

Tony
