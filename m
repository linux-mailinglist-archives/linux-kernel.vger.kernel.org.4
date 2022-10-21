Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E99606DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJUCl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJUClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:41:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546941EEA04
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:41:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h185so1296229pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHaTEgELqZucdbkgwdj5xVLrR3sTANCQHwBWYpXrDwg=;
        b=dn1FJWNAP+t44tpnfehnU21uXU5pdAaACu3Oa79rz0ubMUQKxXq5xEKNle55fcNpNr
         k1/muB+8CtaMnBgpWGzHI/67dp1Y0IBmwFn44HrvW5DlW9v+X+CGhPnrkWEiAjfg+2QQ
         aZDzR9Bdf8jk/5zW3Ic0OW+3tHEXLBdAf2JY5vuYHQjkhm+uvnXHvO0e77cavyq9BoML
         CD8xq2DJNbVRw20lnq3wrGiGcfqqcZP/nR8lokGzfL94W4LzLrAg019frrTS0sfeVJXA
         X3DVCPXyUtxQyufXAKsnJpYj4EZYx4IYZPIZOiXkYQgKbet34Bk8EHh0ysa7vGLhjGBj
         SzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHaTEgELqZucdbkgwdj5xVLrR3sTANCQHwBWYpXrDwg=;
        b=KZHceLOiRvQUbqEzXLMUxBviGgKFyJwRwVWO3W4IZYBBw5qWEhIysuP711uP8thGaM
         EVcnJv6AxNXmFgXIJnKfUqaIizaFDr0TGs2DSyiIjR4my3URSrMSdso2zVHiAFJIbItS
         czrcNQIRKG2PYE8YBM8xkt1i0hIJOzBHSUpmA18J28tTJ+MdadQCM00BUttrrEHLOYt/
         aTP2FuMe+84Spdz1DhRF2vX1f1gEUPNlNHtp4c39/qnmPCBJ9oAXrRFTFmdxebc8IbBU
         W8fMwVRQSBm43/zckoUzc9KN9m40LuXXp5KJ7o6+xcCf0wb3RC/vhLvLYNRt5aWGvNGv
         vz6w==
X-Gm-Message-State: ACrzQf1ktSEmAl4F0NTcaxaGMJJJXKwj2D/0a8m56PHyhQyxNKdFu2H8
        k/JK0Sv5+4LJQBb86HxU6Ec=
X-Google-Smtp-Source: AMsMyM6PtbI8J6Oapq5CSGQIqVaxBmmc+AT2patlNedL5QjRuHQN6mBD3iXGD0ZH3+VFJhwWx4zSiA==
X-Received: by 2002:a63:1609:0:b0:45c:7c1c:4e7d with SMTP id w9-20020a631609000000b0045c7c1c4e7dmr14170938pgl.265.1666320077331;
        Thu, 20 Oct 2022 19:41:17 -0700 (PDT)
Received: from localhost ([159.226.94.113])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b00177fb862a87sm13725924plg.20.2022.10.20.19.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:41:16 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     mike.kravetz@oracle.com
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        syzbot+a3e6acd85ded5c16a709@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH -next] hugetlbfs: fix null-ptr-deref in hugetlbfs_parse_param()
Date:   Fri, 21 Oct 2022 10:37:41 +0800
Message-Id: <20221021023740.184533-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y1Hb6sIJXrRwEttv@monkey>
References: <Y1Hb6sIJXrRwEttv@monkey>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, 21 Oct 2022 at 07:38, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
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
This issue did not exist before commit ac369cdd9448, because kernel will
sets param->string a string(although a zero length string) by kmemdup_nul()
when fs string has zero length in vfs_parse_fs_string(). So it will ensures
that param->string is not a null pointer in hugetlbfs_parse_param().

I also revert commit ac369cdd9448 or reset to ac369cdd9448~, and test
the syzkaller reproducer. The reproducer does not trigger any issue
in both situations.

>
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
> >       case Opt_size:
> >               /* memparse() will accept a K/M/G without a digit */
> > -             if (!isdigit(param->string[0]))
> > +             if (!param->string || !isdigit(param->string[0]))
> >                       goto bad_val;
> >               ctx->max_size_opt = memparse(param->string, &rest);
> >               ctx->max_val_type = SIZE_STD;
> > @@ -1387,7 +1387,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
> >
> >       case Opt_nr_inodes:
> >               /* memparse() will accept a K/M/G without a digit */
> > -             if (!isdigit(param->string[0]))
> > +             if (!param->string || !isdigit(param->string[0]))
> >                       goto bad_val;
> >               ctx->nr_inodes = memparse(param->string, &rest);
> >               return 0;
> > @@ -1403,7 +1403,7 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
> >
> >       case Opt_min_size:
> >               /* memparse() will accept a K/M/G without a digit */
> > -             if (!isdigit(param->string[0]))
> > +             if (!param->string || !isdigit(param->string[0]))
> >                       goto bad_val;
> >               ctx->min_size_opt = memparse(param->string, &rest);
> >               ctx->min_val_type = SIZE_STD;
> > --
> > 2.25.1
> >
