Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2906FF0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbjEKLwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEKLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:52:30 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB242680;
        Thu, 11 May 2023 04:52:29 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1px4qR-0008QZ-22;
        Thu, 11 May 2023 11:52:28 +0000
Date:   Thu, 11 May 2023 13:50:30 +0200
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
Message-ID: <ZFzWhn7yXazjjmzq@pidgin.makrotopia.org>
References: <cover.1683756691.git.daniel@makrotopia.org>
 <302d982c5550f10d589735fc2e46cf27386c39f4.1683756691.git.daniel@makrotopia.org>
 <8fdffc76-4b2f-44ea-9800-1e5d3624d94e@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fdffc76-4b2f-44ea-9800-1e5d3624d94e@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 02:38:19AM +0200, Andrew Lunn wrote:
> > +#define RTL8221B_SERDES_OPTION_MODE_2500BASEX_SGMII	0
> > +#define RTL8221B_SERDES_OPTION_MODE_HISGMII_SGMII	1
> > +#define RTL8221B_SERDES_OPTION_MODE_2500BASEX		2
> 
> So what is 2500BASEX_SGMII? You cannot run SGMII at 2.5G, because
> there is no way to repeat a symbol 2.5 times so that a 1G stream takes
> up 2.5G bandwidth. The SGMII signalling also does not work at 2.5G.

*_MODE_2500BASEX_SGMII means that the PHY will dynamically switch
interface mode between 2500Base-X for 2500M links and SGMII for
everything else.

Setting  *_MODE_2500BASEX in contrast to that enabled rate-adapter mode
and always uses 2500Base-X no matter what the speed of the link on the
TP interface is.

I will add a comment explaining that.

