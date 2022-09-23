Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228B5E7665
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiIWJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWJDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:03:33 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB79C63;
        Fri, 23 Sep 2022 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Cc:To:From:Date:MIME-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L6X+NVyykXECXexASvsjv9HnB25hHqHZ/AABK6aPkPA=; b=m0BvF06QPo/4R7lQ/IuDPVoQoa
        EGz/4wcqoR1yO7qLsvegnsXSmZdbo74Cp7OE2hnt4v7QLY5ihwDzvWIOkf678xfZ+DPUuZnUdGqXf
        5ADyLJA+03hxf/OeIzc1fDU7ok6FsgcDzJMLId0o+4op54pXy59dmDtmwKL8oMgs/aI6zGLWlDkzS
        /XdxJ+OXt7DAcaktPcHqA3RaFFXX2KNZ/g+zo7W4rjoNyTbHlGNIjtlR6e+X9PS8PtF66C/GxdNp1
        AqwfoG7RKBtF34gMCxN+oo+9mxNWQ4RDAB8EkPkkkKHhpQR2iftBKzUIvdwrUFyXUqfOAmV1p8okZ
        A9gi5uDA==;
Received: from [2001:67c:1be8::200] (port=42784 helo=roundcube.kapsi.fi)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1obeaY-009Bxr-Ba; Fri, 23 Sep 2022 12:03:14 +0300
MIME-Version: 1.0
Date:   Fri, 23 Sep 2022 12:03:14 +0300
From:   maukka@ext.kapsi.fi
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <YyzPVMrfcOkvngxl@lunn.ch>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi> <YyzPVMrfcOkvngxl@lunn.ch>
Message-ID: <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi>
X-Sender: maukka@ext.kapsi.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:1be8::200
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device
 Tree
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.9.2022 00:10, Andrew Lunn wrote:
>> +static void __init dns323_dt_eth_fixup(void)
>> +{
>> +	struct device_node *np;
>> +	u8 addr[ETH_ALEN];
>> +	int ret;
>> +
>> +	/*
>> +	 * The ethernet interfaces forget the MAC address assigned by u-boot
>> +	 * if the clocks are turned off. Usually, u-boot on orion boards
>> +	 * has no DT support to properly set local-mac-address property.
>> +	 * As a workaround, we get the MAC address that is stored in flash
>> +	 * and update the port device node if no valid MAC address is set.
>> +	 */
> 
> This is true for Kirkwood, but orion5x does not have any clocks to
> gate. So i'm pretty sure this is not true. You copied this code for a
> different reason. Please document here the real reason for this code.
> 

Yes, will do. To my understanding it looks like uboot does not pass 
anything
to the kernel.

>> +	ret = dns323_read_mac_addr(addr);
>> +
>> +	if (ret) {
>> +		pr_warn("Unable to find MAC address in flash memory\n");
>> +		return;
>> +	}
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "marvell,orion-eth-port");
>> +
>> +	if (!IS_ERR(np)) {
>> +		struct device_node *pnp = of_get_parent(np);
>> +		struct clk *clk;
>> +		struct property *pmac;
>> +		u8 tmpmac[ETH_ALEN];
>> +		u8 *macaddr;
>> +		int i;
>> +
>> +		if (!pnp)
>> +			return;
>> +
>> +		/* skip disabled nodes or nodes with valid MAC address*/
>> +		if (!of_device_is_available(pnp) ||
>> +		    !of_get_mac_address(np, tmpmac))
>> +			goto eth_fixup_skip;
>> +
>> +		clk = of_clk_get(pnp, 0);
>> +		if (IS_ERR(clk))
>> +			goto eth_fixup_skip;
>> +
>> +		/* ensure port clock is not gated to not hang CPU */
>> +		clk_prepare_enable(clk);
> 
> I'm pretty sure this clock stuff is not needed. Please comment it out
> and see if the machine locks up. Kirkwood just stops dead if you
> access registers when there clocks are disabled. For Orion5x, the
> ethernet should always have a clock.
> 

Will do.

>> +
>> +		/* store MAC address register contents in local-mac-address */
>> +		pmac = kzalloc(sizeof(*pmac) + 6, GFP_KERNEL);
>> +		if (!pmac)
>> +			goto eth_fixup_no_mem;
>> +
>> +		pmac->value = pmac + 1;
>> +		pmac->length = ETH_ALEN;
>> +		pmac->name = kstrdup("local-mac-address", GFP_KERNEL);
>> +		if (!pmac->name) {
>> +			kfree(pmac);
>> +			goto eth_fixup_no_mem;
>> +		}
>> +
>> +		macaddr = pmac->value;
>> +		for (i = 0; i < ETH_ALEN; i++)
>> +			macaddr[i] = addr[i];
>> +
>> +		of_update_property(np, pmac);
>> +
>> +eth_fixup_no_mem:
>> +		clk_disable_unprepare(clk);
>> +		clk_put(clk);
>> +eth_fixup_skip:
>> +		of_node_put(pnp);
>> +	}
>> +}
>> +
>> +void __init dns323_init_dt(void)
>> +{
>> +	if (of_machine_is_compatible("dlink,dns323a1")) {
>> +		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
> 
> I spotted this in dns323-setup.c as well. Do you have any idea what it
> does?
> 

No idea. I have tried to replicate what was in dns323-setup.c as exactly 
as possible.
I can try to leave it out and see if anything changes.

