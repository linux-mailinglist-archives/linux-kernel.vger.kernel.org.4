Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6664A183
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiLLNlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiLLNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:40:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE66167;
        Mon, 12 Dec 2022 05:39:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08BF261073;
        Mon, 12 Dec 2022 13:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722FFC433F1;
        Mon, 12 Dec 2022 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670852391;
        bh=E9veDPnM/AmRfpGqoCi7tQ+BipgpSOgTYR/RBmWbZhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p07s+Wq7dhBsRynFKxvtSzxBgIY8YwY+1Df2t2QQKpzNXu8DVI0NCKC31/ehZtCVN
         oGCBLDi90dR9X78mM2kCQBxeP+xcRRDas4QK31wy6wRJh8ws+ifGto8R3/g+bJdubK
         AgcElhdSWUwSAiA+HWVnM3US2+lXEVlGmzrnkHr9QQ5e/JOtXzIhR4WhkRHMsKTDrA
         5X/f4dI24mpygXbQbZHwaVr1csyZ3AWl/711YYPjRB4+hGh1frmxpbZfp9FJ7zsYQn
         JsZOxy80uYJqVE3Wyw6EsjTnYt18zMNRbsr3J9fKQSDBrW7tplYCMiHD2FLMoHI11d
         1Ze55zdbjDz6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p4j2U-0006iT-IL; Mon, 12 Dec 2022 14:40:14 +0100
Date:   Mon, 12 Dec 2022 14:40:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Message-ID: <Y5cvPulXceujfZv6@hovoldconsulting.com>
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
 <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
 <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:27:46PM +0100, Oliver Neukum wrote:
> On 12.12.22 14:14, Johan Hovold wrote:
> > On Mon, Dec 12, 2022 at 12:13:54PM +0100, Oliver Neukum wrote:

> > And in this case there was also no kernel doc for usb_get_intfdata()
> > which is equally self documenting. Why add redundant docs for only one
> > of these functions?
> 
> Because knowing that one of them exists makes the other much more
> obvious.

I doubt anyone finds out about this function by reading generated kernel
documentation. You look at a driver, grep the function and look at the
single-line implementation.

Driver data is such as integral part of the driver model so it's kinda
hard to miss. Still dev_set_drvdata() also has no kernel doc either.
 
> > I'd rather drop this particular documentation which was added due to a
> > misunderstanding then go down the rabbit hole of adding mindless kernel
> > doc to every helper we have.
> 
> Yes, but those are not the alternatives.
> Removing the perfectly good part of the kerneldoc is a needless regression,
> albeit a minor one.

But it was never perfectly good. It claims that a driver "should" use it,
when it may not need to (think simple driver using devres) and talks
about driver core resetting the pointer which is irrelevant.

> > Yes. The (device group) attributes are removed by driver core before
> > ->remove() is called, otherwise you'd have an even bigger issue with the
> > driver data itself which is typically deallocated before the pointer is
> 
> So what happens if user space calls read() or write() on an existing fd?
> Sorry, but this is an issue we need to be sure about.

No need to be sorry, and I've looked at this before. kernfs handles the
serialisation.

But as I mentioned above, this is again irrelevant for the question at
hand as the driver data is freed before the pointer is set to NULL.

Johan
