Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709BB70E0AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbjEWPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjEWPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:36:51 -0400
X-Greylist: delayed 70 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 08:36:15 PDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D590E58;
        Tue, 23 May 2023 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BcWqLdA3GurqXcNMjCREhUtMZkIto/X5WLb+86lE8cU=; b=dxPngXQTEm0ToqRbGGTFv//dEM
        fWC6TvWXxckmA770KjZZ97YPbS0CQr1ixK+ZyMla5/MEh+RLJPg6YzJBkFPYxIZB38K4P+yAvWzS0
        3CMarL6t8L0OX12H0mwIf7oVqRQmOCd1fZcfcAOIZLJeQjl/xgAPE+N/ofII5Sch+lnfWwlTtgrqV
        v4V6PacAKyq87V5WN5uPZw/axah5JiwzfQN0AqmNANSYuLHXLeOSZL2lNMFuW5Fre8pKcFMvt4c47
        gwIegBRelR3sxTt0hXvKmCQT4R2UUYh6VvyeM7dVDs1r26C3Esq/i0NM9An6dYxIOAyJsqLT7hgOa
        ZtNnhMvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35896)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q1U1Q-0000f3-Cc; Tue, 23 May 2023 16:34:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q1U1P-0000gx-OO; Tue, 23 May 2023 16:33:59 +0100
Date:   Tue, 23 May 2023 16:33:59 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     David Epping <david.epping@missinglinkelectronics.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v3 4/4] net: phy: mscc: enable VSC8501/2 RGMII RX
 clock
Message-ID: <ZGzc50GqA9mDuafm@shell.armlinux.org.uk>
References: <20230523153108.18548-1-david.epping@missinglinkelectronics.com>
 <20230523153108.18548-5-david.epping@missinglinkelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523153108.18548-5-david.epping@missinglinkelectronics.com>
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

On Tue, May 23, 2023 at 05:31:08PM +0200, David Epping wrote:
> By default the VSC8501 and VSC8502 RGMII/GMII/MII RX_CLK output is
> disabled. To allow packet forwarding towards the MAC it needs to be
> enabled.
> 
> For other PHYs supported by this driver the clock output is enabled
> by default.
> 
> Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
