Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF9173D7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFZGbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjFZGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CD8E3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AACCB60C8F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52035C433C0;
        Mon, 26 Jun 2023 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687761092;
        bh=yTWynjpAhpo2gu8Y4caUg/BFG5wYbkP2zkvjL/DB+iQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LaDimiIMDAPdF/zygITg2soLuLIZLvuykkxrp0pq2SxUk+MIRbHLJo3CZojzxrv6o
         qvKl2hXpxJliJcF/VrevKzExYeltWMqPqIscp8kGuI6iG4XkzcQQ2BAAP2+4gI+qki
         aB1pplzRZuNsz57kX9mxY3R7ymmmtJ9G+0Q3wR2jrAMqknyEeC81mitslpQuaLkwur
         riAKJEejphOvrZuUQ//AQoDxN4tnjfnrG3VkLQbvoYZifm/LC/1os9DGFVrzdmbYaJ
         5WI1zjg4v++1OlRkUTc2djVrB1JMbU7t/DBaG3uCZvOx2LHO0EfC90mLA0mZBG0lgo
         OY7s9HcP/xnHQ==
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 08:31:26 +0200
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
Subject: Re: [PATCH net-next v2 04/10] net: phy: replace is_c45 with
 phy_accces_mode
In-Reply-To: <6fcd887a-c731-4c31-bb43-e8d14071524e@lunn.ch>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-4-def0ab9ccee2@kernel.org>
 <52cdebe9-0f94-430d-93ff-11f26d2e3c5b@lunn.ch>
 <6fcd887a-c731-4c31-bb43-e8d14071524e@lunn.ch>
Message-ID: <353752b143bca56f79035635808e8e30@kernel.org>
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

Am 2023-06-23 21:54, schrieb Andrew Lunn:
> On Fri, Jun 23, 2023 at 07:34:22PM +0200, Andrew Lunn wrote:
>> > @@ -131,9 +131,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>> >
>> >  	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
>> >  	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
>> > -		phy = get_phy_device(bus, addr, is_c45);
>> > +		phy = get_phy_device(bus, addr,
>> > +				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
>> >  	else
>> > -		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
>> > +		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
>> > +					NULL);
>> 
>> Documentation/devicetree/bindings/net/ethernet-phy.yaml says:
>> 
>>   compatible:
>>     oneOf:
>>       - const: ethernet-phy-ieee802.3-c22
>>         description: PHYs that implement IEEE802.3 clause 22
>>       - const: ethernet-phy-ieee802.3-c45
>>         description: PHYs that implement IEEE802.3 clause 45
>> 
>> It would be nice to make this documentation more specific. It now
>> refers to 'bus transaction', so maybe we want to append that to these
>> lines?
> 
> Humm, looking at patch 9, maybe i got this wrong. Patch 9 seems to
> suggest ethernet-phy-ieee802.3-c45 means c45 register space, and it is
> upto the core to figure out how to access that register space, either
> using c45 transactions, or C45 over C22.

Yes. And I think the core has all information to determine what mode
should be used. Use C45 transfers first and iff that's not possible
switch to C45-over-C22. Therefore, there isn't really a choice. It's
either "it will work" or "it won't work at all".

For all supported C45 PHYs right now, the mode should stay with C45
because, that was the only supported mode. Except, if a C45 PHY was
probed as a C22 PHY and stayed that way. With this patchset they
would now be probed a PHY with C45 registers and using C45-over-C22.
But I'm not sure if that's a thing.

-michael
