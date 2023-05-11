Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9806FF0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjEKLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjEKLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:46:47 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7AF2D42;
        Thu, 11 May 2023 04:46:46 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1px4ks-0008OX-25;
        Thu, 11 May 2023 11:46:42 +0000
Date:   Thu, 11 May 2023 13:44:48 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 0/8] Improvements for RealTek 2.5G Ethernet PHYs
Message-ID: <ZFzVMHCTMeiTB4T1@pidgin.makrotopia.org>
References: <cover.1683756691.git.daniel@makrotopia.org>
 <018df89a-c3d2-1bda-9966-7f06b24f87f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018df89a-c3d2-1bda-9966-7f06b24f87f2@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:29:21AM +0200, Heiner Kallweit wrote:
> On 11.05.2023 00:53, Daniel Golle wrote:
> > Improve support for RealTek 2.5G Ethernet PHYs (RTL822x series).
> > The PHYs can operate with Clause-22 and Clause-45 MDIO.
> > [...]
> 
> Has this series been tested with RTL8125A/B to ensure that the internal
> PHY use case still works?

The series has been present in OpenWrt for a while now and initially
contained a bug which broke the RTL8221 PCIe RealTek NICs. It has since been
resolved and re-tested, and it seems all fine:

https://github.com/openwrt/openwrt/commit/998b9731577dedc7747dcfa412e4543dabaaa131#r110201620

I assume that quite some OpenWrt users may use RTL8125B PCIe NICs, but I
have asked in the OpenWrt forum for testing results including this series:

https://forum.openwrt.org/t/nanopi-r6s-kernel-6-1-intergration/154677/3?u=daniel

As the r8169 driver is not using phylink and uses C22 to connect to the
PHY the main difference which will affect these devices is that
genphy_soft_reset will be called as a result of
r8169_hw_phy_config->phy_init_hw->(phydrv).soft_reset

Also note the r8169 driver always sets the interface mode to either
PHY_INTERFACE_MODE_GMII or PHY_INTERFACE_MODE_MII in
r8169_phy_connect() before calling phy_connect_direct(). While this is
certainly not technically correct for the 2.5G NICs in the strict sense,
it does have the desired effect that the newly introduced function
rtl8221b_config_init() just returns without making any changes.

