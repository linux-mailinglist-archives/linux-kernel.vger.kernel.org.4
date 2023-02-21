Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5ED69D786
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjBUA3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBUA3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:29:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6D21A0E;
        Mon, 20 Feb 2023 16:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2179EB80E53;
        Tue, 21 Feb 2023 00:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7BCC433EF;
        Tue, 21 Feb 2023 00:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676939352;
        bh=P8NUfxEjZZjcZhSh+l49Z5vcrtS5kD9h99KJTKxF6Ss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/uVVFG3rNA8gbe5j6mIAh3FZ1u2biehBDWxy65DU8vh+97ngTiI7P+9lCRPDwGos
         Eh7echMZF2gOfF49wgpWXmC5xTSMcoPBXj+LW0GL9wQmhvt7urK+XUqDyc0bU2RFnm
         EXBYWX2AKGwPfbhoyi2gXn087bzrKeeWTswXe+rA=
Date:   Mon, 20 Feb 2023 16:29:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm-nonmm-stable tree
Message-Id: <20230220162912.455ebf3a98804ba4ecf15528@linux-foundation.org>
In-Reply-To: <20230221104529.631ac4c9@canb.auug.org.au>
References: <20230221090827.16d1bf96@canb.auug.org.au>
        <20230220151211.1cdec7528db28a00320a855f@linux-foundation.org>
        <20230221104529.631ac4c9@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 10:45:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Mon, 20 Feb 2023 15:12:11 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 21 Feb 2023 09:08:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > > The following commit is also in Linus Torvalds' tree as a different commit
> > > (but the same patch):
> > > 
> > >   bf470202dd9f ("fs: gracefully handle ->get_block not mapping bh in __mpage_writepage")  
> > 
> > CommitDate: Thu Feb 2 22:50:07 2023 -0800
> > 
> > > This is commit
> > > 
> > >   7010839ccfd4 ("fs: gracefully handle ->get_block not mapping bh in __mpage_writepage")
> > > 
> > > in Linus' tree.  
> > 
> > CommitDate: Thu Jan 26 16:46:35 2023 +0100
> > 
> > 
> > So I'm wondering why this came to light on Feb 20?
> 
> Sorry about that, but I wouldn't worry about it too much as it doesn't
> seem to be causing a conflict.
> 
> The latter commit was in the ext3 tree before being merged by Linus and
> I guess I missed it initially because sometimes the check for
> duplicates in the mm tree produces a longish list when the mm tree is
> updated during the day and the mm-hotfixes tree has already been merged
> (and gets rebased as part of the mm tree rebase).
> 
> It would have been put in the list of things to ignore until it turned
> up in Linus's tree today (which is an earlier and check and has a
> separate ignore list).
> 

I see, thanks.

Can you please remind me at what times you pull the trees?  I believe
it's more than once per day?  I'll look at redoing my schedule so we
don't overlap.

