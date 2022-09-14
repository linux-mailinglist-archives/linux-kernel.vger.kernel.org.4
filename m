Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5473D5B81EC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiINHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiINHPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:15:06 -0400
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB861719
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:15:04 -0700 (PDT)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id 156187F54E; Wed, 14 Sep 2022 10:15:02 +0300 (EEST)
Date:   Wed, 14 Sep 2022 10:15:02 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
Message-ID: <YyF/dogp/0C87zLb@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On an Intel SoC with several 8250_mid PCIe UARTs built into the CPU, I
can reliably trigger I/O page faults if I invoke TIOCVHANGUP on any of
the UARTs and then re-open that UART.

Invoking TIOCVHANGUP appears to clear the MSI address/data registers
in the UART via tty_ioctl() -> tty_vhangup() -> __tty_hangup() ->
uart_hangup() -> uart_shutdown() -> uart_port_shutdown() ->
univ8250_release_irq() -> free_irq() -> irq_domain_deactivate_irq() ->
__irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
__pci_write_msi_msg():

[root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee00278  Data: 0000
[root@icelake ~]# cat hangup.c
#include <stdio.h>
#include <sys/ioctl.h>

int main(int argc, char *argv[])
{
	ioctl(1, TIOCVHANGUP);

	return 0;
}
[root@icelake ~]# gcc -Wall -o hangup hangup.c
[root@icelake ~]# ./hangup > /dev/ttyS4
[root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
[root@icelake ~]#

Opening the serial port device again while the UART is in this state
then appears to cause the UART to generate an interrupt before the
MSI vector has been set up again, causing a DMA write to I/O virtual
address zero:

[root@icelake console]# echo > /dev/ttyS4
[  979.463307] DMAR: DRHD: handling fault status reg 3
[  979.469409] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set

I'm guessing there's something under tty_open() -> uart_open() ->
tty_port_open() -> uart_port_activate() -> uart_port_startup() ->
serial8250_do_startup() that triggers a UART interrupt before the
MSI vector has been set up again.

I did a quick search but it didn't seem like this is a known issue.


Thanks,
Lennert
