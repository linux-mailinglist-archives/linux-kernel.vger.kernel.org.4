Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE869A806
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBQJWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBQJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ECE3C17;
        Fri, 17 Feb 2023 01:22:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D386A6175A;
        Fri, 17 Feb 2023 09:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51D2C433EF;
        Fri, 17 Feb 2023 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676625724;
        bh=XugNtRf/YoQtw6qflRGsfJKmB872OguELFXIMclJowo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwOY+PRfceHAx4y0Ixk79MGu4p8uP43h2p2pnALj1xjICLPyCSw2Q4MKrBY/Vu9R6
         WlzDM/0CRLK/ZCejXNDOO775zoZ+4kEcc1r5aSAgMdfNjkQzPuUPqdhaCcbP5V8+oP
         BtKQyf3t3Su15lLAUolEj/Rh41WoeFn/AQdFqkdI=
Date:   Fri, 17 Feb 2023 10:22:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     srinivas.kandagatla@linaro.org, linux-gpio@vger.kernel.org,
        michael@walle.cc, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Tharunkumar.Pasumarthi@microchip.com,
        arnd@arndb.de
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+9HOdHGqmPP/Ude@kroah.com>
References: <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc>
 <Y+yeyNCA48IbKOKC@kroah.com>
 <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <Y+zFo4SP5L/KkT/v@kroah.com>
 <BN8PR11MB3668C37EFBB42FB3FFC7618FE9A09@BN8PR11MB3668.namprd11.prod.outlook.com>
 <Y+4YO7HSmETanIU2@kroah.com>
 <b8663c30e7b46955c5da4794919acf5f518aae52.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8663c30e7b46955c5da4794919acf5f518aae52.camel@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 08:57:32AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> On Thu, 2023-02-16 at 12:49 +0100, Greg KH wrote:
> > > > > > Greg & Michael, I do not want to expose the entire or even
> > > > > > partial
> > > > > > set of device registers to the user space access directly for
> > > > > > safety
> > > > reasons.
> > > > 
> > > > But that's all exposed here through this block device, right?
> > > The block device created by this driver does not expose the device
> > > registers to the user space applications.
> > 
> > What is it exposing?
> The device's OTP and EEPROM are not directly mapped into the
> processor's address space using PCIe's BAR registers.

Ok, that was not obvious and is a lot of the confusion here.

> There is a OTP controller and EEPROM controller in the device and the
> registers of these controllers are mapped into the processor's address
> space along with other registers using the BAR registers.
> OTP/EEPROM driver maps these registers into kernel's virtual space
> using devm_ioremap and accomplishes the reads and writes by accessing
> these registers. To the user side, the driver shows two separate disks
> (one for OTP and one for EEPROM) and both of them could be programmed
> using the "linux dd" command with "oflag=direct" option.
> The driver handles the IO requests that originate out of the dd command
> and this way we would not need a separate user space program also.

I do not recommend using a block interface for this at all.  Why not the
"normal" EEPROM interface that the kernel has today (i.e. a binary sysfs
file)?  That way you can mmap it and edit locations how ever you want.

thanks,

greg k-h
