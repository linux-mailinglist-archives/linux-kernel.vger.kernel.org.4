Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0007C5ED8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiI1JYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiI1JYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:24:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E53ED74DF;
        Wed, 28 Sep 2022 02:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B01DACE1DF1;
        Wed, 28 Sep 2022 09:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82805C433C1;
        Wed, 28 Sep 2022 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664357030;
        bh=9Y7blUAL5zN9+EQU3Z3W3p8hWMps5aDqv5Tab1GFLWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKKOYjthvdVJdkp/WgUPyyIY6j5diqFOr36p4LlYd98uxj1Y9e/lUHtbTqi98vgyQ
         KbRS16fpU145hd3vMZQdmELdiDLMGpX8oUnpC6Y7HhKrvI+DAXOp1Tm9DK0N44XL80
         mdFstae3oCw2JsYi4Sw3KJbhe3HwkElht+CJ4kpn9MhojQ2oiyppWZXSjQeRYlrQSX
         BKyF327yD4FFDPGj+fuNVpeUQ4KPGVY5bXC1MfKLj2L6YNGIBOhJkk3hHOjFVVmLNb
         qweGNfgGyDXDw0TL9Gsif0eqTs8PORFJji2tzGF6cr8+tGLT3NT8J+3GJZe5BvY+uS
         EHNa/rwudrMgw==
Date:   Wed, 28 Sep 2022 10:23:42 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        ChiaEn Wu <peterwu.pub@gmail.com>, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 3/5] iio: adc: mt6370: Add MediaTek MT6370 support
Message-ID: <YzQSnuwPjzJIgsYq@google.com>
References: <cover.1663926551.git.chiaen_wu@richtek.com>
 <9bf36f09bc5f002f2b09b7cc26edccf109516465.1663926551.git.chiaen_wu@richtek.com>
 <20220924155525.5663bed8@jic23-huawei>
 <YzFY5FI0PrZqdAiZ@google.com>
 <CAL_JsqKKJGtacbzGqCupFniSGha610L1cay2V+AK8vehTA=F=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKKJGtacbzGqCupFniSGha610L1cay2V+AK8vehTA=F=g@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022, Rob Herring wrote:

> On Mon, Sep 26, 2022 at 2:46 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Sat, 24 Sep 2022, Jonathan Cameron wrote:
> >
> > > On Fri, 23 Sep 2022 10:51:24 +0800
> > > ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > >
> > > > From: ChiaEn Wu <chiaen_wu@richtek.com>
> > > >
> > > > MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> > > > with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> > > > driver, display bias voltage supply, one general purpose LDO, and the
> > > > USB Type-C & PD controller complies with the latest USB Type-C and PD
> > > > standards.
> > > >
> > > > Add support for the MT6370 ADC driver for system monitoring, including
> > > > charger current, voltage, and temperature.
> > > >
> > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > >
> > > This will have to either wait for next cycle, or go through mfd because
> > > of the dt-bindings include which is in the mfd tree.
> > >
> > > Please make those dependencies clear in new versions.
> >
> > If the bindings come together in -next, then subsequently in Mainline,
> > it shouldn't really matter.
> 
> Except that the bindings haven't come together and at this point may
> not for 6.1. linux-next has been warning for weeks because the child
> device schemas haven't been applied. I've said it before, all the
> schemas for MFD devices need to be applied together. Or at least the
> MFD schema needs to get applied last.
> 
> Furthermore, subsequent versions of this don't get tested and we end
> up with more warnings[1].
> 
> It's only your IIO tree that the DT
> > tooling with complain about, right?
> 
> And the MFD tree...
> 
> Please apply the LED bindings (patches 1 and 2) so we can get the
> existing warnings fixed and address any new warnings.

Who usually applies LED bindings?  Looks as though they're good to go.

-- 
Lee Jones [李琼斯]
