Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D374BEB4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjGHSZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHSZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 14:25:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA894130;
        Sat,  8 Jul 2023 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nnJMw55VwH7NjHH7fwFNTj7b36AqghDRMQwGYCDAQiI=; b=o4KZ7nD2f6HsB+kpF8ZSPDf4wB
        9e4dRDr4Rw5WmePuMVFe8lyYtRmycO3eQ3JAP0JkCGRm2of4fQhiBVIYFze7CZxGpq9LpwdNLYitw
        hTrL2fNzPp0FpE6hGIOUfyKFrcsLFccwPkp80W6W6U1LAaYgfVvh1KqoDo73jrjJbNyc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qICcd-000pKH-Nf; Sat, 08 Jul 2023 20:25:31 +0200
Date:   Sat, 8 Jul 2023 20:25:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH 2/2] dt-bindings: net: phy: vsc8531: document
 'vsc8531,clkout-freq-mhz' property
Message-ID: <9c37e2d5-a430-4a0f-b6b9-5de0dc14033f@lunn.ch>
References: <20230706081554.1616839-1-alex@shruggie.ro>
 <20230706081554.1616839-2-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706081554.1616839-2-alex@shruggie.ro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 11:15:54AM +0300, Alexandru Ardelean wrote:
> For VSC8351 and similar PHYs, a new property was added to generate a clock
> signal on the CLKOUT pin.
> This change documents the change in the device-tree bindings doc.
> 
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 0a3647fe331b..133bdd644618 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -31,6 +31,10 @@ Optional properties:
>  			  VSC8531_LINK_100_ACTIVITY (2),
>  			  VSC8531_LINK_ACTIVITY (0) and
>  			  VSC8531_DUPLEX_COLLISION (8).
> +- vsc8531,clkout-freq-mhz : For VSC8531 and similar PHYs, this will output
> +			  a clock signal on the CLKOUT pin of the chip.
> +			  The supported values are 25, 50 & 125 Mhz.
> +			  Default value is no clock signal on the CLKOUT pin.

It is possible this could cause regressions. The bootloader could
turned the clock on, and then Linux leaves it alone. Now, it will get
turned off unless a DT property is added.

I prefer to explicitly have the property, so there is no dependency on
the bootloader, so lets leave it like this. But if we do get
regressions reported, this might need to change.

   Andrew
