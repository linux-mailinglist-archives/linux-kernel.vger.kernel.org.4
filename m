Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49971618804
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKCS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKCS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:56:41 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AE31A20B;
        Thu,  3 Nov 2022 11:56:37 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id 1so2825433vsx.1;
        Thu, 03 Nov 2022 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8ZxHqehtSCexx7BuFI+vfJrqxKMqvMHNZW3sS2W088=;
        b=hzVuz5H1Uuyy09qJnT5S06m90RimROo1ozi4238CG0WyXBBA2ahhB0DALa4dpmelRB
         48BZQzxH3RpCyvXiIL9Bo3KXdgY1hiK2SSS2j//wwyJ1Tc90BZgXsg7Slqi00T6efCAs
         5mgn/lU1S1wkmZ8993YnKF2QbGB54EiwUUXKuKnQAdWVTFqMDhKVKWGAKVzXjMGyASto
         kKJC9470nqwB0l3e5TAmZUI+rMZ0yUIL8ML2Upaobi+xrb1W8AzEZM/LOtpJS7JnSwyI
         xZB5VQGZLRxijAeedTSvRPw9lwiqwVzNujzDTE44+HuNCxTSOK+Jgq0gDwUeCLZc+miY
         6ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8ZxHqehtSCexx7BuFI+vfJrqxKMqvMHNZW3sS2W088=;
        b=5lpZVaJgqyu4UuF4CivFkHvP9wOywo/GEDIziSq4SFOFUKi8g+hj3YoFLT4j2UZoi6
         7FauPKclTlvPSwQlQw2rcAr0VjSukKyRjXsGE6Np2Bit/QLiqYrQLTiYPpzfjPAj+YWY
         JxGJsrE7azUwx9EzAUXLuE5wSkl2H/v3Pxui/XJVE4oP26xilCNtvo85OZTGr8DaV2u6
         ZG9Krszu9WmAwcHraajhMutwqBXI0UbK+IslPOOiu5G3Ip6IWuwyWcwav6YMpSXxH2OP
         qXkImVah7/FiF41sWQKAI7qbHN10QssmxBth0rbGGxT3tS3stmbh9cUaOqAvMx9ceyhb
         R2ew==
X-Gm-Message-State: ACrzQf0BdWvxviFiRNTyXEecYjvjnk0eBt+GWOwVlYXdzE2XyJjuQvPB
        p1nZWjuTgrrI8taweriTeOKKz7AoZcx+r6fCHDc=
X-Google-Smtp-Source: AMsMyM6E2K+/y8wl95FqQHuOdSXOP5o7JeYLQpxMn8AkU2QaTNL8Zumsne6PSnVW65VYTS1f/nOZWzVzjPJfHow+R4I=
X-Received: by 2002:a67:db0d:0:b0:3aa:12be:c26c with SMTP id
 z13-20020a67db0d000000b003aa12bec26cmr18044287vsj.26.1667501796654; Thu, 03
 Nov 2022 11:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221103141759.1836312-1-syoshida@redhat.com>
In-Reply-To: <20221103141759.1836312-1-syoshida@redhat.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 4 Nov 2022 03:56:19 +0900
Message-ID: <CAKFNMonawKi4b4G1d3CfJ6-+NLFOqVkHzNOO_5DocAJxGnkz7A@mail.gmail.com>
Subject: Re: [PATCH] nilfs: Avoid use-after-free caused by nilfs->ns_writer
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com
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

On Thu, Nov 3, 2022 at 11:18 PM Shigeru Yoshida wrote:
>
> syzbot reported use-after-free in nilfs_segctor_sync() [1].
>
> The use-after-free occurs with nilfs->ns_writer.  The scenario for the
> issue is as follows:
>
> Task1                                   Task2
> ----------------------------------------------------------------------
> nilfs_construct_segment
>   nilfs_segctor_sync
>     init_wait
>     init_waitqueue_entry
>     add_wait_queue
>     schedule
>                                         nilfs_detach_log_writer
>                                           nilfs_segctor_destroy
>                                             kfree
>     finish_wait
>       _raw_spin_lock_irqsave
>         __raw_spin_lock_irqsave
>           do_raw_spin_lock
>             debug_spin_lock_before  <-- use-after-free
>
> While Task1 is sleeping, nilfs->ns_writer is freed by Task2.  After
> Task1 waked up, Task1 accesses nilfs->ns_writer which is already
> freed.
>
> This patch fixes the issue by taking nilfs->ns_segctor_sem in
> nilfs_construct_segment() so that nilfs->ns_segctor_sem cannot be
> freed while nilfs_segctor_sync() is sleeping.
>
> Link: https://syzkaller.appspot.com/bug?id=79a4c002e960419ca173d55e863bd09e8112df8b [1]
> Reported-by: syzbot+f816fa82f8783f7a02bb@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  fs/nilfs2/segment.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index b4cebad21b48..d4f10d82664d 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2239,16 +2239,24 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
>  int nilfs_construct_segment(struct super_block *sb)
>  {
>         struct the_nilfs *nilfs = sb->s_fs_info;
> -       struct nilfs_sc_info *sci = nilfs->ns_writer;
> +       struct nilfs_sc_info *sci;
>         struct nilfs_transaction_info *ti;
> +       int ret;
>
> -       if (!sci)
> +       down_write(&nilfs->ns_segctor_sem);
> +       sci = nilfs->ns_writer;
> +       if (!sci) {
> +               up_write(&nilfs->ns_segctor_sem);
>                 return -EROFS;
> +       }
>
>         /* A call inside transactions causes a deadlock. */
>         BUG_ON((ti = current->journal_info) && ti->ti_magic == NILFS_TI_MAGIC);
>
> -       return nilfs_segctor_sync(sci);
> +       ret = nilfs_segctor_sync(sci);
> +       up_write(&nilfs->ns_segctor_sem);
> +
> +       return ret;
>  }
>
>  /**
> --
> 2.37.3
>

Thank you for your help Yoshida-san.

Your analysis of the bug cause is quite correct.

However, this patch caused deadlock for tests with fsync() or mkcp
command (i.e. nilfs_ioctl_sync).
They both call nilfs_construct_segment().
The approach implemented in this patch may not avoid the deadlock regression.

I'd like to consider other approaches.
My current thoughts are either to stop detaching ns_writer on remount
which is the root cause of the UAF races, or to introduce a refcount
on struct nilfs_sc_info.

Regards,
Ryusuke Konishi
