Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA262E236
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiKQQsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiKQQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:48:05 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0A47540903
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:48:00 -0800 (PST)
Received: (qmail 5505 invoked by uid 1000); 17 Nov 2022 11:47:59 -0500
Date:   Thu, 17 Nov 2022 11:47:59 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Lee Jones <lee@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3Y7MlwV0UFcA3w8@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 01:46:26PM +0000, Lee Jones wrote:
> On Thu, 17 Nov 2022, Greg KH wrote:
> 
> > On Thu, Nov 17, 2022 at 12:08:13PM +0000, Lee Jones wrote:
> > > +static inline bool f_hidg_is_open(struct f_hidg *hidg)
> > > +{
> > > +	return !!kref_read(&hidg->cdev.kobj.kref);
> > > +}
> > 
> > Ick, sorry, no, that's not going to work and is not allowed at all.
> > That's some major layering violations there, AND it can change after you
> > get the value as well.
> 
> This cdev belongs solely to this driver.  Hence the *.*.* and not
> *->*->*.  What is preventing us from reading our own data?  If we
> cannot do this directly, can I create an API to do it 'officially'?
> 
> I do, however, appreciate that a little locking wouldn't go amiss.
> 
> If this solution is not acceptable either, then we're left up the
> creak without a paddle.  The rules you've communicated are not
> compatible with each other.
> 
> Rule 1: Only one item in a data structure can reference count.
> 
> Due to the embedded cdev struct, this rules out my first solution of
> giving f_hidg its own kref so that it can conduct its own life-time
> management.
> 
> A potential option to satisfy this rule would be to remove the cdev
> attribute and create its data dynamically instead.  However, the
> staticness of cdev is used to obtain f_hidg (with container_of()) in
> the character device handling component, so it cannot be removed.

You have not understood this rule correctly.  Only one item in a data 
structure can hold a reference count _for that structure_.  But several 
items in a structure can hold reference counts for themselves.

So for example, you could put a kref in f_hidg which would hold the 
reference count for the f_hidg structure, while at the same time 
including an embedded cdev with its own reference counter.  The point is 
that the refcount in the embedded cdev refers to the lifetime of the 
cdev, not the lifetime of the f_hidg.

To make this work properly, you have to do two additional things:

	When the cdev's refcount is initialized, increment the kref
	in f_hidg.

	When the cdev's refcount drops to 0, decrement the kref (and
	release f_hidg if the kref hits 0).

Alan Stern

> Rule 2: Reading the present refcount causes a laying violation
> 
> So we're essentially saying, if data is already being reference
> counted, you have to use the present implementation instead of adding
> additional counts, but there is no way to actually do that, which
> kind of puts us at stalemate.
> 
> Since this is a genuine issue, doing anything is not really an option
> either.  So where do we go from here?
> 
> -- 
> Lee Jones [李琼斯]
