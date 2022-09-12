Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3475B5C12
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiILORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiILORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:17:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F832610E;
        Mon, 12 Sep 2022 07:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C073BB80D7F;
        Mon, 12 Sep 2022 14:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7344DC433D7;
        Mon, 12 Sep 2022 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662992249;
        bh=aGq0nN+nEaeWXYxt+doqTW9R/4SDnQkBCNcOcCEmsCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlfLpax89DnIeCvbfGgWnusbMfGKwqpDbc8FK85XBv6cSXecxLa0wDC0jHfSDa+UC
         sYNHjMYvr8WeHg+Qz+V7vKYZ+P1fjO1Uft+HIqCP44y16+taLVJ5xudHmnQc9VuCKN
         wyFVZb14XErXNBH6NMD7SpgyuBQie1V1LB5oCYovSFUZa3CoQfwxARYosPK1muWDUp
         duzztajgFzwCEJKB9yWY1dz8vy7IX+i3o/YchMpL8IsHmlcvdI1onAgWgkK4bkVz7Y
         23bx/c3BtlB8K4X+cPOm/c7plZefbZRrA9ErCEpze2bvIUHIMLC6sHFfEyGZz5ewM9
         bhPquCKL7vUIA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXkFa-0001K7-1O; Mon, 12 Sep 2022 16:17:26 +0200
Date:   Mon, 12 Sep 2022 16:17:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cgel.zte@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] USB: serial: ftdi_sio: remove the unneeded
 result variable
Message-ID: <Yx8/dtzrkRE4iFea@hovoldconsulting.com>
References: <20220912133826.18517-1-xu.panda@zte.com.cn>
 <Yx88s4TwEEt6luPY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx88s4TwEEt6luPY@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 04:05:39PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 12, 2022 at 01:38:27PM +0000, cgel.zte@gmail.com wrote:
> > From: Xu Panda <xu.panda@zte.com.cn>
> > 
> > Return the value usb_control_msg() directly instead of storing
> > it in another redundant variable.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>

> > -       rv = usb_control_msg(port->serial->dev,
> > -                           usb_sndctrlpipe(port->serial->dev, 0),
> > -                           FTDI_SIO_SET_BAUDRATE_REQUEST,
> > -                           FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
> > -                           value, index,
> > -                           NULL, 0, WDR_SHORT_TIMEOUT);
> > -       return rv;
> > +       return usb_control_msg(port->serial->dev,
> > +                              usb_sndctrlpipe(port->serial->dev, 0),
> > +                              FTDI_SIO_SET_BAUDRATE_REQUEST,
> > +                              FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
> > +                              value, index,
> > +                              NULL, 0, WDR_SHORT_TIMEOUT);
> >  }
> 
> That's really not the correct use of the return value of
> usb_control_msg().  Can you fix this up to properly handle the return
> value, or better yet, use the usb_control_msg_send() call?

It is actually correct since the buffer length is zero here (i.e. it
returns a negative errno or 0).

But I'm also ignoring patches from this email address as it is used by
multiple users, and of which none so far has replied to feedback (as if
it's all automated).

Johan
