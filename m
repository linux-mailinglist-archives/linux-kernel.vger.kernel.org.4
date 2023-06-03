Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A83B72106A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjFCORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFCORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:17:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA92196;
        Sat,  3 Jun 2023 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=TPu9oEqysmXgL1Bx6owbUOSBu4NDX4mQHTxjCaVYzTQ=; b=y7kUygTDiPuzEVYK5+KMYVP/dg
        VxkabFJ3qFJuLJoDfm1ohXZ3h57clVIRksJdhxXNjgRJ48C2zOv8FQLUZigLyNERbIzqmRd1xTO5I
        w6nsSaNXdXTnwUsi9hZnvZp0Yn3lU2VbsqWmStGwYwuh31/2fUgQKSfEyOY8IlDZSDE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q5S3a-00EkuG-Pi; Sat, 03 Jun 2023 16:16:38 +0200
Date:   Sat, 3 Jun 2023 16:16:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: micrel: Move KSZ9477 errata fixes
 to PHY driver
Message-ID: <9620f9f4-1d0f-45ed-b457-9a272af451f6@lunn.ch>
References: <20230602234019.436513-1-robert.hancock@calian.com>
 <20230602234019.436513-2-robert.hancock@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602234019.436513-2-robert.hancock@calian.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 05:40:18PM -0600, Robert Hancock wrote:
> The ksz9477 DSA switch driver is currently updating some MMD registers
> on the internal port PHYs to address some chip errata. However, these
> errata are really a property of the PHY itself, not the switch they are
> part of, so this is kind of a layering violation. It makes more sense for
> these writes to be done inside the driver which binds to the PHY and not
> the driver for the containing device.
> 
> This also addresses some issues where the ordering of when these writes
> are done may have been incorrect, causing the link to erratically fail to
> come up at the proper speed or at all. Doing this in the PHY driver
> during config_init ensures that they happen before anything else tries to
> change the state of the PHY on the port.
> 
> The new code also ensures that autonegotiation is disabled during the
> register writes and re-enabled afterwards, as indicated by the latest
> version of the errata documentation from Microchip.
> 
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
