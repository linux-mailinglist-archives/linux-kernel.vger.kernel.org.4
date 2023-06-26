Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0573D8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFZHh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZHhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:37:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F60C1AD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C744A60CEE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DEC433C8;
        Mon, 26 Jun 2023 07:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687765073;
        bh=RKPoNxTE7vcvysXf4LPjc4udS84UlrS8TNGtbR/i1LM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JvD6qUdQCSq/1egAvme7X/GHETIBaQmDFD6mhyJxV5fUXJ5A08wSqYgbiu7RCfnwv
         yRWZh4DmDvj+LV2IRW6uYa92Y3GNwMdSXUMM5ftsL6EZdH5dJRviIhrhEvbG16FPV9
         d8W5QLqYkLMXvl8B51Geber6X9Ci2r4JqHOH9DPizVroZbL07wJUFSidD7bfYdOpqx
         Q5p7ilCG1ee4EDZLdFW2eST+55JwOKLV4pp0fsl/5ZQgU0R1dyN1q9jB2JGcRWLwxQ
         oE4xcdjp0K1R19HjP6FsqpZoyno/bXy/d8x732wGEV7/X777cOqVfWl4DHRHVjyjIW
         0sn3hT1qVWPsQ==
MIME-Version: 1.0
Date:   Mon, 26 Jun 2023 09:37:47 +0200
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
Subject: Re: [PATCH net-next v2 10/10] net: mdio: support C45-over-C22 when
 probed via OF
In-Reply-To: <ZJYFDcbZqI+EC3OX@corigine.com>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
 <20230620-feature-c45-over-c22-v2-10-def0ab9ccee2@kernel.org>
 <ZJYFDcbZqI+EC3OX@corigine.com>
Message-ID: <e5e1af31a4e609c94ac306f4f5140193@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Am 2023-06-23 22:48, schrieb Simon Horman:
> On Fri, Jun 23, 2023 at 12:29:19PM +0200, Michael Walle wrote:
> 
> ...
> 
>> @@ -178,24 +209,26 @@ int __of_mdiobus_register(struct mii_bus *mdio, 
>> struct device_node *np,
>>  	if (rc)
>>  		return rc;
>> 
>> -	/* Loop over the child nodes and register a phy_device for each phy 
>> */
>> +	/* Loop over the child nodes, skipping C45 PHYs so we can scan for
>> +	 * broken C22 PHYs. The C45 PHYs will be registered afterwards.
>> +	 */
>>  	for_each_available_child_of_node(np, child) {
>> -		addr = of_mdio_parse_addr(&mdio->dev, child);
>> -		if (addr < 0) {
>> -			scanphys = true;
>> +		if (of_mdiobus_child_is_c45_phy(child))
>>  			continue;
>> -		}
>> +		rc = of_mdiobus_register_child(mdio, child, &scanphys);
>> +		if (rc)
>> +			goto unregister;
>> +	}
>> 
>> -		if (of_mdiobus_child_is_phy(child))
>> -			rc = of_mdiobus_register_phy(mdio, child, addr);
>> -		else
>> -			rc = of_mdiobus_register_device(mdio, child, addr);
>> +	/* Some C22 PHYs are broken with C45 transactions. */
>> +	mdiobus_scan_for_broken_c45_access(mdio);
> 
> Hi Michael,
> 
> Unfortunately this seems to cause a build fauilure
> for x86_64 allmodconfig.
> 
> ERROR: modpost: "mdiobus_scan_for_broken_c45_access" 
> [drivers/net/mdio/of_mdio.ko] undefined!

Oops, sorry. Seems I've forgot to export it. I guess it should
be EXPORT_SYMBOL_GPL().

-michael
