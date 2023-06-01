Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF671A2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjFAPpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjFAPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435C1B1;
        Thu,  1 Jun 2023 08:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB596646DA;
        Thu,  1 Jun 2023 15:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF67FC4339C;
        Thu,  1 Jun 2023 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685634316;
        bh=gjO1MCUCeIzEOnaU6zEAMUbqNxHQQE+ZMiTvcgTF7Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wY4BUtRNsJTSA4kH+jay3APwtzy4GXwATc4zev1EVNVanv+Sjq495beoT8MiBJdcU
         qPAllT0XuSrAELA3ldYNGAD5uUYwdtFiqh8S9XXOuHc7ly/hvWQ7I/5GuFWgq1iER8
         cku0tHFBeVVt6O8uj2/cQeK7JRMGAyVltGKGnPIY=
Date:   Thu, 1 Jun 2023 16:45:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix probing serial_base_bus devices
Message-ID: <2023060137-nuzzle-cadet-6fd4@gregkh>
References: <20230601141445.11321-1-tony@atomide.com>
 <2023060112-onion-disparate-8ce8@gregkh>
 <20230601150706.GD14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601150706.GD14287@atomide.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:07:06PM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230601 14:21]:
> > On Thu, Jun 01, 2023 at 05:14:44PM +0300, Tony Lindgren wrote:
> > > If a physical serial port device driver uses arch_initcall() we fail to
> > > probe the serial_base_bus devices and the serial port tx fails. This is
> > > because as serial_base_bus uses module_initcall().
> > > 
> > > Let's fix the issue by changing serial_base_bus to use arch_initcall().
> > 
> > This will only work if the linking order is such that this will always
> > come before the drivers.  Is that the case here?
> 
> I guess based on Makefile. And also if serial drivers are modules as we
> export uart_add_one_port() from serial_base.ko. But yeah this is pretty
> fragile potentially.

It's fine, and normal, the Makefile is the ordering here so all is good.

> Hmm maybe we could keep module_init() and then also call serial_base_init()
> on uart_add_one_port() path if not yet initialized?
> 
> Probably the module_init() should be still there for case when no serial
> port device drivers are loaded and serial_base is unloaded..

I'll leave this as-is, it looks correct, and I'll queue it up now,
thanks.

greg k-h
