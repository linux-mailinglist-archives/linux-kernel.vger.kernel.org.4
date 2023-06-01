Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076CC71A2F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjFAPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjFAPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA4136;
        Thu,  1 Jun 2023 08:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2793E646D1;
        Thu,  1 Jun 2023 15:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C8C4339B;
        Thu,  1 Jun 2023 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685634276;
        bh=DqnmHsGETvKUOxciKJwJgUxc/bfquKkln00h6FokanM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htB3jkipoBCacSu4F2LqM/7ySFNoqm+YAEJtNT1zH1sMPGEgILC4KRF+WDfSmOfzA
         ACw7rcP5ysXsvHn8nHLQhGRlIBZaXOk3PA8JLXtzJPAahDL82jmlgwZ13bKGDAFJ0K
         1AhRxiMDLHYmru3eo4CKuK0aQLIe7hcjtvOOO1ds=
Date:   Thu, 1 Jun 2023 16:44:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix probing serial_base_bus devices
Message-ID: <2023060123-shelf-bagging-4463@gregkh>
References: <20230601141445.11321-1-tony@atomide.com>
 <CGME20230601142147eucas1p1ae331f80a07ad6280f8f759b2d03ade7@eucas1p1.samsung.com>
 <2023060112-onion-disparate-8ce8@gregkh>
 <d7c857b8-4aa1-cd5d-4c45-392f7ed6857b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c857b8-4aa1-cd5d-4c45-392f7ed6857b@samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:09:52PM +0200, Marek Szyprowski wrote:
> On 01.06.2023 16:21, Greg Kroah-Hartman wrote:
> > On Thu, Jun 01, 2023 at 05:14:44PM +0300, Tony Lindgren wrote:
> >> If a physical serial port device driver uses arch_initcall() we fail to
> >> probe the serial_base_bus devices and the serial port tx fails. This is
> >> because as serial_base_bus uses module_initcall().
> >>
> >> Let's fix the issue by changing serial_base_bus to use arch_initcall().
> > This will only work if the linking order is such that this will always
> > come before the drivers.  Is that the case here?
> 
> Yes, serial_base_bus is linked as a second object, just after the 
> serial_core. Device drivers come later.

Oh good, I guess it wouldn't work at all as the serial_core is needed by
all of those drivers first too, so this should work, thanks for
checking.

greg k-h
