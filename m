Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC762C74D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiKPSL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbiKPSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:11:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF06175A;
        Wed, 16 Nov 2022 10:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BF40B81E4F;
        Wed, 16 Nov 2022 18:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE4C433D6;
        Wed, 16 Nov 2022 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668622311;
        bh=w0UO98liO5fLCNnlMHd5BQufutT9Of+UoFv/uKbaByY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAKPE3PSimsi0+eDiHvPD0qlee7GY738+lb4Z/kt+iyzopEL4vDLZBi2713YTl0LP
         Kg1W0TOqgwruvLtNRIAZeZdf+tOwkqFXGYuZTkjeF8kYL4U+1HUrwiD9Z8zcdGm76R
         4zwKh9CeSj8QWrYOZ7ll+7j7kTij7cCB7ulC/B/LXk1QAXeSP+tLmI1FHZRGW+jhY9
         E0bNNr7YN82FOI/HOt/wUjgBmdSgcQxsTlc8wz8mijzDTZZbR9RAX9FVNzdimGvy8n
         zD65CrnJ4UCifwzRNdMuOhc/yqHSdSW9A/RqKevSBiy5GSJZ2kleyAtIPxdW7Nz04i
         mJo1QaKw6/5Sw==
Date:   Wed, 16 Nov 2022 18:11:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, tony@atomide.com, vigneshr@ti.com,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com, afd@ti.com, khilman@baylibre.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Message-ID: <Y3Un36o/lACru9Kq@google.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-5-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104152311.1098603-5-jneanne@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Nov 2022, Jerome Neanne wrote:

> The TPS65219 is a power management IC PMIC designed to supply a wide
> range of SoCs in both portable and stationary applications. Any SoC can
> control TPS65219 over a standard I2C interface.
> 
> It contains the following components:
> - Regulators.
> - Over Temperature warning and Shut down.
> - GPIOs
> - Multi Function Pins (MFP)
> - power-button
> 
> This patch adds support for tps65219 PMIC. At this time only
> the functionalities listed below are made available:
> 
> - Regulators probe and functionalities
> - warm and cold reset support
> - SW shutdown support
> - Regulator warnings via IRQs
> - Power-button via IRQ
> 
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-for-mfd-by: Lee Jones <lee@kernel.org>
> ---
> 
> Notes:
>     Changes in v7:
>     Lee Jones review
>     - Kconfig nit: button that is
>     - tps65219.c, nits: '\n' x2
>     - tps65219.c, nit: { .name = "tps65219-gpios", },
>     - tps65219.h, nit: Power Management IC
>     - tps65219.h, rework header: struct tps65219
>     - tps65219.h, remove Superflous " " /* MFD_TPS65219_H */
>     - remove unused tps65219_soft_shutdown further to make W=1 check
>     Biju Das review:
>     - Remove all includes that are not mandatory
>     - Remove container_of err check
> 
>  MAINTAINERS                  |   1 +
>  drivers/mfd/Kconfig          |  14 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/tps65219.c       | 299 ++++++++++++++++++++++++++++++
>  include/linux/mfd/tps65219.h | 345 +++++++++++++++++++++++++++++++++++
>  5 files changed, 660 insertions(+)
>  create mode 100644 drivers/mfd/tps65219.c
>  create mode 100644 include/linux/mfd/tps65219.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
