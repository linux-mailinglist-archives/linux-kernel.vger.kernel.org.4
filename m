Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED68A733AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFPUhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:37:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FC3AA2;
        Fri, 16 Jun 2023 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P0TseeKmmyEXnEwa8PR9QMT+rT2HFHcuV2+UK3I323E=; b=eN1tvXysldMMhU48xwBkwDR343
        0CZrCRsEYCiwlAG+tRobBmVNy8fQlIDmr9bDDgGaIcFO6R5sNoHJO7sGTlkcbD2nTArKyoiunCgm/
        ussQ9yACX2BNG1VWPeiGVARbCDvTKJlGvqk3VpngfCt5RaxZDT/sEv8tGH6dZtPrv2n8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qAGBa-00Gl04-OZ; Fri, 16 Jun 2023 22:36:46 +0200
Date:   Fri, 16 Jun 2023 22:36:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com,
        stable@vger.kernel.org
Subject: Re: [PATCH net-next v1 01/14] net: phy: nxp-c45-tja11xx: fix the PTP
 interrupt enablig/disabling
Message-ID: <5f47ee8c-6a84-4449-9331-1895e4a612d9@lunn.ch>
References: <20230616135323.98215-1-radu-nicolae.pirea@oss.nxp.com>
 <20230616135323.98215-2-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616135323.98215-2-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 04:53:10PM +0300, Radu Pirea (NXP OSS) wrote:
> .config_intr() handles only the link event interrupt and should
> disable/enable the PTP interrupt also.
> 
> It's safe to disable/enable the PTP irq even if the egress ts irq
> is disabled. This interrupt, the PTP one, acts as a global switch for all
> PTP irqs.
> 
> Fixes: 514def5dd339 ("phy: nxp-c45-tja11xx: add timestamping support")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Please don't mix fixes and development work in one patchset. Please
post this to applying to net, not net-next.

>  static int nxp_c45_config_intr(struct phy_device *phydev)
>  {
> -	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> +	/* The return value is ignored on purpose. It might be < 0.
> +	 * 0x807A register is not present on SJA1110 PHYs.
> +	 */
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
> +				 VEND1_PORT_FUNC_IRQ_EN, PTP_IRQS);
>  		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
>  					VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);

phy_set_bits_mmd() will not return an error if the register does not
exist. There is no such indication for MDIO. This is going to do a
read/modify/write. That read might get 0xffff, or random junk. And
then the write back will be successful. The only time
phy_read()/phy_write return error is when there is a problem within
the bus master, like its clock gets turned off and the transfer times
out.

So it is good to document you are accessing a register which might not
exist, but there is no need to ignore the return code.

       Andrew
