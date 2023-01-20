Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3D674D89
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjATG66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:58:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E862D58;
        Thu, 19 Jan 2023 22:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACF3EB8184E;
        Fri, 20 Jan 2023 06:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C5DC433EF;
        Fri, 20 Jan 2023 06:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674197933;
        bh=1aDhdD8dlQNsJqn7RhlLZ4uUS8ZQrUcBhKch1rmt+VA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omrqTdMK+jbcdPsuSg6Qx5WaM+ZdejI7Nd574Iw9bf5zdVTwOqUZ+nT8PE3IKHD68
         YeeguDPIItOS3iR1xdZpQqkQgnl+7/+Jn0eolM3bRuQGHwAwpgA7WsPOXPAsiZasPn
         dZWRJerLTAXR+vHzY1Uff+1Jc7+IYBIGTiZYVAdo=
Date:   Fri, 20 Jan 2023 07:58:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v5 6/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Message-ID: <Y8o7qXl9dSRdt1JO@kroah.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
 <20230119115503.268693-7-umang.jain@ideasonboard.com>
 <Y8nz1inld2Hwdc5i@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8nz1inld2Hwdc5i@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:52:22AM +0200, Laurent Pinchart wrote:
> Hi Umang,
> 
> Thank you for the patch.
> 
> On Thu, Jan 19, 2023 at 05:25:03PM +0530, Umang Jain wrote:
> > The devices that the vchiq interface registers(bcm2835-audio,
> 
> Missing space before '('.
> 
> > bcm2835-camera) are implemented and exposed by the VC04 firmware.
> > The device tree describes the VC04 itself with the resources
> > required to communicate with it through a mailbox interface. However,
> > the vchiq interface registers these devices as platform devices. This
> > also means the specific drivers for these devices are also getting
> 
> Drop one of the two "also".
> 
> > registered as platform drivers. This is not correct and a blatant
> > abuse of platform device/driver.
> > 
> > Replace the platform device/driver model with a standard device driver
> > model. A custom bus_type, vchiq_bus_type, is created in the vchiq
> > interface which matches the devices to their specific device drivers
> > thereby, establishing driver binding. A struct vchiq_device wraps the
> > struct device for each device being registered on the bus by the vchiq
> > interface.
> > 
> > Each device registered will expose a 'name' read-only device attribute
> > in sysfs (/sys/bus/vchiq-bus/devices). New devices and drivers can be
> > added by registering on vchiq_bus_type and adding a corresponding
> > device name entry in the static list of devices, vchiq_devices. There
> > is currently no way to enumerate the VCHIQ devices that are available
> > from the firmware.
> 
> Greg, I don't know if you've followed the conversation in earlier mail
> threads, so I'll try to summarize it here.
> 
> There are two layers involved: the VCHIQ layer, which has two clients
> (audio and MMAL), and the MMAL layer, which has multiple clients
> (camera, codec, ISP). The reason for this is that audio and mmal are
> separate hardware, while camera, codec and ISP share some hardware
> blocks.
> 
> The VCHIQ layer provides a mailbox API to its clients to communicate
> with the firmware, and the MMAL layer provides another API implemented
> on top of the VCHIQ layer. Neither APIs offer a way to discover devices
> dynamically (that's not a feature implemented by the firmware). We've
> decided that implementing two buses would be overkill, so Umang went for
> a single vchiq_bus_type. The only value it provides is to stop abusing
> platform_device. That's pretty much it.
> 
> Given the above explanation, do you still think the additional
> complexity introduced by the vchiq bus type is worth it (it more or less
> duplicates a small subset of the platform bus type implementation), and
> are you fine with a single bus type, even if it doesn't exactly match
> the firmware layers ?

Yes, this is the correct way forward.  I didn't review the changes yet,
but I see you just gave a good first pass, so I'll wait for the next
revision.

thanks,

greg k-h
