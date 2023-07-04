Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FBA747A58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjGDXZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGDXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:25:09 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24110E2;
        Tue,  4 Jul 2023 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=FHRTeexmv1Ud/xXw29PxjXSkBNZLd2io9cIF6fc/k1c=; b=K7j0wGDm0EZKlsvLg+BOfzNHcx
        2LCYSmaTWfcakorPbX1G1B9OK87OmaZ4tHKStLSy3X/dP3LCJFW/sKN69dYfm3kI6EAlZANedx7ex
        02MohdEiUMAlM9GvYK6K+HBwS6jPvv99YFs+PrPAMf5kQlKIA+ODyz2BYb9umejmZMDI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qGpO0-000ahY-GN; Wed, 05 Jul 2023 01:24:44 +0200
Date:   Wed, 5 Jul 2023 01:24:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] net: phy: at803x: support qca8081 1G chip type
Message-ID: <66a5f898-e3fd-460a-b604-bb11a000e4e9@lunn.ch>
References: <20230704090016.7757-1-quic_luoj@quicinc.com>
 <20230704090016.7757-2-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704090016.7757-2-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:00:15PM +0800, Luo Jie wrote:
> The qca8081 1G chip version does not support 2.5 capability, which
> is distinguished from qca8081 2.5G chip according to the bit0 of
> register mmd7.0x901d.
> 
> The fast retrain and master slave seed configs are only needed when
> the 2.5G capability is supported.
> 
> Switch to use genphy_c45_pma_read_abilities for .get_features API.

It is better to have lots of small patches, each doing one thing. If
something regresses, a git bisect gives a much finer idea where the
problem is. It is also easier to review small patches with good commit
messages.

So please break this patch up.

> -	/* Configure lower ramdom seed to make phy linked as slave mode */
> -	ret = qca808x_phy_ms_random_seed_set(phydev);
> -	if (ret)
> -		return ret;
> +		/* Configure lower ramdom seed to make phy linked as slave mode */
> +		ret = qca808x_phy_ms_random_seed_set(phydev);
> +		if (ret)
> +			return ret;

Shouldn't this depend on how MDIO_MMD_AN, MDIO_AN_T1_ADV_L bit
MDIO_AN_T1_ADV_M_MST is set? Maybe the user wants it to prefer master
rather than slave?

I know you are just trying to move code around, but it does seem like
a good time to also improve the code.

FYI: net-next is closed at the moment. Officially you should post as
RFC, or wait until it opens again.

  Andrew
