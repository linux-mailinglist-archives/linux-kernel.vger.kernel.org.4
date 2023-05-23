Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7512170DCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjEWMr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbjEWMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:47:52 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392ABFF;
        Tue, 23 May 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Z6eOEPsyrN+N7rxxjRZ8obpKLPnx37W4en5fClkPwhs=; b=QF5fCvNg3Rr9X+pP2QSVuCCfxr
        tRKORr+icqPX3ynC8b13QzqnUzmvGDMeaoKWSKU5AS06sH0CjHQo02WPuIVG0Gq4i76PkYBkOUZRe
        vx6dYseNOBWFBd9yu6Z+i2TDSWwvBXVatZxVUy7pMLN30zEjmZcQYjbZvuM+Av3cwmrw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1R3W-00DgTf-Ti; Tue, 23 May 2023 14:23:58 +0200
Date:   Tue, 23 May 2023 14:23:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban.Veerasooran@microchip.com
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ramon.nordin.rodriguez@ferroamp.se, Horatiu.Vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 4/6] net: phy: microchip_t1s: fix reset
 complete status handling
Message-ID: <e9db9ce6-dee8-4a78-bfa4-aace4ae88257@lunn.ch>
References: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
 <20230522113331.36872-5-Parthiban.Veerasooran@microchip.com>
 <f0769755-6d04-4bf5-a273-c19b1b76f7f6@lunn.ch>
 <b226c865-d4a7-c126-9e54-60498232b5a5@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b226c865-d4a7-c126-9e54-60498232b5a5@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:30:06AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 22/05/23 6:13 pm, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Mon, May 22, 2023 at 05:03:29PM +0530, Parthiban Veerasooran wrote:
> >> As per the datasheet DS-LAN8670-1-2-60001573C.pdf, the Reset Complete
> >> status bit in the STS2 register to be checked before proceeding for the
> >> initial configuration.
> > 
> > Is this the unmaskable interrupt status bit which needs clearing?
> Yes, it is non-maskable interrupt.
> > There is no mention of interrupts here.
> The device will assert the Reset Complete (RESETC) bit in the Status 2 
> (STS2) register to indicate that it has completed its internal 
> initialization and is ready for configuration. As the Reset Complete 
> status is non-maskable, the IRQ_N pin will always be asserted and driven 
> low following a device reset. Upon reading of the Status 2 register, the 
> pending Reset Complete status bit will be automatically cleared causing 
> the IRQ_N pin to be released and pulled high again.
> 
> Do you think it makes sense to add these explanation regarding the reset 
> and interrupt behavior with the above comment for a better understanding?

Comments should explain 'Why?'. At the moment, it is not clear why you
are reading the status. The discussion so far has been about clearing
the interrupt, not about checking it has actually finished its
internal reset. So i think you should be mentioning interrupts
somewhere. Especially since this is a rather odd behaviour.

	   Andrew
