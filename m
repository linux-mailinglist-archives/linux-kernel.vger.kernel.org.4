Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E282670552B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEPRn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEPRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB9FC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E24863C4D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 17:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D60C433EF;
        Tue, 16 May 2023 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684259032;
        bh=FBdb3Sw75P42umLk3eSV+Bs/CaOiqTKESdDSW/zxNjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwCzn2TDEhjKgCJk9/NdN2H7DmW09ne+wPA0Daejbok6A8xkzmVYDkKR0GNTUbZh1
         8E49E2L8TTCURVIr4/S5AfGHLZkwlMsTVkM/dmZuV9+any7YP64Vo0HRa/DyApF0Dn
         mjlooOrh2HZkeO0Wc7JfEyffx6Whu2dxVpX/RTnQ=
Date:   Tue, 16 May 2023 19:43:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/5] debugfs: Prevent NULL dereference reading from
 string property
Message-ID: <2023051642-tiling-manlike-7536@gregkh>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-2-rf@opensource.cirrus.com>
 <2023051659-sinless-lemon-e3b1@gregkh>
 <705c4511-bfba-ea46-1aad-b3783c1b21ae@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705c4511-bfba-ea46-1aad-b3783c1b21ae@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 06:29:52PM +0100, Richard Fitzgerald wrote:
> On 16/5/23 17:33, Greg KH wrote:
> > On Tue, May 16, 2023 at 05:07:49PM +0100, Richard Fitzgerald wrote:
> > > Check in debugfs_read_file_str() if the string pointer is NULL.
> > > 
> > > It is perfectly reasonable that a driver may wish to export a string
> > > to debugfs that can have the value NULL to indicate empty/unused/ignore.
> > 
> > Does any in-kernel driver do this today?
> 
> I don't know. The history here is that I was using debugfs_create_str()
> to add a debugfs to a driver and made these improvements along the way.
> Ultimately I had a reason to use a custom reader implementation.
> But as I'd already written these patches I thought I'd send them.
> 
> > 
> > If not, why not fix up the driver instead?
> > 
> 
> Well... could do. Though it seems a bit odd to me that a driver
> design should be forced by the debugfs API, instead of the debugfs API
> fitting normal code design. It's pretty standard and idiomatic for code
> to use if (!str) { /* bail */ } type logic, so why shouldn't the debugfs
> API handle that?
> 
> > > 
> > > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> > > ---
> > >   fs/debugfs/file.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > index 1f971c880dde..2c085ab4e800 100644
> > > --- a/fs/debugfs/file.c
> > > +++ b/fs/debugfs/file.c
> > > @@ -878,6 +878,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
> > >   		return ret;
> > >   	str = *(char **)file->private_data;
> > > +	if (!str)
> > > +		return simple_read_from_buffer(user_buf, count, ppos, "\n", 1);
> > 
> > Why not print "(NULL)"?
> > 
> 
> Again, could do. My thought here is that a debugfs can be piped into
> tools and having to insert a catch for "(NULL)" in the pipeline is a
> nuisance. This is a bit different from a dmesg print, which is less
> likely to be used this way or to guarantee machine-parsing.
> However, I don't mind changing to "(NULL)" if you prefer.

If a driver wants an "empty" string, they should provide an empty
string.  We don't do empty values for any other type of pointer, right?

Actually we really should just bail out with an error if this is NULL,
let's not paper over bad drivers like this.

thanks,

greg k-h
