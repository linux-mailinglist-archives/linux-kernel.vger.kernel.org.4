Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7467185F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjEaPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjEaPRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:17:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838E211D;
        Wed, 31 May 2023 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=zulFnBIOvpdXzsXSodPwLCmaalOVRPPAxIcwsGbXZrU=; b=ttG6x4A+90V0zw0Y8l/vgIMO/G
        uRCnVZduiOSABPA65Vx4Jw8llwlvtzFL6+wWbf6g/DqKHHAiNB1QESkW88rQAccgX7Hra/ONdweIG
        z148paC7S7agHEWsUK332nBTWYQFgXXpmdhHw7QxAbljfg6wxg3BWvLUCVGBCsIvW1So=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q4NZ8-00ETKT-FD; Wed, 31 May 2023 17:16:46 +0200
Date:   Wed, 31 May 2023 17:16:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: phy: Support external PHY xtal
Message-ID: <ade45bcf-c174-429a-96ca-d0ffb41748d4@lunn.ch>
References: <20230531150340.522994-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531150340.522994-1-detlev.casanova@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:03:39AM -0400, Detlev Casanova wrote:
> Ethernet PHYs can have external an clock that needs to be activated before
> probing the PHY.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../devicetree/bindings/net/ethernet-phy.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 4f574532ee13..e83a33c2aa59 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -93,6 +93,16 @@ properties:
>        the turn around line low at end of the control phase of the
>        MDIO transaction.
>  
> +  clock-names:
> +    items:
> +      - const: xtal

I don't think xtal is the best of names here. It generally is used as
an abbreviation for crystal. And the commit message is about there not
being a crystal, but an actual clock.

How is this clock named on the datasheet?

    Andrew
