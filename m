Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BAC64A41C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiLLPZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiLLPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:25:27 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4A732FADA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:25:26 -0800 (PST)
Received: (qmail 854837 invoked by uid 1000); 12 Dec 2022 10:25:25 -0500
Date:   Mon, 12 Dec 2022 10:25:25 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Johan Hovold <johan@kernel.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
Message-ID: <Y5dH5RqY2yOK1bVj@rowland.harvard.edu>
References: <20221211120626.12210-1-johan@kernel.org>
 <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
 <Y5cDBSZrgC2TUnXs@hovoldconsulting.com>
 <4cf7bce3-dfbb-b064-9d91-27616bf11d6a@suse.com>
 <Y5cpH8aV7aox2Pbd@hovoldconsulting.com>
 <2a2935e6-ae3c-85d9-a2e9-f42fb4ca7d59@suse.com>
 <Y5cvPulXceujfZv6@hovoldconsulting.com>
 <b1a5874b-8028-db14-e2ac-ebe3967559a5@suse.com>
 <Y5c3WWKyohzkspnw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5c3WWKyohzkspnw@hovoldconsulting.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 03:14:49PM +0100, Johan Hovold wrote:
> On Mon, Dec 12, 2022 at 03:04:50PM +0100, Oliver Neukum wrote:
> > 
> > 
> > On 12.12.22 14:40, Johan Hovold wrote:
> > > On Mon, Dec 12, 2022 at 02:27:46PM +0100, Oliver Neukum wrote:
> > >> On 12.12.22 14:14, Johan Hovold wrote:
> > >>> On Mon, Dec 12, 2022 at 12:13:54PM +0100, Oliver Neukum wrote:
> > > 
> > >>> And in this case there was also no kernel doc for usb_get_intfdata()
> > >>> which is equally self documenting. Why add redundant docs for only one
> > >>> of these functions?
> > >>
> > >> Because knowing that one of them exists makes the other much more
> > >> obvious.
> > > 
> > > I doubt anyone finds out about this function by reading generated kernel
> > > documentation. You look at a driver, grep the function and look at the
> > > single-line implementation.
> > 
> > Look, we cannot solve the issue whether kerneldoc is a good idea
> > in general here. If you want to open that can of worms on lkml,
> > by all means. go for it.
> > But failing that, silently eliminating it is just not nice.
> 
> It was just added. It's mostly misleading and incorrect. Hence revert,
> rather than put the burden of adding proper documentation on the person
> calling out the misunderstanding (which has already led to a series of
> bogus patches).
> 
> > > But it was never perfectly good. It claims that a driver "should" use it,
> > > when it may not need to (think simple driver using devres) and talks
> > 
> > If you are presented with an interface something needs to be done
> > specific to that interface.
> 
> I'm not sure what you're saying here.
> 
> > > about driver core resetting the pointer which is irrelevant.
> > 
> > But correct and topical. I am not arguing what people should or should
> > mot know.
> 
> The comment is also misleading as it signals that this is something you
> need to care about.
> 
> > If you just remove the last sentence, all will be well. And if you
> > insist replace "should" with "can".
> 
> Since you insist, I'll just rewrite the whole thing.

You're both missing the main point, which is that the USB core clears 
intfdata after a driver is unbound.  As a consequence, drivers don't 
need to worry about clearing intfdata themselves -- a fact which is 
_not_ easily apparent from the implementation.  This would be a useful 
thing to mention in the kerneldoc, as it may help prevent lots of 
drivers from making unnecessary function calls (like the ones that 
Vincent recently removed).

Of course, this doesn't mean that drivers can't clear intfdata if they 
want to, for example, if they use it as an internal flag.  But 
developers shouldn't feel that they _need_ to clear it as a sort of 
hygienic measure.

IMO it's worthwhile keeping the kerneldoc (but correcting it) so that it 
can get this point across.

Alan Stern
