Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE268AA78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjBDOCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjBDOCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:02:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A102128B;
        Sat,  4 Feb 2023 06:02:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED7260C59;
        Sat,  4 Feb 2023 14:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6317FC433EF;
        Sat,  4 Feb 2023 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675519332;
        bh=4tevTq0ZK3e0nDQwHERVCexCjZDk0MAnrNVo/rkAtsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joVtuQRYAVX0+8t9Tme5RiGcFra0dHmP91Fsusdtx8tAA3gVYL331+8inIDQe1R7K
         g2oLr9taLiS+4od38oVeknqkd5+54Xk1nkd1RrfIre/74PbzP0WJXLIGk4nEy134Vs
         89MKJMZaXJLqGzIcsmCXEcBQoK9wDUIeO0mHajMIJ+Sis5pA9+m+D4tiORXp41lmKn
         HWnhw6Lnd7LuQaMWtmHrWMWNmNOneEEByt5BOX6bSJT/rictUO6IkR4NAozVaWFQiW
         7i7t4c074Ct/i+ySIrDIwFSXgdKMRZBqInQ9ds+5YYqN0ebKjqIPh0YByC6fMy3So1
         +GVt8Lm/LTb+w==
Date:   Sat, 4 Feb 2023 14:01:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 05/11] mfd: rk808: split into core and i2c
Message-ID: <Y95lSpUaOnbSAOIC@google.com>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-6-sebastian.reichel@collabora.com>
 <Y95jJYlqDayiaMP1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y95jJYlqDayiaMP1@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Feb 2023, Lee Jones wrote:

> On Fri, 27 Jan 2023, Sebastian Reichel wrote:
> 
> > Split rk808 into a core and an i2c part in preperation for
> > SPI support.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/clk/Kconfig                   |   2 +-
> >  drivers/input/misc/Kconfig            |   2 +-
> >  drivers/mfd/Kconfig                   |   7 +-
> >  drivers/mfd/Makefile                  |   3 +-
> >  drivers/mfd/{rk808.c => rk8xx-core.c} | 209 +++++---------------------
> >  drivers/mfd/rk8xx-i2c.c               | 200 ++++++++++++++++++++++++
> >  drivers/pinctrl/Kconfig               |   2 +-
> >  drivers/power/supply/Kconfig          |   2 +-
> >  drivers/regulator/Kconfig             |   2 +-
> >  drivers/rtc/Kconfig                   |   2 +-
> >  include/linux/mfd/rk808.h             |   6 +
> >  sound/soc/codecs/Kconfig              |   2 +-
> >  12 files changed, 256 insertions(+), 183 deletions(-)
> >  rename drivers/mfd/{rk808.c => rk8xx-core.c} (76%)
> >  create mode 100644 drivers/mfd/rk8xx-i2c.c
> 
> Looks like you completely ignored (no response / no action) my review of
> v4.  This submission is therefore not getting one!  All comments can be
> superimposed from v4.

s/v4/v5/

-- 
Lee Jones [李琼斯]
