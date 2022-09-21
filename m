Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F8D5BFE81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIUM5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232BB6CF58
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B47E162B3C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58A7C433D6;
        Wed, 21 Sep 2022 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663765046;
        bh=OGgXPceGJJkLuXVPedJyDxmwKaBfo87tdcas+G7ybtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMWUMwS/MzJ6pLnBI0IxFYB9qkdvRmn3atnmw6qHtxUXK4uJcHbwZwmXml2Ipj2Hg
         LmE37t+J31lAlNcztOHWK2UsAIYpL2iq7Hg5Ov5YRaeKWy3cD2Q6JP3mOP+Vf+KE2W
         rI/UFuovWCsPPuOhF5eXJFHMsth1BuAWPf8tSTAzasuXHR2Nj+KmxJPr7kCSHNtSgD
         A+UdV5MQH47BVb6sLcPgMm/wFAzisbqn2c5IsnEiqn4XRRem7XHiyf7o8qH9Rhm+oJ
         Tv5AjzeFe9sHC8LWnK440NsVjefNzSwQkvjuJf/4IpOOeLuqd1jJ1rp7WlcdjPWcNs
         S5YCFPVLa2MHg==
Received: by pali.im (Postfix)
        id 9E10C789; Wed, 21 Sep 2022 14:57:22 +0200 (CEST)
Date:   Wed, 21 Sep 2022 14:57:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Reset COMPHY
 registers before USB 3.0 power on
Message-ID: <20220921125722.enp2tffhuz55enwv@pali>
References: <20220920121154.30115-1-pali@kernel.org>
 <20220921050300.riwyofdncxscrwe3@shindev>
 <20220921080557.jdg5wywpa5qxcyo2@pali>
 <20220921124457.26hjljy7fcv45zfk@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921124457.26hjljy7fcv45zfk@shindev>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2022 12:44:58 Shinichiro Kawasaki wrote:
> On Sep 21, 2022 / 08:05, Pali Rohár wrote:
> > On Wednesday 21 September 2022 05:03:01 Shinichiro Kawasaki wrote:
> > > On Sep 20, 2022 / 14:11, Pali Rohár wrote:
> > > > Turris MOX board with older ARM Trusted Firmware version v1.5 is not able
> > > > to detect any USB 3.0 device connected to USB-A port on Mox-A module after
> > > > commit 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken
> > > > reset support"). On the other hand USB 2.0 devices connected to the same
> > > > USB-A port are working fine.
> > > > 
> > > > It looks as if the older firmware configures COMPHY registers for USB 3.0
> > > > somehow incompatibly for kernel driver. Experiments show that resetting
> > > > COMPHY registers via setting SFT_RST auto-clearing bit in COMPHY_SFT_RESET
> > > > register fixes this issue.
> > > > 
> > > > Reset the COMPHY in mvebu_a3700_comphy_usb3_power_on() function as a first
> > > > step after selecting COMPHY lane and USB 3.0 function. With this change
> > > > Turris MOX board can successfully detect USB 3.0 devices again.
> > > > 
> > > > Before the above mentioned commit this reset was implemented in PHY reset
> > > > method, so this is the reason why there was no issue with older firmware
> > > > version then.
> > > > 
> > > > Fixes: 0a6fc70d76bd ("phy: marvell: phy-mvebu-a3700-comphy: Remove broken reset support")
> > > > Reported-by: Marek Behún <kabel@kernel.org>
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > > Shinichiro, could you please check that all USB functionality still
> > > > works correctly on your board?
> > > > ---
> > > 
> > > Sure. TL;DR, this patch works ok for my espressobin v7 board.
> > > 
> > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > 
> > > I prepared base kernel v5.19.10 applying the commit 0a6fc70d76bd. Regardless
> > > whether this fix patch for Turrix MOX board is applied or not, two USB ports on
> > > my esprssobin v7 board worked as expected. I confirmed it by using USB thumb
> > > drive. The drive was detected and its partition was mounted successfully using
> > > either of the two USB ports.
> > 
> > Thank you for testing! Anyway, please check that USB 3.0 device is
> > working fine. Because as I wrote in commit message, on Turris Mox was
> > USB 2.0 device working fine, but USB 3.0 not. And maybe check in system
> > (lsusb) that USB 3.0 device was really detected as USB 3.0 because USB
> > 3.0 devices have supported also fallback USB 2.0/1.x legacy mode.
> 
> Ah, I see. For that check, I connected my USB 3.1 drive to the USB 3.0 port of
> my espressobin, then checked 'lsusb -vt' and sysfs:
> 
> $ lsusb -vt
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>     ID 1d6b:0003 Linux Foundation 3.0 root hub
>     |__ Port 1: Dev 2, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
>         ID 0781:5583 SanDisk Corp. Ultra Fit
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
>     ID 1d6b:0002 Linux Foundation 2.0 root hub
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=orion-ehci/1p, 480M
>     ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> $ cat /sys/bus/usb/devices/3-1/version 
>  3.00
> 
> USB3 port is listed under the Bus 03, "3.0" root hub. According to sysfs, its
> USB version is 3.00. I observed same outputs with and without the patch for
> Turris MOX board.
> 
> Are these good enough? If other check is needed, please let me know.

Perfect, that is enough! If USB 3.1 drive is detected and working then
everything is OK.
