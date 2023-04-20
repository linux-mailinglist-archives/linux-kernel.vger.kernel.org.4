Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8EC6E92E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjDTLfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjDTLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77440CA;
        Thu, 20 Apr 2023 04:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF381647CB;
        Thu, 20 Apr 2023 11:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC007C433EF;
        Thu, 20 Apr 2023 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681990445;
        bh=VsfZrco2JQZGfIqPwGjRvxKZSNISIaz4em2BpQLe6c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDpo9ghQp8RBnno7IyBfZhU+f1LWUGRZE9uPmuOOaaRrJKBWQCyU3YIBTocmUU3io
         Z09//nBu/OvgR/EDUIn/KzXXL1861GS/FCBu6x8/jSlYPsQ7ts8xCTJ7bzqxdEGeLF
         MvgmqSlUQN5YYAifuBMFxqxUjBnlPF/WjMZfPKnk=
Date:   Thu, 20 Apr 2023 13:34:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZEEjKiHTyGsbpfma@kroah.com>
References: <20230116080002.47315-1-tony@atomide.com>
 <Y9jo9bTnmejWYoH2@kroah.com>
 <Y9oI8m132aQOeSed@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9oI8m132aQOeSed@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 08:38:42AM +0200, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230131 10:10]:
> > On Mon, Jan 16, 2023 at 09:59:58AM +0200, Tony Lindgren wrote:
> > > We want to enable runtime PM for serial port device drivers in a generic
> > > way. To do this, we want to have the serial core layer manage the
> > > registered physical serial controller devices.
> > > 
> > > To do this, let's set up a struct device for the serial core controller
> > > as suggested by Greg and Jiri. The serial core controller devices are
> > > children of the physical serial port device. The serial core controller
> > > device is needed to support multiple different kind of ports connected
> > > to single physical serial port device.
> > > 
> > > Let's also set up a struct device for the serial core port. The serial
> > > core port instances are children of the serial core controller device.
> > 
> > Looking better, but why is this new device a platform device?  That
> > feels odd, you should never have a platform device hanging off of a
> > non-platform device, right?
> 
> No special need for it to be a platform device. It just is easy to set
> up, and for my test case the serial port physical device is also a
> platform device.
> 
> What's your preference here?

Never make up a "fake" platform device please.  Only use them for real
platform devices.  Use a virtual device if you want a virtual one.

thanks,

greg k-h
