Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A574DE4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGJTjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGJTjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:39:15 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C695D9E;
        Mon, 10 Jul 2023 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=O1YKh0iCibYzsm4hsCWbry564ZmymBSwh69WIn0oPJM=; b=svDqzOPyzOOPqTymB4KcsYSohE
        EnNrMhpo5uqx6SfFuNs/gqFoSzOUNocdni5V//pWJO0rhKU+55pvKYxVRWXifQLe5uUcfDUq6FUf0
        T7g6F7zl+52RnGQ3gCy1Ir74sMuai5p6dKqzc5MFpW2kcvPo5vC8gJUV33SqEYkS4z84=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qIwih-000yaT-6n; Mon, 10 Jul 2023 21:38:51 +0200
Date:   Mon, 10 Jul 2023 21:38:51 +0200
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
Message-ID: <6cf76d72-4747-46d2-a1f7-d2f1131491f7@lunn.ch>
References: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
 <261cb91c-eb3a-4612-93ad-25e2bc1a7c23@lunn.ch>
 <87fac0dd-9a97-b188-4887-8c4bb21196d5@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fac0dd-9a97-b188-4887-8c4bb21196d5@vaisala.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> 
> This is needed for configuration in link between DP83822 and Ethernet Switch
> chip.

What switch chip is it?

Most boards just connect the MACs together and don't have PHYs in the
middle. There are some boards which do have PHYs, but they don't need
any special mode.

> In the connection there there is no Ethernet cable at all but routes
> within the circuit boards but instead has capacitive coupling on routes.

So you also left out the magnetics?
 
> So the setting itself is related to specific circuit board design.

Agreed. So it is then valid to put it into DT, if it is actually
needed.

> MLT-3 is related to encoding used in the signals -- I suppose wiki page is
> good introduction reference:
> 
> https://en.wikipedia.org/wiki/MLT-3_encoding

MLT-3 is well defined. What i could not find is any reference to what
reduced MLT-3 is. If it is not part of any standard, why don't you
just hard code the PHY to always use MTL-3 which is defined as part of
802.3?

I get the feeling reduced MLT-3 is TI proprietary. As such, it should
default to MLT-3 as defined in 802.3 and there could then be an option
to enable this proprietary mode for anybody we wants to use it.

So before accepting any patches, we need a better understanding of
that reduced MLT-3 is and why you would want to use it.

     Andrew

