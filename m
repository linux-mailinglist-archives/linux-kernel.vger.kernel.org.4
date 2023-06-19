Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195E735301
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFSKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjFSKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A2CC;
        Mon, 19 Jun 2023 03:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F7D60B7F;
        Mon, 19 Jun 2023 10:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899B0C433C9;
        Mon, 19 Jun 2023 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687171235;
        bh=A32VZcKVct460PbyXiy0SEpYxkFlA+mChVgoKGC13xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvE1YV7pbgTDCY3xO/1Vy4uSFVfwNSfxbjzoDv5tR5bIsVAkLbrCG5odDnpBe6Vwh
         f5dMtO61lxlnfhjksIrUy5HSyS3G8piHZ9sD+JcjP5xsNih0CvYJNPT9VkUvTrZ7UH
         OpoFkuuhuV+gRMumPY1YXTX54WpuRH00qUrKTyH/D0k81qHuefhf+XReLAEu13o9QN
         AAn/9lKPcgLaC5nROiynVUvvjBTJ9S+oJdSg1spNJGahdul6PvRSbLnUNnvicbmMiE
         H0rtAZegrL64yXltbK/Rg3AeILfFBKEfej/nz8uLw+u8ZrgtvhkQbOV1XFA4hKbmtZ
         Hcjg3fThT0dHw==
Date:   Mon, 19 Jun 2023 11:40:30 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 0/3] leds: trigger: netdev: add additional
 modes
Message-ID: <20230619104030.GB1472962@google.com>
References: <20230617115355.22868-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230617115355.22868-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023, Christian Marangi wrote:

> This is a continue of [1]. It was decided to take a more gradual
> approach to implement LEDs support for switch and phy starting with
> basic support and then implementing the hw control part when we have all
> the prereq done.
> 
> This should be the final part for the netdev trigger.
> I added net-next tag and added netdev mailing list since I was informed
> that this should be merged with netdev branch.
> 
> We collect some info around and we found a good set of modes that are
> common in almost all the PHY and Switch.
> 
> These modes are:
> - Modes for dedicated link speed(10, 100, 1000 mbps). Additional mode
>   can be added later following this example.
> - Modes for half and full duplex.
> 
> The original idea was to add hw control only modes.
> While the concept makes sense in practice it would results in lots of 
> additional code and extra check to make sure we are setting correct modes.
> 
> With the suggestion from Andrew it was pointed out that using the ethtool
> APIs we can actually get the current link speed and duplex and this
> effectively removed the problem of having hw control only modes since we
> can fallback to software.
> 
> Since these modes are supported by software, we can skip providing an
> user for this in the LED driver to support hw control for these new modes
> (that will come right after this is merged) and prevent this to be another
> multi subsystem series.
> 
> For link speed and duplex we use ethtool APIs.
> 
> To call ethtool APIs, rtnl lock is needed but this can be skipped on
> handling netdev events as the lock is already held.
> 
> [1] https://lore.kernel.org/lkml/20230216013230.22978-1-ansuelsmth@gmail.com/
> 
> Changes v4:
> - Add net-next tag
> - Add additional patch to expose hw_control via sysfs
> - CC netdev mailing list
> Changes v3:
> - Add Andrew review tag
> - Use SPEED_UNKNOWN to init link_speed
> - Fix using HALF_DUPLEX as duplex init and use DUPLEX_UNKNOWN instead
> Changes v2:
> - Drop ACTIVITY patch as it can be handled internally in the LED driver
> - Reduce duplicate code and move the link state to a dedicated helper
> 
> Christian Marangi (3):
>   leds: trigger: netdev: add additional specific link speed mode
>   leds: trigger: netdev: add additional specific link duplex mode
>   leds: trigger: netdev: expose hw_control status via sysfs
> 
>  drivers/leds/trigger/ledtrig-netdev.c | 114 +++++++++++++++++++++++---
>  include/linux/leds.h                  |   5 ++
>  2 files changed, 109 insertions(+), 10 deletions(-)

Seeing as we're on -rc7 already, any reason why we shouldn't hold off
and simply apply these against LEDs once v6.5 is released?

-- 
Lee Jones [李琼斯]
