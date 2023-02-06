Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6AE68B8D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBFJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:41:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3399811674;
        Mon,  6 Feb 2023 01:41:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBD5060DCC;
        Mon,  6 Feb 2023 09:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66AAC433EF;
        Mon,  6 Feb 2023 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675676506;
        bh=TvgaLId7CjU5WDr/jGvVee6fSSjJFU/9lSDvuAuffYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+TD6NzCKPHi3I9A8nr9sfLqBY/pwU0ihDoP1Ys6Ttk2SyT3o9S24tB8mEA6bVWOT
         jx8hnBoEb2VLclUNoGHsj697V6ALD3aKyAV3grV7g82Q0kZtIy57zp4rcra1achSIC
         yG6W0uCKj4oiD9BoZ6+HfJb4uG4afJ8Q2InlkZ0U=
Date:   Mon, 6 Feb 2023 10:41:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        UNGLinuxDriver@microchip.com, lkp@intel.com
Subject: Re: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+DLVwfOjEKYJpyB@kroah.com>
References: <20230116192908.2980862-1-kumaravel.thiagarajan@microchip.com>
 <Y8pzIgeMyf2oNCn4@kroah.com>
 <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:20:51AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, January 20, 2023 4:26 PM
> > To: Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>
> > > +             dev_err(&priv->pdev->dev,
> > > +                     "EPC_Timeout, EEPROM is unresponsive: %x\n",
> > > + data);
> > 
> > Can this spam the kernel logs?  If so, please rate limit it.
> 
> This print will only come once at max and will not spam logs.
> 
> > > +     delay = msecs_to_jiffies(OTP_RW_TIMEOUT_MILLISECONDS);
> > > +     j0 = jiffies;
> > > +     j1 = j0 + delay;
> > 
> > Are you sure this math works out?  Please use the jiffies math functions
> > instead so you can handle wrapping properly.
> 
> You suggest using any existing APIs to add jiffies to handle wrapping? I am not able 
> to find any such API. Can you please point out API name. 

I have no context here for what you are doing with the math in jiffies,
but that is usually a very odd thing.  If you use the normal timer
functions, you will not have to worry about the wrapping as it is
handled for you, right?

thanks,

greg k-h
