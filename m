Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462D473885E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjFUPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjFUPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD55BAA;
        Wed, 21 Jun 2023 08:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8836155A;
        Wed, 21 Jun 2023 14:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC66CC433C8;
        Wed, 21 Jun 2023 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687359296;
        bh=bSDgKgIaIT7I/HAb2R0Ikz2XfAeToNBLTRIqFY41i2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDZ6bRNauyHwq6dzmJDZBnfL7lqHk5LlP9nPVhO2IUmRMZGfhnj1f+Q9liDfa/86s
         8P4Y2TyCqe4y1hJmblPWEVbdSjYKtw9z1vkIE/oWCF/hnMxXimkcJTwG6DDAcX2763
         9vyLMKbKAXgOlnitHHdntphT1vIz798ohvojXaI0astRKHidJzkuCqg4cCoMPACcXm
         7tj0/D0ERra+CpIlP0FBrXL3xKBZJrVvJT0pqfKyolFredeGkNRqCp2rrJNR9n/4x9
         izlHFSa30qohHUt/R4c35KTDGvAAon6+FmC87iRQALDOfA/ksWXrcLwIOh9fvHg/Tb
         Bwu7IYbjlbwqQ==
Date:   Wed, 21 Jun 2023 15:54:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 1/3] leds: trigger: netdev: add additional
 specific link speed mode
Message-ID: <20230621145451.GA10378@google.com>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
 <20230619204700.6665-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619204700.6665-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023, Christian Marangi wrote:

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
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 80 +++++++++++++++++++++++----
>  include/linux/leds.h                  |  3 +
>  2 files changed, 73 insertions(+), 10 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
