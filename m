Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F656608004
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJUUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJUUmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:42:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EADBB076
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4138CB80C82
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 20:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97720C433D7;
        Fri, 21 Oct 2022 20:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666384908;
        bh=Qzg0lzb4PyXJJpKafhb5Mq85PLuLiXUJJpeNDuwXkKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ReshceG5rp6LLS2X4EjA3hNe+xtJmtSeqLaGBy4fLcsKbO0DOWo7r0Axsge39E7rp
         Bs6rMoys5yCI8c/5Hn6n8ygTleU67IOhzfAhdNN2uwZ3Md0UmFDpGiDWtPJBdqL0rj
         aPnDajP6SSLCjixdJ65PrIzlZq4bjdlDe+Ec1SDI=
Date:   Fri, 21 Oct 2022 13:41:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hawkins Jiawei <yin31149@gmail.com>,
        syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, 18801353760@163.com,
        Ian Kent <raven@themaw.net>
Subject: Re: [PATCH -next] hugetlbfs: fix null-ptr-deref in
 hugetlbfs_parse_param()
Message-Id: <20221021134147.17278fc73dce36589d167c5d@linux-foundation.org>
In-Reply-To: <Y1Hb6sIJXrRwEttv@monkey>
References: <20221020231609.4810-1-yin31149@gmail.com>
        <Y1Hb6sIJXrRwEttv@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 16:38:18 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 10/21/22 07:16, Hawkins Jiawei wrote:
> > Syzkaller reports a null-ptr-deref bug as follows:
> > ======================================================
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > RIP: 0010:hugetlbfs_parse_param+0x1dd/0x8e0 fs/hugetlbfs/inode.c:1380
> > [...]
> > Call Trace:
> >  <TASK>
> >  vfs_parse_fs_param fs/fs_context.c:148 [inline]
> >  vfs_parse_fs_param+0x1f9/0x3c0 fs/fs_context.c:129
> >  vfs_parse_fs_string+0xdb/0x170 fs/fs_context.c:191
> >  generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:231
> >  do_new_mount fs/namespace.c:3036 [inline]
> >  path_mount+0x12de/0x1e20 fs/namespace.c:3370
> >  do_mount fs/namespace.c:3383 [inline]
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  [...]
> >  </TASK>
> > ======================================================
> > 
> > According to commit
> > ac369cdd9448("vfs: parse: deal with zero length string value"),
> > kernel will sets the param->string to null pointer in
> > vfs_parse_fs_string() if fs string has zero length.
> > 
> > Yet the problem is that, hugetlbfs_parse_param() will
> > dereference the param->string, without checking whether it
> > is a null pointer. To be more specific, if hugetlbfs_parse_param()
> > parses an illegal mount parameter, such as "size=,", kernel will
> > constructs struct fs_parameter with null pointer in
> > vfs_parse_fs_string(), then passes this struct fs_parameter to
> > hugetlbfs_parse_param(), which triggers the above
> > null-ptr-deref bug.
> > 
> > This patch solves it by adding sanity check on param->string
> > in hugetlbfs_parse_param().
> > 
> > Reported-by: syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com
> > Tested-by: syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/all/0000000000005ad00405eb7148c6@google.com/
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> 
> Thank you!
> 
> This was on my list of things to look at.
> 
> Do you know if the issue existed before commit ac369cdd9448?  Just
> wondering if we need a Fixes tag and stable backports.

Ian Kent's "vfs: parse: deal with zero length string value" exists only
in mm-nonmm-unstable.  I'm hoping that it gets some attention from Al
Viro.

I'll merge this patch so we're ready for Ian's patch.  I normally merge
mm-stable ahead of mm-nonmm-stable so there shouldn't be a bisection
window.

Ian, could you please go through the filesystems and see if there are
other instances of this getting ready to bite us?


> I'll take a closer look at the patch a bit later, unless someone beats
> me to it.
> -- 
> Mike Kravetz
> 
> > ---
> >  fs/hugetlbfs/inode.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 7f836f8f9db1..3ee84604e36d 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -1377,7 +1377,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
> >  
> >  	case Opt_size:
> >  		/* memparse() will accept a K/M/G without a digit */
> > -		if (!isdigit(param->string[0]))
> > +		if (!param->string || !isdigit(param->string[0]))
> >  			goto bad_val;
> >  		ctx->max_size_opt = memparse(param->string, &rest);
> >  		ctx->max_val_type = SIZE_STD;
> > @@ -1387,7 +1387,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
> >  
> >  	case Opt_nr_inodes:
> >  		/* memparse() will accept a K/M/G without a digit */
> > -		if (!isdigit(param->string[0]))
> > +		if (!param->string || !isdigit(param->string[0]))
> >  			goto bad_val;
> >  		ctx->nr_inodes = memparse(param->string, &rest);
> >  		return 0;
> > @@ -1403,7 +1403,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
> >  
> >  	case Opt_min_size:
> >  		/* memparse() will accept a K/M/G without a digit */
> > -		if (!isdigit(param->string[0]))
> > +		if (!param->string || !isdigit(param->string[0]))
> >  			goto bad_val;
> >  		ctx->min_size_opt = memparse(param->string, &rest);
> >  		ctx->min_val_type = SIZE_STD;
> > -- 
> > 2.25.1
> > 
