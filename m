Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47B722595
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjFEMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjFEMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:24:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED0AEBD;
        Mon,  5 Jun 2023 05:24:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 31DB880FE;
        Mon,  5 Jun 2023 12:24:49 +0000 (UTC)
Date:   Mon, 5 Jun 2023 15:24:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
Message-ID: <20230605122447.GY14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com>
 <20230603063533.GS14287@atomide.com>
 <20230605061511.GW14287@atomide.com>
 <CAGXv+5Fbx7eTxP0ep6DV+jyronAWxYvu2M-g=MjHGRhjSXUc=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Fbx7eTxP0ep6DV+jyronAWxYvu2M-g=MjHGRhjSXUc=w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Chen-Yu Tsai <wenst@chromium.org> [230605 11:34]:
> On Mon, Jun 5, 2023 at 2:15 PM Tony Lindgren <tony@atomide.com> wrote:
> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> > --- a/drivers/tty/serial/8250/8250_mtk.c
> > +++ b/drivers/tty/serial/8250/8250_mtk.c
> > @@ -425,11 +439,10 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
> >  static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
> >  {
> >         struct mtk8250_data *data = dev_get_drvdata(dev);
> > -       struct uart_8250_port *up = serial8250_get_port(data->line);
> >
> >         /* wait until UART in idle status */
> >         while
> > -               (serial_in(up, MTK_UART_DEBUG0));
> > +               (mtk8250_read(data, MTK_UART_DEBUG0));
> 
> I believe it still gets stuck here sometimes.

Hmm so maybe you need to mtk8250_write(data, 0, MTK_UART_RATE_FIX) in
probe before pm_runtime_resume_and_get() that enables the baud clock?
That's something I changed, so maybe it messes up things.

Looking at the 8250_mtk git log, it's runtime PM functions seem to only
currently manage the baud clock so register access should be doable
without runtime PM resume?

> With your earlier patch, it could get through registering the port, and
> the console would show
> 
>     11002000.serial: ttyS0 at MMIO 0x11002000 (irq = 240, base_baud =
> 1625000) is a ST16650V2
> 
> for the console UART.

OK

> Angelo mentioned that we should be using SLEEP_REQ/SLEEP_ACK registers
> in the MTK UART hardware.
> 
> I tried reworking it into your patch here, but it causes issues with the
> UART-based Bluetooth on one of my devices. After the UART runtime suspends
> and resumes, something is off and causes the transfers during Bluetooth
> init to become corrupt.
> 
> I'll try some more stuff, but the existing code seems timing dependent.
> If I add too many printk statements to the runtime suspend/resume
> callbacks, things seem to work. One time I even ended up with broken
> UARTs but otherwise booted up the system.

Well another thing that now changes is that we now runtime suspend the
port at the end of the probe. What the 8250_mtk probe was doing earlier
it was leaving the port baud clock enabled, but runtime PM disabled
until mtk8250_do_pm() I guess.

Regards,

Tony
