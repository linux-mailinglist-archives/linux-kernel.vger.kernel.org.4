Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9F7719FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFAOUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjFAOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:20:19 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD8408E;
        Thu,  1 Jun 2023 07:20:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BE5A880F1;
        Thu,  1 Jun 2023 14:20:16 +0000 (UTC)
Date:   Thu, 1 Jun 2023 17:20:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
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
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230601142015.GC14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <CGME20230601110030eucas1p2eed547c326a51a6110100fb50799d136@eucas1p2.samsung.com>
 <88d9edfe-2f39-b15f-f513-463eac6bf473@samsung.com>
 <20230601111147.GA14287@atomide.com>
 <20230601132012.GB14287@atomide.com>
 <ada0d2f8-cb62-1ce7-99c8-c39f071a476d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ada0d2f8-cb62-1ce7-99c8-c39f071a476d@samsung.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marek Szyprowski <m.szyprowski@samsung.com> [230601 14:16]:
> On 01.06.2023 15:20, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [230601 11:12]:
> >> * Marek Szyprowski <m.szyprowski@samsung.com> [230601 11:00]:
> >>> This patch landed in today's linux next-20230601 as commit 84a9582fd203
> >>> ("serial: core: Start managing serial controllers to enable runtime
> >>> PM"). Unfortunately it breaks booting some of my test boards. This can
> >>> be easily reproduced with QEMU and ARM64 virt machine. The last message
> >>> I see in the log is:
> >>>
> >>> [    3.084743] Run /sbin/init as init process
> >> OK thanks for the report. I wonder if this issue is specific to ttyAM
> >> serial port devices somehow?
> > Looks like the problem happens with serial port drivers that use
> > arch_initcall():
> >
> > $ git grep arch_initcall drivers/tty/serial/
> > drivers/tty/serial/amba-pl011.c:arch_initcall(pl011_init);
> > drivers/tty/serial/mps2-uart.c:arch_initcall(mps2_uart_init);
> > drivers/tty/serial/mvebu-uart.c:arch_initcall(mvebu_uart_init);
> > drivers/tty/serial/pic32_uart.c:arch_initcall(pic32_uart_init);
> > drivers/tty/serial/serial_base_bus.c:arch_initcall(serial_base_init);
> > drivers/tty/serial/xilinx_uartps.c:arch_initcall(cdns_uart_init);
> >
> > We have serial_base_bus use module_init() so the serial core controller
> > and port device associated with the physical serial port are not probed.
> >
> > The patch below should fix the problem you're seeing, care to test and
> > if it works I'll post a proper fix?
> 
> Right, this fixes my issue. Feel free to add:
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

OK great just posted it with your Reported-by before seeing this, I added
returning an error too so maybe reply to the posted patch with your
Tested-by assuming it's still OK for you.

For reference if other folks are hitting this, the fix is at [0] below.

Regards,

Tony


[0] https://lore.kernel.org/linux-serial/20230601141445.11321-1-tony@atomide.com/T/#u
