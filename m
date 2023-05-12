Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06A701298
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjELXqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjELXqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C542107;
        Fri, 12 May 2023 16:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DA1B6594D;
        Fri, 12 May 2023 23:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7726AC433EF;
        Fri, 12 May 2023 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683935188;
        bh=5ZiYRU6RWKYZUiTi+ixrCoeaVHLHcmBFcrn2mNYPdjc=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=bFXkBwBzLTlPAyCh35B7yXPVZ5CnuzzDdJ1NRfmUkuL0GcRhteQYwcgchaXhSduOq
         AKfHxVDb2EU5nty2WE5n15DCOpJT9Ls9EvlFmLUJgb62FvvqCqG+LMw9p0/4AHOCLD
         8xuN/AhUJI6aOobid4J0af6+L/ug6LFP6y1CqTYI=
Date:   Fri, 12 May 2023 16:46:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org,
        syzbot <syzbot+78d4495558999f55d1da@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nilfs2: fix use-after-free bug of nilfs_root in
 nilfs_evict_inode()
Message-Id: <20230512164627.0cd2a6f5d6a61bf736715c32@linux-foundation.org>
In-Reply-To: <20230512164424.865d7929600ed070824764e6@linux-foundation.org>
References: <00000000000099e5ac05fb1c3b85@google.com>
        <20230509152956.8313-1-konishi.ryusuke@gmail.com>
        <20230512164424.865d7929600ed070824764e6@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 16:44:24 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 10 May 2023 00:29:56 +0900 Ryusuke Konishi <konishi.ryusuke@gmail.com> wrote:
> 
> > During unmount process of nilfs2, nothing holds nilfs_root structure after
> > nilfs2 detaches its writer in nilfs_detach_log_writer().  However, since
> > nilfs_evict_inode() uses nilfs_root for some cleanup operations, it may
> > cause use-after-free read if inodes are left in "garbage_list" and
> > released by nilfs_dispose_list() at the end of nilfs_detach_log_writer().
> > 
> > Fix this issue by modifying nilfs_evict_inode() to only clear inode
> > without additional metadata changes that use nilfs_root if the file system
> > is degraded to read-only or the writer is detached.
> > 
> > ...
> >
> > --- a/fs/nilfs2/inode.c
> > +++ b/fs/nilfs2/inode.c
> > @@ -917,6 +917,7 @@ void nilfs_evict_inode(struct inode *inode)
> >  	struct nilfs_transaction_info ti;
> >  	struct super_block *sb = inode->i_sb;
> >  	struct nilfs_inode_info *ii = NILFS_I(inode);
> > +	struct the_nilfs *nilfs;
> >  	int ret;
> 
> `the_nilfs' is unused - I'll zap it.

argh, sorry, brainfart.
