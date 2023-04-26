Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707CE6EF664
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbjDZO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbjDZO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ED57286;
        Wed, 26 Apr 2023 07:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 052CB62DDF;
        Wed, 26 Apr 2023 14:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765A3C433D2;
        Wed, 26 Apr 2023 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682519265;
        bh=Tl4ahZpkXgA0RLxXwHHiJ4Q1ElnebSYGSLsHuGHWOpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgyUIf8Jg5Vrio4F/n6rOGUZO05RRGYSSrKLrqhzzClCIkRqrA7jEdk7/7KkbYEv7
         SOGggQb9aryRD/28pH6NzyJQqRYvDx76Yb8U2yNR/0ocgBBjdK9x56DCZHq3kOd9Dy
         sB9iaE1g21iRJergm/PuKhr+/p8iZeUK4u/XqjVamzIN6PJDGHunznvaTneskG9Ykf
         JNexncDHELPyj/RQ5Dxg2YnqZrkFnNwjkjuSBjNCc3moiRY4P44yt3PaFMX/o58Xdw
         3lEWKx/dzaO/WxBxoGdpqum2Ru4mjPrxD/7T643j2XZpcEe65v/aYs0KLKhJIk1LJP
         olYxUanBe5LNg==
Date:   Wed, 26 Apr 2023 15:27:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andre.przywara@arm.com, conor.dooley@microchip.com
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
Message-ID: <20230426142740.GN50521@google.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023, Shengyu Qu wrote:

> The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
> via an I2C bus.
> 
> Describe the regmap and the MFD bits, along with the registers exposed
> via I2C. Eventually advertise the device using a new compatible string
> and add support for power off the system.
> 
> The driver would disable PEK function if IRQ is not configured in device
> tree, since some boards (For example, Starfive Visionfive 2) didn't
> connect IRQ line of PMIC to SOC.
> 
> GPIO function isn't enabled in this commit, since its configuration
> operation is different from any existing AXP PMICs and needs
> logic modification on existing driver. GPIO support might come in later
> patches.
> 
> ---

You must not use these above the tags or Git will drop them.

> Changes since v2:
>  - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
>  - Add axp_regulator_only_cells rather than directly using axp806_cells
>    for cases that IRQ line isn't connected.
> 
> Changes since v1:
>  - Nothing
> 
> [1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---

Put change-logs here instead.

>  drivers/mfd/axp20x-i2c.c   |   2 +
>  drivers/mfd/axp20x.c       | 107 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h |  85 +++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+)

I manually added the missing tags for this and the DT patch and applied.

-- 
Lee Jones [李琼斯]
