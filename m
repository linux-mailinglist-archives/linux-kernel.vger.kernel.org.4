Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8068AA5B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBDNxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjBDNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:53:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C0516AF7;
        Sat,  4 Feb 2023 05:53:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33FCEB80AC0;
        Sat,  4 Feb 2023 13:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D70C433EF;
        Sat,  4 Feb 2023 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675518779;
        bh=SBmLBfbPwmxMq1JunLKNGqJ1Bg0KuqBM2RCdrwTq2f0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1siZoUCWHvsI1gm4KBlpR5GVlfW0Lv/noX57QpCfnPyIVioS8qF3mvjMxZ13UDh3
         IDTs66nEqbYrUbXDISefcBayDN+LKWn131pcTJ38A2d3hk/yc83kLLL61OgDvPjEdp
         rQcJ0qv8nqYQJuEj8UW4rXBX5ezx/nxd2i5//MFVB6q0nP5bbqCfmuYwcOV6JHKZck
         NHg66tGHP8n0Z4WQfMEzBrWRewrcbVIbtFc9Kq34wrCTVeSOSt8lY4dHfuSjOGPkyG
         BRf78chuuAsNNsnZO9KY5VEdV6ijQ4cmJ9nFg+LE2IediO9ie0cv0MVZqhNLOlfn/A
         bGn6XczXC6q8A==
Date:   Sat, 4 Feb 2023 13:52:37 +0000
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
Message-ID: <Y95jJYlqDayiaMP1@google.com>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127181244.160887-6-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023, Sebastian Reichel wrote:

> Split rk808 into a core and an i2c part in preperation for
> SPI support.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/clk/Kconfig                   |   2 +-
>  drivers/input/misc/Kconfig            |   2 +-
>  drivers/mfd/Kconfig                   |   7 +-
>  drivers/mfd/Makefile                  |   3 +-
>  drivers/mfd/{rk808.c => rk8xx-core.c} | 209 +++++---------------------
>  drivers/mfd/rk8xx-i2c.c               | 200 ++++++++++++++++++++++++
>  drivers/pinctrl/Kconfig               |   2 +-
>  drivers/power/supply/Kconfig          |   2 +-
>  drivers/regulator/Kconfig             |   2 +-
>  drivers/rtc/Kconfig                   |   2 +-
>  include/linux/mfd/rk808.h             |   6 +
>  sound/soc/codecs/Kconfig              |   2 +-
>  12 files changed, 256 insertions(+), 183 deletions(-)
>  rename drivers/mfd/{rk808.c => rk8xx-core.c} (76%)
>  create mode 100644 drivers/mfd/rk8xx-i2c.c

Looks like you completely ignored (no response / no action) my review of
v4.  This submission is therefore not getting one!  All comments can be
superimposed from v4.

-- 
Lee Jones [李琼斯]
