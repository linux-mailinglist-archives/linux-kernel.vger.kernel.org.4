Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533646561D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiLZK1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLZK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:27:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189235FD1;
        Mon, 26 Dec 2022 02:27:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A96D8B80D11;
        Mon, 26 Dec 2022 10:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6701C433EF;
        Mon, 26 Dec 2022 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672050442;
        bh=hVha1FGsr/BmeLaghWhC0c48RTyAxF2U24ZFLUAgVy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEzCXCcvjH80vck2xNc8lJwSRl7Ssq363WQs0RJehi4p1GOTP1f3BS8lvw3BgFB21
         MKx65XskwpIedzprYHvmYoTx/LzR5U1KQn3c/6hzl4qqH8IUNWW1HsBbzWAUAlMYz+
         HRLQVPVTvfpav5RLlt8Ta57YCl03wnAseVeuM1KQ=
Date:   Mon, 26 Dec 2022 11:27:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Create
 platform_device per device
Message-ID: <Y6l3B8QOdkY9adLh@kroah.com>
References: <20221220084404.19280-1-umang.jain@ideasonboard.com>
 <Y6Lqs8RUiyi452gM@pendragon.ideasonboard.com>
 <Y6MF3l40WM3onmyO@kroah.com>
 <d48462f6-de4c-2816-0a7a-b3b13993604c@ideasonboard.com>
 <Y6SVegtHvwQ3p+3K@pendragon.ideasonboard.com>
 <629b3f63-74e4-5cb5-29d1-6d2846bc24c7@i2se.com>
 <Y6W/q7v0KdYNy81+@kroah.com>
 <Y6lyPS6XWhACIF5j@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6lyPS6XWhACIF5j@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 12:06:53PM +0200, Laurent Pinchart wrote:
> On Fri, Dec 23, 2022 at 03:48:11PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Dec 23, 2022 at 12:24:22PM +0100, Stefan Wahren wrote:
> > > i vaguely remember the discussion how to represent audio and camera
> > > interface in the device tree. Representing as child nodes of the VC4 has
> > > been rejected on the device tree mailing some years ago, because this
> > > doesn't represent the physical (hardware) wiring. It's still possible to
> > > access e.g. the camera interface from the ARM.
> > > 
> > > The whole approach with using a separate binding for all the firmware stuff
> > > lead to a lot of trouble on the Raspberry Pi platform (ugly dependencies
> > > between firmware, DT and kernel). So i would like to avoid this here. In
> > > case the current implementation is a no go, how about letting the ARM core
> > > discover the available interfaces e.g. via mailbox interface?
> > > 
> > > For more inspiration take a look at this old thread [1]
> > 
> > Yes, that's the proper way to do this please!  This should be a bus and
> > dynamically add the devices when found, it is NOT a platform device
> > anymore.
> 
> I'm fine with making this a bus, but when it comes to dynamically adding
> devices, that depends on the firmware exposing an interface to enumerate
> those devices. If that's not possible, are you fine with a custom bus
> and hardcoded children device instantiation in the VCHIQ driver ?

Yes, that is at least a step forward and is not abusing the platform
device/driver code.

thanks,

greg k-h
