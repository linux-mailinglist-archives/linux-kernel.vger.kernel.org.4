Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A40A64AB15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiLLXFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLLXFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:05:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6871B1F9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8330E6126A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD07C433EF;
        Mon, 12 Dec 2022 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670886309;
        bh=x0cHRAp8vVmV/XZj21AnddH1EoJNiefnFUy3qnybb6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+/1GchgKTLX0JfWUgJtfxQ4wzp/NGEXf3sZVFK/yDrTCoKjwYrdMIM34Qg22IANp
         K+PcxbGsDnRoP8NgRvAXzEq0r7+/B9q/pXKRKYQnW/p6HIRQTL1lBHnHlCBjy5vGbY
         zxNp+SAIHriPUIvi5w0xS7o2zeru9lTLEm+9GIxBZu9M0lEjdZZJofNCAIEMAuBcP5
         nxteDNzk2ff5CyrVBx6xSEEOF9jiHYY7Bqcm377Uqi2vf17WSSrTLVNbKBZMuivlX7
         NqFmqDMCFDKi/weI5IAp3YEwCBJgO6lCwqprgcd67JBUZkQqF0Lt2t3KuSTcI6Qnhp
         tecPtKV2M1HPg==
Date:   Mon, 12 Dec 2022 15:05:08 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     zhoudan <zhuqiandann@gmail.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8@xiaomi.com
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not
 compressed
Message-ID: <Y5ezpOwd8sOTTaW5@google.com>
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com>
 <Y5OYYJYx9G2LbRmc@google.com>
 <20221212122109.GA714122@mi-ThinkStation-K>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212122109.GA714122@mi-ThinkStation-K>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, zhoudan wrote:
> Maybe I'm not describing it clearly enough, but I think there is 
> something wrong with the logic here.The 'f2fs_release_compress_blocks'
> method does not determine if the file is compressed, but simply adds 
> the FI_COMPRESS_RELEASED flag. 

I firstly lost your point since f2fs_release_compress_blocks() checked
f2fs_compressed_file().

> In particular, in the current Android system, when the application is 
> installed, the release interface is called by default to release the 
> storage marked as compressed,  without checking whether the file is 
> actually compressed. In this case, when compress_mode is set to user, 
> calling the compress interface returns ENVAL and the file cannot be 
> compressed.
> So I think the implementation of release needs to be modified, and 
> only set FI_COMPRESS_RELEASED when it's really compressed and the 
> storage is released.
> 
> On Fri, Dec 09, 2022 at 12:19:44PM -0800, Jaegeuk Kim wrote:
> > On 12/08, zhoudan8 wrote:
> > > In compress_mode=user, f2fs_release_compress_blocks()
> > >  does not verify whether it has been compressed and
> > >  sets FI_COMPRESS_RELEASED directly. which will lead to
> > > return -EINVAL after calling compress.
> > > To fix it,let's do not set FI_COMPRESS_RELEASED if file
> > > is not compressed.
> > 
> > Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_RELEASED
> > with zero i_compr_blokcs?
> > 
> > I think the current logic is giving the error on a released file already.
> > 
> > > 
> > > Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> > > ---
> > >  fs/f2fs/file.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 82cda1258227..f32910077df6 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
> > >  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > >  	if (ret)
> > >  		goto out;
> > > -
> > > -	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > >  	inode->i_ctime = current_time(inode);
> > >  	f2fs_mark_inode_dirty_sync(inode, true);
> > >  
> > >  	if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
> > >  		goto out;
> > >  
> > > +	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > >  	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > >  	filemap_invalidate_lock(inode->i_mapping);
> > >  
> > > -- 
> > > 2.38.1
