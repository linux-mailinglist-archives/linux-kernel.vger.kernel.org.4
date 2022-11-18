Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377AA62F035
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiKRIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbiKRIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:55:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBD40905;
        Fri, 18 Nov 2022 00:54:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C7B623A2;
        Fri, 18 Nov 2022 08:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F7CC433D6;
        Fri, 18 Nov 2022 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668761698;
        bh=Yt61zdf3aCar3pN9dGLzspIWr117IUEcCCJbjox3RFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnYoHUpXHYCrF0WshAMxfauq4ZWdWgzfghC7PsYDiDpshZTeNMfQDMd+sGJt2KQPi
         uimNDN+Ca6GW8EkYdebmZKIR8ae0b+EuVRi5Ph4zKY9Pndxrhpl1QzEdf4PMkoDiCD
         jwdf87/lW8rJkZKExqtmUWdZRsQKRnneWS4gEyxpOT3J8M8DQ3ykUtnvF1bPtuAovm
         d6a/9m1/PgZ9Hi0rFwedoubJJIPlGB7NHyRth9VaLMgMYjof6W+NFhEePoIXscprrn
         BaiQLNTwAI/sB0O5so6Gyb6gwLXDpWYHuwx5iPNgKwI+jWFXP/aVNwkNM6AUOmd5PO
         MzSYqMUrOoHjA==
Date:   Fri, 18 Nov 2022 08:54:53 +0000
From:   Lee Jones <lee@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3dIXUmjTfJLpPe7@google.com>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Alan Stern wrote:

> On Thu, Nov 17, 2022 at 01:46:26PM +0000, Lee Jones wrote:
> > On Thu, 17 Nov 2022, Greg KH wrote:
> > 
> > > On Thu, Nov 17, 2022 at 12:08:13PM +0000, Lee Jones wrote:
> > > > +static inline bool f_hidg_is_open(struct f_hidg *hidg)
> > > > +{
> > > > +	return !!kref_read(&hidg->cdev.kobj.kref);
> > > > +}
> > > 
> > > Ick, sorry, no, that's not going to work and is not allowed at all.
> > > That's some major layering violations there, AND it can change after you
> > > get the value as well.
> > 
> > This cdev belongs solely to this driver.  Hence the *.*.* and not
> > *->*->*.  What is preventing us from reading our own data?  If we
> > cannot do this directly, can I create an API to do it 'officially'?
> > 
> > I do, however, appreciate that a little locking wouldn't go amiss.
> > 
> > If this solution is not acceptable either, then we're left up the
> > creak without a paddle.  The rules you've communicated are not
> > compatible with each other.
> > 
> > Rule 1: Only one item in a data structure can reference count.
> > 
> > Due to the embedded cdev struct, this rules out my first solution of
> > giving f_hidg its own kref so that it can conduct its own life-time
> > management.
> > 
> > A potential option to satisfy this rule would be to remove the cdev
> > attribute and create its data dynamically instead.  However, the
> > staticness of cdev is used to obtain f_hidg (with container_of()) in
> > the character device handling component, so it cannot be removed.
> 
> You have not understood this rule correctly.  Only one item in a data 
> structure can hold a reference count _for that structure_.  But several 
> items in a structure can hold reference counts for themselves.

Here was the review comment I was working to on this patch [0]:

 "While at first glance, it seems that f_hidg is not reference
  counted, it really is, with the embedded "struct cdev" a few lines
  above this.

  That is the reference count that should control the lifecycle of
  this object, not another reference here in the "outer layer"
  structure."

> So for example, you could put a kref in f_hidg which would hold the 
> reference count for the f_hidg structure, while at the same time 
> including an embedded cdev with its own reference counter.  The point is 
> that the refcount in the embedded cdev refers to the lifetime of the 
> cdev, not the lifetime of the f_hidg.

This was the approach in the original submission [1], which during
review I was told was unacceptable for the aforementioned reason.

[0] https://lore.kernel.org/all/Y1PnoMvDmZMqXScw@kroah.com/
[1] https://lore.kernel.org/all/20221017112737.230772-1-lee@kernel.org/

> To make this work properly, you have to do two additional things:
> 
> 	When the cdev's refcount is initialized, increment the kref
> 	in f_hidg.
> 
> 	When the cdev's refcount drops to 0, decrement the kref (and
> 	release f_hidg if the kref hits 0).

More than happy to revisit the first solution with Greg's blessing.

-- 
Lee Jones [李琼斯]
