Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635A46400A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiLBGmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiLBGmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:42:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD205EFBB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 22:42:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2E9A60EA8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBC3C433C1;
        Fri,  2 Dec 2022 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669963323;
        bh=pfoVIxv1s3mR730ZK9hxNn3ZKRlUzfY2HFUxqjF2NbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dL/rFsHmEs/EmBYMA2mXy/GhwEwTPjlbSE3uWtbnq/VnwWynNi/3LEQNbAfKtLIh7
         rrM1lIG53tWcaV6tbePhaC05dvzC0P9tlHjiB4UogP6FzHDdKPrS7bu4vwHKGV0tfa
         c8rGVad5t5MquyfPgkUB0mP2CokYXTx3o6lCKCSw=
Date:   Fri, 2 Dec 2022 07:41:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4meN3TGqN4nrdjK@kroah.com>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
 <Y4kvne/Vv+H5pjzW@smile.fi.intel.com>
 <Y4lK1LbEaI0LqtJW@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4lK1LbEaI0LqtJW@ziepe.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 08:46:12PM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 02, 2022 at 12:50:05AM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> > > container_of does not preserve the const-ness of a pointer that is
> > > passed into it, which can cause C code that passes in a const pointer to
> > > get a pointer back that is not const and then scribble all over the data
> > > in it.  To prevent this, container_of_const() will preserve the const
> > > status of the pointer passed into it using the newly available _Generic()
> > > method.
> > > 
> > > Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> > 
> > I believe this tag requires SoB of the co-develper.
> 
> Sure, Greg you can add whatever tags are required

I need you to send me a signed-off-by line, I can't add that on my own
for obvious reasons.

> Did you look at possibly just calling this "container_of" ?

Yes, but to do that would require all instances to be touched as this
call takes 4 parameters, while container_of() takes 3, so that can't be
done simply, AND there would be a lot of build errors all at once.

I'll work on moving code over to the new call as needed.

thanks,

greg k-h
