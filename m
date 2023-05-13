Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D18701654
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjEMLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjEMLKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655240CD;
        Sat, 13 May 2023 04:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262B560A36;
        Sat, 13 May 2023 11:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC3EC433D2;
        Sat, 13 May 2023 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683976199;
        bh=d6U6HY4Y147yLj/hkR4VH4OA5h+IAkhNN7SsSQMVw2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptS5Mq+PYQvQxKaGII3Bvz7UtKN661n9Mp0jjAtuIlc8ZxaucY2LZnAmWPN+K4QY2
         vxx17LOmeusIfM8qxE7dQMAI25tOkWga9iC0jvOA27QKXVOEMVn6vpjy9cZTiZ/20w
         Vle63pCtnK4g3OHW+q8WYUDT4TUagFdwHlA+QlYU=
Date:   Sat, 13 May 2023 20:07:31 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v11 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <2023051332-pretended-spoiler-61fc@gregkh>
References: <20230511065355.47525-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511065355.47525-1-tony@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:53:51AM +0300, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To do this, let's set up a struct bus and struct device for the serial
> core controller as suggested by Greg and Jiri. The serial core controller
> devices are children of the physical serial port device. The serial core
> controller device is needed to support multiple different kind of ports
> connected to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> 
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.

Much better, thanks!

One thing jumps out at me though, you are passing around "raw" struct
device pointers as the serial port structure, why?

Shouldn't:

> @@ -563,7 +564,8 @@ struct uart_port {
>  	unsigned int		minor;
>  	resource_size_t		mapbase;		/* for ioremap */
>  	resource_size_t		mapsize;
> -	struct device		*dev;			/* parent device */
> +	struct device		*dev;			/* serial port physical parent device */
> +	struct device		*port_dev;		/* serial core port device */

port_dev here be something like "struct serial_port" (or some better
name)?  That way you enforce the type being passed around to the serial
code in this change which will help catch any type mistakes.

Yes, this structure can just be a "wrapper" around 'struct device' but
at least it's a unique type.

Or am I missing why this was done this way?

thanks,

greg k-h
