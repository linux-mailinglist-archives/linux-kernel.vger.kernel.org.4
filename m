Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5763205B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiKULW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKULVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:21:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66C4BCF;
        Mon, 21 Nov 2022 03:17:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8750EB80E67;
        Mon, 21 Nov 2022 11:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA8CC433D6;
        Mon, 21 Nov 2022 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669029438;
        bh=20eHod9+LKqinzyklLfNuMaBJMnRT6ZSBVaGJSuFWFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xb41IYLaWLfLIWIarzzEUIzhTAKVERZ7VJaelCNFJYcVGm1Ko2vKxdkUqU9Thu4I9
         O9iJdHVwP3rg0xMYEQi1TlHrjkA5sUZndcyCE34TEKSXP0R/hHIrm1ZmSZQoSHOfJI
         evH0ZPb0m6s3Oc4iHPKUHKgXgnHnGuvoDrZtMnI1RseOZBPFpDkHHPRpwweM4ptaZy
         SOO4kBYyBpOq45010BTTGmwH4Cz235xdWYYi8T3P04k8y8x0vL304l1LiCJ2OxLmL/
         yAH9bWhrDsnUHvIQH3x0Ch7ma75gjMoeOTFiqzffpEvhimuin58fERanqbKr/GrNCQ
         wQ5wZACB4OhEg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ox4n9-0001Pz-Vt; Mon, 21 Nov 2022 12:16:48 +0100
Date:   Mon, 21 Nov 2022 12:16:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Second-source devices and interrupt-mapping race
Message-ID: <Y3teH14YduOQQkNn@hovoldconsulting.com>
References: <YuJXMHoT4ijUxnRb@hovoldconsulting.com>
 <CAL_JsqJJdEFspgJkJnC4jmeq+qaQjkRQU2-WTRmYVOzWrnKifQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJJdEFspgJkJnC4jmeq+qaQjkRQU2-WTRmYVOzWrnKifQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

and sorry about the late follow up. I received your reply just before my
holiday and then ended up in a bit of a rabbit hole with the Qualcomm
PHY drivers so this got put on the back burner.

On Thu, Aug 04, 2022 at 09:42:01AM -0600, Rob Herring wrote:
> On Thu, Jul 28, 2022 at 3:30 AM Johan Hovold <johan@kernel.org> wrote:

> > 2. Rob, Krzysztof, I assume that handling second-source devices by
> > enabling multiple variants in the devicetree can not be considered
> > correct?
> 
> Probably not, but there's not really any defined policy there. What
> that looks like in DT depends on the component. Displays are a common
> one and don't lend well to populating multiple in the DT. For those,
> the only solution so far is we require the 2nd source to be compatible
> with the default/1st. I think that was QCom chromebooks...
> 
> The easy answer is firmware should deal with figuring out what's
> actually there and update the DT accordingly.

Right.
 
> > What about the related case of simply non-populated devices (e.g. laptop
> > variants without a touchscreen)?
> 
> Shouldn't that just be a case of the driver not screaming if there's
> no device?

Right, that's simple, but what I'm getting at is that this is also a
case of the devicetree not describing the actual hardware. If we allow
that, does that imply that we should also allow having second-source
devices in the devicetree even if we know that at least one of them will
be non-populated?

The big difference is dealing with any "shared" resources, such has the
pinconfig and interrupt in my HID example, which would now appear to be
claimed by more than one device.

It seems we'd need some way to describe the devices as mutually
exclusive, and perhaps that's reason enough not to try to generalise the
single-non-populated-device case.

> > Note that we have at least two cases of "second-source" nodes in mainline
> > ("rtc" and "trackpad", respectively):
> >
> >         85a9efcd4e29 ("ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay")
> >         689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
> >
> > and that, for example, the i2c-hid driver explicitly supports
> > non-populated devices:
> >
> >         b3a81b6c4fc6 ("HID: i2c-hid: check if device is there before really probing")
> >
> > and the commit message indicates that this is something that Chromebooks
> > rely on.
> >
> > For the X13s, I'm not sure how we would go about to tell the variants
> > apart (the ACPI tables that Windows use include both touchpads and an
> > optional touchscreen). In the end, the boot firmware might need to
> > resort to a similar kind of probing if we don't allow the kernel to do
> > it.
> >
> > Finally, note that while disabling async probing for "second-source"
> > nodes (e.g. if we could mark them as requiring that) would take care of
> > the irq-mapping race, we'd still currently also need to move any
> > pinconfig handles to the parent bus node (as is also done in one of the
> > in-tree examples above) to suppress the corresponding pinctrl errors in
> > case the populated device is probed and bound first:
> >
> > [  +0.010217] sc8280xp-tlmm f100000.pinctrl: pin GPIO_182 already requested by 0-0015; cannot claim for 0-002c
> 
> If the config is the same for both we could suppress that warning. If
> not the same, seems a bit dangerous to configure the wrong config...

Indeed, the pin configs would need to be at least compatible.

I'm sure this has the potential to mess things up with respect to other
resources too. And even if it may be possible to get this to work in
many cases it seems firmware needs to be involved for it to work
generally.

Johan
