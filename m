Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63C660632F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJTOep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJTOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54BBA1B2;
        Thu, 20 Oct 2022 07:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8467861BB5;
        Thu, 20 Oct 2022 14:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9559EC433C1;
        Thu, 20 Oct 2022 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666276470;
        bh=zu+R8HI2/cXSHvhVAOtRsz8nljjuEiATfLLT8HY3i7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JATnFczXFSq0Gl8FY5CJWycWOGe68O/J538Bd+HMzMxVZWgaLxhsxuYsjd3eaXmAj
         MpygX9oviETGkAgVs5217Gi1hVA/b1pZ3FvN5ZTQBDUugvfbyre5OzSnUGFFeuqlFm
         TyyViXmiPSahQV98ZBIQYTuFyqRYqtjS1CmbtAiQ=
Date:   Thu, 20 Oct 2022 16:34:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>, stable-commits@vger.kernel.org,
        josef@toxicpanda.com, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Subject: Re: Patch "btrfs: separate out the eb and extent state leak helpers"
 has been added to the 6.0-stable tree
Message-ID: <Y1Fcc3dl1FYM4S9K@kroah.com>
References: <20221017023918.2399433-1-sashal@kernel.org>
 <20221020132737.GG13389@suse.cz>
 <Y1FTsM2Z0q27r5di@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1FTsM2Z0q27r5di@sashalap>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:57:04AM -0400, Sasha Levin wrote:
> On Thu, Oct 20, 2022 at 03:27:37PM +0200, David Sterba wrote:
> > On Sun, Oct 16, 2022 at 10:39:18PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     btrfs: separate out the eb and extent state leak helpers
> > > 
> > > to the 6.0-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      btrfs-separate-out-the-eb-and-extent-state-leak-help.patch
> > > and it can be found in the queue-6.0 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > 
> > > 
> > > commit 72845648c29a262b9cfbbe0e1ac678db0bc6166d
> > > Author: Josef Bacik <josef@toxicpanda.com>
> > > Date:   Fri Sep 9 17:53:19 2022 -0400
> > > 
> > >     btrfs: separate out the eb and extent state leak helpers
> > > 
> > >     [ Upstream commit a40246e8afc0af3ffdee21854fb755c9364b8346 ]
> > > 
> > >     Currently we have the add/del functions generic so that we can use them
> > >     for both extent buffers and extent states.  We want to separate this
> > >     code however, so separate these helpers into per-object helpers in
> > >     anticipation of the split.
> > > 
> > >     Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > >     Reviewed-by: David Sterba <dsterba@suse.com>
> > >     Signed-off-by: David Sterba <dsterba@suse.com>
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > This is another case when a patch that's not fixing anything nor a
> > dependency is taken from a series that in the end is only cleanups.
> > Isn't there supposed to be some human oversight over the patches that
> > are then sent as autosel?
> > 
> > I think the number of false positives is too high and this means I have
> > to spend more time on the autosel patches, though majority of them have
> > some impact when backporting.
> 
> Would it make sense to remove fs/btrfs/ from autosel?

I think so, they are one of the few filesystems that do a great job of
marking things for stable when needed (other good examples are ext4, and
xfs is finally getting there.)

So I would remove them.

thanks,

greg k-h
