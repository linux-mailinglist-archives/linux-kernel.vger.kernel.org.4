Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B160B734460
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 00:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjFQW3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFQW3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 18:29:08 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18CC1AA;
        Sat, 17 Jun 2023 15:29:06 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qAePH-0005ow-24;
        Sat, 17 Jun 2023 22:28:31 +0000
Date:   Sun, 18 Jun 2023 00:26:32 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        Frank Sae <Frank.Sae@motor-comm.com>,
        Michael Walle <michael@walle.cc>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: phy: mediatek: fix compile-test dependencies
Message-ID: <ZI4zGF4MUSclEJK_@pidgin.makrotopia.org>
References: <20230616093009.3511692-1-arnd@kernel.org>
 <ZIxL16HWci5dd7Ah@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIxL16HWci5dd7Ah@corigine.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 01:47:35PM +0200, Simon Horman wrote:
> On Fri, Jun 16, 2023 at 11:29:54AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The new phy driver attempts to select a driver from another subsystem,
> > but that fails when the NVMEM subsystem is disabled:
> > 
> > WARNING: unmet direct dependencies detected for NVMEM_MTK_EFUSE
> >   Depends on [n]: NVMEM [=n] && (ARCH_MEDIATEK [=n] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
> >   Selected by [y]:
> >   - MEDIATEK_GE_SOC_PHY [=y] && NETDEVICES [=y] && PHYLIB [=y] && (ARM64 && ARCH_MEDIATEK [=n] || COMPILE_TEST [=y])
> > 
> > I could not see an actual compile time dependency, so presumably this
> > is only needed for for working correctly but not technically a dependency
> 
> nit: for for -> for
>      or
>      for for working correctly -> for correct operation
> 
> > on that particular nvmem driver implementation, so it would likely
> > be safe to remove the select for compile testing.
> > 
> > To keep the spirit of the original 'select', just replace this with a
> > 'depends on' that ensures that the driver will work but does not get in
> > the way of build testing.
> > 
> > Fixes: 98c485eaf509b ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I don't know the answer to the question of if this dependency is needed or
> not. But I do agree that it does what it says on the box.

It's not needed to build or load the driver, but the PHY won't function
at all without reading values from the SoCs efuse, and for that the
nvmem driver is required.

Using a simple dependency instead of select will fix it.

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> 
