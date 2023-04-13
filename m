Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8636E098A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDMJAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDMI7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08BF93EA;
        Thu, 13 Apr 2023 01:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD4D60F51;
        Thu, 13 Apr 2023 08:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76DEC433EF;
        Thu, 13 Apr 2023 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681376265;
        bh=ESKq4Yc4rw95zXlQHJsWDTT7htc0nkptP1B5meprI2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myX/JUKqLGrxp5j+ucexvpLLZGyzPqOh7io0Nv6yqjdZAm6RvgYjLRqzgDbS1QPxS
         5XC0MkXbcv8lj1f4bkkKxrMm+z0HL2Nky4nY4NcBS0I+poEi+gowJR8Bc/Vfncerda
         SDxfYsnh4Xaj4yk1c3nkR67mczHNiX+6R1QRDjLro23lrKwIdBSURferIoFenHPV0e
         kmXxNFt+U9rNDHu5Ka9frhGkehtQX1srGgQGj0dqlP6MOFHS/yhsr/lqnaNKWhRvJt
         uoUg7DyAIV+EeM6kA9WDeMV9G69jhHMUoJlJKB4kQhxi5a0ImyQDZCrhTPcexbflmO
         E3//COcDggBMQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pmsm4-000092-Qe; Thu, 13 Apr 2023 10:57:48 +0200
Date:   Thu, 13 Apr 2023 10:57:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jarkko Sonninen <kasper@iki.fi>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZDfEDOihHTIDlbx+@hovoldconsulting.com>
References: <20230313010416.845252-1-kasper@iki.fi>
 <20230314070002.1008959-1-kasper@iki.fi>
 <ZBAkOr0epPPICLNP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBAkOr0epPPICLNP@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 08:37:30AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 14, 2023 at 09:00:01AM +0200, Jarkko Sonninen wrote:
> > Add support for RS-485 in Exar USB adapters.
> > RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> > Gpio mode register is set to enable RS-485.
> > 
> > Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> > ---
 
> > @@ -237,6 +238,7 @@ static const struct xr_type xr_types[] = {
> >  struct xr_data {
> >  	const struct xr_type *type;
> >  	u8 channel;			/* zero-based index or interface number */
> > +	u32 rs485_flags;
> 
> Nit, you might want to move this up above channel as you now have a hole
> in this structure.  Not like it's that big of a deal so if you don't
> have to respin this no need to change.

Generally, it's better to keep related fields together than worry about
holes so the above is just fine.

Johan
