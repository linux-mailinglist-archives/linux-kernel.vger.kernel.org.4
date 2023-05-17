Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A7F705FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjEQGTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjEQGTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1331725
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63D866109E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A4CC433D2;
        Wed, 17 May 2023 06:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684304382;
        bh=E3ulOcUbHMrvd+SibIL4yGd2qj2mvkplI+T7K5BtABQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9UVfbhx/YDqKchjMs3bH9NXZhCgMpkUzMmc7QNk0mJeqL9fpgXooY8D2vwtKJ33P
         Bo0NsKovLsOFKXi3pHXpoH8AHEaXbMFY6c8xeZCPOV2W4AEOCnUjz6rLJ4jYg1yD2L
         fQNRSnIeXPXbJOJGECU89C4FI2KeuWfLEyw86pP4=
Date:   Wed, 17 May 2023 08:19:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/5] debugfs: Prevent NULL dereference reading from
 string property
Message-ID: <2023051741-basin-thermos-dc5c@gregkh>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-2-rf@opensource.cirrus.com>
 <2023051659-sinless-lemon-e3b1@gregkh>
 <705c4511-bfba-ea46-1aad-b3783c1b21ae@opensource.cirrus.com>
 <2023051642-tiling-manlike-7536@gregkh>
 <1efdb84f-5a84-4c1e-8d0c-bb516c0aebf7@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1efdb84f-5a84-4c1e-8d0c-bb516c0aebf7@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 07:04:42PM +0100, Richard Fitzgerald wrote:
> On 16/5/23 18:43, Greg KH wrote:
> > On Tue, May 16, 2023 at 06:29:52PM +0100, Richard Fitzgerald wrote:
> > > On 16/5/23 17:33, Greg KH wrote:
> > > > On Tue, May 16, 2023 at 05:07:49PM +0100, Richard Fitzgerald wrote:
> > > > > Check in debugfs_read_file_str() if the string pointer is NULL.
> > > > > 
> > > > > It is perfectly reasonable that a driver may wish to export a string
> > > > > to debugfs that can have the value NULL to indicate empty/unused/ignore.
> > > > 
> > > > Does any in-kernel driver do this today?
> > > 
> > > I don't know. The history here is that I was using debugfs_create_str()
> > > to add a debugfs to a driver and made these improvements along the way.
> > > Ultimately I had a reason to use a custom reader implementation.
> > > But as I'd already written these patches I thought I'd send them.
> > > 
> > > > 
> > > > If not, why not fix up the driver instead?
> > > > 
> > > 
> > > Well... could do. Though it seems a bit odd to me that a driver
> > > design should be forced by the debugfs API, instead of the debugfs API
> > > fitting normal code design. It's pretty standard and idiomatic for code
> > > to use if (!str) { /* bail */ } type logic, so why shouldn't the debugfs
> > > API handle that?
> > > 
> > > > > 
> > > > > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> > > > > ---
> > > > >    fs/debugfs/file.c | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > > > index 1f971c880dde..2c085ab4e800 100644
> > > > > --- a/fs/debugfs/file.c
> > > > > +++ b/fs/debugfs/file.c
> > > > > @@ -878,6 +878,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
> > > > >    		return ret;
> > > > >    	str = *(char **)file->private_data;
> > > > > +	if (!str)
> > > > > +		return simple_read_from_buffer(user_buf, count, ppos, "\n", 1);
> > > > 
> > > > Why not print "(NULL)"?
> > > > 
> > > 
> > > Again, could do. My thought here is that a debugfs can be piped into
> > > tools and having to insert a catch for "(NULL)" in the pipeline is a
> > > nuisance. This is a bit different from a dmesg print, which is less
> > > likely to be used this way or to guarantee machine-parsing.
> > > However, I don't mind changing to "(NULL)" if you prefer.
> > 
> > If a driver wants an "empty" string, they should provide an empty
> > string.  We don't do empty values for any other type of pointer, right?
> > 
> > Actually we really should just bail out with an error if this is NULL,
> > let's not paper over bad drivers like this.
> > 
> 
> I don't understand this comment.
> I think you'll find there is a very large amount of kernel code that
> uses a NULL value in a pointer to mean ignore/unspecified in
> some way. This has always been accepted C coding style.
> 
> The whole idea that a driver is "bad" for signalling some state
> by a pointer being NULL makes no sense.

The whole idea of passing a NULL pointer to debugfs makes no sense :)

If a driver does this, then they deserve the crash, let's just say "do
not do that" and leave it at that please.

> Please ignore this patch chain. I really don't feel like writing
> non-idiomatic C code just to work around badly designed debugfs APIs.
> Better to write a custom read().

Let's fix the badly designed debugfs apis please, it's not good to have
code that is impossible to use correctly.

thanks,

greg k-h
