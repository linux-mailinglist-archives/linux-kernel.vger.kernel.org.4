Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC78862D9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiKQLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiKQLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:53:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84D1141;
        Thu, 17 Nov 2022 03:53:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC58261303;
        Thu, 17 Nov 2022 11:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B06DC433D6;
        Thu, 17 Nov 2022 11:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685994;
        bh=ShqTe1CG2H2vpLDKDFV7iYYR2HXYxDuYRyuDgEafb10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1BvFloj9U+G4l3s5fB0S3s6wd9nDJWAKF9jgAlxVb07mREgj3TvGzY/NFV8OQxDI
         55Ub+0cRUU+qG0C85Dh85mLvCZWM+4jKMrHQuP/F+tLn/3OX9E4w08s1R+ENbD6bZz
         nR/LKmEs0o2k8PNPS1J10WpjgmXNOJWSpVJut5I55oLwVhYUuqjOqcLTT4UV1F+iTh
         37hpbCxE3i+x2o2Pt5HW0ezQEKQxFff/cJ84NhJkVuZtmrHKMky4DefsVUfZwrg/mw
         oFrLaOuNUPV3LKC8JOONjknV4SCwOcSFMS7jYQPGQya54TdZrVxUdcstunUlmUi71c
         XuASjz1yeh7BA==
Date:   Thu, 17 Nov 2022 11:53:05 +0000
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
Subject: Re: [PATCH v7 5/6] Input: Add tps65219 interrupt driven powerbutton
Message-ID: <Y3YgocGss54KIMRi@google.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-6-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104152311.1098603-6-jneanne@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Nov 2022, Jerome Neanne wrote:

> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> TPS65219 has different interrupts compared to other TPS6521* chips.
> TPS65219 defines two interrupts for the powerbutton one for push and one
> for release.
> 
> This driver is very simple in that it maps the push interrupt to a key
> input and the release interrupt to a key release.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Please feel free to merge through MFD tree.
> ---
>  drivers/input/misc/Kconfig              |  10 ++
>  drivers/input/misc/Makefile             |   1 +
>  drivers/input/misc/tps65219-pwrbutton.c | 148 ++++++++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/input/misc/tps65219-pwrbutton.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
