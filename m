Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7A5E9B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiIZHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiIZHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250E436DCB;
        Mon, 26 Sep 2022 00:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C586617DE;
        Mon, 26 Sep 2022 07:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A275C433C1;
        Mon, 26 Sep 2022 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178412;
        bh=FFVR//93gG0gyZZ/mzwulA0RcoMAWf0wqpd/J/L7u/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcPQPtxo4w7mrkmPUWj6qtpiX7DTvbaFFPeRTn40kuQ3Qfy1FCiDhqmZZwdr1NRXo
         fjqpRNhGlWVsZMZTGYhfX9CYdi5iumzxa0ZT+zR0n0UMwo4j67CqrXaSRO8PBNoYC8
         6BWEptTmb/sQkhdRjmPCd3Ho1U5HEg2laBzXyxuDPiCIbC7ZMB74QGLnUrsh9CNJNQ
         IQ9RkhR51eopx1nNbJmXlwow4CUZiAp7ERREoc309jUS39b2kEkgtupaRPA3amU7FT
         jmzcceTCuFedxAFv6aSOuL5YiaKdStYihptYsz657WxAjjek+dXxC2FD6aIkC3S646
         t2vbsmkbyI34Q==
Date:   Mon, 26 Sep 2022 08:46:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 3/5] iio: adc: mt6370: Add MediaTek MT6370 support
Message-ID: <YzFY5FI0PrZqdAiZ@google.com>
References: <cover.1663926551.git.chiaen_wu@richtek.com>
 <9bf36f09bc5f002f2b09b7cc26edccf109516465.1663926551.git.chiaen_wu@richtek.com>
 <20220924155525.5663bed8@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924155525.5663bed8@jic23-huawei>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022, Jonathan Cameron wrote:

> On Fri, 23 Sep 2022 10:51:24 +0800
> ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> 
> > From: ChiaEn Wu <chiaen_wu@richtek.com>
> > 
> > MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> > with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> > driver, display bias voltage supply, one general purpose LDO, and the
> > USB Type-C & PD controller complies with the latest USB Type-C and PD
> > standards.
> > 
> > Add support for the MT6370 ADC driver for system monitoring, including
> > charger current, voltage, and temperature.
> > 
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> This will have to either wait for next cycle, or go through mfd because
> of the dt-bindings include which is in the mfd tree.
> 
> Please make those dependencies clear in new versions.

If the bindings come together in -next, then subsequently in Mainline,
it shouldn't really matter.  It's only your IIO tree that the DT
tooling with complain about, right?

-- 
Lee Jones [李琼斯]
