Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5835B870A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiINLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:10:49 -0400
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E05E643;
        Wed, 14 Sep 2022 04:10:46 -0700 (PDT)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id DECA37F54E; Wed, 14 Sep 2022 14:10:44 +0300 (EEST)
Date:   Wed, 14 Sep 2022 14:10:44 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <YyG2tDdq9PWTlaBQ@wantstofly.org>
References: <YyF/dogp/0C87zLb@wantstofly.org>
 <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyGoZLTFhYQvlf+P@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 01:09:40PM +0300, Andy Shevchenko wrote:

> > On an Intel SoC with several 8250_mid PCIe UARTs built into the CPU, I
> > can reliably trigger I/O page faults if I invoke TIOCVHANGUP on any of
> > the UARTs and then re-open that UART.
> > 
> > Invoking TIOCVHANGUP appears to clear the MSI address/data registers
> > in the UART via tty_ioctl() -> tty_vhangup() -> __tty_hangup() ->
> > uart_hangup() -> uart_shutdown() -> uart_port_shutdown() ->
> > univ8250_release_irq() -> free_irq() -> irq_domain_deactivate_irq() ->
> > __irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
> > __pci_write_msi_msg():
> > 
> > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > 		Address: fee00278  Data: 0000
> > [root@icelake ~]# cat hangup.c
> > #include <stdio.h>
> > #include <sys/ioctl.h>
> > 
> > int main(int argc, char *argv[])
> > {
> > 	ioctl(1, TIOCVHANGUP);
> > 
> > 	return 0;
> > }
> > [root@icelake ~]# gcc -Wall -o hangup hangup.c
> > [root@icelake ~]# ./hangup > /dev/ttyS4
> > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > 		Address: 00000000  Data: 0000
> > [root@icelake ~]#
> > 
> > Opening the serial port device again while the UART is in this state
> > then appears to cause the UART to generate an interrupt
> 
> The interrupt is ORed three: DMA Tx, DMA Rx and UART itself.
> Any of them can be possible, but to be sure, can you add:
> 
> 	dev_info(p->dev, "FISR: %x\n", fisr);
> 
> into dnv_handle_irq() before any other code and see which bits we
> actually got there before the crash?
> 
> (If it floods the logs, dev_info_ratelimited() may help)

I think that that wouldn't report anything because when the UART is
triggering an interrupt here, the MSI address/data are zero, so the
IRQ handler is not actually invoked.

If Ilpo doesn't beat me to it, I'll try adding some debug code to see
exactly which UART register write in the tty open path is causing the
UART to signal an interrupt before the IRQ handler is set up.

(The IOMMU stops the write in this case, so the machine doesn't crash,
we just get an I/O page fault warning in dmesg every time this happens.)


> > before the
> > MSI vector has been set up again, causing a DMA write to I/O virtual
> > address zero:
> > 
> > [root@icelake console]# echo > /dev/ttyS4
> > [  979.463307] DMAR: DRHD: handling fault status reg 3
> > [  979.469409] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> > 
> > I'm guessing there's something under tty_open() -> uart_open() ->
> > tty_port_open() -> uart_port_activate() -> uart_port_startup() ->
> > serial8250_do_startup() that triggers a UART interrupt before the
> > MSI vector has been set up again.
> > 
> > I did a quick search but it didn't seem like this is a known issue.
> 
> Thanks for your report and reproducer! Yes, I also never heard about
> such an issue before. Ilpo, who is doing more UART work nowadays, might
> have an idea, I hope.

Thank you!
