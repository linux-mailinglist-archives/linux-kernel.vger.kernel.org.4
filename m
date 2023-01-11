Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8F665B29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjAKMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjAKMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:14:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38C64CC;
        Wed, 11 Jan 2023 04:14:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4EBAB81BDF;
        Wed, 11 Jan 2023 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12212C433D2;
        Wed, 11 Jan 2023 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673439296;
        bh=LETd3pG99Kwo3bLxrESekaid/mKi6lfOrfsazSIu5hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Vz8dGLe8d+W9N/4DzOLskp3KhYK/X0RR9uwlGMLbOh7LCw2BMxB4mmmRFaSUbQyD
         b8H4HyfZ9UZZ4Yd7SdLo54LSWsGFjxrUvN/ranrnZVTMQPcBvAJH0RaJUGyCVM1cJB
         eYDPgm5hmp7Gw5xRArCBEsybB3TOkSBSs2CscA20=
Date:   Wed, 11 Jan 2023 13:14:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 03/16] platform/surface: aggregator: move
 to_ssam_device() to use container_of_const()
Message-ID: <Y76oPCJyHktT+Ni9@kroah.com>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-4-gregkh@linuxfoundation.org>
 <d66843b0-5420-7237-c8e1-73bc402bff70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66843b0-5420-7237-c8e1-73bc402bff70@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:02:01PM +0100, Maximilian Luz wrote:
> On 1/11/23 12:30, Greg Kroah-Hartman wrote:
> > The driver core is changing to pass some pointers as const, so move
> > to_ssam_device() to use container_of_const() to handle this change.
> > to_ssam_device() now properly keeps the const-ness of the pointer passed
> > into it, while as before it could be lost.
> > 
> > Cc: Maximilian Luz <luzmaximilian@gmail.com>
> > Cc: platform-driver-x86@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   include/linux/surface_aggregator/device.h | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> > index 46c45d1b6368..24151a0e2c96 100644
> > --- a/include/linux/surface_aggregator/device.h
> > +++ b/include/linux/surface_aggregator/device.h
> > @@ -229,10 +229,7 @@ static inline bool is_ssam_device(struct device *d)
> >    * Return: Returns a pointer to the &struct ssam_device wrapping the given
> >    * device @d.
> >    */
> > -static inline struct ssam_device *to_ssam_device(struct device *d)
> > -{
> > -	return container_of(d, struct ssam_device, dev);
> > -}
> > +#define to_ssam_device(d)	container_of_const(d, struct ssam_device, dev)
> >   /**
> >    * to_ssam_device_driver() - Casts the given device driver to a SSAM client
> 
> A small note in addition to the comment by Hans: I think it might be a
> good idea to convert the to_ssam_device_driver() function as well. I
> could also send this in as a follow-up patch.

Sure, that can be a follow-on patch as it's not needed here.

thanks,

greg k-h
