Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2845BADF6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiIPNS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiIPNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:18:50 -0400
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C519EA3D44;
        Fri, 16 Sep 2022 06:18:47 -0700 (PDT)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id 2D4807F505; Fri, 16 Sep 2022 16:18:46 +0300 (EEST)
Date:   Fri, 16 Sep 2022 16:18:46 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <YyR3tnUXsgIJ1w/W@wantstofly.org>
References: <YyF/dogp/0C87zLb@wantstofly.org>
 <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
 <YyG2tDdq9PWTlaBQ@wantstofly.org>
 <YyHR4o5bOnODZzZ9@smile.fi.intel.com>
 <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com>
 <YyRiPMa26qDptj3L@wantstofly.org>
 <421c541b-25d7-a1de-8c21-5a164dcf24ef@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <421c541b-25d7-a1de-8c21-5a164dcf24ef@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:02:04PM +0300, Ilpo Järvinen wrote:

> > > > > > > On an Intel SoC with several 8250_mid PCIe UARTs built into the CPU, I
> > > > > > > can reliably trigger I/O page faults if I invoke TIOCVHANGUP on any of
> > > > > > > the UARTs and then re-open that UART.
> > > > > > > 
> > > > > > > Invoking TIOCVHANGUP appears to clear the MSI address/data registers
> > > > > > > in the UART via tty_ioctl() -> tty_vhangup() -> __tty_hangup() ->
> > > > > > > uart_hangup() -> uart_shutdown() -> uart_port_shutdown() ->
> > > > > > > univ8250_release_irq() -> free_irq() -> irq_domain_deactivate_irq() ->
> > > > > > > __irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
> > > > > > > __pci_write_msi_msg():
> > > > > > > 
> > > > > > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > > > > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > > > > 		Address: fee00278  Data: 0000
> > > > > > > [root@icelake ~]# cat hangup.c
> > > > > > > #include <stdio.h>
> > > > > > > #include <sys/ioctl.h>
> > > > > > > 
> > > > > > > int main(int argc, char *argv[])
> > > > > > > {
> > > > > > > 	ioctl(1, TIOCVHANGUP);
> > > > > > > 
> > > > > > > 	return 0;
> > > > > > > }
> > > > > > > [root@icelake ~]# gcc -Wall -o hangup hangup.c
> > > > > > > [root@icelake ~]# ./hangup > /dev/ttyS4
> > > > > > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > > > > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > > > > 		Address: 00000000  Data: 0000
> > > > > > > [root@icelake ~]#
> > > > > > > 
> > > > > > > Opening the serial port device again while the UART is in this state
> > > > > > > then appears to cause the UART to generate an interrupt
> > > > > > 
> > > > > > The interrupt is ORed three: DMA Tx, DMA Rx and UART itself.
> > > > > > Any of them can be possible, but to be sure, can you add:
> > > > > > 
> > > > > > 	dev_info(p->dev, "FISR: %x\n", fisr);
> > > > > > 
> > > > > > into dnv_handle_irq() before any other code and see which bits we
> > > > > > actually got there before the crash?
> > > > > > 
> > > > > > (If it floods the logs, dev_info_ratelimited() may help)
> > > > > 
> > > > > I think that that wouldn't report anything because when the UART is
> > > > > triggering an interrupt here, the MSI address/data are zero, so the
> > > > > IRQ handler is not actually invoked.
> > > > 
> > > > Ah, indeed. Then you may disable MSI (in 8250_mid) and see that anyway?
> > > > 
> > > > > If Ilpo doesn't beat me to it, I'll try adding some debug code to see
> > > > > exactly which UART register write in the tty open path is causing the
> > > > > UART to signal an interrupt before the IRQ handler is set up.
> > > > > 
> > > > > (The IOMMU stops the write in this case, so the machine doesn't crash,
> > > > > we just get an I/O page fault warning in dmesg every time this happens.)
> > > > 
> > > > And I believe you are not using that UART as debug console, so it won't
> > > > dead lock itself. It's then better than I assumed.
> > > > 
> > > > > > > before the
> > > > > > > MSI vector has been set up again, causing a DMA write to I/O virtual
> > > > > > > address zero:
> > > > > > > 
> > > > > > > [root@icelake console]# echo > /dev/ttyS4
> > > > > > > [  979.463307] DMAR: DRHD: handling fault status reg 3
> > > > > > > [  979.469409] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> > > > > > > 
> > > > > > > I'm guessing there's something under tty_open() -> uart_open() ->
> > > > > > > tty_port_open() -> uart_port_activate() -> uart_port_startup() ->
> > > > > > > serial8250_do_startup() that triggers a UART interrupt before the
> > > > > > > MSI vector has been set up again.
> > > > > > > 
> > > > > > > I did a quick search but it didn't seem like this is a known issue.
> > > > > > 
> > > > > > Thanks for your report and reproducer! Yes, I also never heard about
> > > > > > such an issue before. Ilpo, who is doing more UART work nowadays, might
> > > > > > have an idea, I hope.
> > > 
> > > The patch below seems to avoid the faults. [...]
> > 
> > Thanks for the fix!
> > 
> > 
> > > [...] I'm far from sure if it's the 
> > > best fix though as I don't fully understand what causes the faults during 
> > > the THRE tests because the port->irq is disabled by the THRE test block.
> > 
> > If the IRQ hasn't been set up yet, the UART will have zeroes in its MSI
> > address/data registers.  Disabling the IRQ at the interrupt controller
> > won't stop the UART from performing a DMA write to the address programmed
> > in its MSI address register (zero) when it wants to signal an interrupt.
> > 
> > (These UARTs (in Ice Lake-D) implement PCI 2.1 style MSI without masking
> > capability, so there is no way to mask the interrupt at the source PCI
> > function level, except disabling the MSI capability entirely, but that
> > would cause it to fall back to INTx# assertion, and the PCI specification
> > prohibits disabling the MSI capability as a way to mask a function's
> > interrupt service request.)

(In other words, disabling the IRQ at the interrupt controller doesn't
prevent the device from signaling an interrupt, and signaling an
interrupt without a proper MSI target address configured in the device's
MSI address register is what is causing the I/O page fault.)


> > > Reported-by: Lennert Buytenhek <buytenh@wantstofly.org>
> > 
> > Could you make this buytenh@arista.com ?
> 
> Sure. Should I add Tested-by as well?

OK!

Tested-by: Lennert Buytenhek <buytenh@arista.com>
