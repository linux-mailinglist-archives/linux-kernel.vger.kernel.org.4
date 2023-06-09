Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9C729CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjFIOZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241386AbjFIOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:25:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B683A92;
        Fri,  9 Jun 2023 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=bXpo5an5196WDZpIgE59UGMtc7zp7G/aFyDLKV93j7A=; b=JIK9TLd62MQWABt6DFJ6ya498i
        0Yk/8AY13/C0NHcZ85hzeW4GlfHxmY3u8T3JDZCEFwam2tMt3BS3n43Zx6Goqs1qK7JG7AEFYrRUj
        VjRGL0Hkd4KZr9F6WbiAfwyj3UzXJRzgR7a+1vPjID+SSH5lpk4HGRJgibUsKgJQZN0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q7d3C-00FLqi-7Q; Fri, 09 Jun 2023 16:25:14 +0200
Date:   Fri, 9 Jun 2023 16:25:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] leds: trigger: netdev: add additional specific link
 speed mode
Message-ID: <b4d25621-f89a-4b48-9a00-33274f130e8c@lunn.ch>
References: <20230609135103.14221-1-ansuelsmth@gmail.com>
 <20230609135103.14221-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609135103.14221-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (trigger_data->net_dev != NULL) {
> +		struct ethtool_link_ksettings cmd;
> +

cmd is a stack variable, so contains random junk:

>  		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
>  
> +		if (trigger_data->carrier_link_up) {
> +			rtnl_lock();
> +			__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);

/* Internal kernel helper to query a device ethtool_link_settings. */
int __ethtool_get_link_ksettings(struct net_device *dev,
				 struct ethtool_link_ksettings *link_ksettings)
{
	ASSERT_RTNL();

	if (!dev->ethtool_ops->get_link_ksettings)
		return -EOPNOTSUPP;

If the op is not implemented, it just returns.


> +			rtnl_unlock();
> +
> +			trigger_data->link_speed = cmd.base.speed;

and now you are accessing the random junk.

> +			__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
> +
> +			trigger_data->link_speed = cmd.base.speed;

You have this code three times. I suggest you pull it out into a
little helper, and within the helper, deal with the return code, and
set speed to 0 if it is unknown.

    Andrew
