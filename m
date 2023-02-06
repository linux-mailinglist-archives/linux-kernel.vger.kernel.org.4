Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C068C51C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBFRtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBFRtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:49:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC83FFF1A;
        Mon,  6 Feb 2023 09:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74B7AB815BA;
        Mon,  6 Feb 2023 17:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C89C433EF;
        Mon,  6 Feb 2023 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675705740;
        bh=l4coTATTprfbe4VXz6O3GT3eY0BooCJyaol9ewLBwaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPT38Ts/cAWH9wYfLxkbXDsMoZxYkTqZ1IbKTpsWJbXQaGnrKYF1eEaWU7hWt9mn5
         nclnR+XiVCndayPHw9p8wtnQelI3pXSWbMffrJoq+xZ4sQNDOO7ob+2P+e1DU8iAj+
         mi4ke2pf9Uq5yIuhiIWZFamdzL5dPfr6zEWEtO5Q=
Date:   Mon, 6 Feb 2023 18:48:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        UNGLinuxDriver@microchip.com, lkp@intel.com
Subject: Re: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+E9iRWyxqOjO4UX@kroah.com>
References: <20230116192908.2980862-1-kumaravel.thiagarajan@microchip.com>
 <Y8pzIgeMyf2oNCn4@kroah.com>
 <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+DLVwfOjEKYJpyB@kroah.com>
 <PH7PR11MB59589EE1C7787496316C04339BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB59589EE1C7787496316C04339BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 05:03:57PM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, February 6, 2023 3:12 PM
> > To: Tharunkumar Pasumarthi - I67821
> > <Tharunkumar.Pasumarthi@microchip.com>
> > > > > +     delay = msecs_to_jiffies(OTP_RW_TIMEOUT_MILLISECONDS);
> > > > > +     j0 = jiffies;
> > > > > +     j1 = j0 + delay;
> > > >
> > > > Are you sure this math works out?  Please use the jiffies math
> > > > functions instead so you can handle wrapping properly.
> > >
> > > You suggest using any existing APIs to add jiffies to handle wrapping?
> > > I am not able to find any such API. Can you please point out API name.
> > 
> > I have no context here for what you are doing with the math in jiffies, but
> > that is usually a very odd thing.  If you use the normal timer functions, you
> > will not have to worry about the wrapping as it is handled for you, right?
> 
> Hi Greg,
> Our objective with that part of code is to wait for OTP_STATUS_BUSY_BIT 
> to be cleared in the hardware, but make sure that we wait for a maximum 
> of OTP_RW_TIMEOUT_MILLISECONDS ms in the driver and not beyond that. 

How exact much do you mean by "not beyond that"?

> This logic is not possible with normal timer functions. Timer wrapping logic is 
> handled by time_before API internally. So, there does not seem to be issue with
> existing code. 

I have no context here as to what the code actually looked like anymore,
so I do not know what is going on anymore, sorry.

greg k-h
