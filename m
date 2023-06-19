Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924C735933
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFSOLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjFSOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:11:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A6B9C;
        Mon, 19 Jun 2023 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=EIRGd1UTDvTL390FzzHdf8HQrhz40uusNBI41NZbMhY=; b=yzwRwoTGnJPjBQYvqskOO3huZz
        FnqDg6J/ffjxtcx4CNkxcqWG97x7K9lJheWf9HufBfPMIV+yDHyoafovCXbF53Uf27XTYX/2BirdF
        u46lYa0u+e0qlkOxZgKu18sIXQiLJYhr2jF/IMnu5cl5dnxCyJmpPt8W9ONQUdgwfLS8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qBFai-00Gun1-IO; Mon, 19 Jun 2023 16:10:48 +0200
Date:   Mon, 19 Jun 2023 16:10:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Hancock <hancock@sedsystems.ca>, stable@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: ksz9477: follow errata
 sheet when applying fixups
Message-ID: <fd1fce8c-cd88-4d71-9fba-6e40cc01182e@lunn.ch>
References: <20230619081633.589703-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619081633.589703-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static void ksz9477_phy_errata_setup(struct ksz_device *dev, int port)
>  {
> +	u16 cr;
> +
> +	/* Errata document says the PHY must be configured to 100Mbps
> +	 * with auto-neg disabled before configuring the PHY MMD
> +	 * registers.
> +	 */
> +	ksz_pread16(dev, port, REG_PORT_PHY_CTRL, &cr);
> +	ksz_pwrite16(dev, port, REG_PORT_PHY_CTRL,
> +		     PORT_SPEED_100MBIT | PORT_FULL_DUPLEX);
> +

For this fix, these are fine.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Looking at the values of PORT_SPEED_100MBIT and PORT_FULL_DUPLEX, they
are identical to BMCR_SPEED100 and BMCR_FULLDPLX. In fact, it looks
like for 9477 this is a standard BMCR. Please could you add a follow
up patch which replaces these #defines with the standard ones in
include/uapi/linux/mii.h. The code is then more understandable by
people who know the standard defines.

Thanks
	Andrew

