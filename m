Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0676EEF32
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjDZHUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbjDZHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:20:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1953130F1;
        Wed, 26 Apr 2023 00:19:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 39DF680AF;
        Wed, 26 Apr 2023 07:19:12 +0000 (UTC)
Date:   Wed, 26 Apr 2023 10:19:10 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230426071910.GE14287@atomide.com>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux>
 <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
 <20230425212040.5a4d5b09@aktux>
 <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
 <20230425215848.247a936a@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425215848.247a936a@aktux>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andreas Kemnade <andreas@kemnade.info> [230425 19:58]:
> On Tue, 25 Apr 2023 22:36:37 +0300
> Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> 
> > On Tue, Apr 25, 2023 at 09:20:40PM +0200, Andreas Kemnade wrote:
> > > Aaro Koskinen <aaro.koskinen@iki.fi> wrote:  
> > > > Which commit introduced that regression? Also, the changelog mentions
> > > > it happens only with "unusual" probe order. Now, all the ordinary cases
> > > > for OMAP1 are broken.
> > > >   
> > > did not bisect that to an exact commit.
> > > Unusual probe order: on the device where I tested it,
> > > I did not see a completely successful probe.  
> > 
> > If you cannot point out a working past commit, there was no regression. If
> > you fix something that hasn't worked before or has been long time broken,
> > it must not cause breakage to other current users.
> > 
> Well, I did not take the time for a bisect. As we need a less aggressive
> fix, it seems to be worth doing it. 
> 
> > > > And it's not just that tps65010 thing. E.g. 770 fails to boot as well
> > > > and it doesn't use it; and reverting 92bf78b33b0b fixes that one as
> > > > well. AFAIK it's because all the gpio_request()s in OMAP1 board files
> > > > stopped now working.
> > > >   
> > > so we break every non-devicetree user of omap-gpio?   
> > 
> > It seems so.
> > 
> or maybe an if (not_using_devicetree())

Not sure what the best way to fix this might be, adding Linus W to Cc too.
Maybe using gpio line names in the legacy platform data instead of numbers?

Seems that we should just revert this patch for now and try again after
the issues have been fixed.

Regards,

Tony
