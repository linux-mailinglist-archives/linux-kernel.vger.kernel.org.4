Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D38709C51
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjESQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjESQWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:22:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BEF1BD;
        Fri, 19 May 2023 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=F9VR5GWsmaIvh2GRlnTeCnpK7d8csC6dZRD/nCtAshA=; b=Al8kK3YwCDmJ1zMU0PPrh+98h8
        xqSzwayDzUWNoLxxMXAB7v+uhAH/z0E2vIavco5dSEBhcQbK51En/1QsJzh7MiIvCVVjHo9brmfXn
        AHiUCl3EMKHxr4QXmv/qSdITOMrOOS/jj7B7adrLp+7MhpTrR0huboKi2NtukFNiTrOY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q02rL-00DLVY-Du; Fri, 19 May 2023 18:21:39 +0200
Date:   Fri, 19 May 2023 18:21:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     alexis.lothore@bootlin.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, paul.arola@telus.com,
        scott.roberts@telus.com,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v2 7/7] net: dsa: mv88e6xxx: enable support for
 88E6361 switch
Message-ID: <f8f60a03-b190-41ad-8b67-4c63fd43ae47@lunn.ch>
References: <20230519141303.245235-1-alexis.lothore@bootlin.com>
 <20230519141303.245235-8-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519141303.245235-8-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -421,9 +421,14 @@ phy_interface_t mv88e6390x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
>  int mv88e6393x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
>  				     int speed, int duplex)
>  {
> +	bool is_6361 =
> +		chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6361;
>  	u16 reg, ctrl;
>  	int err;
>  
> +	if (is_6361 && speed > 2500)
> +		return -EOPNOTSUPP;

I would move the comparison inside the if, so removing the ugly looking split is_6361 line.

> +
>  	if (speed == 200 && port != 0)
>  		return -EOPNOTSUPP;
>  
> @@ -506,8 +511,12 @@ int mv88e6393x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
>  phy_interface_t mv88e6393x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
>  					       int port)
>  {
> +	bool is_6361 =
> +		chip->info->prod_num == MV88E6XXX_PORT_SWITCH_ID_PROD_6361;
> +
>  	if (port == 0 || port == 9 || port == 10)
> -		return PHY_INTERFACE_MODE_10GBASER;
> +		return is_6361 ? PHY_INTERFACE_MODE_2500BASEX :
> +			PHY_INTERFACE_MODE_10GBASER;

Please see if you can rearrange this code as well.

Thanks
	Andrew
