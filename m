Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492F720DF6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 07:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjFCFlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 01:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFCFlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 01:41:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D4C2E52;
        Fri,  2 Jun 2023 22:41:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9E7208111;
        Sat,  3 Jun 2023 05:41:40 +0000 (UTC)
Date:   Sat, 3 Jun 2023 08:41:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
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
Message-ID: <20230603054139.GR14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5xii33r.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* John Ogness <john.ogness@linutronix.de> [230602 10:13]:
> Unfortunately next-20230601 also brought in a series that added
> spinlocking to the 8250 driver. That may be the issue here instead.

I think you're off the hook here with the spinlocking changes :)

My guess right now is that 8250_mtk does not want runtime PM resume called
on probe for some reason, and assumes it won't happen until until in
mtk8250_do_pm()?

Looking at the probe, the driver does pm_runtime_enable(), but then calls
mtk8250_runtime_resume() directly. Not sure what the intention here is.
Maybe adding pm_runtime_set_active() in probe might provide more clues.

When we add the new serial_ctrl and serial_port devices, their runtime PM
functions propagate to the parent 8250_mtk device. And then something goes
wrong, well this is my guess on what's going on..

To me it seems the 8250_mtk should just do pm_runtime_resume_and_get()
instead of mtk8250_runtime_resume(), then do pm_runtime_put() at the end
of the probe?

I don't think 8250_mtk needs to do register access before and after the
serial port registration, but if it does, then adding custom read/write
functions can be done that do not rely on initialized port like
serial_out().

Looking at the kernelci.org test boot results for Linux next [0], seems
this issue is somehow 8250_mtk specific. I don't think the rk3399 boot
issue is serial port related.

Regards,

Tony

[0] https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20230602/plan/baseline/
