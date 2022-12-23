Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2E655143
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiLWOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiLWOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:19:10 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154E03EACA;
        Fri, 23 Dec 2022 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yOe6ftm83MjcbSsPzfhXQYYG0KG1pAc9ELl18Zq14Gs=; b=M2rXfeoOXsELTA+n9t49bHnxKd
        /wuaZLFU+jz64uDHhv+ghw745Z3XrazuJOTRWkpzlOBC0e51iNCGGcb2N2OsIve322+kf9B8NNdAd
        MgP4OMuifOp1S+jNaZxbtOGlrLO2D1WYbDiWEi9FP9JNPOUohxdVdgQYtOPQN94VVw5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1p8ish-000LAe-KP; Fri, 23 Dec 2022 15:18:39 +0100
Date:   Fri, 23 Dec 2022 15:18:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        macpaul.lin@mediatek.com
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Message-ID: <Y6W4vwJHG+6PI8fd@lunn.ch>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
 <20221223015029.24978-2-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223015029.24978-2-biao.huang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 09:50:28AM +0800, Biao Huang wrote:
> In current driver, MAC will always enable 2ns delay in RGMII mode,
> but that will lead to transmission failures for "rgmii-id"/"rgmii-txid"
> cases.
> 
> Modify the implementation of fix_mac_speed() to ensure the 2ns delay
> will only take effect for "rgmii-rxid"/"rgmii" cases, then user can
> choose phy-mode freely.

This does not seem correct. There are three ways the delays can be added:

1) The MAC
2) The PHY
3) Extra long lines on the board.

What the four RGMII modes tell you is what is needed in addition to
whatever the board provides. So it describes the combination of 1) and
2). Your board does not appear to be applying any delays, so you
should be using rgmii-id.

The MAC and PHY driver then need to decide how to add these delays,
and in most cases, the MAC does nothing, and passes phy-mode to the
PHY and the PHY adds the delay.

The MAC can add delays, but if it does, it need to mask out the delays
it added to the value passed to the PHY. Otherwise the PHY will add
the delay as well.

>  
> -	if ((phy_interface_mode_is_rgmii(priv_plat->phy_mode))) {
> +	switch (priv_plat->phy_mode) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>  		/* prefer 2ns fixed delay which is controlled by TXC_PHASE_CTRL,
>  		 * when link speed is 1Gbps with RGMII interface,
>  		 * Fall back to delay macro circuit for 10/100Mbps link speed.

So this is wrong. PHY_INTERFACE_MODE_RGMII means the board is adding
the delay via long lines. You should not be added any delay at all.

For PHY_INTERFACE_MODE_RGMII_RXID, you need to mask the RXID bit from
phy_mode when connecting the MAC to the PHY. Otherwise the PHY is
going to add this delay as well.

	 Andrew
