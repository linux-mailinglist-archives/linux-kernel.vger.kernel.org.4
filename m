Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B113C5B88D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiINNGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiINNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:06:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94183474E0;
        Wed, 14 Sep 2022 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663160807; x=1694696807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0axQ8qJC3iBquWFyEiDgeDMFF0a3+ccpP77u6bRgCM=;
  b=dyNuHRx/vj7qH3PJPhcAzYDNVi5U+8GpBJTG00rBEHVbS2CZR+SHMZA9
   yMpxDrEqfAd3nCBBabW7Xbdvxp0UpKs+VoLyzPIaVZQcsUGtILG/PQV+B
   bLBkmg9KEVgP+4mPjW1q1TXxMZw2Gb8lHRs2PuPP8uuth5cNL/LPXm7mG
   qIOIUS8I6sgjcTqw0wPgp2qxdqb6gexIwIkAdshrOJVp6oqheIs7MyMzu
   0v7GnVHdqARbYOfdnAnk0Gs5TrbpOmjwbxgJI/4rlny9KJsZ/dzXk6lYc
   7TZGuF+cThCy4MXgc1oQKArhyurDwPeXRVPhQu7CriqL5SNobsWN9cL0z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362385383"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="362385383"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:06:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594377659"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 06:06:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oYS6E-002DFA-2H;
        Wed, 14 Sep 2022 16:06:42 +0300
Date:   Wed, 14 Sep 2022 16:06:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <YyHR4o5bOnODZzZ9@smile.fi.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org>
 <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
 <YyG2tDdq9PWTlaBQ@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyG2tDdq9PWTlaBQ@wantstofly.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 02:10:44PM +0300, Lennert Buytenhek wrote:
> On Wed, Sep 14, 2022 at 01:09:40PM +0300, Andy Shevchenko wrote:
> > > On an Intel SoC with several 8250_mid PCIe UARTs built into the CPU, I
> > > can reliably trigger I/O page faults if I invoke TIOCVHANGUP on any of
> > > the UARTs and then re-open that UART.
> > > 
> > > Invoking TIOCVHANGUP appears to clear the MSI address/data registers
> > > in the UART via tty_ioctl() -> tty_vhangup() -> __tty_hangup() ->
> > > uart_hangup() -> uart_shutdown() -> uart_port_shutdown() ->
> > > univ8250_release_irq() -> free_irq() -> irq_domain_deactivate_irq() ->
> > > __irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
> > > __pci_write_msi_msg():
> > > 
> > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > 		Address: fee00278  Data: 0000
> > > [root@icelake ~]# cat hangup.c
> > > #include <stdio.h>
> > > #include <sys/ioctl.h>
> > > 
> > > int main(int argc, char *argv[])
> > > {
> > > 	ioctl(1, TIOCVHANGUP);
> > > 
> > > 	return 0;
> > > }
> > > [root@icelake ~]# gcc -Wall -o hangup hangup.c
> > > [root@icelake ~]# ./hangup > /dev/ttyS4
> > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > 		Address: 00000000  Data: 0000
> > > [root@icelake ~]#
> > > 
> > > Opening the serial port device again while the UART is in this state
> > > then appears to cause the UART to generate an interrupt
> > 
> > The interrupt is ORed three: DMA Tx, DMA Rx and UART itself.
> > Any of them can be possible, but to be sure, can you add:
> > 
> > 	dev_info(p->dev, "FISR: %x\n", fisr);
> > 
> > into dnv_handle_irq() before any other code and see which bits we
> > actually got there before the crash?
> > 
> > (If it floods the logs, dev_info_ratelimited() may help)
> 
> I think that that wouldn't report anything because when the UART is
> triggering an interrupt here, the MSI address/data are zero, so the
> IRQ handler is not actually invoked.

Ah, indeed. Then you may disable MSI (in 8250_mid) and see that anyway?

> If Ilpo doesn't beat me to it, I'll try adding some debug code to see
> exactly which UART register write in the tty open path is causing the
> UART to signal an interrupt before the IRQ handler is set up.
> 
> (The IOMMU stops the write in this case, so the machine doesn't crash,
> we just get an I/O page fault warning in dmesg every time this happens.)

And I believe you are not using that UART as debug console, so it won't
dead lock itself. It's then better than I assumed.

> > > before the
> > > MSI vector has been set up again, causing a DMA write to I/O virtual
> > > address zero:
> > > 
> > > [root@icelake console]# echo > /dev/ttyS4
> > > [  979.463307] DMAR: DRHD: handling fault status reg 3
> > > [  979.469409] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> > > 
> > > I'm guessing there's something under tty_open() -> uart_open() ->
> > > tty_port_open() -> uart_port_activate() -> uart_port_startup() ->
> > > serial8250_do_startup() that triggers a UART interrupt before the
> > > MSI vector has been set up again.
> > > 
> > > I did a quick search but it didn't seem like this is a known issue.
> > 
> > Thanks for your report and reproducer! Yes, I also never heard about
> > such an issue before. Ilpo, who is doing more UART work nowadays, might
> > have an idea, I hope.
> 
> Thank you!

-- 
With Best Regards,
Andy Shevchenko


