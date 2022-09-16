Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B25BACE9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIPMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIPMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:02:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1870B27F;
        Fri, 16 Sep 2022 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663329730; x=1694865730;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I7bEY9XKWq/5NwZYNFjLUnUwGKzFVrZ2+hj0izSWBsQ=;
  b=Qm1ixPEfcw+2Pd/wEZYTduwIpKEuygU6UgwEd/jPTDfajhf6hPXajZ81
   mYTjiHmeie4AEjc/prEMOK/W69b5IuWstAsqqC49Kf1aik/mW+5bmZ/kv
   SoipXPpY8gJPnV1vyKdQ9as7R1H6U6lVcC5aZrg9lI3QY8l9xyRaO3fVI
   hZhnGTm/QvvkTAJEW0NfDvBXEqgm0HuYwHJf+oSo5SY+l4MU+fkpbd2Sz
   z80XCKbGuJM0724VnOR5ueMmJlin2CHdUgNVJgvvZ19VqC69GSEqX0Srb
   5gjVS/Cc+dfqCQ3sB+FL+clPcKCdm0V8NIqkgd15j6lP2vupXeDQM9sdC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="360716620"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="360716620"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 05:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="679941259"
Received: from lroque-mobl1.amr.corp.intel.com ([10.251.209.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 05:02:06 -0700
Date:   Fri, 16 Sep 2022 15:02:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
In-Reply-To: <YyRiPMa26qDptj3L@wantstofly.org>
Message-ID: <421c541b-25d7-a1de-8c21-5a164dcf24ef@linux.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org> <YyGoZLTFhYQvlf+P@smile.fi.intel.com> <YyG2tDdq9PWTlaBQ@wantstofly.org> <YyHR4o5bOnODZzZ9@smile.fi.intel.com> <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com> <YyRiPMa26qDptj3L@wantstofly.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2065269609-1663329729=:1788"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2065269609-1663329729=:1788
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 16 Sep 2022, Lennert Buytenhek wrote:

> On Thu, Sep 15, 2022 at 07:27:45PM +0300, Ilpo Järvinen wrote:
> 
> > > > > > On an Intel SoC with several 8250_mid PCIe UARTs built into the CPU, I
> > > > > > can reliably trigger I/O page faults if I invoke TIOCVHANGUP on any of
> > > > > > the UARTs and then re-open that UART.
> > > > > > 
> > > > > > Invoking TIOCVHANGUP appears to clear the MSI address/data registers
> > > > > > in the UART via tty_ioctl() -> tty_vhangup() -> __tty_hangup() ->
> > > > > > uart_hangup() -> uart_shutdown() -> uart_port_shutdown() ->
> > > > > > univ8250_release_irq() -> free_irq() -> irq_domain_deactivate_irq() ->
> > > > > > __irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
> > > > > > __pci_write_msi_msg():
> > > > > > 
> > > > > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > > > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > > > 		Address: fee00278  Data: 0000
> > > > > > [root@icelake ~]# cat hangup.c
> > > > > > #include <stdio.h>
> > > > > > #include <sys/ioctl.h>
> > > > > > 
> > > > > > int main(int argc, char *argv[])
> > > > > > {
> > > > > > 	ioctl(1, TIOCVHANGUP);
> > > > > > 
> > > > > > 	return 0;
> > > > > > }
> > > > > > [root@icelake ~]# gcc -Wall -o hangup hangup.c
> > > > > > [root@icelake ~]# ./hangup > /dev/ttyS4
> > > > > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > > > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > > > 		Address: 00000000  Data: 0000
> > > > > > [root@icelake ~]#
> > > > > > 
> > > > > > Opening the serial port device again while the UART is in this state
> > > > > > then appears to cause the UART to generate an interrupt
> > > > > 
> > > > > The interrupt is ORed three: DMA Tx, DMA Rx and UART itself.
> > > > > Any of them can be possible, but to be sure, can you add:
> > > > > 
> > > > > 	dev_info(p->dev, "FISR: %x\n", fisr);
> > > > > 
> > > > > into dnv_handle_irq() before any other code and see which bits we
> > > > > actually got there before the crash?
> > > > > 
> > > > > (If it floods the logs, dev_info_ratelimited() may help)
> > > > 
> > > > I think that that wouldn't report anything because when the UART is
> > > > triggering an interrupt here, the MSI address/data are zero, so the
> > > > IRQ handler is not actually invoked.
> > > 
> > > Ah, indeed. Then you may disable MSI (in 8250_mid) and see that anyway?
> > > 
> > > > If Ilpo doesn't beat me to it, I'll try adding some debug code to see
> > > > exactly which UART register write in the tty open path is causing the
> > > > UART to signal an interrupt before the IRQ handler is set up.
> > > > 
> > > > (The IOMMU stops the write in this case, so the machine doesn't crash,
> > > > we just get an I/O page fault warning in dmesg every time this happens.)
> > > 
> > > And I believe you are not using that UART as debug console, so it won't
> > > dead lock itself. It's then better than I assumed.
> > > 
> > > > > > before the
> > > > > > MSI vector has been set up again, causing a DMA write to I/O virtual
> > > > > > address zero:
> > > > > > 
> > > > > > [root@icelake console]# echo > /dev/ttyS4
> > > > > > [  979.463307] DMAR: DRHD: handling fault status reg 3
> > > > > > [  979.469409] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> > > > > > 
> > > > > > I'm guessing there's something under tty_open() -> uart_open() ->
> > > > > > tty_port_open() -> uart_port_activate() -> uart_port_startup() ->
> > > > > > serial8250_do_startup() that triggers a UART interrupt before the
> > > > > > MSI vector has been set up again.
> > > > > > 
> > > > > > I did a quick search but it didn't seem like this is a known issue.
> > > > > 
> > > > > Thanks for your report and reproducer! Yes, I also never heard about
> > > > > such an issue before. Ilpo, who is doing more UART work nowadays, might
> > > > > have an idea, I hope.
> > 
> > The patch below seems to avoid the faults. [...]
> 
> Thanks for the fix!
> 
> 
> > [...] I'm far from sure if it's the 
> > best fix though as I don't fully understand what causes the faults during 
> > the THRE tests because the port->irq is disabled by the THRE test block.
> 
> If the IRQ hasn't been set up yet, the UART will have zeroes in its MSI
> address/data registers.  Disabling the IRQ at the interrupt controller
> won't stop the UART from performing a DMA write to the address programmed
> in its MSI address register (zero) when it wants to signal an interrupt.
> 
> (These UARTs (in Ice Lake-D) implement PCI 2.1 style MSI without masking
> capability, so there is no way to mask the interrupt at the source PCI
> function level, except disabling the MSI capability entirely, but that
> would cause it to fall back to INTx# assertion, and the PCI specification
> prohibits disabling the MSI capability as a way to mask a function's
> interrupt service request.)
>
> > Reported-by: Lennert Buytenhek <buytenh@wantstofly.org>
> 
> Could you make this buytenh@arista.com ?

Sure. Should I add Tested-by as well?

-- 
 i.

--8323329-2065269609-1663329729=:1788--
