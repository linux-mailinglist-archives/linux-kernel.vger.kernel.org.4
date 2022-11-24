Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D5F63728D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKXGur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiKXGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:50:45 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0456BA659E;
        Wed, 23 Nov 2022 22:50:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EF18380F1;
        Thu, 24 Nov 2022 06:50:42 +0000 (UTC)
Date:   Thu, 24 Nov 2022 08:50:41 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: core: Add port port device to flush TX on
 runtime resume
Message-ID: <Y38UQXbzw54Jo93s@atomide.com>
References: <20221123082825.32820-1-tony@atomide.com>
 <20221123082825.32820-2-tony@atomide.com>
 <Y35oT9/3OKRciWCP@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35oT9/3OKRciWCP@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review again, will fix what you noted. One idea
for an improvment below though.

* Andy Shevchenko <andriy.shevchenko@intel.com> [221123 18:37]:
> On Wed, Nov 23, 2022 at 10:28:25AM +0200, Tony Lindgren wrote:
> > +EXPORT_SYMBOL(serial_port_get);
> 
> Can we move these to namespace from day 1?

Assuming you mean EXPORT_SYMBOL_NS(), sure.

But we might be better off doing the following:

- Move already exported uart_add_one_port() and uart_remove_one_port()
  from serial_core to serial_port as wrapper functions for serial_core

- Export new functions in serial_core for serial_core_register_port()
  and serial_core_unregister_port() for serial_port to call

This would ensure both serial_core and serial_port modules are
always loaded when a hardware specific serial port driver is
loaded.

This should also leave out the need for serial_port_get() and
serial_port_put().

Regards,

Tony

