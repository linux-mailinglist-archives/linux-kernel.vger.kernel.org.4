Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA9705FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEQGTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEQGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF2272D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8032960F28
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818CDC4339B;
        Wed, 17 May 2023 06:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684304324;
        bh=wKqkHvW8YRCZBQqkh+oMj1zOtFej3/tgcZrgi/WwsEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1CK3sIFM1MG762LdB3D9BwwhEVH/SBGS9OousQu3vjpqfn3x3r8+Uak8O49YJ9sE
         Smg5cmUFH99yNaSmDZfcYMPb6Z3E2S9q2KQbe6Cx08bARjLDfm+RDwIVfvkwFAEGfO
         N9oavdg5QFB6uracWxV+9iQ2pDaAzciVMGDyLdoM=
Date:   Wed, 17 May 2023 08:18:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/5] debugfs: Update debugfs_create_str() kerneldoc to
 warn about pointer race
Message-ID: <2023051700-puzzling-visiting-e647@gregkh>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-4-rf@opensource.cirrus.com>
 <2023051607-trial-worrisome-87df@gregkh>
 <1d174049-0eaf-01d5-2f85-c3cd3f4a40a0@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d174049-0eaf-01d5-2f85-c3cd3f4a40a0@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 06:50:16PM +0100, Richard Fitzgerald wrote:
> On 16/5/23 17:35, Greg KH wrote:
> > On Tue, May 16, 2023 at 05:07:51PM +0100, Richard Fitzgerald wrote:
> > > Add a warning to the debugfs_create_str() kerneldoc that the char * pointer
> > > value must not change after the function returns, because of a race with
> > > debugfs_read_file_str() accessing the pointer.
> > > 
> > > The only safe case is a change from NULL to non-NULL because in that case
> > > debugfs_read_file_str() will see either the NULL or the valid pointer.
> > > 
> > > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> > > ---
> > >   fs/debugfs/file.c | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > index 0c039a3d9a42..77794871f26d 100644
> > > --- a/fs/debugfs/file.c
> > > +++ b/fs/debugfs/file.c
> > > @@ -938,11 +938,18 @@ static const struct file_operations fops_str_wo = {
> > >    *          directory dentry if set.  If this parameter is %NULL, then the
> > >    *          file will be created in the root of the debugfs filesystem.
> > >    * @value: a pointer to the variable that the file should read to and write
> > > - *         from.
> > > + *         from. The char* pointer must not change, except from NULL to
> > > + *         non-NULL.
> > 
> > This feels odd.  Why wouldn't you want to change the string value?  Or
> > why would you?
> 
> Well, if you _would_ want to change the string value, then the
> implementation of debugfs_create_str() is certainly broken and could
> only be fixed by involving a shared mutex to protect use of the pointer.

Agreed.  So let's just say "never change the pointer" and leave it at
that?

> > And why is this one-way transition ok?
> > 
> 
> This one case happens to be safe because it either sees NULL (which it
> handles) or a valid pointer (which is ok). It will not result in using a
> stale pointer. This wasn't a deliberate design intent but happens to be
> safe, and easily maintainable behavior.
> 
> A transition from valid->NULL or old->new isn't safe because the
> read function could get the old pointer but racing with that is the
> change to the pointer, and so the debugfs code could try to use a
> stale pointer.
> 
> > Given that this is only used internally, why is it exported?
> > 
> 
> It isn't only used internally. I found 3 drivers that use it.
> But there are no uses internal to debugfs.

Oops, I missed the other users (arm_scmi and opp), so let's leave it.

> I didn't write debugfs_create_str(), I only tried to use it and made
> an attempt to fix some problems.
> 
> Given the limitations of the basic implementation of
> debugfs_create_str() and its file reading function (the lack of
> protection against the pointer changing) perhaps drop this chain? Don't
> bother fixing it, instead deprecate it for being unsafe?

We don't "deprecate" things, that never works.  We either fix them, or
rip them out :)

thanks,

greg k-h
