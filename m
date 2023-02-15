Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50528697AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbjBOLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjBOLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:44:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81683A9B;
        Wed, 15 Feb 2023 03:44:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B5E7B81E9A;
        Wed, 15 Feb 2023 11:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63ACC433EF;
        Wed, 15 Feb 2023 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676461478;
        bh=zffZcsdJ2UU+p64/x6vS7zCO6brF87H+zMZ2pG6TqXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=En4ozv2+lINTGIKHxd+jP0pEbe61/DSa62Nei6sT+ce5GcniyCKnzNZxxGQfocwud
         kfTuUfBowRS+cA7GHdjVgGV6Kou1daWHiWPwDzdzPXBlsZZtod/wbJPgYRjUwXSirq
         hSbO3sJ+TfWMtunm8dmLRPyWGp0mNk9kz8doPYzQ=
Date:   Wed, 15 Feb 2023 12:44:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     michael@walle.cc, Tharunkumar.Pasumarthi@microchip.com,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+zFo4SP5L/KkT/v@kroah.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc>
 <Y+yeyNCA48IbKOKC@kroah.com>
 <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 09:56:46AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> > From: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>
> > Sent: Wednesday, February 15, 2023 3:18 PM
> > To: Greg KH <gregkh@linuxfoundation.org>; Michael Walle 
> > <michael@walle.cc>
> > Cc: Tharunkumar Pasumarthi - I67821
> > <Tharunkumar.Pasumarthi@microchip.com>; UNGLinuxDriver 
> > <UNGLinuxDriver@microchip.com>; arnd@arndb.de; linux- 
> > gpio@vger.kernel.org; linux-kernel@vger.kernel.org; 
> > srinivas.kandagatla@linaro.org
> > Subject: RE: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add 
> > OTP/EEPROM driver for the pci1xxxx switch
> > 
> > >
> > > On Wed, Feb 15, 2023 at 09:20:10AM +0100, Michael Walle wrote:
> > > > Hi,
> > > >
> > > > > > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for 
> > > > > > > consumer, industrial, and automotive applications. This 
> > > > > > > switch integrates OTP and EEPROM to enable customization of 
> > > > > > > the part in the field. This patch provides the OTP/EEPROM 
> > > > > > > driver to support the
> > > same.
> > > > > >
> > > > > > Why isn't this driver using the nvmem subsystem which is 
> > > > > > usually used for OTP and EEPROM?
> > > > > Michael, these OTP and EEPROM memories do not have any fixed 
> > > > > location registers which store values (Eg. mac address, config 
> > > > > parameters, etc) at fixed offsets.
> > > > > It stores a bunch of records, each of which has some data to be 
> > > > > written into the device's hardware registers at different locations.
> > > > > These records are directly consumed by the hardware and 
> > > > > interpreted without the involvement of the software.
> > > > > Therefore, we don't require any OTP / EEPROM register map to be 
> > > > > input to the OS / driver through device tree or board files.
> > > > > I only had to enumerate two separate block devices using the 
> > > > > driver so that the config binary files can be overlayed using 
> > > > > the dd command.
> > > > > Since this is not fitting like a conventional nvme device, I 
> > > > > didn't choose the nvme subsystem.
> > > > > Please let me know your thoughts / comments if any.
> > > >
> > > > So this is only for provisioning. i.e. during manufacturing a 
> > > > board which uses this PCI bridge? There are no kernel users, nor 
> > > > is there a common interface towards user-space. But just some 
> > > > block device (why not a char device?) exposed to userspace. I 
> > > > presume there is a companion userspace application for it? Why do 
> > > > you take the extra step and have a (random) kernel interface, you 
> > > > could also just access the PCI device directly from userspace 
> > > > within your companion application, e.g. through libpci.
> > >
> > > Yeah, why not just use userspace, I missed that, thanks!
> > Greg & Michael, I do not want to expose the entire or even partial set 
> > of device registers to the user space access directly for safety reasons.

But that's all exposed here through this block device, right?

And this is already exposed to userspace today, no need to add anything
the kernel already provides this.

> > I think hardware registers shall be accessible only through safe and 
> > robust kernel mode components and that the user space shall only be 
> > able to access the device through the kernel mode services.

Again, PCI devices are already exposed to userspace today, what am I
missing?

> > I want the user to use the hardware only in those ways designated by 
> > the driver.
> > We were using the "busybox devmem" to access the hardware registers 
> > directly and to program the EEPROM / OTP.
> > But we understood that it cannot be an end user solution in all cases 
> > and based on some of the operating environments, there can be some 
> > restrictions in opening the direct hardware access to the user space.

What restrictions are you referring to?


> > Please let me know your thoughts / comments if any.
> 
> I missed one more important point. This driver is targeted not just for the manufacturing environment.
> we want to be able to update the OTP / EEPROM when the device is in the field also.

Great, then this really should just be using the firmware download
interface if you wish to write to this hardware.  Don't expose this as a
block device, as that's not what this is.

thanks,

greg k-h
