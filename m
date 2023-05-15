Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B33A70316A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbjEOPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbjEOPU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC151736;
        Mon, 15 May 2023 08:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0446861EBE;
        Mon, 15 May 2023 15:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A02BC433D2;
        Mon, 15 May 2023 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164052;
        bh=nxvWi/otVuWMaj62KIoDJ9818+/B5dyaNH4gjpPPa7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPS6Q07r7GinekYV3ypLQIXtnCz99RqqM7yEvIpBs8a6wFffLeK03sJb3YgGYrPdm
         O3kHwK7atvneP5N56RzyGJHfGy/CVN+f+zL1jsGByXXe3errUQ0zyb2UgW9rn7sq7Z
         09JvtctsWV8VBHULU7x095WopQQJv6BluH7aI4qc0igN0JfIZ7qp4zPOCslwlOPYeN
         zJ9y04RL2NJpyhbZJc671iM5oMm2PD+XEoMx8O6O7YM+KTd4CvVxN+3sgucpj45CgC
         i/eqRUAxlsn4xAPmpZDeB9XePaWXrrqbaufJZDx2HrjgotS7MXqF5tsaGJv7T5vn2j
         8OtrO16qQudAQ==
Date:   Mon, 15 May 2023 16:20:44 +0100
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
Subject: Re: [PATCH v8 08/14] mfd: rk8xx: add rk806 support
Message-ID: <20230515152044.GT10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-9-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-9-sebastian.reichel@collabora.com>
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

> Add support for SPI connected rk806, which is used by the RK3588
> evaluation boards. The PMIC is advertised to support I2C and SPI,
> but the evaluation boards all use SPI. Thus only SPI support is
> added here.
> 
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/Kconfig       |  14 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rk8xx-core.c  |  69 ++++++-
>  drivers/mfd/rk8xx-spi.c   | 124 ++++++++++++
>  include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 614 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/mfd/rk8xx-spi.c

Applied, thanks

-- 
Lee Jones [李琼斯]
