Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AE5BCF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiISOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiISOlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:41:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E036114E;
        Mon, 19 Sep 2022 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663598471; x=1695134471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=38Iy38ftkISKzc0y4uuVPmb65R/Pe1Mz6gRWMcovat4=;
  b=npJI+jHFk4Zm3TXFSmR12BGiAdH2/OUij+qJqX7Rw+bVSKw6ZkRlQqmM
   LsMQm/9Mvl92VgqfuAw8yjtoQ5TzO2aN3wX2/g/QsU5+aKpdwQPtfZ6jN
   CxA+uAQ0ifZlEufdVrA54eI5jGIX7Fg0Ee7aZaDo7kZBweSbd2TAXkKBG
   Hn6dULg6qmLdaYCeGneL7k8sLIH5ew9PHrD7Hdef15OWQWXwX8MrYcMYR
   ftQoifEtFGwpzGY80dTLRgNNjEK7ELmhUM3hfW6Q+Rqc/vYtsVH27ncyz
   d8EVrgdYV1kjE96Ub9VcmR3sMFvRUhzVLksIGS1P0uONzVmsuCTUdBEkE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299407522"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="299407522"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:41:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863583868"
Received: from iswiersz-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.33.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:41:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lennert Buytenhek <buytenh@arista.com>
Subject: [PATCH v3 1/1] serial: 8250: Toggle IER bits on only after irq has been set up
Date:   Mon, 19 Sep 2022 17:40:57 +0300
Message-Id: <20220919144057.12241-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

The MSI address register is zeroed during by the hangup as the irq is
freed. The interrupt is signalled during serial8250_do_startup()
performing a THRE test that temporarily toggles THRI in IER. The THRE
test currently occurs before UART's irq (and MSI address) is properly
set up.

Refactor serial8250_do_startup() such that irq is set up before the
THRE test. The current irq setup code is intermixed with the timer
setup code. As THRE test must be performed prior to the timer setup,
extract it into own function and call it only after the THRE test.

Reported-by: Lennert Buytenhek <buytenh@arista.com>
Tested-by: Lennert Buytenhek <buytenh@arista.com>
Fixes: 40b36daad0ac ("[PATCH] 8250 UART backup timer")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- Improved the commit with Lennert's superior descriptions.
- Added Andy's Rev-by

 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_core.c | 16 +++++++++++-----
 drivers/tty/serial/8250/8250_port.c |  8 +++++---
 3 files changed, 18 insertions(+), 8 deletions(-)

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
index 2e83e7367441..10d535640434 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -298,10 +298,9 @@ static void serial8250_backup_timeout(struct timer_list *t)
 		jiffies + uart_poll_timeout(&up->port) + HZ / 5);
 }
 
-static int univ8250_setup_irq(struct uart_8250_port *up)
+void univ8250_setup_timer(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
-	int retval = 0;
 
 	/*
 	 * The above check will only give an accurate result the first time
@@ -322,10 +321,17 @@ static int univ8250_setup_irq(struct uart_8250_port *up)
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
2.30.2

