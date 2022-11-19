Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65BF630CE6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiKSHSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKSHSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:18:05 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D00B7011;
        Fri, 18 Nov 2022 23:18:04 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id t14so6770169vsr.9;
        Fri, 18 Nov 2022 23:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5+UwlhJcwWjm7+nwp869T/Xrji+nD7ZnGo6JwjADN0=;
        b=dBILmOvL+mq3KdKRiq55myh11lfFkPoP6KxnVv8XotrkG7Hvqq+ajLYER9j1m4dJ8k
         997ayW1FIhmZZxnGHrreNOEzLrKWtWUinXFVODI2NcJnZvFtOcczpK8++1N7/3HoosLD
         QIIPJqhICPL+CQVd164jAqvXLXhhNqi6efUPvHGgsMCLctZ1+hkx8FlRR48yIip8zqUn
         aJovWojrZT9wXnmsFfU9NTxvm6TOIN2jqrifm6xigOOSCZk5OWGePyzEOyeP/aQxCx7w
         bajy6IENK72rXROpLB4n7kb6YC7gdy9sINhQhTPTRzODBU3Po3XM7nGHVGJJJdG2CRIU
         KEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5+UwlhJcwWjm7+nwp869T/Xrji+nD7ZnGo6JwjADN0=;
        b=Qrf/xwpAQjb3ui3y2ZgARB5ER5F8Wd19Gvgr19W/wFfo/9ibg2O7E33vObyfxY93cn
         KYjLBkPpLe11mnVlxdbz6DW8f+bb83+fQirrlJ+jsvOF09zShmdCQVQdPNPLyGxffy2Z
         q0ElSMQa5o1f9fjuRq76fUELGtlp+g1HNftKBfaD4ctwly9zQt2Pre2PGq9lkTQL8XUU
         7KbdpoK1Yo+Xm1WERHr30wKzuMdxj2j72irzxlCSf29DP5YnZksWKUZocSv/5Z393hzh
         kpW1EgxXkVm1A5D2pVnH80IceNlT/1xPaNpeUtfekL29qDXTswo7GzL4uJOIFOok7Wwk
         8+tg==
X-Gm-Message-State: ANoB5plkullGyvh0ZjhHehTal9ju/96a2gi3QeLswhQ2ybLJLmR8jaB1
        8HQWqsjQUYGnREeZgPjNP5O4hebNmaJO6UD+PtRo/xGXD1w=
X-Google-Smtp-Source: AA0mqf4Dx6XmHygEgZqSCnODMgit8jjYfe9rzzHtA54gpd8DuWN6vsACtgbzL70va18XoYViEVb3aHq8SF644VbuBXg=
X-Received: by 2002:a67:1006:0:b0:3aa:5e8:3a19 with SMTP id
 6-20020a671006000000b003aa05e83a19mr5329017vsq.37.1668842283372; Fri, 18 Nov
 2022 23:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20221118063304.140187-1-chenzhongjin@huawei.com>
 <20221118141138.c091445bdda36b78f6277c1f@linux-foundation.org>
 <0e693d41-0bb5-b4a9-19b7-1c71e90e06bf@huawei.com> <55553de4-04c3-09f3-b075-f0112d2298cb@huawei.com>
In-Reply-To: <55553de4-04c3-09f3-b075-f0112d2298cb@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 19 Nov 2022 16:17:46 +0900
Message-ID: <CAKFNMom=vjGrXJoc02ut8GocQ6hMmHrkcdReEvk-ykcE4p0b-w@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Fix nilfs_sufile_mark_dirty() not set segment
 usage as dirty
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

Hi Chen Zhongjin,

On Sat, Nov 19, 2022 at 2:29 PM Chen Zhongjin wrote:
>
>
> On 2022/11/19 13:24, Chen Zhongjin wrote:
> > On 2022/11/19 6:11, Andrew Morton wrote:
> >> On Fri, 18 Nov 2022 14:33:04 +0800 Chen Zhongjin
> >> <chenzhongjin@huawei.com> wrote:
> >>
> >>> In nilfs_sufile_mark_dirty(), the buffer and inode are set dirty, but
> >>> nilfs_segment_usage is not set dirty, which makes it can be found by
> >>> nilfs_sufile_alloc() because it checks nilfs_segment_usage_clean(su).
> >>>
> >>> This will cause the problem reported by syzkaller:
> >>> https://syzkaller.appspot.com/bug?id=c7c4748e11ffcc367cef04f76e02e931833cbd24
> >>>
> >>>
> >>> It's because the case starts with segbuf1.segnum = 3, nextnum = 4, and
> >>> nilfs_sufile_alloc() not called to allocate a new segment.
> >>>
> >>> The first time nilfs_segctor_extend_segments() allocated segment
> >>> segbuf2.segnum = segbuf1.nextnum = 4, then nilfs_sufile_alloc() found
> >>> nextnextnum = 4 segment because its su is not set dirty.
> >>> So segbuf2.nextnum = 4, which causes next segbuf3.segnum = 4.
> >>>
> >>> sb_getblk() will get same bh for segbuf2 and segbuf3, and this bh is
> >>> added to both buffer lists of two segbuf.
> >>> It makes the list head of second list linked to the first one. When
> >>> iterating the first one, it will access and deref the head of second,
> >>> which causes NULL pointer dereference.
> >>>
> >>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> >> Merged in 2009!
> >
> > Yes, seems it is introduced at the beginning of this file and the
> > function called nilfs_touch_segusage().
> >

Could you please resubmit the patch reflecting the following comments ?

After I replied to Andrew, I noticed them.
Also, When reposting, it would be helpful if you could add all the
tags I asked for Andrew in advance.

Comments:
1) Please change nilfs_sufile_mark_dirty() so that it protects the
segusage modification
with &NILFS_MDT(sufile)->mi_sem:

> --- a/fs/nilfs2/sufile.c
> +++ b/fs/nilfs2/sufile.c
> @@ -495,12 +495,18 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
>  int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
>  {
>       struct buffer_head *bh;
> +     void *kaddr;
> +     struct nilfs_segment_usage *su;
>       int ret;
>
>       ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);

+       down_write(&NILFS_MDT(sufile)->mi_sem);
>       if (!ret) {
>               mark_buffer_dirty(bh);
>               nilfs_mdt_mark_dirty(sufile);
> +             kaddr = kmap_atomic(bh->b_page);
> +             su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
> +             nilfs_segment_usage_set_dirty(su);
> +             kunmap_atomic(kaddr);
>               brelse(bh);
>       }
+       up_write(&NILFS_MDT(sufile)->mi_sem);
>       return ret;

All functions that modify metadata on the sufile need protection with
this R/W semaphore.
You may not see this protection for some sufile functions as is, but
in that case, the wrapper function that uses them acquires this R/W
semaphore instead.

Since I retested for this change as well, you don't have to drop my
"Tested-by" tag.

2) Please use the following complete email address for the
"Reported-by" tag of syzbot.

Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com

Your tag is partially abbreviated.  I don't know that abbreviation is
valid, but there are very few examples of such.
And even if it's valid for syzbot, I don't think that omission is
desirable as some tools may not support it.

Thanks,
Ryusuke Konishi
