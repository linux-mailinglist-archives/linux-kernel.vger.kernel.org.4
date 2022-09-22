Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1F5E5BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIVHAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIVHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:00:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347637757C;
        Thu, 22 Sep 2022 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663830048; x=1695366048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pDByM+4EvL9jGznxlWX5L9b0tuoSXIGd5gx3VxbZxGE=;
  b=P8J7rUgPAE+PS07jW+8Gaxhh8IUeWmJbjeELBJXuYaxScQFxxuFpcm9a
   zqmA2MLMWmJ13jngNTL/Xh200qRGkQVWGqa+eMxCrFH14qXt8OPSGd21b
   lGimXaHkm5OmYIPn+RwFPMbeJEfeNTmNiOXzlQIZXK7259ERsUBhncCih
   gchQtO3mwBiQOE1Eu0r9Q86ckF2OOXFAQBSQP9klDv+W3KYMNsxUIpTKc
   a+yRkE/F/j4eBxEhfCwpL2GP+wraAzFCHHHaNi0BuA+0tnou8h3UFb354
   sGYmRpCIrisinxNn9K9x8w/2VCMBbNkf2ryAGjkd1wi6At8nvB9LYeVY9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="298934345"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="298934345"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 00:00:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="688181506"
Received: from lsundin-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.58.180])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 00:00:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lennert Buytenhek <buytenh@arista.com>
Subject: [PATCH v4 1/1] serial: 8250: Toggle IER bits on only after irq has been set up
Date:   Thu, 22 Sep 2022 10:00:05 +0300
Message-Id: <20220922070005.2965-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoking TIOCVHANGUP on 8250_mid port on Ice Lake-D and then reopening
the port triggers these faults during serial8250_do_startup():

  DMAR: DRHD: handling fault status reg 3
  DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set

If the IRQ hasn't been set up yet, the UART will have zeroes in its MSI
address/data registers. Disabling the IRQ at the interrupt controller
won't stop the UART from performing a DMA write to the address programmed
in its MSI address register (zero) when it wants to signal an interrupt.

The UARTs (in Ice Lake-D) implement PCI 2.1 style MSI without masking
capability, so there is no way to mask the interrupt at the source PCI
function level, except disabling the MSI capability entirely, but that
would cause it to fall back to INTx# assertion, and the PCI specification
prohibits disabling the MSI capability as a way to mask a function's
interrupt service request.

The MSI address register is zeroed by the hangup as the irq is freed.
The interrupt is signalled during serial8250_do_startup() performing a
THRE test that temporarily toggles THRI in IER. The THRE test currently
occurs before UART's irq (and MSI address) is properly set up.

Refactor serial8250_do_startup() such that irq is set up before the
THRE test. The current irq setup code is intermixed with the timer
setup code. As THRE test must be performed prior to the timer setup,
extract it into own function and call it only after the THRE test.

The ->setup_timer() needs to be part of the struct uart_8250_ops in
order to not create circular dependency between 8250 and 8250_base
modules.

Reported-by: Lennert Buytenhek <buytenh@arista.com>
Tested-by: Lennert Buytenhek <buytenh@arista.com>
Fixes: 40b36daad0ac ("[PATCH] 8250 UART backup timer")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v4:
- Add setup_timer() to univ8250_driver_ops to avoid circular module dependency

v3:
- Improved the commit with Lennert's superior descriptions.
- Added Andy's Rev-by

v2:
- Remove unnecessary changes to comments & newlines
- Change Lennert's email & add Tested-by
- Improve description of the problem (thank to Lennert's explanation)

 drivers/tty/serial/8250/8250_core.c | 16 +++++++++++-----
 drivers/tty/serial/8250/8250_port.c |  8 +++++---
 include/linux/serial_8250.h         |  1 +
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 2e83e7367441..94fbf0add2ce 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -298,10 +298,9 @@ static void serial8250_backup_timeout(struct timer_list *t)
 		jiffies + uart_poll_timeout(&up->port) + HZ / 5);
 }
 
-static int univ8250_setup_irq(struct uart_8250_port *up)
+static void univ8250_setup_timer(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
-	int retval = 0;
 
 	/*
 	 * The above check will only give an accurate result the first time
@@ -322,10 +321,16 @@ static int univ8250_setup_irq(struct uart_8250_port *up)
 	 */
 	if (!port->irq)
 		mod_timer(&up->timer, jiffies + uart_poll_timeout(port));
-	else
-		retval = serial_link_irq_chain(up);
+}
 
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
@@ -381,6 +386,7 @@ static struct uart_ops univ8250_port_ops;
 static const struct uart_8250_ops univ8250_driver_ops = {
 	.setup_irq	= univ8250_setup_irq,
 	.release_irq	= univ8250_release_irq,
+	.setup_timer	= univ8250_setup_timer,
 };
 
 static struct uart_8250_port serial8250_ports[UART_NR];
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 39b35a61958c..cfc022529e60 100644
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
+	up->ops->setup_timer(up);
 
 	/*
 	 * Now, initialize the UART
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 8c7b793aa4d7..16e3d75a324c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -74,6 +74,7 @@ struct uart_8250_port;
 struct uart_8250_ops {
 	int		(*setup_irq)(struct uart_8250_port *);
 	void		(*release_irq)(struct uart_8250_port *);
+	void		(*setup_timer)(struct uart_8250_port *);
 };
 
 struct uart_8250_em485 {
-- 
2.30.2

