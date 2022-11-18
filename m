Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A0062FA6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbiKRQiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiKRQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:37:44 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD7F94A4A;
        Fri, 18 Nov 2022 08:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=FiWlnseYeDmvYf6ekVLuoQu6zvB2WYQgiPGiJyyGB7U=; b=3olHQ
        pwcdzstTqdGOogS4c7XYEkB/GBP5GjnjYxK8e00xx3J2AnZVWeRgJUhniaXd/H5xCpdrlA82VZ5qa
        xANx4QLa2aQTMozg/E4pjlDIczrfQ/wGTlxh0AasS5Na3ZIICG+TCnfZR/Z7OCkIwG7TwUuV0yllS
        Mn7Lw1MFwjL/tQ6G3b2gEaNG+JptHhgeJCkrifzq8q6JFgnqMV9kUt5A0i9FOBYCowEFuwA99ZlyB
        9sse3H3qV6Z1V6cBrv/i5f76ec32Q2zmGSOaxvU/vZYqgD4pdDGhrNBrBzBNf9vIIxnB2dUrtfRTe
        trUroe17qeBhKzTVtcyKVJlw475Qw==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1ow4Mu-00049L-SR;
        Fri, 18 Nov 2022 16:37:33 +0000
Date:   Fri, 18 Nov 2022 16:37:32 +0000
From:   John Keeping <john@metanate.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3e0zAa7+HiNVrKN@donbot>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3er7nenAhbmBdBy@rowland.harvard.edu>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:59:42AM -0500, Alan Stern wrote:
> On Fri, Nov 18, 2022 at 08:54:53AM +0000, Lee Jones wrote:
> > On Thu, 17 Nov 2022, Alan Stern wrote:
> > 
> > > On Thu, Nov 17, 2022 at 01:46:26PM +0000, Lee Jones wrote:
> > > > On Thu, 17 Nov 2022, Greg KH wrote:
> > > > 
> > > > > On Thu, Nov 17, 2022 at 12:08:13PM +0000, Lee Jones wrote:
> > > > > > +static inline bool f_hidg_is_open(struct f_hidg *hidg)
> > > > > > +{
> > > > > > +	return !!kref_read(&hidg->cdev.kobj.kref);
> > > > > > +}
> > > > > 
> > > > > Ick, sorry, no, that's not going to work and is not allowed at all.
> > > > > That's some major layering violations there, AND it can change after you
> > > > > get the value as well.
> > > > 
> > > > This cdev belongs solely to this driver.  Hence the *.*.* and not
> > > > *->*->*.  What is preventing us from reading our own data?  If we
> > > > cannot do this directly, can I create an API to do it 'officially'?
> > > > 
> > > > I do, however, appreciate that a little locking wouldn't go amiss.
> > > > 
> > > > If this solution is not acceptable either, then we're left up the
> > > > creak without a paddle.  The rules you've communicated are not
> > > > compatible with each other.
> > > > 
> > > > Rule 1: Only one item in a data structure can reference count.
> > > > 
> > > > Due to the embedded cdev struct, this rules out my first solution of
> > > > giving f_hidg its own kref so that it can conduct its own life-time
> > > > management.
> > > > 
> > > > A potential option to satisfy this rule would be to remove the cdev
> > > > attribute and create its data dynamically instead.  However, the
> > > > staticness of cdev is used to obtain f_hidg (with container_of()) in
> > > > the character device handling component, so it cannot be removed.
> > > 
> > > You have not understood this rule correctly.  Only one item in a data 
> > > structure can hold a reference count _for that structure_.  But several 
> > > items in a structure can hold reference counts for themselves.
> > 
> > Here was the review comment I was working to on this patch [0]:
> > 
> >  "While at first glance, it seems that f_hidg is not reference
> >   counted, it really is, with the embedded "struct cdev" a few lines
> >   above this.
> > 
> >   That is the reference count that should control the lifecycle of
> >   this object, not another reference here in the "outer layer"
> >   structure."
> 
> It's worth noting that the review comment goes on to say:
> 
>  "But, the cdev api is tricky and messy and not really set up to control
>   the lifecycle of objects it is embedded in."
> 
> This is a good indication that a separate reference counter really is 
> needed (in fact it almost contradicts what was written above).

I don't think it's at all simple to fix this - I posted a series
addressing the lifetime issues here a few years ago but didn't chase it
up and there was no feedback:

	https://lore.kernel.org/linux-usb/20191028114228.3679219-1-john@metanate.com/

That includes a patch to remove the embedded struct cdev and manage its
lifetime separately, which I think is needed as there are two different
struct device objects here and we cannot tie their lifetimes together.
