Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE15EBEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiI0JrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0Jq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:46:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1841B40D0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:46:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so19499728ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pm5S/m5lntP/nI957+LkEdbF4CPh42i6AWwrR+XYcgQ=;
        b=L5DRm5QyqX16wZb9CnVothgyHMNsXhUFDy5PaGk4U+Qw0DNyB16TiwMTIz+3HzEd1X
         Rc1B6sp7+WIbgeefdsTivaunqgcxmBUe+QoRGx8gQEi3hSqtGJd8Zy5eCOsWwXmaiJ4K
         QTikQrh5Fs0iBRCahBTfjytOqCdYqAlMUnIcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pm5S/m5lntP/nI957+LkEdbF4CPh42i6AWwrR+XYcgQ=;
        b=2cE2iYWb6ALwAyM1s9a1I881wR/QZOV7nSUdqrQTF3zNClHAP4txmrgcTzWzAVUNWq
         yaPkmwP80x6bRp8Y4tgUBMusXcKQ7dV7OXI6pSOJkdR+I2cB7aok2PYb/gl7H+lA6rlB
         YWg4sjogwdBxqBuZfStnuCTOlaSt0LxBKYdpKhzvH10GJHNpSm4MpE/GVOZST5tSklmf
         clc6CfZyYwbY0zUSSbzc2Gzko2ZYGFe2MmU1zxs0NDqETpsGCglVfGFkYFD1z6Pc0+ci
         Ta/ukuiYRLQm0cvry6wV6LALw3mpZEDQmPyJQc1b24Whlqcl37UhIIEUSciYxR4BPSvb
         G5RQ==
X-Gm-Message-State: ACrzQf2GwzwyQ8U9jdcBL7T4nQ4ZLdOz2p5zPqh9o2JUMdCkDpN+/e6+
        265Z6owMYQCmbRzqXLB5H/F35b0jb+0NnHqd82JAMg==
X-Google-Smtp-Source: AMsMyM4aszY/Wi2NlGBw/Ofg5eXDwjSqeRp3474QSsHXy13C021bFVlN5jeHzGS/UeFV9vdrfKEHxhZL24mg6b/TBmU=
X-Received: by 2002:a17:907:7faa:b0:783:a5f7:86ec with SMTP id
 qk42-20020a1709077faa00b00783a5f786ecmr6784403ejc.187.1664272015290; Tue, 27
 Sep 2022 02:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <YvpRLJ79GRWYjLdf@tycho.pizza> <20220901140647.1125079-1-tycho@tycho.pizza>
In-Reply-To: <20220901140647.1125079-1-tycho@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 27 Sep 2022 11:46:44 +0200
Message-ID: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
Subject: Re: [PATCH] fuse: In fuse_flush only wait if someone wants the return code
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sept 2022 at 16:07, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> In my very light testing this resolves a hang where a thread of the
> fuse server was accessing the fuse filesystem (the fuse server is
> serving up), when the fuse server is killed.
>
> The practical problem is that the fuse server file descriptor was
> being closed after the file descriptor into the fuse filesystem so
> that the fuse filesystem operations were being blocked for instead of
> being aborted.  Simply skipping the unnecessary wait resolves this
> issue.
>
> This is just a proof of concept and someone should look to see if the
> fuse max_background limit could cause a problem with this approach.

Maybe you missed my comments here:

https://lore.kernel.org/all/CAJfpegsTmiO-sKaBLgoVT4WxDXBkRES=HF1YmQN1ES7gfJEJ+w@mail.gmail.com/

I'm generally okay with this, but please write a proper changelog for
the patch, also mentioning the issues related to posix locks.

> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -464,6 +464,67 @@ static void fuse_sync_writes(struct inode *inode)
>         fuse_release_nowrite(inode);
>  }
>
> +struct fuse_flush_args {
> +       struct fuse_args args;
> +       struct fuse_flush_in inarg;
> +       struct inode *inode;
> +       struct fuse_file *ff;
> +};
> +
> +static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
> +{
> +       struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
> +
> +       if (err == -ENOSYS) {
> +               fm->fc->no_flush = 1;
> +               err = 0;
> +       }
> +
> +       /*
> +        * In memory i_blocks is not maintained by fuse, if writeback cache is
> +        * enabled, i_blocks from cached attr may not be accurate.
> +        */
> +       if (!err && fm->fc->writeback_cache)
> +               fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
> +
> +
> +       iput(fa->inode);
> +       fuse_file_put(fa->ff, false, false);
> +       kfree(fa);
> +}
> +
> +static int fuse_flush_async(struct file *file, fl_owner_t id)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct fuse_mount *fm = get_fuse_mount(inode);
> +       struct fuse_file *ff = file->private_data;
> +       struct fuse_flush_args *fa;
> +       int err;
> +
> +       fa = kzalloc(sizeof(*fa), GFP_KERNEL);
> +       if (!fa)
> +               return -ENOMEM;
> +
> +       fa->inarg.fh = ff->fh;
> +       fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> +       fa->args.opcode = FUSE_FLUSH;
> +       fa->args.nodeid = get_node_id(inode);
> +       fa->args.in_numargs = 1;
> +       fa->args.in_args[0].size = sizeof(fa->inarg);
> +       fa->args.in_args[0].value = &fa->inarg;
> +       fa->args.force = true;
> +       fa->args.nocreds = true;
> +       fa->args.end = fuse_flush_end;
> +       fa->inode = igrab(inode);

Grabbing the inode should already taken care of by fuse_file_release().

Also please try to reduce duplication in both the above functions.

Thanks,
Miklos
