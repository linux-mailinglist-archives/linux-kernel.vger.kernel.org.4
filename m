Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5C7388CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjFUPWS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjFUPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:21:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31187268F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:20:21 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qBzcv-0007yD-MP; Wed, 21 Jun 2023 17:20:09 +0200
Message-ID: <6ef512179a4cc9ce24890e5ed50c6fabd86a18c1.camel@pengutronix.de>
Subject: Re: [PATCH v10 03/11] drm/etnaviv: Add dedicated functions to
 create and destroy platform device
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Sui Jingfeng <18949883232@163.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        etnaviv@lists.freedesktop.org
Date:   Wed, 21 Jun 2023 17:20:04 +0200
In-Reply-To: <ab17a1e6-c621-9a92-73fc-8b762fd0800e@loongson.cn>
References: <20230620094716.2231414-1-18949883232@163.com>
         <20230620094716.2231414-4-18949883232@163.com>
         <0daa7182d6600a24988d1c81cf8fe3c0c9487f52.camel@pengutronix.de>
         <1c7596fd-7e63-6719-2574-7d7820687832@loongson.cn>
         <6d287bbb1733814009dfeb7d48f08cb6f44dc56c.camel@pengutronix.de>
         <30d80802-2d9d-2816-1a02-240145f6dd3a@loongson.cn>
         <0f1095ef333da7ea103486a1121ca9038815e57c.camel@pengutronix.de>
         <ab17a1e6-c621-9a92-73fc-8b762fd0800e@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 21.06.2023 um 22:35 +0800 schrieb Sui Jingfeng:
> Hi,
> 
> On 2023/6/21 22:00, Lucas Stach wrote:
> > Am Mittwoch, dem 21.06.2023 um 21:31 +0800 schrieb Sui Jingfeng:
> > > On 2023/6/21 18:23, Lucas Stach wrote:
> > > > > While back to the question you ask, I want etnaviv_create_platform_device() to be generic,
> > > > > 
> > > > > can be used by multiple place for multiple purpose.
> > > > > 
> > > > > I have successfully copy this to a another drm driver by simply renaming.
> > > > > 
> > > > > The body of the function itself does not need to change.
> > > > But it isn't shared,
> > > This can be shared for drm/etnaviv in the future,
> > > 
> > > currently, we just need an opportunity to use this function.
> > > 
> > I'm not convinced, yet.
> > 
> > > I want to create a dummy platform device,
> > > 
> > > let this dummy platform be bound to the single PCI GPU master.
> > > 
> > > 
> > > etnaviv_create_platform_device("dummy", &dummy_device);
> > > 
> > > 
> > > 1) To verify the component code path on PCI case.
> > > 
> > My favorite option would be to just always use the component path even
> > when the GPU is on a PCI device to keep both paths mostly aligned. One
> > could easily image both a 3D and a 2D core being made available though
> > the same PCI device.
> 
> Component is for something that is possible not available. (or something 
> is optional)
> 
> Yes it provided flexibly, but don't forget, it rely on the DT.

The component framework itself doesn't rely on DT in any way. By
providing a appropriate match function you can make it work with any
kind of device. In fact etnaviv supports platform devices instantiated
via board code today. They don't need to come from DT.

If we could make the PCI stuff work the same way, that would be my
preferred option.

> 
> 
> But for the PCIe device, it always the case that all of the hardware is 
> available at the same time
> 
> when the device driver(kernel module) is loaded.
That isn't the issue solved by the component framework. On the existing
SoCs all the hardware is available when the driver is probed. The
component framework just makes sure that we only expose the DRM device
after all GPU cores that should be managed by a single DRM device
instance are probed.

One could easily image a PCI device that containing a 2D and a 3D
Vivante GPU that should be made available through a single DRM device.
In that case you'll also need to use the component framework.

> 
> 
> > > 2) Possibly for create a device for some other tiny hardware logic
> > > come with the platform
> > > 
> > Do you have something in mind here? Until now I assumed that only the
> > GPU core is behind the PCI abstraction. Is there something else sharing
> > the MMIO space?
> 
> A display controller, HDMI phy, vga encoder etc
> 
> 
> I have a discrete PCIe GPU card from another vendor,
> 
> It integrated display controller and vivante GPU and unknown VPUs.
> 
> All of the  hardware block mentioned above sharing the MMIO space.
> 
> There are available on the same time when you mount this discrete PCIe 
> GPU card on the mother board
> 
But they surely should not all be made available through the etnaviv
driver. Etnaviv deals with the Vivante GPUs. If you have a PCI device
with multiple IP cores behind the shared MMIO space you should have a
PCI driver instantiating platform devices so the respective drivers for
those IP cores can bind to the platform device. Etnaviv is not that
driver.

Regards,
Lucas

> > 
> > Regards,
> > Lucas
> > 
> > > 3) Revival component_compare_dev_name() function.
> > > 
> > > > in this compilation unit this function is specific
> > > > to the etnaviv driver and I don't see why we shouldn't have etnaviv
> > > > specifics in there if it makes the code of this driver easier to
> > > > follow.
> 

