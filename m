Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB1971FDDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjFBJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjFBJ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:28:26 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 718981B9;
        Fri,  2 Jun 2023 02:27:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8E8B78111;
        Fri,  2 Jun 2023 09:27:02 +0000 (UTC)
Date:   Fri, 2 Jun 2023 12:27:01 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230602092701.GP14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602083335.GA181647@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Chen-Yu Tsai <wenst@chromium.org> [230602 08:33]:
> This patch, in linux-next since 20230601, unfortunately breaks MediaTek
> based Chromebooks. The kernel hangs during the probe of the serial ports,
> which use the 8250_mtk driver. This happens even with the subsequent
> fixes in next-20230602 and on the mailing list:
> 
>     serial: core: Fix probing serial_base_bus devices
>     serial: core: Don't drop port_mutex in serial_core_remove_one_port
>     serial: core: Fix error handling for serial_core_ctrl_device_add()

OK thanks for reporting it.

> Without the fixes, the kernel gives "WARNING: bad unlock balance detected!"
> With the fixes, it just silently hangs. The last messages seen on the
> (serial) console are:
> 
>     Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>     printk: console [ttyS0] disabled
>     mt6577-uart 11002000.serial: using DT '/soc/serial@11002000' for 'rs485-term' GPIO lookup
>     of_get_named_gpiod_flags: can't parse 'rs485-term-gpios' property of node '/soc/serial@11002000[0]'
>     of_get_named_gpiod_flags: can't parse 'rs485-term-gpio' property of node '/soc/serial@11002000[0]'
>     mt6577-uart 11002000.serial: using lookup tables for GPIO lookup
>     mt6577-uart 11002000.serial: No GPIO consumer rs485-term found
>     mt6577-uart 11002000.serial: using DT '/soc/serial@11002000' for 'rs485-rx-during-tx' GPIO lookup
>     of_get_named_gpiod_flags: can't parse 'rs485-rx-during-tx-gpios' property of node '/soc/serial@11002000[0]'
>     of_get_named_gpiod_flags: can't parse 'rs485-rx-during-tx-gpio' property of node '/soc/serial@11002000[0]'
>     mt6577-uart 11002000.serial: using lookup tables for GPIO lookup
>     mt6577-uart 11002000.serial: No GPIO consumer rs485-rx-during-tx found
> 
> What can we do to help resolve this?

There may be something blocking serial_ctrl and serial_port from
probing. That was the issue with the arch_initcall() using drivers.

Not sure yet what the issue here might be, but the 8250_mtk should be
fairly similar use case to the 8250_omap driver that I've tested with.
But unfortunately I don't think I have any 8250_mtk using devices to
test with.

The following hack should allow you to maybe see more info on what goes
wrong and allows adding some debug printk to serial_base_match() for
example to see if that gets called for mt6577-uart.

Hmm maybe early_mtk8250_setup() somehow triggers the issue? Not sure why
early_serial8250_setup() would cause issues here though.

Regards,

Tony

8< -----------------
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -144,7 +144,7 @@ static void __uart_start(struct tty_struct *tty)
 		return;
 
 	port_dev = port->port_dev;
-
+#if 0
 	/* Increment the runtime PM usage count for the active check below */
 	err = pm_runtime_get(&port_dev->dev);
 	if (err < 0) {
@@ -161,6 +161,9 @@ static void __uart_start(struct tty_struct *tty)
 		port->ops->start_tx(port);
 	pm_runtime_mark_last_busy(&port_dev->dev);
 	pm_runtime_put_autosuspend(&port_dev->dev);
+#else
+	port->ops->start_tx(port);
+#endif
 }
 
 static void uart_start(struct tty_struct *tty)
-- 
2.41.0
