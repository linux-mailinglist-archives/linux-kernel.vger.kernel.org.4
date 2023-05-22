Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6660970BEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjEVM47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjEVM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:56:55 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90817C5;
        Mon, 22 May 2023 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QgXnsrFF/eM2ahjoriewoNCLFM3CfsM4mow2EOGXBSw=; b=4wSwfd/ts3aW08Yk3aF3qarO5l
        2YotqNK6pAGChYhnuNzd6uHSFpt+E2mRThWPkYXfRoE3vk0csDN3p1m/rnNpN4r5gLw5xENu4sxD5
        0t6GQRkC4G2WC1lfdsNYsG7pAgSJNo3K9mKi1/0J4tzXHkm739Yeaa1jMc4+ZteiMAiE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q155f-00DXqz-6H; Mon, 22 May 2023 14:56:43 +0200
Date:   Mon, 22 May 2023 14:56:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ramon.nordin.rodriguez@ferroamp.se, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 6/6] net: phy: microchip_t1s: add support for
 Microchip LAN865x Rev.B0 PHYs
Message-ID: <349e1c57-24c6-46fa-b0ab-c6225ae1ece4@lunn.ch>
References: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
 <20230522113331.36872-7-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522113331.36872-7-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int lan865x_setup_cfgparam(struct phy_device *phydev)
> +{
> +	u16 cfg_results[5];
> +	u16 cfg_params[ARRAY_SIZE(lan865x_revb0_fixup_cfg_regs)];
> +	s8 offsets[2];
> +	int ret;

Reverse Christmas tree please.

> +
> +	ret = lan865x_generate_cfg_offsets(phydev, offsets);
> +	if (ret)
> +		return ret;
> +
> +	ret = lan865x_read_cfg_params(phydev, cfg_params);

Is this doing a read from fuses? Is anything documented about this?
What the values mean? Would a board designer ever need to use
different values? Or is this just a case of 'trust us', you don't need
to understand this magic.

> +	if (ret)
> +		return ret;
> +
> +	cfg_results[0] = (cfg_params[0] & 0x000F) |
> +			  FIELD_PREP(GENMASK(15, 10), 9 + offsets[0]) |
> +			  FIELD_PREP(GENMASK(15, 4), 14 + offsets[0]);
> +	cfg_results[1] = (cfg_params[1] & 0x03FF) |
> +			  FIELD_PREP(GENMASK(15, 10), 40 + offsets[1]);
> +	cfg_results[2] = (cfg_params[2] & 0xC0C0) |
> +			  FIELD_PREP(GENMASK(15, 8), 5 + offsets[0]) |
> +			  (9 + offsets[0]);
> +	cfg_results[3] = (cfg_params[3] & 0xC0C0) |
> +			  FIELD_PREP(GENMASK(15, 8), 9 + offsets[0]) |
> +			  (14 + offsets[0]);
> +	cfg_results[4] = (cfg_params[4] & 0xC0C0) |
> +			  FIELD_PREP(GENMASK(15, 8), 17 + offsets[0]) |
> +			  (22 + offsets[0]);
> +
> +	return lan865x_write_cfg_params(phydev, cfg_results);
> +}


	Andrew
