Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7A5B9F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIOQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIOQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:27:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195519E11F;
        Thu, 15 Sep 2022 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663259277; x=1694795277;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hTLgiq46065uoaGpLmCVB41MvllRV5rjFIMLJgL3xHU=;
  b=gp6Fbu9f7eEvTJ+5RnrIg5o6HslxPAkykbFp8WmNmfIQmK5mnFrT0TjK
   QLah07IbZE4L7Jh/e5T0htAYlDWpDhPBqdt1s3zApOvD3qnYisYLlz5x3
   +eGhABU23bI3ZhFFFvc9B5U0HKNGnEPAzlNP8kDR6m+C8un/LSWU/RFYs
   3284Okm7YOrEv5tl9dch9GaCIjpOapSSKa7zeaOQfZEkipMtXAb9o35Gr
   LjqGAHY0dj7CJjlO2lUFgtgHZ/bh3vJrTlUjsnD9m46lAqsDndziV9b9u
   lUjV9RoQ8LwxeuCsRS8Iaqon0/vYWYb9rSeoT8hdRYEPVz1i/wk/TRYNf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="297490732"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="297490732"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 09:27:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="721066213"
Received: from khagn-mobl1.ger.corp.intel.com ([10.249.46.185])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 09:27:53 -0700
Date:   Thu, 15 Sep 2022 19:27:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lennert Buytenhek <buytenh@wantstofly.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: I/O page faults from 8250_mid PCIe UART after TIOCVHANGUP
In-Reply-To: <YyHR4o5bOnODZzZ9@smile.fi.intel.com>
Message-ID: <7fd034a9-c1e1-2dca-693b-129c9d2649@linux.intel.com>
References: <YyF/dogp/0C87zLb@wantstofly.org> <YyGoZLTFhYQvlf+P@smile.fi.intel.com> <YyG2tDdq9PWTlaBQ@wantstofly.org> <YyHR4o5bOnODZzZ9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1047278770-1663259274=:1610"
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

--8323329-1047278770-1663259274=:1610
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 14 Sep 2022, Andy Shevchenko wrote:

> On Wed, Sep 14, 2022 at 02:10:44PM +0300, Lennert Buytenhek wrote:
> > On Wed, Sep 14, 2022 at 01:09:40PM +0300, Andy Shevchenko wrote:
> > > > On an Intel SoC with several 8250_mid PCIe UARTs built into the CPU, I
> > > > can reliably trigger I/O page faults if I invoke TIOCVHANGUP on any of
> > > > the UARTs and then re-open that UART.
> > > > 
> > > > Invoking TIOCVHANGUP appears to clear the MSI address/data registers
> > > > in the UART via tty_ioctl() -> tty_vhangup() -> __tty_hangup() ->
> > > > uart_hangup() -> uart_shutdown() -> uart_port_shutdown() ->
> > > > univ8250_release_irq() -> free_irq() -> irq_domain_deactivate_irq() ->
> > > > __irq_domain_deactivate_irq() -> msi_domain_deactivate() ->
> > > > __pci_write_msi_msg():
> > > > 
> > > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > 		Address: fee00278  Data: 0000
> > > > [root@icelake ~]# cat hangup.c
> > > > #include <stdio.h>
> > > > #include <sys/ioctl.h>
> > > > 
> > > > int main(int argc, char *argv[])
> > > > {
> > > > 	ioctl(1, TIOCVHANGUP);
> > > > 
> > > > 	return 0;
> > > > }
> > > > [root@icelake ~]# gcc -Wall -o hangup hangup.c
> > > > [root@icelake ~]# ./hangup > /dev/ttyS4
> > > > [root@icelake ~]# lspci -s 00:1a.0 -vv | grep -A1 MSI:
> > > > 	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > > 		Address: 00000000  Data: 0000
> > > > [root@icelake ~]#
> > > > 
> > > > Opening the serial port device again while the UART is in this state
> > > > then appears to cause the UART to generate an interrupt
> > > 
> > > The interrupt is ORed three: DMA Tx, DMA Rx and UART itself.
> > > Any of them can be possible, but to be sure, can you add:
> > > 
> > > 	dev_info(p->dev, "FISR: %x\n", fisr);
> > > 
> > > into dnv_handle_irq() before any other code and see which bits we
> > > actually got there before the crash?
> > > 
> > > (If it floods the logs, dev_info_ratelimited() may help)
> > 
> > I think that that wouldn't report anything because when the UART is
> > triggering an interrupt here, the MSI address/data are zero, so the
> > IRQ handler is not actually invoked.
> 
> Ah, indeed. Then you may disable MSI (in 8250_mid) and see that anyway?
> 
> > If Ilpo doesn't beat me to it, I'll try adding some debug code to see
> > exactly which UART register write in the tty open path is causing the
> > UART to signal an interrupt before the IRQ handler is set up.
> > 
> > (The IOMMU stops the write in this case, so the machine doesn't crash,
> > we just get an I/O page fault warning in dmesg every time this happens.)
> 
> And I believe you are not using that UART as debug console, so it won't
> dead lock itself. It's then better than I assumed.
> 
> > > > before the
> > > > MSI vector has been set up again, causing a DMA write to I/O virtual
> > > > address zero:
> > > > 
> > > > [root@icelake console]# echo > /dev/ttyS4
> > > > [  979.463307] DMAR: DRHD: handling fault status reg 3
> > > > [  979.469409] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
> > > > 
> > > > I'm guessing there's something under tty_open() -> uart_open() ->
> > > > tty_port_open() -> uart_port_activate() -> uart_port_startup() ->
> > > > serial8250_do_startup() that triggers a UART interrupt before the
> > > > MSI vector has been set up again.
> > > > 
> > > > I did a quick search but it didn't seem like this is a known issue.
> > > 
> > > Thanks for your report and reproducer! Yes, I also never heard about
> > > such an issue before. Ilpo, who is doing more UART work nowadays, might
> > > have an idea, I hope.

The patch below seems to avoid the faults. I'm far from sure if it's the 
best fix though as I don't fully understand what causes the faults during 
the THRE tests because the port->irq is disabled by the THRE test block.

--
From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[PATCH] serial: 8250: Turn IER bits on only after irq has been set up

Invoking TIOCVHANGUP on 8250_mid port and then reopening the
port triggers these faults during serial8250_do_startup():

  DMAR: DRHD: handling fault status reg 3
  DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set

The faults are triggered by the THRE test that temporarily toggles THRI
in IER before UART's irq is set up.

Refactor serial8250_do_startup() such that irq is setup before the THRE
test. The current irq setup code is intermixed with the timer setup
code. As THRE test must be performed prior to the timer setup, extract
it into own function and call it only after the THRE test.

Reported-by: Lennert Buytenhek <buytenh@wantstofly.org>
Fixes: 40b36daad0ac ("[PATCH] 8250 UART backup timer")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_core.c | 23 ++++++++++++-----------
 drivers/tty/serial/8250/8250_port.c |  8 +++++---
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 287153d32536..dbf4c1204bf3 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -403,3 +403,5 @@ static inline int serial_index(struct uart_port *port)
 {
 	return port->minor - 64;
 }
+
+void univ8250_setup_timer(struct uart_8250_port *up);
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 2e83e7367441..e81a9cab6960 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -298,21 +298,15 @@ static void serial8250_backup_timeout(struct timer_list *t)
 		jiffies + uart_poll_timeout(&up->port) + HZ / 5);
 }
 
-static int univ8250_setup_irq(struct uart_8250_port *up)
+void univ8250_setup_timer(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
-	int retval = 0;
 
-	/*
-	 * The above check will only give an accurate result the first time
-	 * the port is opened so this value needs to be preserved.
-	 */
 	if (up->bugs & UART_BUG_THRE) {
 		pr_debug("%s - using backup timer\n", port->name);
 
 		up->timer.function = serial8250_backup_timeout;
-		mod_timer(&up->timer, jiffies +
-			  uart_poll_timeout(port) + HZ / 5);
+		mod_timer(&up->timer, jiffies + uart_poll_timeout(port) + HZ / 5);
 	}
 
 	/*
@@ -322,10 +316,17 @@ static int univ8250_setup_irq(struct uart_8250_port *up)
 	 */
 	if (!port->irq)
 		mod_timer(&up->timer, jiffies + uart_poll_timeout(port));
-	else
-		retval = serial_link_irq_chain(up);
+}
+EXPORT_SYMBOL_GPL(univ8250_setup_timer);
 
-	return retval;
+static int univ8250_setup_irq(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+
+	if (port->irq)
+		return serial_link_irq_chain(up);
+
+	return 0;
 }
 
 static void univ8250_release_irq(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 39b35a61958c..6e8e16227a3a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2294,6 +2294,10 @@ int serial8250_do_startup(struct uart_port *port)
 	if (port->irq && (up->port.flags & UPF_SHARE_IRQ))
 		up->port.irqflags |= IRQF_SHARED;
 
+	retval = up->ops->setup_irq(up);
+	if (retval)
+		goto out;
+
 	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
 		unsigned char iir1;
 
@@ -2336,9 +2340,7 @@ int serial8250_do_startup(struct uart_port *port)
 		}
 	}
 
-	retval = up->ops->setup_irq(up);
-	if (retval)
-		goto out;
+	univ8250_setup_timer(up);
 
 	/*
 	 * Now, initialize the UART

-- 
tg: (1d10cd4da593..) 8250/setup-irq-fix (depends on: tty-linus)
--8323329-1047278770-1663259274=:1610--
