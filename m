Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0775EF729
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiI2OGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiI2OGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:06:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D1315E4DD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:06:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id jo24so792223plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xFM2w75WxT/coRawPhn0ZKkfLbQHCo667TO7S5diK2I=;
        b=Z4O3zypZZ/1IrnKBh23JGUnea4QaTzVb1Evg7UiEBTmBy4F/E/m5C3fwn/pUPky3d7
         64rueQB/u7q2hoaP3GBvuqm/DE348IRyYJapQhzRHffFp079DfSFHccd9s7+9k5QLGWk
         xupdVGw7XHym8RBecI6vc4zvigThnZU1qctEazopDLidg85/b6CLlpfM0hvUvsMaB++f
         wp1Xcrk+ET4el+GFthAXi6y9TiAryyNA5GZk2iS3d5xMtGsHhnDNln3DxoH2J0anqcvd
         MGESLfZkv5+oZb8ifxX89n0Uo5yLQUP9kdyqpBfB7PPSqY8yYec1YdxvgKYJVCuoBpZ+
         9qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xFM2w75WxT/coRawPhn0ZKkfLbQHCo667TO7S5diK2I=;
        b=Myj1x2Z3pnNULDv5RgPVHwdOgy4W2ldgCGmy2PM4C3ZItCTSHj6ko6gMNDdMHJGh/v
         LW+XqKYonA+CN3nSkq0hqxS5d7Q7mtIwAhpVtLxxKIJaiE63VdfnHLO3lp0yOnCUOGQH
         NpIbUdKbaAbeYEnb4jhdyzhMCyNF+qRngTxOTkRRNiRi8LnJvTVF65N35voIKA1D6XfC
         uCKsQ/xlhFG5Z866NVWPNsAy6gdYCQFz1LR11Vz2m0o2prv26nQa33JYrIpP6SqrZhhu
         yJoygKjgYT6Po85KGuIHBYSf5lRc6BsNUBhC3QPRe02EVuCh9ghbcHaQtNqmBsZui6Qb
         Zqxw==
X-Gm-Message-State: ACrzQf2xMw0LT9fpHVSCCHUhaMVx0kRkKBYeJBm3T9d/i31HaTqRok8G
        ZG4SLIudxeqL1Y8eZKY/8hSCQhhnZSrY3BmLLw==
X-Google-Smtp-Source: AMsMyM7wqtcgUVsjYJOvZ4BL9UsjWiMvv8ppL6WSSdoFIaPUiSTaEuGkJKq1Q9oJLwdB/wf4djoXmXfZNYNoi17sdL8=
X-Received: by 2002:a17:902:7c02:b0:178:3670:944b with SMTP id
 x2-20020a1709027c0200b001783670944bmr3671413pll.148.1664460365810; Thu, 29
 Sep 2022 07:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <YvpRLJ79GRWYjLdf@tycho.pizza> <20220901140647.1125079-1-tycho@tycho.pizza>
 <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
In-Reply-To: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
From:   Stef Bon <stefbon@gmail.com>
Date:   Thu, 29 Sep 2022 16:05:54 +0200
Message-ID: <CANXojcw6bi0TMu62wiXxkXg-osTELt2=5UcNdVeAHNCwd_xOhg@mail.gmail.com>
Subject: Re: [fuse-devel] [PATCH] fuse: In fuse_flush only wait if someone
 wants the return code
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        fuse-devel@lists.sourceforge.net,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
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

Hi,

I've some idea;s about the cause of the error.
In the first message about this:

"However, there's a problem when the fuse daemon
itself spawns a thread that does a flush: since the thread has a copy of
the fd table with an fd pointing to the same fuse device, the reference
count isn't decremented to zero in fuse_dev_release(), and the task hangs
forever."

If the kernel starts to abort the filesystem (since the daemon in
userspace is terminated), and cannot do that since a file handle is
still open due to a flush, resulting in a hang, maybe the reason to
stop/abort the filesystem is wrong. The kernel should look at the fuse
device fd (which is duplicated after spawning), find there is still
one fd open, and should not go into aborting the fs.

I hope this helps,

Stef Bon
the Netherlands

Op di 27 sep. 2022 om 11:48 schreef Miklos Szeredi via fuse-devel
<fuse-devel@lists.sourceforge.net>:


>
> On Thu, 1 Sept 2022 at 16:07, Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > In my very light testing this resolves a hang where a thread of the
> > fuse server was accessing the fuse filesystem (the fuse server is
> > serving up), when the fuse server is killed.
> >
> > The practical problem is that the fuse server file descriptor was
> > being closed after the file descriptor into the fuse filesystem so
> > that the fuse filesystem operations were being blocked for instead of
> > being aborted.  Simply skipping the unnecessary wait resolves this
> > issue.
> >
> > This is just a proof of concept and someone should look to see if the
> > fuse max_background limit could cause a problem with this approach.
>
> Maybe you missed my comments here:
>
> https://lore.kernel.org/all/CAJfpegsTmiO-sKaBLgoVT4WxDXBkRES=HF1YmQN1ES7gfJEJ+w@mail.gmail.com/
>
> I'm generally okay with this, but please write a proper changelog for
> the patch, also mentioning the issues related to posix locks.
>
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -464,6 +464,67 @@ static void fuse_sync_writes(struct inode *inode)
> >         fuse_release_nowrite(inode);
> >  }
> >
> > +struct fuse_flush_args {
> > +       struct fuse_args args;
> > +       struct fuse_flush_in inarg;
> > +       struct inode *inode;
> > +       struct fuse_file *ff;
> > +};
> > +
> > +static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
> > +{
> > +       struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
> > +
> > +       if (err == -ENOSYS) {
> > +               fm->fc->no_flush = 1;
> > +               err = 0;
> > +       }
> > +
> > +       /*
> > +        * In memory i_blocks is not maintained by fuse, if writeback cache is
> > +        * enabled, i_blocks from cached attr may not be accurate.
> > +        */
> > +       if (!err && fm->fc->writeback_cache)
> > +               fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
> > +
> > +
> > +       iput(fa->inode);
> > +       fuse_file_put(fa->ff, false, false);
> > +       kfree(fa);
> > +}
> > +
> > +static int fuse_flush_async(struct file *file, fl_owner_t id)
> > +{
> > +       struct inode *inode = file_inode(file);
> > +       struct fuse_mount *fm = get_fuse_mount(inode);
> > +       struct fuse_file *ff = file->private_data;
> > +       struct fuse_flush_args *fa;
> > +       int err;
> > +
> > +       fa = kzalloc(sizeof(*fa), GFP_KERNEL);
> > +       if (!fa)
> > +               return -ENOMEM;
> > +
> > +       fa->inarg.fh = ff->fh;
> > +       fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> > +       fa->args.opcode = FUSE_FLUSH;
> > +       fa->args.nodeid = get_node_id(inode);
> > +       fa->args.in_numargs = 1;
> > +       fa->args.in_args[0].size = sizeof(fa->inarg);
> > +       fa->args.in_args[0].value = &fa->inarg;
> > +       fa->args.force = true;
> > +       fa->args.nocreds = true;
> > +       fa->args.end = fuse_flush_end;
> > +       fa->inode = igrab(inode);
>
> Grabbing the inode should already taken care of by fuse_file_release().
>
> Also please try to reduce duplication in both the above functions.
>
> Thanks,
> Miklos
>
>
> --
> fuse-devel mailing list
> To unsubscribe or subscribe, visit https://lists.sourceforge.net/lists/listinfo/fuse-devel
