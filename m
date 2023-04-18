Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370D6E68FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDRQHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjDRQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270EBC678
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B956B6363A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E79C4339C;
        Tue, 18 Apr 2023 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834023;
        bh=nLK3HuPjSuFH/vS2H+8eBQtgXoA+Y82Z7zfq+WISfx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avsseWId/13Cvdf1kXTPI6USe0FJrQFGs4MG6TrSJxcnOtLhj6aAv47sEhbk0GcoF
         ozxEGyTlI2ONLQeyYiqnCgnHwVNDkaoB6VFiGJVlM1gxV6nMFltQEc4Sc7/xIyYbyM
         wexU2ee4vTwBr0GM7gGHFF1mL1aVI3mvSM8ne535DgKyFLRSjt7qj07h/CRjjRJ9YH
         3XEXNFaLdNPxPyO7fq3UylLAScovoCKU9JIzZczCrSU2+qQi6Q+gg27eM5lwrs/UHX
         9dqcxJ5cUORICAMpVeB+tDvkqf78wgnawffbYwgCHQgrFaPZxpfYa6BCraefvn2BCI
         VlW4ezJbSgw7g==
Date:   Tue, 18 Apr 2023 09:07:01 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Wu Bo <bo.wu@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
Subject: Re: [PATCH 1/1] f2fs: allocate trace path buffer from names_cache
Message-ID: <ZD7AJT7ZYPji8TWk@google.com>
References: <20230414104308.6591-1-bo.wu@vivo.com>
 <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ec7e19-634c-a065-fe7a-b052d02d4752@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18, Chao Yu wrote:
> On 2023/4/14 18:43, Wu Bo wrote:
> > It would be better to use the dedicated slab to store path.
> > 
> > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > ---
> >   fs/f2fs/file.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 15dabeac4690..27137873958f 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -4361,7 +4361,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
> >   	struct inode *inode = file_inode(iocb->ki_filp);
> >   	char *buf, *path;
> > -	buf = f2fs_kmalloc(F2FS_I_SB(inode), PATH_MAX, GFP_KERNEL);
> > +	buf = __getname();
> 
> How about:
> 
> buf = f2fs_kmem_cache_alloc(names_cachep, GFP_KERNEL, NULL, F2FS_I_SB(inode));

This looks like a hack using names_cachep?

> 
> >   	if (!buf)
> >   		return;
> >   	path = dentry_path_raw(file_dentry(iocb->ki_filp), buf, PATH_MAX);
> > @@ -4374,7 +4374,7 @@ static void f2fs_trace_rw_file_path(struct kiocb *iocb, size_t count, int rw)
> >   		trace_f2fs_dataread_start(inode, iocb->ki_pos, count,
> >   				current->pid, path, current->comm);
> >   free_buf:
> > -	kfree(buf);
> > +	__putname(buf);
> 
> kmem_cache_free(names_cachep, buf);
> 
> Thanks,
> 
> >   }
> >   static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
