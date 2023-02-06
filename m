Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6BE68C617
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBFSrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBFSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:47:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AD059D7;
        Mon,  6 Feb 2023 10:47:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A0B3B815D1;
        Mon,  6 Feb 2023 18:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6987CC433D2;
        Mon,  6 Feb 2023 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675709250;
        bh=QBQbut+dS9DWWb7cU2SLLEmpT5wVs6vyJKlsVYbSx5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N35UigjewuSkXwfDWjd3Fs4r+fvjjuqkXTuNIVyYAcbcvr9GONO0uIwCQtnwNJtIz
         hqgHuxEsCZyiaKYW2jD/3IhLJef33P2YlM8wk56MRo2EDT6eo+hsf4m+n3C235C+Xi
         YmP530h/A1VRbrhbk94oDaYFN96R7k/br27z+8I5b2BZ4fmrb9O5bEGQS5sV1Qz1rp
         HECf4i8IxBYW/14Rt+dxz12ltQsrC75xCbjrLdXUJm2Z419JdQaJdtqKHMaSxr+r8H
         pze5Rh+nSoCQWbo389i7imDSUuCs1CgLXsWvN+lhx1lofws32ONzw0z28imyXVCCW2
         McqZbAWYOFF0w==
Date:   Mon, 6 Feb 2023 10:47:28 -0800
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
Message-ID: <Y+FLQL08U7wXjqi+@google.com>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-6-sebastian.reichel@collabora.com>
 <Y95jJYlqDayiaMP1@google.com>
 <Y95lSpUaOnbSAOIC@google.com>
 <20230205010632.wt5m3a7w7k62w6se@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230205010632.wt5m3a7w7k62w6se@mercury.elektranox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Feb 2023, Sebastian Reichel wrote:

> Hi Lee,
> 
> On Sat, Feb 04, 2023 at 02:01:46PM +0000, Lee Jones wrote:
> > On Sat, 04 Feb 2023, Lee Jones wrote:
> > > On Fri, 27 Jan 2023, Sebastian Reichel wrote:
> > > > Split rk808 into a core and an i2c part in preperation for
> > > > SPI support.
> > > > 
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > >  drivers/clk/Kconfig                   |   2 +-
> > > >  drivers/input/misc/Kconfig            |   2 +-
> > > >  drivers/mfd/Kconfig                   |   7 +-
> > > >  drivers/mfd/Makefile                  |   3 +-
> > > >  drivers/mfd/{rk808.c => rk8xx-core.c} | 209 +++++---------------------
> > > >  drivers/mfd/rk8xx-i2c.c               | 200 ++++++++++++++++++++++++
> > > >  drivers/pinctrl/Kconfig               |   2 +-
> > > >  drivers/power/supply/Kconfig          |   2 +-
> > > >  drivers/regulator/Kconfig             |   2 +-
> > > >  drivers/rtc/Kconfig                   |   2 +-
> > > >  include/linux/mfd/rk808.h             |   6 +
> > > >  sound/soc/codecs/Kconfig              |   2 +-
> > > >  12 files changed, 256 insertions(+), 183 deletions(-)
> > > >  rename drivers/mfd/{rk808.c => rk8xx-core.c} (76%)
> > > >  create mode 100644 drivers/mfd/rk8xx-i2c.c
> > > 
> > > Looks like you completely ignored (no response / no action) my review of
> > > v4.  This submission is therefore not getting one!  All comments can be
> > > superimposed from v4.
> > 
> > s/v4/v5/
> 
> not sure what you are talking about. I dropped the PM wrappers and
> added a new patch moving the driver to use OF match. There were no
> other comments as far as I can tell. Did I miss a second mail with
> more comments?

Ah, the driver was split *then* you implemented my suggestions.

That's not what I was expecting, but is also valid.

Very well, ignore my last - this set is back in my to-review queue.

-- 
Lee Jones [李琼斯]
