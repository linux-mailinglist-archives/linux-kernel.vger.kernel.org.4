Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E66FF0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbjEKL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEKLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:55:59 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F612680;
        Thu, 11 May 2023 04:55:58 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1px4tm-0008Rg-01;
        Thu, 11 May 2023 11:55:57 +0000
Date:   Thu, 11 May 2023 13:53:53 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/8] net: phy: realtek: rtl8221: allow to configure
 SERDES mode
Message-ID: <ZFzXPGeob0q4DTza@pidgin.makrotopia.org>
References: <cover.1683756691.git.daniel@makrotopia.org>
 <302d982c5550f10d589735fc2e46cf27386c39f4.1683756691.git.daniel@makrotopia.org>
 <81c3f04d-ec48-4ac0-ac16-b69dc6ae72e0@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c3f04d-ec48-4ac0-ac16-b69dc6ae72e0@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 02:41:07AM +0200, Andrew Lunn wrote:
> > +#define RTL8221B_MMD_SERDES_CTRL		MDIO_MMD_VEND1
> > +#define RTL8221B_MMD_PHY_CTRL			MDIO_MMD_VEND2
> 
> I suggest you don't do this. Use MDIO_MMD_VEND[1|2] to make it clear
> these are vendor registers.

Ack, I will not introduce new macros to label them, but just use
MDIO_MMD_VEND1 and MDIO_MMD_VEND2 then.

> 
> > +	case RTL8221B_SERDES_OPTION_MODE_2500BASEX_SGMII:
> > +	case RTL8221B_SERDES_OPTION_MODE_2500BASEX:
> > +		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6a04, 0x0503);
> > +		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f10, 0xd455);
> > +		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f11, 0x8020);
> > +		break;
> > +	case RTL8221B_SERDES_OPTION_MODE_HISGMII_SGMII:
> > +	case RTL8221B_SERDES_OPTION_MODE_HISGMII:
> > +		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6a04, 0x0503);
> > +		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f10, 0xd433);
> > +		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f11, 0x8020);
> > +		break;
> > +	}
> 
> Is there anything in the datasheet to indicate register names and what
> the values mean? It would be good to replace these magic values with
> #defines.

Unfortunately they are only mentioned as magic values which have to be
written to magic registers also in the datasheet :(

