Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B270E0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbjEWPpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjEWPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:45:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A366126;
        Tue, 23 May 2023 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1+dt2wcWtDRFL60DFDtDsXIf3i7e1mxDA+qh9iBLVkk=; b=baVQPajyuli0BQmtdyxm0/yqn4
        jb/zDIcl/uV1XAlNc7BcmaPKyzQvDdfdOxSrNr/bhmqWa+PO4jiNXjqMBSAOvLgdMhMdtAxMTBHEH
        ECzq9b571tu+SYvKy6yDK7aBdWQ7pty+ANiy29dQxOz1v5hbaiotvQTqwcwYzmLPCvZZGFVxn0DId
        ZUgUgwswufuWgntJKcJ4aEkDFXsXUP9qSrb8RAElWWbxf+zAjQ8t5mQNPC97/DVJb1tTGIBF9Hv/x
        CyxO8ko+9VXQUcxXUKvf6mxh0jX9wnywzOnEfkhBP3PMQcSImRTURcUX8MUKwPk5MUK5b2cf5s1Qg
        svIBmmwQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34660)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q1U0H-0000eb-G5; Tue, 23 May 2023 16:32:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q1U0C-0000gq-OR; Tue, 23 May 2023 16:32:44 +0100
Date:   Tue, 23 May 2023 16:32:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     David Epping <david.epping@missinglinkelectronics.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v3 3/4] net: phy: mscc: remove unnecessary phydev
 locking
Message-ID: <ZGzcnFuhapF/h0lt@shell.armlinux.org.uk>
References: <20230523153108.18548-1-david.epping@missinglinkelectronics.com>
 <20230523153108.18548-4-david.epping@missinglinkelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523153108.18548-4-david.epping@missinglinkelectronics.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:31:07PM +0200, David Epping wrote:
> Holding the struct phy_device (phydev) lock is unnecessary when
> accessing phydev->interface in the PHY driver .config_init method,
> which is the only place that vsc85xx_rgmii_set_skews() is called from.
> 
> The phy_modify_paged() function implements required MDIO bus level
> locking, which can not be achieved by a phydev lock.
> 
> Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
