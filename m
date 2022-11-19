Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855EA630BC5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 05:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiKSEMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 23:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiKSEMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 23:12:10 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C883EAE;
        Fri, 18 Nov 2022 20:11:22 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 128so6544936vsz.12;
        Fri, 18 Nov 2022 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFTErpkyzUkKz4ZMbc5fuZ/BIhGwsKOPVm98ZEN6Gw0=;
        b=dwc1huwFF6jYZdqDS9arWDVXnvg6wO3C13GYEqmpH9hPak4zNhpMGPlUPgcJx7J//u
         HEiPB5L1L5ixQEy6PW5eyc9NbNSBzlsmANoEDd+iARirivsjs4zBBUZciJzwqsdM8ARK
         knqo3wS7+kIPT+U5EYi0PDAld+vb9GyLqcQf75PY9tMk6F035cIj2kNjp8eVUFrHlBY9
         p0Of/4Y9+xd20KvYuMnQeAx/XMnKSspnk19Dgg8T25Kh1X9bfhbparyLGKiuXQiP0XPk
         gnT3fjVzYvqih9oKVVBpOAtNyBw9yxhuX5UbOr7NbtJFtAVNKzBeYIEfMaNIcGYu7Bfy
         3FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFTErpkyzUkKz4ZMbc5fuZ/BIhGwsKOPVm98ZEN6Gw0=;
        b=MbZCCTxDe4hglIMf2UxRyjDTV6pjBe4raNwdJVBrAACCU6J/acutzj0bgKAff0Vy8u
         zjwZurMqhTLzwfWVldc1DHwk418bO1UpAkMqu4/1fJOXJz5iVwN+QsibQk+X3H3/+BK1
         572iHJT51BlWp5fiUjPpbveXq+jtTpN5+s59cXcdp2W8qNrT58qNDdobQ0GCS0kcEJVt
         o+U36/81HY98D6fMMemONtkPLwOTW4+HPkIhtOaY+Df7Ga3s8iJq4KSmoxLs9QbGP+so
         MP0EKJFYeg58rhaBKTjE9EriJhIVfUK/cN8Be0dUPH9MTS0OoepbNWh+N6n3fPZTN2X5
         F4bQ==
X-Gm-Message-State: ANoB5pnt6Cgd3OMeiE3HFSEKNUVboEfPUhV3D2VbThyuK9ErakWMmi3n
        IasPgx9otDhIyKr9k2LE2rir92jfdjFNZ8V5iRWqXlprzpk=
X-Google-Smtp-Source: AA0mqf7Q+wT5O9gYE4BGZUDzzTDnTAdkgtVf1kWKDrow0EwM3qB5U/1/9HytXgOk6SZUGBNQMaS9MD4naEqsa7Y2LO0=
X-Received: by 2002:a05:6102:2cf:b0:3aa:2f91:5230 with SMTP id
 h15-20020a05610202cf00b003aa2f915230mr5915vsh.68.1668831081845; Fri, 18 Nov
 2022 20:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20221118063304.140187-1-chenzhongjin@huawei.com> <20221118141138.c091445bdda36b78f6277c1f@linux-foundation.org>
In-Reply-To: <20221118141138.c091445bdda36b78f6277c1f@linux-foundation.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 19 Nov 2022 13:11:05 +0900
Message-ID: <CAKFNMonaKuOrCt0dKxN5t3gPKOq--z=Q+LZ8iczqN30kQEdhkQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Fix nilfs_sufile_mark_dirty() not set segment
 usage as dirty
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Nov 19, 2022 at 7:11 AM Andrew Morton wrote:
>
> On Fri, 18 Nov 2022 14:33:04 +0800 Chen Zhongjin wrote:
>
> > In nilfs_sufile_mark_dirty(), the buffer and inode are set dirty, but
> > nilfs_segment_usage is not set dirty, which makes it can be found by
> > nilfs_sufile_alloc() because it checks nilfs_segment_usage_clean(su).
> >
> > This will cause the problem reported by syzkaller:
> > https://syzkaller.appspot.com/bug?id=c7c4748e11ffcc367cef04f76e02e931833cbd24
> >
> > It's because the case starts with segbuf1.segnum = 3, nextnum = 4, and
> > nilfs_sufile_alloc() not called to allocate a new segment.
> >
> > The first time nilfs_segctor_extend_segments() allocated segment
> > segbuf2.segnum = segbuf1.nextnum = 4, then nilfs_sufile_alloc() found
> > nextnextnum = 4 segment because its su is not set dirty.
> > So segbuf2.nextnum = 4, which causes next segbuf3.segnum = 4.
> >
> > sb_getblk() will get same bh for segbuf2 and segbuf3, and this bh is
> > added to both buffer lists of two segbuf.
> > It makes the list head of second list linked to the first one. When
> > iterating the first one, it will access and deref the head of second,
> > which causes NULL pointer dereference.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

This is a simple and side-effect-free nice patch for this problem,
even though the functionality of nilfs_sufile_mark_dirty() has changed
from what it is supposed to do.

Making the segment usage dirty was the responsibility of another
function, nilfs_sufile_alloc().
However, it turns out that the current implementation is insufficient
for corrupted disk images like those created by syzbot. This patch
complements that.

If you don't mind, please add the following tag as well:

Reported-by: Liu Shixin <liushixin2@huawei.com>

He initially tried to fix this issue [1]:

[1] https://lkml.kernel.org/r/20221108022928.497746-1-liushixin2@huawei.com

> >
> > Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
>
> Merged in 2009!

This is not wrong.  Sorry for the long term bug.
Because mkfs.nilfs2 and the nilfs2 module don't create broken metadata
that would require this patch, so we never encountered this bug until
syzbot reported it.

>
> > --- a/fs/nilfs2/sufile.c
> > +++ b/fs/nilfs2/sufile.c
> > @@ -495,12 +495,18 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
> >  int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
> >  {
> >       struct buffer_head *bh;
> > +     void *kaddr;
> > +     struct nilfs_segment_usage *su;
> >       int ret;
> >
> >       ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
> >       if (!ret) {
> >               mark_buffer_dirty(bh);
> >               nilfs_mdt_mark_dirty(sufile);
> > +             kaddr = kmap_atomic(bh->b_page);
> > +             su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
> > +             nilfs_segment_usage_set_dirty(su);
> > +             kunmap_atomic(kaddr);
> >               brelse(bh);
> >       }
> >       return ret;
>
> Do we feel that this fix should be backported into -stable kernels?

Yes, it should be. Please do so.

Thanks,
Ryusuke Konishi
