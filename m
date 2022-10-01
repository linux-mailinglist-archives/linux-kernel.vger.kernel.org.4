Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F7C5F1E43
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJARLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJARLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 13:11:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE65A882;
        Sat,  1 Oct 2022 10:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 520BDB8076E;
        Sat,  1 Oct 2022 17:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392F2C433D6;
        Sat,  1 Oct 2022 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664644266;
        bh=8/44+tCSDFyhjA92zaYauwO92/g0g3Xh1rsDr7QVWcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qmheUtIfr5JybckX7f7bA9Sd3Py8wBG14xJCadq/+nk6NPIk5qQI/rioK0VZT9Ou3
         qLzTCn/nLQAlNGDG6JpXFxnVCavpzpB2/OvcNreWI6yqLH9LIKn8rjUs/6cTHgI++k
         9D58XicM9lDLXIcDIywsUITbNqDeKwLeGntsiHqKNaAp+doEnWZaEhD637mab7dlux
         OwMPtsOK9QULS9GD6Tlcy+qKFSkh+Ojg4eoi6EDB3ymwYDjsXT/2Bpaed0JnB5LB4F
         mov9I9irgRKH0x6IfWtrvmD/hFKht/ZbdV7jcHjeQITd2EMzJTxQRQEQ+059ise5pA
         P5Ks5UgL1YkRg==
Date:   Sat, 1 Oct 2022 18:11:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, ChiaEn Wu <peterwu.pub@gmail.com>,
        pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
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
Message-ID: <20221001181117.7b3f3297@jic23-huawei>
In-Reply-To: <YzXbJM31s0P0nLD5@google.com>
References: <cover.1663926551.git.chiaen_wu@richtek.com>
        <9bf36f09bc5f002f2b09b7cc26edccf109516465.1663926551.git.chiaen_wu@richtek.com>
        <20220924155525.5663bed8@jic23-huawei>
        <YzFY5FI0PrZqdAiZ@google.com>
        <CAL_JsqKKJGtacbzGqCupFniSGha610L1cay2V+AK8vehTA=F=g@mail.gmail.com>
        <YzQSnuwPjzJIgsYq@google.com>
        <20220929163418.GA2270491-robh@kernel.org>
        <YzXbJM31s0P0nLD5@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 18:51:32 +0100
Lee Jones <lee@kernel.org> wrote:

> On Thu, 29 Sep 2022, Rob Herring wrote:
> 
> > On Wed, Sep 28, 2022 at 10:23:42AM +0100, Lee Jones wrote:  
> > > On Mon, 26 Sep 2022, Rob Herring wrote:
> > >   
> > > > On Mon, Sep 26, 2022 at 2:46 AM Lee Jones <lee@kernel.org> wrote:  
> > > > >
> > > > > On Sat, 24 Sep 2022, Jonathan Cameron wrote:
> > > > >  
> > > > > > On Fri, 23 Sep 2022 10:51:24 +0800
> > > > > > ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > > > > >  
> > > > > > > From: ChiaEn Wu <chiaen_wu@richtek.com>
> > > > > > >
> > > > > > > MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> > > > > > > with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> > > > > > > driver, display bias voltage supply, one general purpose LDO, and the
> > > > > > > USB Type-C & PD controller complies with the latest USB Type-C and PD
> > > > > > > standards.
> > > > > > >
> > > > > > > Add support for the MT6370 ADC driver for system monitoring, including
> > > > > > > charger current, voltage, and temperature.
> > > > > > >
> > > > > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>  
> > > > > >
> > > > > > This will have to either wait for next cycle, or go through mfd because
> > > > > > of the dt-bindings include which is in the mfd tree.
> > > > > >
> > > > > > Please make those dependencies clear in new versions.  
> > > > >
> > > > > If the bindings come together in -next, then subsequently in Mainline,
> > > > > it shouldn't really matter.  
> > > > 
> > > > Except that the bindings haven't come together and at this point may
> > > > not for 6.1. linux-next has been warning for weeks because the child
> > > > device schemas haven't been applied. I've said it before, all the
> > > > schemas for MFD devices need to be applied together. Or at least the
> > > > MFD schema needs to get applied last.
> > > > 
> > > > Furthermore, subsequent versions of this don't get tested and we end
> > > > up with more warnings[1].
> > > > 
> > > > It's only your IIO tree that the DT  
> > > > > tooling with complain about, right?  
> > > > 
> > > > And the MFD tree...
> > > > 
> > > > Please apply the LED bindings (patches 1 and 2) so we can get the
> > > > existing warnings fixed and address any new warnings.  
> > > 
> > > Who usually applies LED bindings?  Looks as though they're good to go.  
> > 
> > Pavel. The issue would be I don't know if the driver side is ready and 
> > those usually go together. Other than my complaining here, how's he 
> > supposed to know that the bindings at least need to be applied?
> > 
> > Again, the process here is not working. I've said before, all the 
> > bindings for an MFD need to go via 1 tree. You obviously don't agree, so 
> > propose something. The current process of no coordination doesn't work.  
> 
> The solution would be for someone to create succinct immutable branches, like
> I do for real code.  If someone would be happy to do that, I'd be more than
> happy to pull from them.
> 
> I go to the effort of creating them to prevent actual build breakages,
> however doing so to keep a documentation helper script happy is a step
> too far for me personally, sorry.
> 

In this case the bindings include is included from the driver - not just the
binding.  Obviously there are dances to get around that by using the values
and replacing in following cycle, but that's not the case here!

Jonathan

