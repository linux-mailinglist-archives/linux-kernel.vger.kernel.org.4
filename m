Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25BE60948E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJWPx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE5B26ACD;
        Sun, 23 Oct 2022 08:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C6BE60BC2;
        Sun, 23 Oct 2022 15:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BAAC433C1;
        Sun, 23 Oct 2022 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666540403;
        bh=ekK4EkWfWOMVR684/LcQ4fMn38h47MS8KHYwWM+PKgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOrt6JzqRmT1xmvsjzceT7jUFDpFfSmFcpmI8z4M3McDifaEytLVrCQd3xwNU83Fz
         B8K0W8248/16bs2J/C+RpCB5GFs8KBMWfF+yaVFiwr1ctinT60/wBuCSkmI7eep7IY
         1NLtfQPRdLWfyphYMVjZ8yKQuomy1pjQFy4E+/pA=
Date:   Sun, 23 Oct 2022 17:53:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] USB: gadget: dummy_hcd: switch char * to u8 *
Message-ID: <Y1Vjb9v2ggSjhRbc@kroah.com>
References: <20221021064453.3341050-1-gregkh@linuxfoundation.org>
 <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggc19mf+WR=eg7h7MfVVNbE1c8b5vcOc6wmDASNTMddg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:30:37AM -0700, Linus Torvalds wrote:
> On Thu, Oct 20, 2022 at 11:44 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The function handle_control_request() casts the urb buffer to a char *,
> > and then treats it like a unsigned char buffer when assigning data to
> > it.  On some architectures, "char" is really signed, so let's just
> > properly set this pointer to a u8 to take away any potential problems as
> > that's what is really wanted here.
> 
> I think you might as well also remove the cast that was always a bit odd:
> 
>                 buf[0] = (u8)dum->devstatus;
> 
> although maybe it's intentional ("look, ma, I'm truncating this
> value") because 'devstatus' is a 'u16' type?

(adding Alan as he's the owner of this file now)

Yes, devstatus is a u16 as that's what the USB spec says it should be,
but so far only 7 of the lower bits have been used.  I guess to do this
properly we should also copy the upper 8 bits in to buf[1], eventhough
in reality it's only ever going to be 0x00 for now.

Although if we ever do get another 2 status bits defined, this code will
break so we probably should do that too.

I'll go do that for a v2 of this and properly comment it.

> I suspect a comment would be more readable than an odd cast that
> doesn't actually change anything (since the assignment does it
> anyway).
> 
> Or maybe people wrote it that way on purpose, and used that variable
> name on purpose.
> 
> Because 'dum' is Swedish for 'stupid', and maybe there's a coded
> message in that driver?

That whole driver is called "dummy" as it's a "fake" driver, not a
"stupid" one :)

thanks,

greg k-h
