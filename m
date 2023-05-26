Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB957124FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbjEZKnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjEZKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:43:00 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646AE13D;
        Fri, 26 May 2023 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p6gZGYkzEZra90Ov53s4Zo39rKzj5xOBW7Fj0aYklb4=; b=z2SVF97U2nzlAUNoG+MftZHkYL
        PMhR8msg2OhhdCekSckaC6W7w/6SkvnvTV6f7iJTsmO+AjyOCYQpLqOfT1SqLqZE34AIAOLnttl5d
        ACLXlDb2uXTtDQOmHjcJL4HVKdVoaPUVYaG71gb5XNtP3BG+JsXvce+g3yU+HXqlpefXMZCAX/MMG
        5O/JDZeB3CVN6dFwgFIgbJtb5MD5GomD5byTvFGwRnmGtAjAuSgDb0VqJwv90NnELymwnlU2S1RoS
        2zfVNxzXIQGXBSVt3vHaDKiY71T0YSfVXAmYuDn73enIqJ+w6RkSLg10gZp5GSFfmev5ifto0pnRK
        d+EfC/FQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35688)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q2UuK-0005Sz-S2; Fri, 26 May 2023 11:42:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q2UuI-0003fU-VC; Fri, 26 May 2023 11:42:50 +0100
Date:   Fri, 26 May 2023 11:42:50 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Mark Brown <broonie@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Subject: Re: [PATCH net-next v3 2/4] net: ethernet: altera-tse: Convert to
 mdio-regmap and use PCS Lynx
Message-ID: <ZHCNKjMFd4bu4Cmz@shell.armlinux.org.uk>
References: <20230526074252.480200-1-maxime.chevallier@bootlin.com>
 <20230526074252.480200-3-maxime.chevallier@bootlin.com>
 <ZHBwLBnKacQCG2/U@corigine.com>
 <ZHB2Tfn9yZPs6l56@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHB2Tfn9yZPs6l56@shell.armlinux.org.uk>
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

On Fri, May 26, 2023 at 10:05:17AM +0100, Russell King (Oracle) wrote:
> On Fri, May 26, 2023 at 10:39:08AM +0200, Simon Horman wrote:
> > On Fri, May 26, 2023 at 09:42:50AM +0200, Maxime Chevallier wrote:
> > > The newly introduced regmap-based MDIO driver allows for an easy mapping
> > > of an mdiodevice onto the memory-mapped TSE PCS, which is actually a
> > > Lynx PCS.
> > > 
> > > Convert Altera TSE to use this PCS instead of the pcs-altera-tse, which
> > > is nothing more than a memory-mapped Lynx PCS.
> > > 
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > 
> > Hi Maxime,
> > 
> > I have some concerns about the error paths in this patch.
> 
> We've had similar problems with mdio_device_create() vs the XPCS
> driver.
> 
> I think it's time that we made this easier for users.

Patch series here:
https://lore.kernel.org/all/ZHCGZ8IgAAwr8bla@shell.armlinux.org.uk/

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
