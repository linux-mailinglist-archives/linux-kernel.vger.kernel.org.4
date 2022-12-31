Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082665A5E4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiLaRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLaRJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:09:01 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16B1148;
        Sat, 31 Dec 2022 09:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=bMVAzwQFZgS6/79gxTjQk0OIZT1bFWSDg8GQkqwhKBM=; b=U1x/GJszPLwinN0A9rqq3iH+La
        5GMe66Fw6XLjit13/wJFSPX7OIzyw0HPA3BDa1AX1iukpLwLRUHKRD3USRRzD5jojbf5ZKc4FJzag
        EUqeGN+xQLC++yrN+ixNQzprKW8oldtUDNHEkmyNRoiHh6N6JSUOGEWKTzv+3OAJuOis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pBfLd-000pwG-1s; Sat, 31 Dec 2022 18:08:41 +0100
Date:   Sat, 31 Dec 2022 18:08:41 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Nikolaus Voss <nikolaus.voss@haag-streit.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, nv@vosn.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] imx6qdl.dtsi: use MAC-address from nvmem
Message-ID: <Y7BsmULn+VQNP3g+@lunn.ch>
References: <20221128084749.5F10D1D73@mail.steuer-voss.de>
 <20221231064923.GD6112@T480>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231064923.GD6112@T480>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -1053,6 +1053,8 @@ fec: ethernet@2188000 {
> >  					 <&clks IMX6QDL_CLK_ENET_REF>;
> >  				clock-names = "ipg", "ahb", "ptp", "enet_out";
> >  				fsl,stop-mode = <&gpr 0x34 27>;
> > +				nvmem-cells = <&fec_mac_addr>;
> > +				nvmem-cell-names = "mac-address";
> 
> May I ask where is the support of FEC driver for this?

The fec uses of_get_mac_address() which calls
of_get_mac_address_nvmem() as its last place to look for the MAC
address.

    Andrew
