Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7A649FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiLLNOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiLLNNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:13:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F10C32;
        Mon, 12 Dec 2022 05:13:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D807E61041;
        Mon, 12 Dec 2022 13:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E6C433EF;
        Mon, 12 Dec 2022 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670850825;
        bh=xBqcSjH2ykKNHWeS29A6f/ABA0xmeApYpT4bmdclxwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/ERXN2/FU0xWK5RR25PGcd4u+2BATn9Om5ykZH2mdUaKLp81N+Up+nCBiri4/pRz
         05BDA/XgSrQ55Un8f7xPpaj8cXMKVLMOVTMzB3Cm4NC0fxwTdvgso4C1oxMPSN9v7I
         m8Q7i6CjFmUIinyNLUulk1w/DBmI3Kb1ydvkBtZiFGqMr0/Hq3oBrGxH+azrRVV5cJ
         x7SGIZ2L8aBpT/vrELq/LLog749yIbWIVAXDJe+yv0p1ZyukNIu5PnOL0up+ftrC1G
         hbR65/TPkEMXnOK10HGGFLIVGxUg4g0QWgd1Zs5PFBpc7Nlu/YAYnxgAgXGM3b4J2y
         uVLN0jsOLzMBw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4idD-0006NU-Jw; Mon, 12 Dec 2022 14:14:08 +0100
Date:   Mon, 12 Dec 2022 14:14:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Message-ID: <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 12:13:54PM +0100, Oliver Neukum wrote:
> 
> 
> On 12.12.22 11:31, Johan Hovold wrote:
> > On Mon, Dec 12, 2022 at 11:19:00AM +0100, Oliver Neukum wrote:
> >> On 11.12.22 13:06, Johan Hovold wrote:
> >>
> >>> Due to a misunderstanding, a redundant and misleading kernel doc comment
> >>> for usb_set_intfdata() was recently added which claimed that the driver
> >>> data pointer must not be cleared during disconnect before "all actions
> >>> [are] completed", which is both imprecise and incorrect.
> >>
> >> OK, but is that a reason to remove all kerneldoc? Kerneldoc is generally
> >> a good thing. And if a pointer is NULLed by driver core, that will need
> >> to be in it. IMHO you'd better just remove the questionable part of the
> >> kerneldoc.
> > 
> > Yeah, I started off with just rewriting the kernel doc and removing the
> > obviously incorrect bits, but then there is essentially nothing left of
> > the documentation.
> 
> 1. that the function exists and its purpose

That should be apparent from the function name (and implementation).

> 2. its parameters

Apparent from the prototype.

But sure, it would not show up in generated documentation (like many
other functions).
 
> most kerneldoc isn't exactly a great revelation. Nevertheless it
> serves a purpose.

Yeah, we have a lot of

	/**
	 * set_x_to_y() - set x to y
	 * @x: the x
	 * @y: the y
	 */

it seems. Not sure how much value there is in that, though.

And in this case there was also no kernel doc for usb_get_intfdata()
which is equally self documenting. Why add redundant docs for only one
of these functions?

I'd rather drop this particular documentation which was added due to a
misunderstanding then go down the rabbit hole of adding mindless kernel
doc to every helper we have.

> > A driver does not need to care that the pointer is cleared by driver
> > core after the driver is unbound. The driver is gone.
> 
> Is that true even with respect to sysfs?

Yes. The (device group) attributes are removed by driver core before
->remove() is called, otherwise you'd have an even bigger issue with the
driver data itself which is typically deallocated before the pointer is
cleared.

Johan
