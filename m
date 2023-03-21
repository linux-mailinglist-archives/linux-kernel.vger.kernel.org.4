Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273596C3BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCUUXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCUUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:23:27 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36F7D8B;
        Tue, 21 Mar 2023 13:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679430104; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sq40Cd7UAFcnyk8bmLX+Sc1SHLTnambK3Y7DuApLuOecG9zPTcoEME4pbmmdgfgaLC
    sslRVAvwv2l2VCu1xQ696hKYDpXDZ4CSLp6nmkggcjN1QoyslL7xdsL/O+RRySkcRcaK
    sXykukInD4IsQpPhQQUn6WKHDcPoyC2r3cpxacvoTgmrmoRYFFmuAWTzHA4BLy90m7CT
    BxOjyUwixfnCvqOHOEGnDiUqrogLdoO2d+dcVWXOkFvQ43bcUrU3wXSCDLAO85te3K98
    9Mr8EKPsyhz6oxYS8lofBa6hPjk2AIHxqrR8jqD8JXWt5B8yC/eJ6J6zQ1bdIYnoU3Lx
    LiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679430104;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zqoNakOrYN9VuTDp9Rgfg3D/AHQRrAh7yltFEX866/0=;
    b=MJHhhTueJwt/7n0DYOIz5N8b4rRrjDOqVg5lW8CsG7utyIzp9tEgQ6ZYLFYV16HIzN
    nGChSw3PYPyMtynPlMPsDpAuK8VubFBqiDFWZLjhXUhs/gkRMM3bS/zF/XV1zxdyHT9F
    kOEJcZWGgwbgVEiVmlxR8oVcjg+nqYDU0u34Cx9af+IeATiY3ZpoQfLvBgJoarnhNRPN
    Vj+khVIWWdhuoRo3Cvoc/IMsr2nH4oxvkRpYOPL5qCOmXPI763WCA2iGdi5UO1wDJ+Ec
    mQegfvzFwYLvFwIM218kt95QRUEqlGRN37h7XD/TqmGOQUOToHtV5pEBJx8pIABbdfQJ
    oeMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679430104;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zqoNakOrYN9VuTDp9Rgfg3D/AHQRrAh7yltFEX866/0=;
    b=bmUr3Rx4VKPEeHCWXjNv9nqMxspiGJBZatQnwfuHs1cAFiCPGB9aCRyYfxNWfe9jdg
    wDYOU5AfLsipXcNxVRk3Z8DqolflDL6PM0pEFaRfk+0BZ+TN7uRawKuJ9PH+l8PD3GW1
    bhm9/tZgcSkUVDt0QxOxJqqc71TdtV26zEKpdQYHEuBZZrcRWXl98KQocDW+L4LPhTLV
    IvHwC1ouQVhOAvlIusWGP1xKSMipj42HJhtrMbm+e88f+154SJuZeNq0bSmB/4l+7QPX
    AOw9CmQwS1VFvMa5e7W+mSPcoYun+KOJQ8XxujvF+P9uqLK1BC140/JOeWrx6g5uAdZR
    cgGw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKw7+KY="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id i40d22z2LKLhH9y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 21 Mar 2023 21:21:43 +0100 (CET)
Date:   Tue, 21 Mar 2023 21:21:36 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: aw2013: Document vddio-supply
Message-ID: <ZBoR0DPQ+AufzKHk@gerhold.net>
References: <20230320174949.174600-1-linmengbo0689@protonmail.com>
 <20230320175131.174657-1-linmengbo0689@protonmail.com>
 <922eab51-6931-8533-db51-51cd911a36b3@linaro.org>
 <ZBitAGOmF/hyxDYP@gerhold.net>
 <94cdb512-b168-6ffe-73c1-caf23bb79d6f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94cdb512-b168-6ffe-73c1-caf23bb79d6f@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:42:37AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2023 19:59, Stephan Gerhold wrote:
> > On Mon, Mar 20, 2023 at 07:04:22PM +0100, Krzysztof Kozlowski wrote:
> >> On 20/03/2023 18:55, Lin, Meng-Bo wrote:
> >>> Some LEDs controllers are used with external pull-up for the interrupt
> >>> line and the I2C lines, so we might need to enable a regulator to bring
> >>> the lines into usable state.
> >>
> >> Not a property of this device.
> >>
> >>> Otherwise, this might cause spurious
> >>> interrupts and reading from I2C will fail.
> >>>
> >>> Document support for "vddio-supply" that is enabled by the aw2013 driver
> >>> so that the regulator gets enabled when needed.
> >>>
> >>> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/leds/leds-aw2013.yaml | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> >>> index 08f3e1cfc1b1..79b69cf1d1fe 100644
> >>> --- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> >>> +++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> >>> @@ -23,6 +23,11 @@ properties:
> >>>    vcc-supply:
> >>>      description: Regulator providing power to the "VCC" pin.
> >>>  
> >>> +  vddio-supply:
> >>> +    description: |
> >>> +      Optional regulator that provides digital I/O voltage,
> >>
> >> NAK. I responded to your patch and you just send a v2 without explanation.
> >>
> >> The device does not have VDDIO pin, either.
> >>
> > 
> > The power supply Lin is trying to add here is basically the "VIO1"
> > example in "Figure 1 AW2013 Typical Application Circuit" on page 1 of
> > the AW2013 datasheet [1]. The I2C pins and the interrupt output are both
> > open-drain and therefore require external pull-up resistors, connected
> > to a power supply that might not be always on.
> > 
> > Because of the open-drain pins AW2013 does indeed not have a dedicated
> > input pin for the I/O supply voltage. However, it is still necessary to
> > describe the power supply _somewhere_, to ensure that it is enabled when
> > needed.
> > 
> > It is hard to model this properly but it's generally easiest to handle
> > this inside the peripheral driver since it knows exactly when I2C and/or
> > interrupt lines are currently needed or not. This situation is fairly
> > common for I2C devices so there are several precedents, e.g.:
> > 
> >   1. cypress,tm2-touchkey.yaml: "vddio-supply"
> >      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e730ec11d51283ad62a98436967c01b718132ab
> >   2. goodix,gt7375p.yaml: "mainboard-vddio-supply"
> >      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d18c1f3b7d938bdefc44289d137b4e6c7a3d502
> 
> Both are mistaken. How can you enumerate or autodetect a device if its
> regulator pulling up I2C are not on?

You don't. By design I2C does not support enumeration or autodetection.
Nothing we implement in software can change that.

I2C devices have all sorts of requirements before they show up on the
bus at all (power supplies, enable GPIOs, clocks, ...). All these are
currently modelled as part of the consumer IC.

> What's more, on I2C lines you could have more devices, so you expect
> each of them having the supply?

Yes, I don't think this is a problem since it's typical for regulators
to be shared. If at least one of the I2C devices is active, the bus will
be active as well.

> These are properties of I2C controller, not the consumer. I2C controller
> should enable any regulators necessary for the IO pins.

In general I agree with you here. But as I mentioned already there is
usually more than just the I2C I/O lines. For AW2013 there is at least
also the open-drain interrupt line. On other ICs there could also be
arbitrary GPIO lines that are used in open-drain mode. Those are
completely unrelated to the I2C controller.

Do you have any suggestions how to handle the power supply for those?

IMO for interrupts lines the pull-up I/O supply is hardly a property of
the interrupt controller. It just cares that a line switches from high
to low. It's not exactly a property of the consumer IC either. However,
since operating the interrupt line in open-drain mode is part of the
consumer IC specification I would say that the I/O supply for interrupt
lines is better described on the consumer side.

For sake of completeness we could additionally describe the supply for
the I2C lines on the I2C controller, but then we still need this patch
or something else for the interrupt lines.

Thanks,
Stephan
