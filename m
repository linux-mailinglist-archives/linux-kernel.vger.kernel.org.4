Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B323967FBF3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 01:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjA2ARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 19:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2ARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 19:17:35 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342F23111
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 16:17:32 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pLvNx-0005R3-3D;
        Sun, 29 Jan 2023 01:17:30 +0100
Date:   Sun, 29 Jan 2023 00:17:20 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: apply reg_base and reg_downshift for single
 register ops
Message-ID: <Y9W7EHQUVQOL7Yv/@makrotopia.org>
References: <5355a99496d764a7918f0eaf801fab7c9a3f5a98.1674875341.git.daniel@makrotopia.org>
 <Y9WAPBYaLMsCbQN6@euler>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9WAPBYaLMsCbQN6@euler>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Sat, Jan 28, 2023 at 12:06:20PM -0800, Colin Foster wrote:
> Hi Daniel,
> 
> On Sat, Jan 28, 2023 at 03:10:01AM +0000, Daniel Golle wrote:
> > reg_base and reg_downshift currently don't have any effect if used with
> > simple single register operations.
> > 
> > Fix that by taking them into account also for _reg_read, _reg_write and
> > _reg_update_bits (they may still be missing also in other place, eg.
> > page selection code).
> > 
> > Fixes: 0074f3f2b1e43d ("regmap: allow a defined reg_base to be added to every address")
> > Fixes: 86fc59ef818beb ("regmap: add configurable downshift for addresses")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/base/regmap/regmap.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> > index d12d669157f24..7b8386ec21b8c 100644
> > --- a/drivers/base/regmap/regmap.c
> > +++ b/drivers/base/regmap/regmap.c
> > @@ -1986,6 +1986,8 @@ int _regmap_write(struct regmap *map, unsigned int reg,
> >  		}
> >  	}
> >  
> > +	reg += map->reg_base;
> > +	reg >>= map->format.reg_downshift;
> >  	ret = map->reg_write(context, reg, val);
> >  	if (ret == 0) {
> >  		if (regmap_should_log(map))
> > @@ -2879,6 +2881,8 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
> >  	if (!regmap_readable(map, reg))
> >  		return -EIO;
> >  
> > +	reg += map->reg_base;
> > +	reg >>= map->format.reg_downshift;
> 
> Something more subtle is going on.
> 
> Here's a stack dump from a write and a read:
> 
> [    3.238249]  dump_backtrace from show_stack+0x20/0x24
> [    3.243349]  r7:c3a27c00 r6:00000000 r5:c17aa2d8 r4:60000113
> [    3.249034]  show_stack from dump_stack_lvl+0x60/0x78
> [    3.254121]  dump_stack_lvl from dump_stack+0x18/0x1c
> [    3.259208]  r7:c3a27c00 r6:c3a5a400 r5:00000007 r4:c1e64d5c
> [    3.264892]  dump_stack from ocelot_spi_regmap_bus_write+0x9c/0xa8
> [    3.271113]  ocelot_spi_regmap_bus_write from _regmap_raw_write_impl+0x60c/0x8b8
> [    3.278555]  r7:00000000 r6:c3a5a403 r5:c1dfe160 r4:c3a1ba00
> [    3.284239]  _regmap_raw_write_impl from _regmap_bus_raw_write+0x7c/0xa0
> [    3.290982]  r10:df9bd164 r9:df9bd164 r8:c3a1ba00 r7:00000000 r6:00000000 r5:00000000
> [    3.298847]  r4:c3a1ba00
> [    3.301391]  _regmap_bus_raw_write from _regmap_write+0x64/0x174
> [    3.307448]  r6:00000000 r5:00000000 r4:c3a1ba00
> [    3.312085]  _regmap_write from regmap_write+0x4c/0x6c
> [    3.317263]  r9:df9bd164 r8:c1d9e1e0 r7:00000000 r6:00000000 r5:00000000 r4:c3a1ba00
> [    3.325040]  regmap_write from ocelot_spi_initialize+0x44/0xc0
> [    3.330910]  r7:00000000 r6:c1da1904 r5:c3a58d40 r4:c3a58d40
> [    3.336595]  ocelot_spi_initialize from ocelot_spi_probe+0x9c/0x178
> 
> 
> [    3.753685]  dump_backtrace from show_stack+0x20/0x24
> [    3.758777]  r7:00000004 r6:00000000 r5:c17aa2d8 r4:60000113
> [    3.764462]  show_stack from dump_stack_lvl+0x60/0x78
> [    3.769547]  dump_stack_lvl from dump_stack+0x18/0x1c
> [    3.774633]  r7:00000004 r6:c3a5a403 r5:c1e64d5c r4:c3a27c00
> [    3.780317]  dump_stack from ocelot_spi_regmap_bus_read+0x144/0x150
> [    3.786623]  ocelot_spi_regmap_bus_read from _regmap_raw_read+0x114/0x2d4
> [    3.793455]  r9:df9bd164 r8:c1dfe160 r7:c3a5a403 r6:00000004 r5:c3a1ba00 r4:c0a84140
> [    3.801232]  _regmap_raw_read from _regmap_bus_read+0x54/0x80
> [    3.807016]  r10:df9bd164 r9:df9bd164 r8:c1d9e1e0 r7:e0055ab8 r6:c3a5a403 r5:00000004
> [    3.814881]  r4:c3a1ba00
> [    3.817425]  _regmap_bus_read from _regmap_read+0x70/0x190
> [    3.822952]  r7:e0055ab8 r6:c3a1ba00 r5:00000004 r4:c3a1ba00
> [    3.828635]  _regmap_read from regmap_read+0x4c/0x6c
> [    3.833642]  r10:df9bd164 r9:df9bd164 r8:c1d9e1e0 r7:00000000 r6:e0055ab8 r5:00000004
> [    3.841508]  r4:c3a1ba00 r3:c21fc700
> [    3.845098]  regmap_read from ocelot_spi_initialize+0xa0/0xc0
> [    3.850886]  r7:00000000 r6:c1da1904 r5:c3a58d40 r4:00000001
> [    3.856570]  ocelot_spi_initialize from ocelot_spi_probe+0x9c/0x178
> 
> 
> So applying this in both _regmap_write and _regmap_raw_write_impl cause
> the operations to happen twice. Similarly with _regmap_read and
> _regmap_raw_read.

Ok, so I'll need another way to address this. Will dig more ;)

> Rewinding my brain back a year - I also didn't want to tamper with the
> reg value before any cache checks. Those operations are at the very end
> of the processing chain. In my scenario, I'm getting a 4-byte register
> at address 0x4. The fact that it needs to go out a SPI bus as 0x1
> shouldn't change any other logic in the system.
> 
> And my other _main_ motivation was to use bus reads, so that bulk
> transfers were possible. My initial implementations didn't use the bus
> interface, so I did all address manipulation in my custom read / write
> functions. Bulk transfers offered an order of magnitude improvement in
> access time.

I'm using a regmap_bus with only reg_read and reg_write functions, in
this case the value of reg_base is currently not taken into account.

> Perhaps there is some confusion due to my field description in
> include/linux/regmap.h, and it should reference "any bus operation"? Or
> something similar...

I suppose so, as that's where my expectation regarding reg_base also
being applied on regmap_read operations on e.g. regmap-mdio stem
from. I also expected reg_base base to affect the 'registers' file in
debugfs (ie. offset being applied there as well).

To get an idea what I was doing while encountering this problem, see
the top 4 commits here:

https://github.com/dangowrt/linux/commits/wip
