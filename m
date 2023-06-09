Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7098172931E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbjFII1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbjFIIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0926B2;
        Fri,  9 Jun 2023 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/ddh/njnY2cXtqQRzpQCozAt2Drn97mnuIEdRepzLZw=; b=heKsqyPzgKPY52cmAe4+oO/pfy
        3Ctl5VfyScPLOgIkGfIh84Wjom1i9QooaBADAirB+AVNytkcJ9aaOwy5/Iy+UVUH//grS+VpJzmkE
        SGmi1+d4wm1RtMUEEY1MEWIQX+tGMhY/EnmF7bS5C0CdBXcTu+zYzAK/C5TekSsCHx+RTGAEYL+Yu
        CVt61AvpcJy6DP55BvrnHV6jLdSkMhGKEFmNwpUwVzM/5ORVG0yxYAp80KXKLrKCj8Cza4nTiuJD/
        /nrPRxsoKJGH667SBbFGBwNPe4bEgfFECKieHzVeEEZazaL+7QHtl18uzvaojF0NXlOI3Be6ssd+d
        Gw4JCaMA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34538)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q7XPW-0001eE-DZ; Fri, 09 Jun 2023 09:23:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q7XPS-0001hR-On; Fri, 09 Jun 2023 09:23:50 +0100
Date:   Fri, 9 Jun 2023 09:23:50 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Horatiu.Vultur@microchip.com,
        Allan.Nielsen@microchip.com, UNGLinuxDriver@microchip.com,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net v2 0/2] fixes for Q-USGMII speeds and autoneg
Message-ID: <ZILhllzq5SAFTgOf@shell.armlinux.org.uk>
References: <20230609080305.546028-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609080305.546028-1-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:03:03AM +0200, Maxime Chevallier wrote:
> This is the second version of a small changeset for QUSGMII support,
> fixing inconsistencies in reported max speed and control word parsing.
> 
> As reported here [1], there are some inconsistencies for the Q-USGMII
> mode speeds and configuration. The first patch in this fixup series
> makes so that we correctly report the max speed of 1Gbps for this mode.
> 
> The second patch uses a dedicated helper to decode the control word.
> This is necessary as although USGMII control words are close to USXGMII,
> they don't support the same speeds.
> 
> Thanks,
> 
> Maxime
> 
> [1] : https://lore.kernel.org/netdev/ZHnd+6FUO77XFJvQ@shell.armlinux.org.uk/
> 
> V1->V2: Fix decoding logic for usgmii control word, as per Russell's review

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
