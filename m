Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DD870315F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbjEOPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242306AbjEOPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:19:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD68213D;
        Mon, 15 May 2023 08:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70E361F0D;
        Mon, 15 May 2023 15:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EACC433D2;
        Mon, 15 May 2023 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684163962;
        bh=gSsz0TtD4VwTX5/SiNoopUYE4KqZEhjXfngLTmzZtnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouzHOk/POs9ihJcT5jFuJ6wSQyvQoWmvcGhchKiEzE3/u7VdNW5LhXOeMvXNtWLLT
         qhAO0Zm/NfpDzvKxhkwJuxIB469P+0Js2+GVsYtInOEuD7lP+1NuOk0Xhe6+KaxAq5
         oQjmRI8u8LP0jfSYjMz9FHNzdSqhV4e9v4LzQAWHXX4QNbNApPglidaC4l+Cmfsu05
         A7IiznSHmy/BzxEfZX3skPaDdgNCSr8lGkl9RVaD1mntvZm5Gr9r612ek+m3B/33bz
         nakja/e5O8nvBtgmi8Z5lQHYNAbW9gEjNdQSVAjrM3Ejn8AcM76uaOsOdH19G4bvXL
         83OxEBEDZtT0Q==
Date:   Mon, 15 May 2023 16:19:14 +0100
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
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH v8 05/14] mfd: rk808: split into core and i2c
Message-ID: <20230515151914.GQ10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-6-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023, Sebastian Reichel wrote:

> Split rk808 into a core and an i2c part in preparation for
> SPI support.
> 
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com> # for RTC
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
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

Applied, thanks

-- 
Lee Jones [李琼斯]
