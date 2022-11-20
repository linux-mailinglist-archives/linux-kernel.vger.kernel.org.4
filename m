Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47F631668
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTUqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKTUq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:46:29 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1034EE0CC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:46:27 -0800 (PST)
Received: (qmail 99007 invoked by uid 1000); 20 Nov 2022 15:46:26 -0500
Date:   Sun, 20 Nov 2022 15:46:26 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Keeping <john@metanate.com>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3piS43drwSoipD9@donbot>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 05:22:19PM +0000, John Keeping wrote:
> On Fri, Nov 18, 2022 at 04:07:24PM -0500, Alan Stern wrote:
> > On Fri, Nov 18, 2022 at 04:37:32PM +0000, John Keeping wrote:
> > > I don't think it's at all simple to fix this - I posted a series
> > > addressing the lifetime issues here a few years ago but didn't chase it
> > > up and there was no feedback:
> > > 
> > > 	https://lore.kernel.org/linux-usb/20191028114228.3679219-1-john@metanate.com/
> > > 
> > > That includes a patch to remove the embedded struct cdev and manage its
> > > lifetime separately, which I think is needed as there are two different
> > > struct device objects here and we cannot tie their lifetimes together.
> > 
> > I still don't have a clear picture of what the real problem is.  Lee's 
> > original patch description just said "external references are presently 
> > not tracked", with no details about what those external references are. 
> > Why not add just proper cdev_get() and cdev_put() calls to whatever code 
> > handles those external references, so that they _are_ tracked?
> > 
> > What are the two different struct device objects?  Why do their 
> > lifetimes need to be tied together?  If you do need to tie their 
> > lifetimes somehow, why not simply make one of them (the one which is 
> > logically allowed to be shorter-lived) hold a reference to the other?
> 
> The problem is that we have a struct cdev embedded in f_hidg but the
> lifetime of f_hidg is not tied to any kobject so we can't solve this in
> the right way by setting the parent kobject of the cdev.
> 
> While refcounting struct f_hidg is necessary, it's not sufficient
> because the only way to keep it alive long enough for the final
> kobject_put() on the embedded cdev is to tie the lifetime to a kobject
> of its own and there is no suitable object as this is not the model
> followed by gadget function instances.

I see.  The solution is simple: Embed a struct device in struct f_hidg, 
and call cdev_device_add() to add the device and the cdev.  This will 
automatically make the device the parent of the cdev, so the device's 
refcount won't go to 0 until the cdev's refcount does.  Then you can tie 
the f_hidg's lifetime to the device's, so the device's release routine 
can safely deallocate the entire f_hidg structure.

The parent of the new struct device should be set to &gadget->dev.  If 
you can't think of a better name for the device, you could simply append 
":I" to the parent's name, where I is the interface number, or even 
append ":C.I" where C is the config number (like we do on the host 
side).

Alan Stern
