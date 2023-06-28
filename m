Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A618740E20
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjF1KG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjF1J41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:56:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87435AE;
        Wed, 28 Jun 2023 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pfjacbNuUwNkrWAeX5Ew7Qz/kZoiz3IcmwDj95RMCcU=; b=tXJSifE16qh8I4CRy5NBp/XIYX
        2GwwbwIoEpaBUvWf/xRX5/W2QDGoOfYvCt/iARxSA8EKGG4Cnjy+Kr3tr5BcMDzZLjw1vi9IDV46y
        1ao7vzotqEPWi12kqEQRipNiimnRZ4u5m/BEDyTlKFXbfH9vXutfJQKiva3H3fJD+51ucfpS4TO8D
        jubHGiI/FFT6xo57D9ufPAQeuNkD7XKAnNAMYW4dAgmNp13AboEGdJv0TJt1h8osmD+sQhjAao6q7
        zwcZA+WIdrahy/4QkavoMuu01xZgh6XeA9Hgt4daBaEV15xnGX2Pg6RKcNiIstSUHvCg3UbzqliS0
        QGitV93A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33168)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qERoy-00071a-19;
        Wed, 28 Jun 2023 10:50:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qERov-0006eS-Aj; Wed, 28 Jun 2023 10:50:41 +0100
Date:   Wed, 28 Jun 2023 10:50:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     wuych <yunchuan@nfschina.com>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next 08/10] net: mdio: Remove unnecessary (void*)
 conversions
Message-ID: <ZJwCcWgi0d6kEepI@shell.armlinux.org.uk>
References: <20230628024517.1440644-1-yunchuan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628024517.1440644-1-yunchuan@nfschina.com>
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

Hi,

I think you missed one case:

        if (mdio_id == XGENE_MDIO_RGMII) {
                mdio_bus->read = xgene_mdio_rgmii_read;
                mdio_bus->write = xgene_mdio_rgmii_write;
                mdio_bus->priv = (void __force *)pdata;

This cast using __force is also not required.

On Wed, Jun 28, 2023 at 10:45:17AM +0800, wuych wrote:
> @@ -211,7 +211,7 @@ static void xgene_enet_wr_mdio_csr(void __iomem *base_addr,
>  static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
>  				int reg, u16 data)
>  {
> -	void __iomem *addr = (void __iomem *)bus->priv;
> +	void __iomem *addr = bus->priv;
>  	int timeout = 100;
>  	u32 status, val;
>  
> @@ -234,7 +234,7 @@ static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
>  
>  static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
>  {
> -	void __iomem *addr = (void __iomem *)bus->priv;
> +	void __iomem *addr = bus->priv;
>  	u32 data, status, val;
>  	int timeout = 100;

These probably cause Sparse to warn whether or not the cast is there.

Given that in this case, bus->priv is initialised via:

                mdio_bus->priv = (void __force *)pdata->mdio_csr_addr;

I think the simple thing is to _always_ initialise mdio_bus->priv
to point at pdata, and have xgene_xfi_mdio_*() always do:

	struct xgene_mdio_pdata *pdata = bus->priv;
	void __iomem *addr = pdata->mdio_csr_addr;

The extra access will be dwarfed by the time taken to perform the
access.

This change should be made with a separate patch and not combined with
the patch removing the casts in xgene_mdio_rgmii_*().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
