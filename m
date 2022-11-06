Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102E861E290
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKFOW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKFOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:22:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F4AE60;
        Sun,  6 Nov 2022 06:22:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75F9560C44;
        Sun,  6 Nov 2022 14:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E702C433B5;
        Sun,  6 Nov 2022 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667744542;
        bh=zMQq5KVoUakp3AmASPT6vRdZJaoWJ0I5UcBTyHI2uhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyP0hInquLvAOFubq0ycCXqIwA31DouAZcaxGy4hAV1YlNEFWh1wBPa1GUeNNE0Of
         JKeI/GdHns6x4HF8gUfG1GZiRyMlh3r0SQ0IpL4CPsRLGnjPU2Ojli9jf9xnGRAsMP
         3viZ4oMBbV8yUdoNHPfIQd2xxwFlXeIce+QbchG4=
Date:   Sun, 6 Nov 2022 15:22:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
Message-ID: <Y2fDG9AsuFZh0Dkr@kroah.com>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com>
 <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
 <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
 <Y2afm9xFIvJnwXh/@kroah.com>
 <Y2cDlrNjL5YSAPm2@rowland.harvard.edu>
 <Y2eYw9Kna712mzR8@kroah.com>
 <CAMZ6RqJVFwhCjxghmDBt2kYeT_KhqE-4h=UGtKaSA1bwke1CaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJVFwhCjxghmDBt2kYeT_KhqE-4h=UGtKaSA1bwke1CaA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 09:47:05PM +0900, Vincent MAILHOL wrote:
> On Sun. 6 Nov. 2022 at 20:25, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Nov 05, 2022 at 08:45:10PM -0400, Alan Stern wrote:
> > > On Sat, Nov 05, 2022 at 06:38:35PM +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Nov 06, 2022 at 02:21:11AM +0900, Vincent MAILHOL wrote:
> > > > > On Sat. 5 Nov. 2022 at 18:27, Vincent MAILHOL
> > > > > <mailhol.vincent@wanadoo.fr> wrote:
> > > > > > On Sat. 5 Nov. 2022 at 17:36, Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > It's late right now, and I can't remember the whole USB spec, but I
> > > > think the device provides a list of the string ids that are valid for
> > > > it.  If so, we can add that to sysfs for any USB device out there, no
> > > > matter the string descriptor number.
> > >
> > > No, there is no such list.
> >
> > Yeah, my fault, nevermind about that, sorry.
> >
> > > > If not, maybe we can just iterate the 255 values and populate sysfs
> > > > files if they are present?  I'll dig up the USB spec tomorrow...
> > >
> > > Yes, we could do that.  But the filename would have to be the string
> > > id, which is not meaningful.  We wouldn't be able to have labels like
> > > "product-info" unless somehow a driver could provide the label.
> >
> > We could have a directory of strings/ with the individual descriptors in
> > there as files with the name being the string id.
> >
> > But that might take a long time to populate, as it can take a few tries
> > to get the string from a device, and to do that 256 times might be
> > noticable at device insertion time.
> >
> > > Also, there's the matter of language.  Devices can have string
> > > descriptors in multiple languages; which one should we show in sysfs?
> > > All of them?  Right now we use just the default language for the strings
> > > that we put in sysfs.
> > >
> > > > I say do this at the USB core level, that way it works for any USB
> > > > device, and you don't have a device-specific sysfs file and custom
> > > > userspace code just for this.
> > >
> > > This is unavoidable to some extent.  Without device-specific information
> > > or userspace code, there is no way to know which string descriptor
> > > contains the data you want.
> >
> > Agreed.
> >
> > Ok, for this specific instance, adding the "we know this string id
> > should be here" as a device-specific sysfs file seems to be the easiest
> > way forward.
> >
> > Vincent, want to try that instead?
> 
> OK for me. Will do that and remove the kernel log spam and replace it
> by a sysfs entry.
> 
> I have two questions:
> 
> 1/ Can I still export and use usb_cache_string()? In other terms, does
> the first patch of this series still apply? This looks like the most
> convenient function to retrieve that custom string to me.

Everyone seems to just use the usb_string() function, will that not work
for you?

> 2/ Is it a no-go to also populate ethtool_drvinfo::fw_version? Some
> users might look for the value in sysfs, while some might use ethtool.
> If the info is not available in ethtool, people might simply assume it
> is not available at all. So, I would like to provide both.

That's up to the network developers/maintainers.  I don't know if that's
a required or common api for network devices to have.

thanks,

greg k-h
