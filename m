Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD66AB719
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCFHba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCFHb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:31:26 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03E181E1F6;
        Sun,  5 Mar 2023 23:31:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5D1AC8027;
        Mon,  6 Mar 2023 07:31:25 +0000 (UTC)
Date:   Mon, 6 Mar 2023 09:31:24 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 15/17] gpio: omap: Convert to immutable irq_chip
Message-ID: <20230306073124.GC7501@atomide.com>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
 <20230215-immutable-chips-v1-15-51a8f224a5d0@linaro.org>
 <Y+8xkV5aUrAajLNP@atomide.com>
 <20230217173108.1448ce92@aktux>
 <20230306072852.GB7501@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306072852.GB7501@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230306 07:28]:
> * Andreas Kemnade <andreas@kemnade.info> [230217 16:31]:
> > On Fri, 17 Feb 2023 09:49:37 +0200
> > Tony Lindgren <tony@atomide.com> wrote:
> > 
> > > Hi,
> > > 
> > > * Linus Walleij <linus.walleij@linaro.org> [230216 09:38]:
> > > > Convert the driver to immutable irq-chip with a bit of
> > > > intuition.
> > > > 
> > > > This driver require some special care: .irq_ack() was copied
> > > > from dummy_irq_chip where it was defined as noop. This only
> > > > makes sense if using handle_edge_irq() that will unconditionally
> > > > call .irq_ack() to avoid a crash, but this driver is not ever
> > > > using handle_edge_irq() so just avoid assigning .irq_ack().
> > > > 
> > > > A separate chip had to be created for the non-wakeup instance.  
> > > 
> > > Nice, works for me.
> > > 
> > > BTW, I still see these warnings remaining on boot:
> > > 
> > > gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
> > > 
> > > Seems like we might be able to get rid of those too now or are
> > > there still some dependencies with /sys/class/gpio for example?
> > > 
> > on what are you testing? on -next? I thought I have fixed theese warning with
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=92bf78b33b0b463b00c6b0203b49aea845daecc8
> 
> You're right, sorry looks like I pasted the wrong line from the dmesg
> output :)
> 
> I intended to paste this example instead of the static allocation line:
> 
> gpio gpiochip1: (gpio-32-63): not an immutable chip, please consider fixing it!

Hmm, nope, sorry it seems I was just confused between two patches.
Hopefully all the gpio warnings will be gone with this $subject patch
applied.

Regards,

Tony
