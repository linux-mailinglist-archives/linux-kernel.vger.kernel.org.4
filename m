Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0356F5B5C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiILOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:32:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D62E9E8;
        Mon, 12 Sep 2022 07:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC2BCB80CAA;
        Mon, 12 Sep 2022 14:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C622C433D6;
        Mon, 12 Sep 2022 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662993162;
        bh=ncuO1M5I6yJQVCdLgnE0oN45X8h9B0j2Tl5id4/B5mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PE0k+qHzmaQGYo80mVOe5B8M1ljcyhfAe7XeKc8NwID48J8UL/lf4WH6Sr0u7NdzB
         NDYsFCdJ/jkXpFpCPyjOWwUgChZ2qbtXmcO18kppxBCSs6+3PsJ8XhfaoCsvqMEbN2
         3Geyklr4MB8Q29Pm4kKWKAmXN70w6gAkRhwIrVK4=
Date:   Mon, 12 Sep 2022 16:33:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     cgel.zte@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] USB: serial: ftdi_sio: remove the unneeded
 result variable
Message-ID: <Yx9DIpc3oTwhdRPi@kroah.com>
References: <20220912133826.18517-1-xu.panda@zte.com.cn>
 <Yx88s4TwEEt6luPY@kroah.com>
 <Yx8/dtzrkRE4iFea@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx8/dtzrkRE4iFea@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 04:17:26PM +0200, Johan Hovold wrote:
> On Mon, Sep 12, 2022 at 04:05:39PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 12, 2022 at 01:38:27PM +0000, cgel.zte@gmail.com wrote:
> > > From: Xu Panda <xu.panda@zte.com.cn>
> > > 
> > > Return the value usb_control_msg() directly instead of storing
> > > it in another redundant variable.
> > > 
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> 
> > > -       rv = usb_control_msg(port->serial->dev,
> > > -                           usb_sndctrlpipe(port->serial->dev, 0),
> > > -                           FTDI_SIO_SET_BAUDRATE_REQUEST,
> > > -                           FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
> > > -                           value, index,
> > > -                           NULL, 0, WDR_SHORT_TIMEOUT);
> > > -       return rv;
> > > +       return usb_control_msg(port->serial->dev,
> > > +                              usb_sndctrlpipe(port->serial->dev, 0),
> > > +                              FTDI_SIO_SET_BAUDRATE_REQUEST,
> > > +                              FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE,
> > > +                              value, index,
> > > +                              NULL, 0, WDR_SHORT_TIMEOUT);
> > >  }
> > 
> > That's really not the correct use of the return value of
> > usb_control_msg().  Can you fix this up to properly handle the return
> > value, or better yet, use the usb_control_msg_send() call?
> 
> It is actually correct since the buffer length is zero here (i.e. it
> returns a negative errno or 0).

Yeah, that's a hack :)

> But I'm also ignoring patches from this email address as it is used by
> multiple users, and of which none so far has replied to feedback (as if
> it's all automated).

Great, that's the correct thing to do here, thanks.

greg k-h
