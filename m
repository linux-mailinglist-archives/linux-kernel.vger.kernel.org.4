Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E799C68663A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjBAMsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjBAMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:48:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5953A9D;
        Wed,  1 Feb 2023 04:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FAB0B8204A;
        Wed,  1 Feb 2023 12:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874CCC433D2;
        Wed,  1 Feb 2023 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675255727;
        bh=gQ5ykPhITwYFSRSgdfkrS0T30uD5xET28MqxXO6rQWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbSOWMm8j1n+Ho4B9J8/8OkQ/kwgrGAJJwGPS7+Lr05AiMCjxokKWkHuYKZV7hsxh
         gU/zqI69+4SQvXgm/FdRvCfK6tJ0ah0jzuocC+5/wAGZOeTMCNv9Jah/a7Y5gCaHIx
         KUj2F2qFBPPlj7lQqfcwU1QJV+72Msd9G5RSHLGk=
Date:   Wed, 1 Feb 2023 13:48:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty: n_gsm: add keep alive support
Message-ID: <Y9pfrFPngFVgQUN7@kroah.com>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
 <Y9olcm0PiSCSikri@kroah.com>
 <DB9PR10MB58814F4711FC3403F7AF089BE0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <Y9owmfZwKn9+1xBf@kroah.com>
 <DB9PR10MB588101762F5AA07EE43F0658E0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB588101762F5AA07EE43F0658E0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:48:58AM +0000, Starke, Daniel wrote:
> > > > > index cb8693b39cb7..b64360aca1f9 100644
> > > > > --- a/include/uapi/linux/gsmmux.h
> > > > > +++ b/include/uapi/linux/gsmmux.h
> > > > > @@ -19,7 +19,8 @@ struct gsm_config
> > > > >  	unsigned int mtu;
> > > > >  	unsigned int k;
> > > > >  	unsigned int i;
> > > > > -	unsigned int unused[8];		/* Padding for expansion without
> > > > > +	unsigned int keep_alive;
> > > > > +	unsigned int unused[7];		/* Padding for expansion without
> > > > 
> > > > "unsigned int" is not really a valid uapi variable type.
> > > > 
> > > > Shouldn't this be __u32 instead?
> > > 
> > > I know but changing it to a fixed size data type may break compatibility
> > > as this may change the overall size of the structure.
> > 
> > Will it?  It shouldn't that's why using the correct data types is
> > essencial.
> 
> Well, unsigned int is defined to be at least 16 bit.

In the kernel, it should just be 32 bits, but as this is a userspace
header, it's pretty undefined :(

> Using __u32 will break
> systems where this is true. I am not sure if the Linux kernel targets any
> system which defines unsigned int with 16 bit. But sure, I can change it to
> __u32.

Please do, that's what those types are for.

> > > This is why I
> > > took a field out of the "unused" array for the "keep_alive" parameter.
> > > A value of zero disables keep-alive polling.
> > > 
> > > > Should you document this field as to what the value is and the units as
> > > > you are creating a new user/kernel api here.
> > > 
> > > I will add a comment here. Comments for the other fields remain subject to
> > > another patch.
> > > 
> > > > And finally, "unused" here is being properly checked to be all 0, right?
> > > > If not, then this change can't happen for obvious reasons :(
> > > 
> > > This was not the case until now. I assumed there was some coding guideline
> > > that unused fields need to be initialized to zero. Obviously, checking it
> > > prevents misuse here. I will add relevant checks for this.
> > 
> > If the value was not checked previously, then you can not use the field
> > now, otherwise things will break, sorry.  Those are useless fields and
> > should be marked as such :(
> 
> What is the way forward here? Should I introduce a complete new ioctl?

You are going to have to, as if the unused fields were never verified to
be 0, you will have bugs where old userspace code could have data in
that location that previously worked just fine, and now it does not at
all.  We can not cause regressions like that, sorry.

> Or should I use a different size for this structure to break existing code
> intentionally?

You can not break userspace, sorry.

> Does this mean that we cannot extend this structure at all in the
> future?

That is correct, it is a broken interface it seems :(

> I had planned another extension here to properly support parameter
> negotiation.
> In case we need to keep the structure as it is: Would a comment be
> sufficient to mark this field accordingly?

Yes, mark it as "can not be used" or something like that, and then just
create a new ioctl, sorry.

thanks,

greg k-h
