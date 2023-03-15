Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5808D6BAF57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjCOLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjCOLdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:33:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756080E34
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9893CB81DEA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01824C433D2;
        Wed, 15 Mar 2023 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678879942;
        bh=o+wBhEIU2AJd1UGubPSJyVrioGamKTeg0Gy51VoWi3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z5Gx5ryNZjAtRl3WaWy47nFBO48Ff/P7b+V9MWM3+zjg+NVyCDmMSh2zer1Phf9sO
         W7GQYQSP2khEVLUVf27Y03n2YlP+YuT7JgFXRnHaEnCNwLoIN4XSYiUMlOufFYENmZ
         32FA4J/xtXDBT2rF/0ln0dy79sXxiipY1qTuWQtU=
Date:   Wed, 15 Mar 2023 12:32:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     VaibhaavRam.TL@microchip.com
Cc:     arnd@arndb.de, Kumaravel.Thiagarajan@microchip.com,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Tharunkumar.Pasumarthi@microchip.com
Subject: Re: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <ZBGsxNwKxcdyoq7v@kroah.com>
References: <20230303170426.353-1-vaibhaavram.tl@microchip.com>
 <ZAm7PDSIUN5HMxUu@kroah.com>
 <DM4PR11MB62385D0541F7AF8EC7E9F6CE97B99@DM4PR11MB6238.namprd11.prod.outlook.com>
 <ZA9Me2d9IsoYGifp@kroah.com>
 <DM4PR11MB6238653CE39A429E4B10B9C497BF9@DM4PR11MB6238.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB6238653CE39A429E4B10B9C497BF9@DM4PR11MB6238.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 09:07:12AM +0000, VaibhaavRam.TL@microchip.com wrote:
> 
> From: Greg KH <gregkh@linuxfoundation.org> 
> Sent: Monday, March 13, 2023 9:47 PM
> To: VaibhaavRam TL - I69105 <VaibhaavRam.TL@microchip.com>
> Subject: Re: [PATCH v7 char-misc-next] misc: microchip: pci1xxxx: Add OTP/EEPROM driver for the pci1xxxx switch
> 
> 
> On Mon, Mar 13, 2023 at 04:01:15PM +0000, VaibhaavRam.TL@microchip.com wrote:
> > > > Again, default group will handle this automatically, you should 
> > > > never need to call a sysfs_*() call from a driver.  Otherwise something is usually very wrong.
> > >
> > > Are you recommending similar to this snippet?
> > >
> > > static struct bin_attribute *pci1xxxx_bin_attributes[] = {
> > >       &pci1xxxx_otp_attr,
> > >       &pci1xxxx_eeprom_attr
> > >       NULL,
> > > };
> > >
> > > static const struct attribute_group pci1xxxx_bin_attributes_group = {
> > >       .bin_attrs = pci1xxxx_bin_attributes, }; ..
> > > ..
> > > auxiliary_device.device.attribute_group = 
> > > pci1xxxx_bin_attributes_group
> >
> > Yes.
> >
> > > This creates sysfs for both EEPROM and OTP at once and handles for its removal, right?
> > > But, In this case, I have to check whether EEPROM is responsive and only then create sysfs for it.
> > >
> > > Can you please provide some guidance, on how to handle this situation without using sysfs_*().
> >
> > Use the "is_visible" callback in your group to tell the driver core if the specific attribute needs to be created or not.
> 
> I have added "is_bin_visible" callback and it is working fine. Sysfs for EEPROM and OTP is created inside drivers folder

It should be for the device, not the driver, are you sure you are using
the right groups pointer?

> But I have used attribute group inside device_driver under auxiliary_driver structure.
> as opposed to what I have mentioned previously because , struct device_driver is exposed to me instead of struct device.
> Since there can be only one instance of driver for multiple devices, I cannot account for multiple instances of EEPROM/OTPs present in those devices.

Then your driver might be structured incorrectly, as the instance of the
device is what your driver binds to.

> Is it possible to use sysfs_create_group in this situation?

You should not need that at all, I really don't understand the problem,
sorry, can you post a patch that shows the issue?

thanks,

greg k-h
