Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E200669788E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjBOI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBOI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:58:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F3D23320;
        Wed, 15 Feb 2023 00:58:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E0E61AB3;
        Wed, 15 Feb 2023 08:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA428C433D2;
        Wed, 15 Feb 2023 08:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676451531;
        bh=4c95aYCcmHPtqewbK2mfz6djfnMHhVLOVGmL0P6YOhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocremeFTMrpjRkawnDLniZKw3cTe976hN7g0GdyvyBZXU7D96MZpaUGvzaZasl/lb
         AebGH0RbSWueWUrqdZDVG7yD04QBQvouCs29e5D3PfF9amYHtvNlYiifuw4a5Hq8LC
         y8uLynd/gpkzhjxPSN/DTGgj9MoONeiY5tg88i14=
Date:   Wed, 15 Feb 2023 09:58:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Kumaravel.Thiagarajan@microchip.com,
        Tharunkumar.Pasumarthi@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+yeyNCA48IbKOKC@kroah.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7276bef47792e489abd093e4bd0044de@walle.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:20:10AM +0100, Michael Walle wrote:
> Hi,
> 
> > > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> > > > industrial, and automotive applications. This switch integrates OTP
> > > > and EEPROM to enable customization of the part in the field. This
> > > > patch provides the OTP/EEPROM driver to support the same.
> > > 
> > > Why isn't this driver using the nvmem subsystem which is usually
> > > used for
> > > OTP and EEPROM?
> > Michael, these OTP and EEPROM memories do not have any fixed location
> > registers which
> > store values (Eg. mac address, config parameters, etc) at fixed offsets.
> > It stores a bunch of records, each of which has some data to be
> > written into the device's
> > hardware registers at different locations. These records are directly
> > consumed by the hardware
> > and interpreted without the involvement of the software.
> > Therefore, we don't require any OTP / EEPROM register map to be input
> > to the OS / driver through
> > device tree or board files.
> > I only had to enumerate two separate block devices using the driver so
> > that the config binary files can be
> > overlayed using the dd command.
> > Since this is not fitting like a conventional nvme device, I didn't
> > choose the nvme subsystem.
> > Please let me know your thoughts / comments if any.
> 
> So this is only for provisioning. i.e. during manufacturing a board
> which uses this PCI bridge? There are no kernel users, nor is
> there a common interface towards user-space. But just some block
> device (why not a char device?) exposed to userspace. I presume
> there is a companion userspace application for it? Why do you take
> the extra step and have a (random) kernel interface, you could
> also just access the PCI device directly from userspace within your
> companion application, e.g. through libpci.

Yeah, why not just use userspace, I missed that, thanks!

greg k-h
