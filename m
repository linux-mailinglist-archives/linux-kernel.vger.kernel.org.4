Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2113962C06E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiKPOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiKPOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:02:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AF326F2;
        Wed, 16 Nov 2022 05:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8F961E1E;
        Wed, 16 Nov 2022 13:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0414BC433C1;
        Wed, 16 Nov 2022 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668607128;
        bh=spBy13TF3IPkg/f7DCG3EN7Jrcv6GTnctHUcUhR7QXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zdayrm3SZ8At2BbfoF05zcIkXocTTOEJ2JFgzSojUcCsWgwtyVfbMMqKKNXJIDq6f
         LxMGrFWdJAZ3zaOOH1osaqXMn6gtRY02nW7F2A6LwNf6QQKwYUZz+MA0Uf2jQBvY4D
         SZ0aGaWYXsW8TNm4GNwAP0mnlvaItfAnuU3622G3xTL2iC/PzFhLETmSFomFjvc1K3
         Cgvk/2oyCR50uHeRGCI+dGWWKoj9II/OymxmzGAiGdA6mUapSlIYSh52gdA5bvXI6x
         BirJaT5rKdh3pUG3mBzMfpDlS4dYUMCn9WpXG3QRd438DewmxBU4gyfc3gUPeIl4z/
         GYbyDSiyy/KSw==
Date:   Wed, 16 Nov 2022 13:58:39 +0000
From:   Lee Jones <lee@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Neanne <jneanne@baylibre.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, tony@atomide.com, vigneshr@ti.com,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com, afd@ti.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Message-ID: <Y3Tsj2H2ihmTWy5R@google.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-5-jneanne@baylibre.com>
 <7hr0y395ea.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7hr0y395ea.fsf@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022, Kevin Hilman wrote:

> Hi Lee,
> 
> Jerome Neanne <jneanne@baylibre.com> writes:
> 
> > The TPS65219 is a power management IC PMIC designed to supply a wide
> > range of SoCs in both portable and stationary applications. Any SoC can
> > control TPS65219 over a standard I2C interface.
> >
> > It contains the following components:
> > - Regulators.
> > - Over Temperature warning and Shut down.
> > - GPIOs
> > - Multi Function Pins (MFP)
> > - power-button
> >
> > This patch adds support for tps65219 PMIC. At this time only
> > the functionalities listed below are made available:
> >
> > - Regulators probe and functionalities
> > - warm and cold reset support
> > - SW shutdown support
> > - Regulator warnings via IRQs
> > - Power-button via IRQ
> >
> > Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Acked-for-mfd-by: Lee Jones <lee@kernel.org>
> 
> You've ack'd this for mfd, and Dmitry acked the input one (PATCH 5/6)
> but suggested it be merged via the mfd tree.
> 
> Could you please take patches 4 & 5 of this series? Then the DT
> patch can go via arm-soc.

Yep.  It's on the list.  Please bear with me as a process it.

-- 
Lee Jones [李琼斯]
