Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB395FD9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJMM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJMM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F7AD18EA;
        Thu, 13 Oct 2022 05:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5939E61792;
        Thu, 13 Oct 2022 12:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C46AC433D6;
        Thu, 13 Oct 2022 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665665803;
        bh=D1v+v+p5tviS9W5Hx32wORn2qM5TjPZ0dBTOY15LvWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NehBH+mRFL5rjnTuJ8qx3tVjdQy9wFMupEbhtY9d5m10nyRxka6uBNqyfk1RczjBT
         3ZeaZx2kp7crwP8avFqPp/fm+rGgOaNhtfn6rdBjLXHqa8zzFFbmr3ymPGIKaJI3Cr
         6ZuLwCbQoORPNPTzRc/8WhcYJmmrJgcCXmK2lEGI=
Date:   Thu, 13 Oct 2022 14:57:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: n_gsm: make n_gsm line number configurable
Message-ID: <Y0gLN5b4TH43NhtZ@kroah.com>
References: <20221012061715.4823-1-daniel.starke@siemens.com>
 <Y0Zjqxl/MAivtf02@kroah.com>
 <DB9PR10MB58818736388F209396CEA749E0259@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58818736388F209396CEA749E0259@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:09:02AM +0000, Starke, Daniel wrote:
> > > --- a/include/uapi/linux/gsmmux.h
> > > +++ b/include/uapi/linux/gsmmux.h
> > > @@ -19,7 +19,9 @@ struct gsm_config
> > >  	unsigned int mtu;
> > >  	unsigned int k;
> > >  	unsigned int i;
> > > -	unsigned int unused[8];		/* Padding for expansion without
> > > +	unsigned short numValid;
> > > +	unsigned short num;
> > 
> > This would never work anyway (hint "short" is not a valid uapi data
> > type...)
> 
> I am surprised about this as gsm_netconfig already uses unsigned short.

How does netconfig pass data to/from userspace?  Through ioctls or
netlink?

thanks,

greg k-h
