Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3881262FFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKRWMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiKRWLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:11:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A9976FA;
        Fri, 18 Nov 2022 14:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE899B8255C;
        Fri, 18 Nov 2022 22:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FEEC433D6;
        Fri, 18 Nov 2022 22:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668809499;
        bh=+7RUpCopDWImHx4kpniYvLBKqUGp3uhYcB86V79wOq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZ7+sTS7ME+VOF+J/iDcMwXeLNFmhd8HaBTNKMqfdJkqrtUnhUme/VUqiwmbXvMN8
         ZcI4DwDYHr91Q86B4xAC92PwVRdbDaZZMceC0PHTDYx3N7dw7zB8NnvoU1djVryuie
         iM4Ktss2tX/23xa47RJ/jnhF1e/Tt4r/YCuRQPhU=
Date:   Fri, 18 Nov 2022 14:11:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konishi.ryusuke@gmail.com>
Subject: Re: [PATCH] nilfs2: Fix nilfs_sufile_mark_dirty() not set segment
 usage as dirty
Message-Id: <20221118141138.c091445bdda36b78f6277c1f@linux-foundation.org>
In-Reply-To: <20221118063304.140187-1-chenzhongjin@huawei.com>
References: <20221118063304.140187-1-chenzhongjin@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 14:33:04 +0800 Chen Zhongjin <chenzhongjin@huawei.com> wrote:

> In nilfs_sufile_mark_dirty(), the buffer and inode are set dirty, but
> nilfs_segment_usage is not set dirty, which makes it can be found by
> nilfs_sufile_alloc() because it checks nilfs_segment_usage_clean(su).
> 
> This will cause the problem reported by syzkaller:
> https://syzkaller.appspot.com/bug?id=c7c4748e11ffcc367cef04f76e02e931833cbd24
> 
> It's because the case starts with segbuf1.segnum = 3, nextnum = 4, and
> nilfs_sufile_alloc() not called to allocate a new segment.
> 
> The first time nilfs_segctor_extend_segments() allocated segment
> segbuf2.segnum = segbuf1.nextnum = 4, then nilfs_sufile_alloc() found
> nextnextnum = 4 segment because its su is not set dirty.
> So segbuf2.nextnum = 4, which causes next segbuf3.segnum = 4.
> 
> sb_getblk() will get same bh for segbuf2 and segbuf3, and this bh is
> added to both buffer lists of two segbuf.
> It makes the list head of second list linked to the first one. When
> iterating the first one, it will access and deref the head of second,
> which causes NULL pointer dereference.
> 
> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")

Merged in 2009!

> --- a/fs/nilfs2/sufile.c
> +++ b/fs/nilfs2/sufile.c
> @@ -495,12 +495,18 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
>  int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
>  {
>  	struct buffer_head *bh;
> +	void *kaddr;
> +	struct nilfs_segment_usage *su;
>  	int ret;
>  
>  	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
>  	if (!ret) {
>  		mark_buffer_dirty(bh);
>  		nilfs_mdt_mark_dirty(sufile);
> +		kaddr = kmap_atomic(bh->b_page);
> +		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
> +		nilfs_segment_usage_set_dirty(su);
> +		kunmap_atomic(kaddr);
>  		brelse(bh);
>  	}
>  	return ret;

Do we feel that this fix should be backported into -stable kernels?

