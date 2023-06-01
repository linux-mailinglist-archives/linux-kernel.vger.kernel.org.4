Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2D71A22B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjFAPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjFAPPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:15:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD00C12C;
        Thu,  1 Jun 2023 08:15:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1142B80F1;
        Thu,  1 Jun 2023 15:07:08 +0000 (UTC)
Date:   Thu, 1 Jun 2023 18:07:06 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix probing serial_base_bus devices
Message-ID: <20230601150706.GD14287@atomide.com>
References: <20230601141445.11321-1-tony@atomide.com>
 <2023060112-onion-disparate-8ce8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023060112-onion-disparate-8ce8@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230601 14:21]:
> On Thu, Jun 01, 2023 at 05:14:44PM +0300, Tony Lindgren wrote:
> > If a physical serial port device driver uses arch_initcall() we fail to
> > probe the serial_base_bus devices and the serial port tx fails. This is
> > because as serial_base_bus uses module_initcall().
> > 
> > Let's fix the issue by changing serial_base_bus to use arch_initcall().
> 
> This will only work if the linking order is such that this will always
> come before the drivers.  Is that the case here?

I guess based on Makefile. And also if serial drivers are modules as we
export uart_add_one_port() from serial_base.ko. But yeah this is pretty
fragile potentially.

Hmm maybe we could keep module_init() and then also call serial_base_init()
on uart_add_one_port() path if not yet initialized?

Probably the module_init() should be still there for case when no serial
port device drivers are loaded and serial_base is unloaded..

Regards,

Tony
