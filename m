Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2AA5F12F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiI3TrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI3TrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:47:11 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE6F534E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:47:08 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 3A17F1ED7; Fri, 30 Sep 2022 14:47:07 -0500 (CDT)
Date:   Fri, 30 Sep 2022 14:47:07 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <20220930194707.GA12456@mail.hallyn.com>
References: <YvpRLJ79GRWYjLdf@tycho.pizza>
 <20220901140647.1125079-1-tycho@tycho.pizza>
 <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:46:44AM +0200, Miklos Szeredi wrote:
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

That's odd - fwiw I too had completely missed that reply, sorry.

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
