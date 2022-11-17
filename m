Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C668862E349
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiKQRjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbiKQRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:39:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1357ECA5;
        Thu, 17 Nov 2022 09:39:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB6A1B8216C;
        Thu, 17 Nov 2022 17:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDD3C433D7;
        Thu, 17 Nov 2022 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668706741;
        bh=oUtsd8Y3RXK7kabHRg0fHPeFFPGJmxPAgbyGHiGHJug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIrQxq9fJB1aCXgL3hr0ktDsC/aITHKnLDhwAf43GzqvtWrJtu+kMOAbF1yqBk85c
         B81cHOovOQa5b3P/1zjk9jIVG8zFJWHj5oM0Y6LS4wpxDyXzLuaKelrFRPQYfKKwkq
         qBEo0mY6m2wMaP8z9zprvAn/XVBt/1RMT93BZfRc=
Date:   Thu, 17 Nov 2022 18:38:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3ZxiCJdIOzcC6f5@kroah.com>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3Yt+YixokbWJ8H9@kroah.com>
 <Y3Y2fTeYTvOHF9Sb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Y2fTeYTvOHF9Sb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 01:26:21PM +0000, Lee Jones wrote:
> On Thu, 17 Nov 2022, Greg KH wrote:
> 
> > On Thu, Nov 17, 2022 at 12:08:13PM +0000, Lee Jones wrote:
> > > A reference to struct f_hidg is shared with this driver's associated
> > > character device handling component without provision for life-time
> > > handling.  In some circumstances, this can lead to unwanted
> > > behaviour depending on the order in which things are torn down.
> > > 
> > > Utilise, the reference counting functionality already provided by the
> > > implanted character device structure to ensure the struct f_hidg's
> > > memory is only freed once the character device handling has finished
> > > with it.
> > > 
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >  drivers/usb/gadget/function/f_hid.c | 47 +++++++++++++++++++++++------
> > >  1 file changed, 37 insertions(+), 10 deletions(-)
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - This looks like a new version of a previously submitted patch, but you
> >   did not list below the --- line any changes from the previous version.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/SubmittingPatches for what needs to be done
> >   here to properly describe this.
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> > 
> > thanks,
> > 
> > greg k-h's patch email bot
> 
> This is a completely new solution to the same problem.
> 
> I'm treating this as a brand new submission.

With the identical subject line, which plays havoc with tools :(

This is a v2, next should be v3 please.

thanks,

greg k-h
