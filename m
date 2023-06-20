Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40EB736E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjFTORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjFTORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FDBB3;
        Tue, 20 Jun 2023 07:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B095D6128D;
        Tue, 20 Jun 2023 14:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AAEC433C8;
        Tue, 20 Jun 2023 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687270628;
        bh=eJNBsqRHWVUBKO9jQvaQZ7ZEyPf7EYF1nWFETYd9yLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAW6JDSzf/cBs0cf/m8szRjrtC1b/jSxNktmJqcOTyHsErMhju7fPWEVRblBjkF74
         RxW8zDb7VlCgCAMcQ4EzFi0SXppJE1a8JsaFPL6sObjmF+4p384WxbNAow/HnoNJ8D
         rm78vjPoc4JeXwTC+s4zSW1MChXGs1xcu6sUPQGw=
Date:   Tue, 20 Jun 2023 16:17:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v7 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Message-ID: <2023062022-whimsical-hasty-b012@gregkh>
References: <20230620134152.383569-1-umang.jain@ideasonboard.com>
 <20230620134152.383569-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620134152.383569-2-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:11:48PM +0530, Umang Jain wrote:
> The devices that the vchiq interface registers (bcm2835-audio,
> bcm2835-camera) are implemented and exposed by the VC04 firmware.
> The device tree describes the VC04 itself with the resources required
> to communicate with it through a mailbox interface. However, the
> vchiq interface registers these devices as platform devices. This
> also means the specific drivers for these devices are getting
> registered as platform drivers. This is not correct and a blatant
> abuse of platform device/driver.
> 
> Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
> which will be used to migrate child devices that the vchiq interfaces
> creates/registers from the platform device/driver.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/Makefile        |  1 +
>  .../interface/vchiq_arm/vchiq_device.c        | 78 +++++++++++++++++++
>  .../interface/vchiq_arm/vchiq_device.h        | 43 ++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>  create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> 
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> index 44794bdf6173..2d071e55e175 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -5,6 +5,7 @@ vchiq-objs := \
>     interface/vchiq_arm/vchiq_core.o  \
>     interface/vchiq_arm/vchiq_arm.o \
>     interface/vchiq_arm/vchiq_debugfs.o \
> +   interface/vchiq_arm/vchiq_device.o \
>     interface/vchiq_arm/vchiq_connected.o \
>  
>  ifdef CONFIG_VCHIQ_CDEV
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> new file mode 100644
> index 000000000000..e16279a25126
> --- /dev/null
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

Code that directly interacts with the driver core can, for obvious
reasons, not be BSD-3 licensed, sorry.

Also, why is any of this dual licensed?  What good is any of that?  In
order for me to accept new dual-licensed code, it needs to be documented
in the changelog very very well as to exactly why this is required, as
the legal issues involved in maintaining dual-licensed code like this is
tricky and easy to get wrong (as proven here already in this patch...)

thanks,

greg k-h
