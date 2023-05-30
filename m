Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEC5716499
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjE3Onf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjE3Ond (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECD8F;
        Tue, 30 May 2023 07:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C57AE62D95;
        Tue, 30 May 2023 14:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84B6C4339B;
        Tue, 30 May 2023 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685457811;
        bh=xNs8m24vD/RjSAGjEwvUKepcpTCIxfktl7qmXjLlGKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i579FhuWiS1GV+82+X0fTorQKPesAzJcBj2uDCMSY5C9itryHvjwJ9DU6CQOxG+64
         NIOj5T3Nk0cUd6a/W5EsVmFv0H+mKCjvhi4rs4ceN4eYCq19opGRo8PTs0ILJ940uG
         HxVut4SuvetGXLIGXRpR6eCuj2mARQ0O2SsJr96M=
Date:   Tue, 30 May 2023 15:43:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <2023053007-disabled-traffic-9812@gregkh>
References: <20230525113034.46880-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525113034.46880-1-tony@atomide.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 02:30:30PM +0300, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To manage serial controllers, let's set up a struct bus and struct device
> for the serial core controller as suggested by Greg and Jiri. The serial
> core controller devices are children of the physical serial port device.
> The serial core controller device is needed to support multiple different
> kind of ports connected to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> 
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Thanks for sticking with this, looks good now so I've queued it up in my
tree.

greg k-h
