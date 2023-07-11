Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313E74F39E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjGKPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjGKPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:35:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0CB10EB;
        Tue, 11 Jul 2023 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=wp3Gf78q27oropR3P7+eQq1HKA6J74ZGkab9Ggf11MA=; b=Lg
        9kbFWJWVcnDtumqg6cH7lFcSrdExgg0dnO5XNJ4II1wJYjSXncNoZuySqiXXhK6EY/TDYiQW76ysj
        RIC7gwd/V5UlVa/wDFAXVeNzx7Nicm7w1Ldc+Yx+6XBsliMzAgd1Y6NTmDE8Lg+DEDHYll1jTFcx9
        qFn/HvgidsZW6Gs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qJFOm-00135w-Rw; Tue, 11 Jul 2023 17:35:32 +0200
Date:   Tue, 11 Jul 2023 17:35:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: phy: dp83822: Add support for line class driver
 configuration
Message-ID: <0ef64a05-64a0-4119-9dcc-83e65434cd24@lunn.ch>
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
 <261cb91c-eb3a-4612-93ad-25e2bc1a7c23@lunn.ch>
 <87fac0dd-9a97-b188-4887-8c4bb21196d5@vaisala.com>
 <6cf76d72-4747-46d2-a1f7-d2f1131491f7@lunn.ch>
 <85e9dfbd-baea-1d73-aaf0-d6c14a1305eb@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85e9dfbd-baea-1d73-aaf0-d6c14a1305eb@vaisala.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:51:22AM +0300, Vesa Jääskeläinen wrote:
> Hi Andrew,
> 
> On 10.7.2023 22.38, Andrew Lunn wrote:
> > > Hi Andrew,
> > > 
> > > This is needed for configuration in link between DP83822 and Ethernet Switch
> > > chip.
> > What switch chip is it?
> 
> Microchip's KSZ9897.

O.K, so nothing special or oddball.

> > Most boards just connect the MACs together and don't have PHYs in the
> > middle. There are some boards which do have PHYs, but they don't need
> > any special mode.
> 
> In here there is PHY<->PHY line link. My understanding is that in this
> particular case PHY link works better than *MII links.

I've seen PHY<->PHY done when the switch was on a daughter board, and
there was worries about getting RGMII over the connector etc.

> > So before accepting any patches, we need a better understanding of
> > that reduced MLT-3 is and why you would want to use it.
> 
> OK.
> 
> My understanding is that as we have PHY<->PHY link it needs to handle itself
> in standard way. Thus the MLT-3 full mode is required for communicating with
> Ethernet switch.
> 
> It seems that Texas Instruments has figured out additional power saving
> mechanism by carefully selecting used magnetics (they have guidelines for
> that and list of supported ones). Now the thinking might have continued that
> let's make the power saving mode the default for all.

Do there guidelines for magnetic says anything about what to do when
using unsupported ones. Like turn reduced MLT-3 off?

> With carefully selected magnetics one most likely gets correct looking
> signal when measured from the cable and thus the other party then gets

> I tried to look up what does this class A and class B mean but I am unable
> to find the reasoning for that.

If you look at the oscilloscope screenshots in the support forum, it
looks like in reduced MLT-3 mode, The TX- and TX+ pins only have two
states, not three. It relies on the magnetics to combine the two
signals to produce a three state signal, and handle the bias in each
signal.

When in MLT-3 mode, i expect the TX- and TX+ pins do real MLT-3.

With real MLT-3, you can then do capacitor coupling to other devices
which conform to 802.3.

> Do we have people from Texas Instruments that could share more insights?

Maybe, but don't hold your breath. Since Dan Murphy left TI, TI does
not really support its own PHYs in mainline.

> In a way this could even be:
> 
>   ti,force-standard-mlt-3-signaling;

Maybe. Or ti,disable-proprietary-line-coding

Lets give TI a couple of days to comment.

     Andrew
