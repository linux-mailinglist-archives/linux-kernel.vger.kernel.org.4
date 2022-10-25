Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AEE60D2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJYRqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJYRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:46:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A7A1D0FB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 911FD61A6A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26C8C433D6;
        Tue, 25 Oct 2022 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666719978;
        bh=8BegBzFebokZgfEsi+2gc5z3pDHvlffY3pA7fRmvbaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vz3szJxFUoMewNmxuZdYMbx4vxSeB2p1KITG6qDCF85pVelpc9IE+Oph1RmSuLhf0
         f72zpbNOOmAVDBGs7OLaq+/ta2yv38JLc+OTuwAgp+ozh+EKEOQSIpUfCIwBLczYkE
         NHuW4etuUZtYatuJrxaRN9T87BZAeQM7KwDpmytnxCpwMx69Y6xK/mmgukqVwtSYD5
         FFCVol+3F3ELM3awyn37iUlJi/LWZ0wU4roVk7JqfM+DpUYr6GDKxoLVG2NOxdfyv1
         x3VmrXAajNhKVZVt4kMBHtOE9l8KwSGQYwMYQBYjKjboLQX8Lvm9A/5fhCllG5tQH0
         VG1nBLvtYT0Xg==
Date:   Tue, 25 Oct 2022 10:46:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow to set compression for inlined
 file
Message-ID: <Y1gg6P6CO9KbDO0O@google.com>
References: <20221024233634.803695-1-jaegeuk@kernel.org>
 <ae5f7c6e-248b-3cf7-b111-a4ddc85dd411@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae5f7c6e-248b-3cf7-b111-a4ddc85dd411@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Chao Yu wrote:
> On 2022/10/25 7:36, Jaegeuk Kim wrote:
> > The below commit disallows to set compression on empty created file which
> > has a inline_data. Let's fix it.
> > 
> > Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/file.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 1c4004c9245f..304fe08edc61 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1915,6 +1915,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
> >   			if (!f2fs_disable_compressed_file(inode))
> >   				return -EINVAL;
> >   		} else {
> > +			/* try to convert inline_data to support compression */
> > +			f2fs_convert_inline_inode(inode);
> 
> It needs to check return value of f2fs_convert_inline_inode()?

I intended to catch that in the below checks?

> 
> Thanks,
> 
> > +
> >   			if (!f2fs_may_compress(inode))
> >   				return -EINVAL;
> >   			if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
