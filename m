Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7618266E697
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAQTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjAQTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:06:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8C031E22;
        Tue, 17 Jan 2023 10:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2266B81975;
        Tue, 17 Jan 2023 18:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CC6C433D2;
        Tue, 17 Jan 2023 18:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673979677;
        bh=7aRxXGEphfT5LNMRbYhiA6ttlYV7jeRaPdDuQxYBe1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZ8uKQWBVJtfGdGphoRSRsp6ZpplVL6v+28Np9lbvLZtyzxyz0n7qzYQnZK3WbcuI
         Vm1VmRRmopnaQxqO/owyQnXLDMrQooltH+R4vGrvJDuusEwvV1ozameHVdtIGcMVdT
         qO7tPHaWpZPOTN33zIcKWKGhQUJG6cJ4stD8t0OY=
Date:   Tue, 17 Jan 2023 19:21:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3] staging: vc04_services: vchiq: Register devices with
 a custom bus_type
Message-ID: <Y8bnGrsxQD6/eYu3@kroah.com>
References: <20230111090029.250884-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111090029.250884-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:30:29PM +0530, Umang Jain wrote:
> The devices that the vchiq interface registers(bcm2835-audio,
> bcm2835-camera) are implemented and exposed by the VC04 firmware.
> The device tree describes the VC04 itself with the resources
> required to communicate with it through a mailbox interface. However,
> the vchiq interface registers these devices as platform devices. This
> also means the specific drivers for these devices are also getting
> registered as platform drivers. This is not correct and a blatant
> abuse of platform device/driver.
> 
> Replace the platform device/driver model with a standard device driver
> model. A custom bus_type, vchiq_bus_type, is created in the vchiq
> interface which matches the devices to their specific device drivers
> thereby, establishing driver binding. A struct vchiq_device wraps the
> struct device for each device being registered on the bus by the vchiq
> interface.
> 
> Each device registered will expose a 'name' read-only device attribute
> in sysfs (/sys/bus/vchiq-bus/devices). New devices and drivers can be
> added by registering on vchiq_bus_type and adding a corresponding
> device name entry in the static list of devices, vchiq_devices. There
> is currently no way to enumerate the VCHIQ devices that are available
> from the firmware.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
> Changes in v3:
> - Rework entirely to replace platform devices/driver model
> 
> -v2:
> https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/
> 
> -v1:
> https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/
> 
> - Developed on top of:
> [PATCH v3 0/7] staging: vc04_services: Remove custom return values
> 
> ---
>  .../vc04_services/bcm2835-audio/Makefile      |   5 +-
>  .../vc04_services/bcm2835-audio/bcm2835.c     |  19 ++-
>  .../vc04_services/bcm2835-camera/Makefile     |   2 +
>  .../bcm2835-camera/bcm2835-camera.c           |  17 ++-
>  .../interface/vchiq_arm/vchiq_arm.c           | 121 +++++++++++++++---
>  .../interface/vchiq_arm/vchiq_arm.h           |   1 +
>  6 files changed, 123 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> index d59fe4dde615..4801467be58a 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
> +++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> @@ -2,4 +2,7 @@
>  obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
>  snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
>  
> -ccflags-y += -I $(srctree)/$(src)/../include -D__VCCOREVER__=0x04000000
> +ccflags-y += \
> +	-I $(srctree)/$(src)/../include \
> +	-I $(srctree)/$(src)/../interface/vchiq_arm \

Please never add new -I entries, as that can break the build when you
only want to build a subdirectory.  Just use the "../" in the .c files
instead.

While you are not responsible for the original one here, please never
add a new one.

And, you can work to get rid of the current addition as well, that
should be done sooner rather than later anyway.

thanks,

greg k-h
