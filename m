Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B22709C17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjESQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjESQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:11:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF61AB;
        Fri, 19 May 2023 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fEghx6mVjcgBf40Xq8ewYu2k1cwOduuzKJ9E2w6kTwM=; b=i1W21HiP4BIviwkn1gcVZAGlHI
        frWQrTpRodMyiUCDpfrOXFUrdkqUDsqQN5UhcGyWxJW5IkZHtevoCdkub2+rufkSMsPx1jaUNH/3w
        VAD1yJZwxtVK5eSgtdBCbr9E2DPYlqzGXaCn2sr1YoQa4SAULzUi26L9O6RmWgJ8GZPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q02hN-00DLRZ-MI; Fri, 19 May 2023 18:11:21 +0200
Date:   Fri, 19 May 2023 18:11:21 +0200
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
Subject: Re: [PATCH net-next v2 4/7] net: dsa: mv88e6xxx: add field to
 specify internal phys layout
Message-ID: <31103ab4-c055-43bc-a124-84976ee47e32@lunn.ch>
References: <20230519141303.245235-1-alexis.lothore@bootlin.com>
 <20230519141303.245235-5-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519141303.245235-5-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1198,13 +1198,17 @@ int mv88e6xxx_g2_irq_mdio_setup(struct mv88e6xxx_chip *chip,
>  {
>  	int phy, irq;
>  
> -	for (phy = 0; phy < chip->info->num_internal_phys; phy++) {
> +	for (phy = chip->info->internal_phys_offset;
> +	     phy <
> +	     chip->info->num_internal_phys + chip->info->internal_phys_offset;
> +	     phy++) {

The code style is not so nice. How about moving this addition out of
the for loop, it is static anyway. And then you can avoid splitting
the expression over multiple lines.

>  		irq = irq_find_mapping(chip->g2_irq.domain, phy);
>  		if (irq < 0)
>  			return irq;
>  
>  		bus->irq[chip->info->phy_base_addr + phy] = irq;
>  	}
> +

No whitespace changed please.

    Andrew

---
pw-bot: cr
