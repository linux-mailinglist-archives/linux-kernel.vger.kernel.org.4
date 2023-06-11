Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FC72B2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjFKP5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:57:14 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5FA97;
        Sun, 11 Jun 2023 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=O155xlsWatty/vA22Zc9zho7iQTVGa+NrR8XT21K/Tk=; b=otdvCnjtSg9IT7hk2j96Y7df1I
        Ixow3w8GfZyD1HYabAWVOlv7bAwLFC3lphAShk29m376zECDOaKJSsHDsCcfpJG3s9wCXKCuw0XMj
        MKDt6XZSZR2hjfjDWn3DdkrwNKTf5CgJZx273gDO9iLiSpdcPWq1y25Pb2MfMaQs6UP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q8NRA-00FVrE-QN; Sun, 11 Jun 2023 17:57:04 +0200
Date:   Sun, 11 Jun 2023 17:57:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: trigger: netdev: add additional specific
 link speed mode
Message-ID: <ef4f7d7b-6dd9-4dbc-adea-2470b5478b50@lunn.ch>
References: <20230610041616.21141-1-ansuelsmth@gmail.com>
 <20230610041616.21141-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610041616.21141-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 06:16:15AM +0200, Christian Marangi wrote:
> Add additional modes for specific link speed. Use ethtool APIs to get the
> current link speed and enable the LED accordingly. Under netdev event
> handler the rtnl lock is already held and is not needed to be set to
> access ethtool APIs.
> 
> This is especially useful for PHY and Switch that supports LEDs hw
> control for specific link speed. (example scenario a PHY that have 2 LED
> connected one green and one orange where the green is turned on with
> 1000mbps speed and orange is turned on with 10mpbs speed)
> 
> On mode set from sysfs we check if we have enabled split link speed mode
> and reject enabling generic link mode to prevent wrong and redundant
> configuration.
> 
> Rework logic on the set baseline state to support these new modes to
> select if we need to turn on or off the LED.
> 
> Add additional modes:
> - link_10: Turn on LED when link speed is 10mbps
> - link_100: Turn on LED when link speed is 100mbps
> - link_1000: Turn on LED when link speed is 1000mbps
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
