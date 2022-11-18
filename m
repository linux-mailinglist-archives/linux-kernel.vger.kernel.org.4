Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374CB62FF25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKRVH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKRVH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:07:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A443798272
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:07:25 -0800 (PST)
Received: (qmail 50645 invoked by uid 1000); 18 Nov 2022 16:07:24 -0500
Date:   Fri, 18 Nov 2022 16:07:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Keeping <john@metanate.com>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3e0zAa7+HiNVrKN@donbot>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:37:32PM +0000, John Keeping wrote:
> I don't think it's at all simple to fix this - I posted a series
> addressing the lifetime issues here a few years ago but didn't chase it
> up and there was no feedback:
> 
> 	https://lore.kernel.org/linux-usb/20191028114228.3679219-1-john@metanate.com/
> 
> That includes a patch to remove the embedded struct cdev and manage its
> lifetime separately, which I think is needed as there are two different
> struct device objects here and we cannot tie their lifetimes together.

I still don't have a clear picture of what the real problem is.  Lee's 
original patch description just said "external references are presently 
not tracked", with no details about what those external references are. 
Why not add just proper cdev_get() and cdev_put() calls to whatever code 
handles those external references, so that they _are_ tracked?

What are the two different struct device objects?  Why do their 
lifetimes need to be tied together?  If you do need to tie their 
lifetimes somehow, why not simply make one of them (the one which is 
logically allowed to be shorter-lived) hold a reference to the other?

Alan Stern
