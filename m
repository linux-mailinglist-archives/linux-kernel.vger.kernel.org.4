Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C17076F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjERAdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjERAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD6273D
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429EA64AFE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761B0C433EF;
        Thu, 18 May 2023 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684369979;
        bh=SVDCwvjNWtAMtqfgwymTV3gQlOjEiooq5eDjOTBGg6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwyInkd/w9jK5ecH7RDsTWHzkxxEs+dYp7XJpfpE4kLspZARKAiwjlXHOgoA41f98
         EF6HYw+KMs/LtFIjx4XsS86FBktUogodPLQ0zLFChjPMQ1GWQkraPbQWAwNahfC+3i
         DY3TjGXfbhcJxIJh3m6ef0s6ydwGorGkpcUGHmkvSZhLZzZ+MJVOk3ZuQ4aY/9yLZ5
         ybR8fExC4OM13WLPoz27VNF6/uEr1Qtd1EaCcP0u7drb24i8O/W5+BFJdjzxR0QzC6
         1FCYysxIHJexIJnNlJdoyNie6rks8htMhupqGhQxEyaz8gmQuweENAvfqSsn/NxwB1
         TLZhNNr8uSGvQ==
Date:   Wed, 17 May 2023 17:32:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Wu Bo <wubo.oduw@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, Wu Bo <bo.wu@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: pass I_NEW flag to trace event
Message-ID: <ZGVyOTqQy5ZhNvAr@google.com>
References: <45eb63c6-a147-776a-99b5-7ac06848ede8@kernel.org>
 <20230517035953.47810-1-bo.wu@vivo.com>
 <94958409-f726-9da6-3b9f-76efa022ee9d@kernel.org>
 <4a512db8-cfca-80a5-ba62-780f56d014f6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a512db8-cfca-80a5-ba62-780f56d014f6@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17, Wu Bo wrote:
> On 2023/5/17 16:36, Chao Yu wrote:
> > On 2023/5/17 11:59, Wu Bo wrote:
> > > On 2023/5/17 10:44, Chao Yu wrote:
> > > > On 2023/5/16 20:07, Wu Bo wrote:
> > > > > Modify the order between 'trace_f2fs_iget' &
> > > > > 'unlock_new_inode', so the
> > > > > I_NEW can pass to the trace event when the inode initialised.
> > > > 
> > > > Why is it needed? And trace_f2fs_iget() won't print inode->i_state?
> > > 
> > > When connect a trace_probe to f2fs_iget, it will be able to
> > > determine whether
> > > the inode is new initialised in order to do different process.
> > 
> > I didn't get it, you want to hook __tracepoint_f2fs_iget() w/ your own
> > callback?
> Yes,  to use 'tracepoint_probe_register ' to register a probe at
> trace_f2fs_iget

Why?

> > 
> > Thanks,
> > 
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > > 
> > > > > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > > > > ---
> > > > >    fs/f2fs/inode.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > > > index cf4327ad106c..caf959289fe7 100644
> > > > > --- a/fs/f2fs/inode.c
> > > > > +++ b/fs/f2fs/inode.c
> > > > > @@ -577,8 +577,8 @@ struct inode *f2fs_iget(struct super_block *sb,
> > > > > unsigned long ino)
> > > > >            file_dont_truncate(inode);
> > > > >        }
> > > > >    -    unlock_new_inode(inode);
> > > > >        trace_f2fs_iget(inode);
> > > > > +    unlock_new_inode(inode);
> > > > >        return inode;
> > > > >      bad_inode:
> > > > 
> > > > 
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > 
