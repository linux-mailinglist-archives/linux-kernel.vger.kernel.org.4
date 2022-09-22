Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8086A5E6DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiIVVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiIVVK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:10:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A6D33FA;
        Thu, 22 Sep 2022 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=oZtCrzlU8zHljgr1R2j9cDX6UybGiJ/h68xP7q8dY5c=; b=xO8rnVeZFkIlPWN5B0GOmOrTrV
        4OUxEC4juRUuOEFhDl/HilDs5jY/dBNVBOu9cbN7apobfsdv5r+kcM/4JoCPkOMyZO/MZQFXtZGKG
        iWLK0QLZQsmGq8V7gFcTmgPxQCZRgyMztSRyeSAQlg7nqk4W7hS81wJYTCGint3a52SM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1obTT2-00HZVa-Ku; Thu, 22 Sep 2022 23:10:44 +0200
Date:   Thu, 22 Sep 2022 23:10:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device
 Tree
Message-ID: <YyzPVMrfcOkvngxl@lunn.ch>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922202458.7592-4-maukka@ext.kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void __init dns323_dt_eth_fixup(void)
> +{
> +	struct device_node *np;
> +	u8 addr[ETH_ALEN];
> +	int ret;
> +
> +	/*
> +	 * The ethernet interfaces forget the MAC address assigned by u-boot
> +	 * if the clocks are turned off. Usually, u-boot on orion boards
> +	 * has no DT support to properly set local-mac-address property.
> +	 * As a workaround, we get the MAC address that is stored in flash
> +	 * and update the port device node if no valid MAC address is set.
> +	 */

This is true for Kirkwood, but orion5x does not have any clocks to
gate. So i'm pretty sure this is not true. You copied this code for a
different reason. Please document here the real reason for this code.

> +	ret = dns323_read_mac_addr(addr);
> +
> +	if (ret) {
> +		pr_warn("Unable to find MAC address in flash memory\n");
> +		return;
> +	}
> +
> +	np = of_find_compatible_node(NULL, NULL, "marvell,orion-eth-port");
> +
> +	if (!IS_ERR(np)) {
> +		struct device_node *pnp = of_get_parent(np);
> +		struct clk *clk;
> +		struct property *pmac;
> +		u8 tmpmac[ETH_ALEN];
> +		u8 *macaddr;
> +		int i;
> +
> +		if (!pnp)
> +			return;
> +
> +		/* skip disabled nodes or nodes with valid MAC address*/
> +		if (!of_device_is_available(pnp) ||
> +		    !of_get_mac_address(np, tmpmac))
> +			goto eth_fixup_skip;
> +
> +		clk = of_clk_get(pnp, 0);
> +		if (IS_ERR(clk))
> +			goto eth_fixup_skip;
> +
> +		/* ensure port clock is not gated to not hang CPU */
> +		clk_prepare_enable(clk);

I'm pretty sure this clock stuff is not needed. Please comment it out
and see if the machine locks up. Kirkwood just stops dead if you
access registers when there clocks are disabled. For Orion5x, the
ethernet should always have a clock.

> +
> +		/* store MAC address register contents in local-mac-address */
> +		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
> +		if (!pmac)
> +			goto eth_fixup_no_mem;
> +
> +		pmac->value = pmac + 1;
> +		pmac->length = ETH_ALEN;
> +		pmac->name = kstrdup("local-mac-address", GFP_KERNEL);
> +		if (!pmac->name) {
> +			kfree(pmac);
> +			goto eth_fixup_no_mem;
> +		}
> +
> +		macaddr = pmac->value;
> +		for (i = 0; i < ETH_ALEN; i++)
> +			macaddr[i] = addr[i];
> +
> +		of_update_property(np, pmac);
> +
> +eth_fixup_no_mem:
> +		clk_disable_unprepare(clk);
> +		clk_put(clk);
> +eth_fixup_skip:
> +		of_node_put(pnp);
> +	}
> +}
> +
> +void __init dns323_init_dt(void)
> +{
> +	if (of_machine_is_compatible("dlink,dns323a1")) {
> +		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */

I spotted this in dns323-setup.c as well. Do you have any idea what it
does?

	Andrew
