Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7C6099CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJXF2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXF2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:28:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7DEC7B29E;
        Sun, 23 Oct 2022 22:28:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F082D822A;
        Mon, 24 Oct 2022 05:19:19 +0000 (UTC)
Date:   Mon, 24 Oct 2022 08:28:32 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: remove wait loop from Errata i202
 workaround
Message-ID: <Y1YigD1lEWRbT8eH@atomide.com>
References: <20221013112339.2540767-1-matthias.schiffer@ew.tq-group.com>
 <ea90b0ba-61bf-e56e-5120-9771122838cf@linux.intel.com>
 <Y00bmec4hvWxtnB5@linutronix.de>
 <c91216ec-c7e7-df7b-463-ec17c76b7bc2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c91216ec-c7e7-df7b-463-ec17c76b7bc2@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adding Nishanth to Cc also.

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221017 12:06]:
> On Mon, 17 Oct 2022, Sebastian Andrzej Siewior wrote:
> 
> > On 2022-10-17 11:12:41 [+0300], Ilpo Järvinen wrote:
> > > On Thu, 13 Oct 2022, Matthias Schiffer wrote:
> > > 
> > > > We were occasionally seeing the "Errata i202: timedout" on an AM335x
> > > > board when repeatedly opening and closing a UART connected to an active
> > > > sender. As new input may arrive at any time, it is possible to miss the
> > > > "RX FIFO empty" condition, forcing the loop to wait until it times out.
> > > 
> > > I can see this problem could occur and why your patch fixes it.
> > > 
> > > > Nothing in the i202 Advisory states that such a wait is even necessary;
> > > > other FIFO clear functions like serial8250_clear_fifos() do not wait
> > > > either. For this reason, it seems safe to remove the wait, fixing the
> > > > mentioned issue.
> > > 
> > > Checking the commit that added this driver and the loop along with it, 
> > > there was no information why it would be needed there either.
> > 
> > I don't remember all the details but I do remember that I never hit it.
> > The idea back then was to document what appears the problem and then
> > once there is a reproducer address it _or_ when there is another problem
> > check if it aligns with the output here (so that _this_ problem's origin
> > could be this). This was part of address all known chip erratas and
> > copied from omap-serial at the time so that the 8250 does not miss
> > anything.
> > Looking closer, this is still part of the omap-serial driver and it was
> > introduced in commit
> >    0003450964357 ("omap2/3/4: serial: errata i202: fix for MDR1 access")
> 
> I found that one too but it doesn't give any explanation for it either.
> In fact, the wait for empty is mysteriously missing from the itemized
> description of the workaround in the commit message.
> 
> > If someone found a way to trigger this output which is unrelated to the
> > expected cause then this is clearly not helping nor intended.
> > 
> > I would prefer to keep the loop and replace the disturbing output with a
> > comment describing _why_ the FIFO might remain non-empty after a flush.
> > 
> > In worst cases that loop causes a delay of less than 0.5ms while setting
> > a baud rate so I doubt that this is causing a real problem.

This sounds like a safe solution for me if it's needed.

> > Either way I would like to see Tony's ACK before this is getting removed
> > as suggested in this patch.
> 
> Thanks for chimming in.
> 
> I went to do some lore searching and came across this thread (it should 
> be added with Link: tag the patch regardless of its final form):
>   https://lore.kernel.org/linux-omap/4BBF61FE.3060807@ti.com/

Nishanth, do you have any more info on checking for fifo empty here?

Regards,

Tony
