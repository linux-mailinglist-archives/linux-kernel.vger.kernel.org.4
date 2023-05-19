Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A322D709857
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjESNbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjESNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:31:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A910F8;
        Fri, 19 May 2023 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fASWcQQZFu9vJAgQoBF8AHHKBRfu7PRMfFGfAqrEr2E=; b=I5lFAz6MfIdiaABPErD7w+7M2B
        xwmf+C1bL/EsCujrpprezIWb4g2expSKqoYA+sR2iiGy0+FjLwEwtN36+37lNn29NOLBgZePp2mSI
        uOoHihrDOiN+Re5ZG8FlY4h/eiFTECkaas28R9trMRDBxe3/e8Aiv9DdtE+ydN1n9r2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q00Bg-00DKTX-DY; Fri, 19 May 2023 15:30:28 +0200
Date:   Fri, 19 May 2023 15:30:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        paul.arola@telus.com, scott.roberts@telus.com
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: enable support for
 88E6361 switch
Message-ID: <85c07e51-8a0b-4328-bab3-acad2ee104e1@lunn.ch>
References: <20230517203430.448705-1-alexis.lothore@bootlin.com>
 <20230517203430.448705-3-alexis.lothore@bootlin.com>
 <9a836863-c279-490f-a49a-de4db5de9fd4@lunn.ch>
 <ee281c0f-5e8b-8453-08bf-858c5503dc22@bootlin.com>
 <6643e099-7b72-4da2-aba1-521e1a4c961b@lunn.ch>
 <20230519143713.1ac9c7a1@thinkpad>
 <7419ffc0-b292-97c4-fee6-610a1a841265@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7419ffc0-b292-97c4-fee6-610a1a841265@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Ports 1 and 2 should hopefully be protected by the
> >> invalid_port_mask. It should not even be possible to create those
> >> ports. port 0 is interesting, and possibly currently broken on
> >> 6393. Please take a look at that.
> > 
> > Why would port 0 be broken on 6393x ?
> By "broken", I guess Andrew means that if we feed port 0 to
> mv88e6xxx_phy_is_internal, it will return true, which is wrong since there is no
> internal phy for port 0 on 6393X ?

Yes, that is what i was thinking. But i did not spend the time to look
at the code see if this is actually true. There might be a special
case somewhere in the code.

But in general, we try to avoid special cases, and add device specific
ops.

	Andrew
