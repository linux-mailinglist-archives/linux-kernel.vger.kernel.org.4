Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525373A531
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjFVPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjFVPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:37:06 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173AF118;
        Thu, 22 Jun 2023 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4lUNPdzeGRfvUv6WjT+IRwoZNLTeUVrgSIo14geZN8U=; b=rT+/pP0BC4mmt62uwzA4v1uCpj
        w3HdtFaJRe54kWXL6Dqf/7+4PgtV7oTVZg7JJ8Zp7KxuXEc1ikzrkm89gMzgObPTgJX5HdBueDsr2
        sdRmqmTvEWW3U2L7l9u3nKQIJys+wFMkCUOU6eIidiVgFILQxwxTwcrmwKA9hSo1PKFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCMMS-00HHKJ-Mz; Thu, 22 Jun 2023 17:36:40 +0200
Date:   Thu, 22 Jun 2023 17:36:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, ansuelsmth@gmail.com,
        rmk+kernel@armlinux.org.uk, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: bcmgenet: Ensure MDIO unregistration has clocks
 enabled
Message-ID: <533872e1-b323-4bca-aacc-4d3cfbed53bd@lunn.ch>
References: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 03:31:07AM -0700, Florian Fainelli wrote:
> With support for Ethernet PHY LEDs having been added, while
> unregistering a MDIO bus and its child device liks PHYs there may be
> "late" accesses to the MDIO bus. One typical use case is setting the PHY
> LEDs brightness to OFF for instance.
> 
> We need to ensure that the MDIO bus controller remains entirely
> functional since it runs off the main GENET adapter clock.

So this clock is enabled in bcmgenet_open() and disabled in
bcmgenet_close(). The assumption being, the MDIO bus is only used when
the interface is up.

How does this work when there is an MDIO based switch attached? I had
similar problems with the FEC and mv88e6xxx. DSA would try to talk to
the switch with the master interface down, and MDIO would time out. I
needed to add runtime PM support to the MDIO bus ops.

       Andrew
