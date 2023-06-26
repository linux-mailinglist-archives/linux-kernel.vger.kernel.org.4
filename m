Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D0F73D84A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFZHPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFZHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056141AD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3760E60CBB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB0AC433C9;
        Mon, 26 Jun 2023 07:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687763691;
        bh=oQZ84XlT6gBokBX5+oyJLL3d5IYeNAfxZeJGitZc8so=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NAAjePZ5DL9HIveOd5UEX7UkXAVtNas2WyE0Br2ufbEipVdloMac8N1ApcPtWRNiX
         UJsE9UHhrn/njbHFaY7X+rBB9S4Rma8x4OqxeYxK+4YbdqhLTnIQXqiV1TqQjJhklp
         f6UALBkriIcA79z8tVXfkdiaNoyDPyXOsRPJqFjig/Qjntot6Gn03XE0cnLabuk/CO
         +3gWRDCse/on6d3GfUbhX9z1YmMUcDy580obmxPxT94Ds2F5Nkf7nRXj58MFOeRQ4f
         Rr2TjHQODBrwYN9EulNzAnnjpY5YszEpZ0g0oWVqmxp2UjxPDuMHX4hm9mEr8/IJFv
         snKgKr6Bk6Jyg==
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 09:14:46 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] net: phy: add support for C45-over-C22
 transfers
In-Reply-To: <52859948-9812-4b0b-ae5f-7e174926d5c4@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-7-def0ab9ccee2@kernel.org>
 <52859948-9812-4b0b-ae5f-7e174926d5c4@lunn.ch>
Message-ID: <6288946d020417d9c87236235d5c664f@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-06-24 22:15, schrieb Andrew Lunn:
>>  int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
>>  {
>> -	int val;
>> +	struct mii_bus *bus = phydev->mdio.bus;
>> +	int phy_addr = phydev->mdio.addr;
>> +	bool check_rc = true;
>> +	int ret;
> 
> Although __phy_read_mmd() is exported as a GPL symbol, it is not in
> fact used outside of this file. I think we can easily change it
> signature.
> 
>> +	switch (phydev->access_mode) {
> 
> Have access_mode passed in as a parameter. It then becomes a generic
> low level helper.

Are you sure? Why is it a generic helper then? You still need the phydev
parameter. E.g. for the bus, the address and more importantly, for the
phydev->drv->read_mmd op. And in this case, you can't use it for my new
phy_probe_mmd_read() because there is no phydev structure at that time.

Also __phy_read_mmd() is just one of a whole block of (unlocked) 
functions
to access the MMDs of a PHY. So, to be consistent you'd have to change 
all
the other ones, too. No?

That being said, what about a true generic helper, without the phydev
parameter, which is then called in __phy_{read,write}_mmd()? Where
would that helper belong to? Without the C45-over-C22 I'd have suggested
to put it into mdio_bus.c but C45-over-C22 being a PHY thing, I guess
it should be in phy-core.c.

> The function which is really exported and expected to by used by PHY
> drivers is:
> 
> int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
> {
> 	int ret;
> 
> 	phy_lock_mdio_bus(phydev);
> 	ret = __phy_read_mmd(phydev, devad, regnum);
> 	phy_unlock_mdio_bus(phydev);
> 
> 	return ret;
> }
> EXPORT_SYMBOL(phy_read_mmd);
> 
> This can easily pass phydev->access_mode as a parameter.
> 
>> +static int phy_probe_mmd_read(struct mii_bus *bus, int prtad, int 
>> devad,
>> +			      u16 regnum, bool c45_over_c22)
>> +{
> 
> What i don't like is this bool c45_over_c22. Why have both the enum
> for the three access modes, and this bool. Pass an access mode.

Ok, but just to be sure, access mode c22 is then a "return -EINVAL".

>> +	int ret;
>> +
>> +	if (!c45_over_c22)
>> +		return mdiobus_c45_read(bus, prtad, devad, regnum);
>> +
>> +	mutex_lock(&bus->mdio_lock);
>> +
>> +	ret = __phy_mmd_indirect(bus, prtad, devad, regnum);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = __mdiobus_read(bus, prtad, MII_MMD_DATA);
> 
> And then this just uses the generic low level __phy_read_mmd().

See above, no there is no *phydev.

-michael
