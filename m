Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40680720026
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjFBLIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFBLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:08:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD066E2;
        Fri,  2 Jun 2023 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HNBLPpuuwhi8v9HkXVIDxJamEPoFjmcMUaXsh28K9BY=; b=qB52FOtrDTU1GIxUjQlT2PH4tZ
        WUPPi/xTFsRWOGTMPiE2hdVC65Zd3idxbXcY/Vu13zUoJKjFKOTUuvriBbJCT2X6OdJeGaXGugYxl
        /1ot1wQd8C5mhjexGv6MlPSHaXgGkrYwP8BR9mDhR50YCjqEzpkeOhn7PQeb4MtvS/VokK/wCPGKy
        Nrp2PkbsFnzQKPkPl+ds8jPCuo83BDkVx2KavweZ1L/2YNA9ErY4Et7FtKFNjq0RVVGS83N7Lf3R7
        nxbOo652hdO7122XZxmtSbuqb8vX2mkf+buC81KHa4ojqqcoQB6xZwcFiGm/YHPIA7SNnCquIY12g
        2QDR+k8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32820)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q52da-0007sL-Lr; Fri, 02 Jun 2023 12:08:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q52dY-0002sR-8K; Fri, 02 Jun 2023 12:08:04 +0100
Date:   Fri, 2 Jun 2023 12:08:04 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     msmulski2@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com,
        kabel@kernel.org, Michal Smulski <michal.smulski@ooma.com>
Subject: Re: [PATCH net-next v6 1/1] net: dsa: mv88e6xxx: implement USXGMII
 mode for mv88e6393x
Message-ID: <ZHnNlGiHRbUYsxlC@shell.armlinux.org.uk>
References: <20230602001705.2747-1-msmulski2@gmail.com>
 <20230602001705.2747-2-msmulski2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602001705.2747-2-msmulski2@gmail.com>
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

On Thu, Jun 01, 2023 at 05:17:04PM -0700, msmulski2@gmail.com wrote:
> +static int mv88e639x_serdes_pcs_get_state_usxgmii(struct mv88e6xxx_chip *chip,
> +						  int port, int lane,
> +						  struct phylink_link_state *state)
> +{
> +	u16 status, lp_status;
> +	int err;
> +
> +	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
> +				    MV88E6390_USXGMII_PHY_STATUS, &status);
> +	if (err) {
> +		dev_err(chip->dev, "can't read Serdes USXGMII PHY status: %d\n", err);
> +		return err;
> +	}
> +	dev_dbg(chip->dev, "USXGMII PHY status: 0x%x\n", status);
> +
> +	state->link = !!(status & MDIO_USXGMII_LINK);

Another thing which is missing is filling in state->an_complete. Does
the PHY have a status bit for this when operating in USXGMII mode?
If not, please set it to state->link.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
