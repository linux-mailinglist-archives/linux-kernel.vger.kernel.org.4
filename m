Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1473D801
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjFZGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjFZGvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A8E76
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:50:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 310C960C97
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5375C433C0;
        Mon, 26 Jun 2023 06:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687762256;
        bh=NK1Y2wM/ZOdh+mw3/gFJTpCbuhSPj2RAqLErmTyzoyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ufnWcxk76jWKQLFOaqzje+TnwPLMLen61PyUWDLytnf2lE3jx+oJVgE+/3gcAClXQ
         KemKhn/4cZtBNK0H2dxij0oWQYhtxNiNWjigmZeXMGS8lzASMVO3W5OrkZ5MmK1Wqt
         L3jPVA4dwEy2xqyrmSy5gjEd3r9/3ueZKG7DjeKpfiLChThRc8O5zMiFHc4X5JKUvP
         GNJ/I1XJ7U8tJzxzp9sMo+BNKSbKhAteU6GaSlNc9UySZCOPFa9WAjlb0fhMRCFKI+
         57+jO21YV1fw2M9wC0aQ5us+FthYPGrmZ09weJYvQ+Uuqg9YCkfy//hOZAoNNWdDz/
         NCiab0BFwuA+g==
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 08:50:51 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
        =?UTF-8?Q?Marek_Beh?= =?UTF-8?Q?=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/10] net: phy: print an info if a broken C45
 bus is found
In-Reply-To: <ZJYCBeKdXBot/9Xd@corigine.com>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-6-def0ab9ccee2@kernel.org>
 <af166ce6-b9b2-44e0-9f45-2b2aa001fd6b@lunn.ch>
 <ZJYCBeKdXBot/9Xd@corigine.com>
Message-ID: <eb8390d30907893c4327ffe076c04c82@kernel.org>
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

Am 2023-06-23 22:35, schrieb Simon Horman:
> On Fri, Jun 23, 2023 at 07:42:08PM +0200, Andrew Lunn wrote:
>> On Fri, Jun 23, 2023 at 12:29:15PM +0200, Michael Walle wrote:
>> > If there is an PHY which gets confused by C45 transactions on the MDIO
>> > bus, print an info together with the PHY identifier of the offending
>> > one.
>> >
>> > Signed-off-by: Michael Walle <mwalle@kernel.org>
>> >
>> > ---
>> > I wasn't sure if this should be phydev_dbg() or phydev_info(). I mainly
>> > see this as an info to a user why some PHYs might not be probed (or
>> > c45-over-c22 is used later).
>> 
>> The information is useful to the DT writer, not the 'user'. I would
>> assume the DT writer has a bit more kernel knowledge and can debug
>> prints on. So i would suggest phydev_dbg().

Why the DT writer? There could be no DT at all, right? But yeah, fair
enough, I thought of our hardware engineers as a user, which might be
surprised to find no C45 transactions at all for a C45 PHY.

That said, I don't have a strong opinion. I'm fine to switch that to
dev_dbg() to make the kernel output less noisy.

>> > @@ -617,10 +617,10 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
>> >   */
>> >  void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
>> >  {
>> > +	struct phy_device *phydev;
>> >  	int i;
>> >
>> >  	for (i = 0; i < PHY_MAX_ADDR; i++) {
>> > -		struct phy_device *phydev;
>> >  		u32 oui;
>> 
>> It is not clear why you changed the scope of phydev. I guess another
>> version used phydev_info(), where as now you have dev_info()?
> 
> I think it is so it can be used in the dev_info() call below.

Yes, to print the PHY ID of the offending one.

> However Smatch has it's doubts that it is always initialised there.
> 
>   .../mdio_bus.c:638 mdiobus_scan_for_broken_c45_access() error: we 
> previously assumed 'phydev' could be null (see line 627)
> 
>> >  		phydev = mdiobus_get_phy(bus, i);
> 
> Line 627 immediately follows the line above, like this:
> 
> 		if (!phydev)
> 			continue;

Mhh, I see. bus->prevent_c45_access could (theoretically) set before
calling this function. I could set it to false at the beginning of
this function or I could use a new flag to indicate when to print the
warning. Any suggestions?

-michael
