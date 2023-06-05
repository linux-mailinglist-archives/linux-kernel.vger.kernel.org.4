Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD280723046
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjFETuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjFETt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B88B196
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58964629F6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E147C433A1;
        Mon,  5 Jun 2023 19:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685994517;
        bh=Sueiie1DUsoUmYO3JzWY/sOCc4aMVdtU32UPjgG9EkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iiyaU3LoSTaZ0MQNp9WFck95P9tfxtA90k6+FX03l0u443qjgA/YZ/9MbPfwz9bsr
         gwf2OLNgFnTLNr4p7w/QN7UDLBjOzDCZ3ePfEwy5DpF54rhgvKf1IAkdTXq4R/eIZs
         oAAynFlWRlRmoT9qGW3JI+B0qsiCvL4or9laTtey+6ODdW5opbE2NI1++tRRGr64v1
         VuriNXXkrvBxp27bSEMMULbM3DPBeEt8ppxQT2d4ZDoE7llv55MPC8Sej58nYPI2W+
         omTAKgV5fOBck+NjNT9/V+qqWioIkQga/A29tpuxJMnzULtzGKDg0XkyO+Q1wZi9iS
         GJX5BKVpY60ow==
Date:   Mon, 5 Jun 2023 12:48:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Juhyung Park <qkrwngud825@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Lu Hongfei <luhongfei@vivo.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: flag as supporting buffered async reads
Message-ID: <ZH48E4/AOtk1viOY@google.com>
References: <20230531125918.55609-1-frank.li@vivo.com>
 <CAD14+f1YoiSVvq2M1v8u5bUdCNN_0nurY4ued6ZFu1gaBSHxDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD14+f1YoiSVvq2M1v8u5bUdCNN_0nurY4ued6ZFu1gaBSHxDw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31, Juhyung Park wrote:
> Hi Yangtao,
> 
> I remember hearing that f2fs can perform relatively poorly under io_uring,
> nice find.
> 
> I suggest rewriting the commit message though. From the looks of it, it
> might suggest that FMODE_BUF_RASYNC is a magic flag that automatically
> improves performance that can be enabled willy nilly.
> 
> How about something like:
> 
> f2fs uses generic_file_buffered_read(), which supports buffered async
> reads since commit 1a0a7853b901 ("mm: support async buffered reads in
> generic_file_buffered_read()").

Thanks Juhyung,

Applied with a minor motification based on yours. :)

> 
> Match other file-systems and enable it. The read performance has been
> greatly improved under io_uring:
> 
>     167M/s -> 234M/s, Increase ratio by 40%
> 
> Test w/:
>     ./fio --name=onessd --filename=/data/test/local/io_uring_test
>     --size=256M --rw=randread --bs=4k --direct=0 --overwrite=0
>     --numjobs=1 --iodepth=1 --time_based=0 --runtime=10
>     --ioengine=io_uring --registerfiles --fixedbufs
>     --gtod_reduce=1 --group_reporting --sqthread_poll=1
> 
> On Wed, May 31, 2023 at 10:01 PM Yangtao Li via Linux-f2fs-devel
> <linux-f2fs-devel@lists.sourceforge.net> wrote:
> >
> > After enabling this feature, the read performance has been greatly
> > improved:
> >
> >     167M/s -> 234M/s, Increase ratio by 40%
> >
> > Test w/:
> >     ./fio --name=onessd --filename=/data/test/local/io_uring_test
> >     --size=256M --rw=randread --bs=4k --direct=0 --overwrite=0
> >     --numjobs=1 --iodepth=1 --time_based=0 --runtime=10
> >     --ioengine=io_uring --registerfiles --fixedbufs
> >     --gtod_reduce=1 --group_reporting --sqthread_poll=1
> >
> > Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/f2fs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 015ed274dc31..23c68ee946e5 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -546,7 +546,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
> >         if (err)
> >                 return err;
> >
> > -       filp->f_mode |= FMODE_NOWAIT;
> > +       filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
> >
> >         return dquot_file_open(inode, filp);
> >  }
> > --
> > 2.39.0
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
