Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E01668656
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjALWHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjALWGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:06:25 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884776ACC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:54:48 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id n190so16597976vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq/9Mnd1yx+6gMtIvx6Zvb004fXPIfhmq+PAIf373GU=;
        b=ATN5lIg2ny7UVhvUkwf09In5CKJtKTjOXChGAhq2wJ8OqtJ0s2CbLnd0WbxXhNbfM9
         y9ydw1CsAnvOraEwtp5NY49B74Z+uairDunFhCHQma0UfECxm5pBJ13Pd0Qc25g2Wxp8
         e9ewg0H8rKp2UWU99RRSpBY0+jNmTfulQHFNczP4W5szNXZoxR/XVRGS1xf2pTdFZAYM
         phQhIA+ipRC1PpStWrDmEOThUQJb6RL9foK+XT98SHwXXyiElB/agenJ1RxWPqbD7svt
         Z6xxwRVmq3TpY3zQ3eI8vUBNEw2nmjjUQqQwptQXNHV44ypI/J8h5j/GFEG6UjweZHsK
         WZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yq/9Mnd1yx+6gMtIvx6Zvb004fXPIfhmq+PAIf373GU=;
        b=RNDa3yB53pw62zs9t2Rhrfbnx/YUddLlFP5D+LnPtTy3l9V3JNTMEFaKynQssAvzX2
         1rgl/EsfU7kqpQXzotxTBk7dZ4NQi3T89HQwugmnfxevt2TFgF2lpAD0k1xcAaTeYCKh
         PqQz20yYZm3HfQSKmZ97Hgoa5E9NXXvXTHjIE0DN2/bkGajFjDkB78JgHDoopyE8cXj5
         2xfe/yBYECElYCHLYWUFX/Y5OozrXA3j2G80x46d74XX+mjFCDTLQ4rilorkNYJ1A/9F
         cZLwZt7azU30VZmi2TeteHnUAulkCx/WbO5Z10knk1CoL6qIWD6kz2iTkp+qKzpyBGz1
         mtNA==
X-Gm-Message-State: AFqh2ko55ZyLklDhPn6gHE73XXMux1RWbp8m+nawVT9uW7qEDvY6kwVr
        IliEO/e8gMuMFHJ9GmJAfY2rfythAP8KzbRHF8RB
X-Google-Smtp-Source: AMrXdXu6NRMtwm7rO8qWTMjQWtMEp/5vpU+B0BJS8BeLtDswajKDzN0GpvwhL5nE2tFyaZFCK5j05oxJP71BJ1dYYyE=
X-Received: by 2002:a05:6102:5344:b0:3a7:9bf9:bcc5 with SMTP id
 bq4-20020a056102534400b003a79bf9bcc5mr8966346vsb.34.1673560487975; Thu, 12
 Jan 2023 13:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com> <20230109213809.418135-5-tjmercier@google.com>
 <CAHC9VhT+5oE4DZzxqCGFDoHjkP+5GcKU1R2BBW29uUu8BcgiAg@mail.gmail.com>
 <CABdmKX2FPf+Ox47g8nMeYw1OBNUOZrnKD5qVBtaVY01FbQq4ig@mail.gmail.com>
 <CAHC9VhTK701norsBFz8XsDS+2m6=UR9TE-XSX1WjSt3-pd3g-A@mail.gmail.com> <CABdmKX08sg2+MtzHD2ar7eD8xXNGUbbS03zYSMpK+wF51LztmQ@mail.gmail.com>
In-Reply-To: <CABdmKX08sg2+MtzHD2ar7eD8xXNGUbbS03zYSMpK+wF51LztmQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 16:54:35 -0500
Message-ID: <CAHC9VhSQTz3-0ONEccA_YfJ4fxWXOqRCQeocf7uPJOJ_jiXsFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] security: binder: Add transfer_charge SElinux hook
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 4:36 PM T.J. Mercier <tjmercier@google.com> wrote:
> On Thu, Jan 12, 2023 at 12:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Jan 11, 2023 at 7:21 PM T.J. Mercier <tjmercier@google.com> wrote:
> > > On Wed, Jan 11, 2023 at 3:00 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Mon, Jan 9, 2023 at 4:38 PM T.J. Mercier <tjmercier@google.com> wrote:
> > > > >
> > > > > Any process can cause a memory charge transfer to occur to any other
> > > > > process when transmitting a file descriptor through binder. This should
> > > > > only be possible for central allocator processes, so a new SELinux
> > > > > permission is added to restrict which processes are allowed to initiate
> > > > > these charge transfers.
> > > > >
> > > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > > > ---
> > > > >  drivers/android/binder.c            | 5 +++++
> > > > >  include/linux/lsm_hook_defs.h       | 2 ++
> > > > >  include/linux/lsm_hooks.h           | 6 ++++++
> > > > >  include/linux/security.h            | 2 ++
> > > > >  security/security.c                 | 6 ++++++
> > > > >  security/selinux/hooks.c            | 9 +++++++++
> > > > >  security/selinux/include/classmap.h | 2 +-
> > > > >  7 files changed, 31 insertions(+), 1 deletion(-)
> > > >
> > > > Hi T.J.,
> > > >
> > > > A few things come to mind when looking at this patchset, but let me
> > > > start with the big one first: you only sent 0/4 and 4/4 to the LSM and
> > > > SELinux lists, so that's all I'm seeing in my inbox to review, and
> > > > it's hard to make sense of what you want to do with just these
> > > > snippets.  This makes me cranky, and less inclined to spend the time
> > > > to give this a proper review, because there are plenty of other things
> > > > which need attention and don't require me having to hunt down missing
> > > > pieces.  Yes, I'm aware of b4/lei, and while they are great tools, my
> > > > workflow was pretty well established before they came into existence
> > > > and I still do things the good ol' fashioned way with mailing lists,
> > > > etc.
> > > >
> > > > Make the patch reviewer's life easy whenever you can, it will rarely
> > > > (ever?) backfire, I promise.
> > >
> > > Hi Paul, sorry about that. I have git send-email calling
> > > get_maintainer.pl to automatically figure out the recipients, and I
> > > think that's why it only sent particular patches to a subset of lists.
> > > Looks like the list of recipients for each patch should be a union of
> > > all patches. Thank you for taking a look anyway! Here's a lore link:
> > > https://lore.kernel.org/lkml/20230109213809.418135-1-tjmercier@google.com/
> > >
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index 9830848c8d25..9063db04826d 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -2279,6 +2279,11 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
> > > > >         if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
> > > > >                 struct dma_buf *dmabuf;
> > > > >
> > > > > +               if (security_binder_transfer_charge(proc->cred, target_proc->cred)) {
> > > > > +                       ret = -EPERM;
> > > > > +                       goto err_security;
> > > > > +               }
> > > >
> > > > This is where I believe I'm missing the proper context, as this
> > > > version of binder_translate_fd() differs from what I see in Linus'
> > > > tree.  However, the version in Linus' tree does have a LSM hook,
> > > > security_binder_transfer_file(), which is passed both the credentials
> > > > you are using above and based solely on the level of indentation shown
> > > > in the chunk of code above, it seems like the existing hook might be
> > > > suitable?
> > >
> > > Yes, patch 3 plumbs through flags to this function:
> > > https://lore.kernel.org/lkml/20230109213809.418135-4-tjmercier@google.com/
> > >
> > > I don't think the existing hook is suitable, which I've tried to explain below.
> >
> > In this particular case the issue of what permission checks are done
> > for a given LSM, SELinux in this case, appears to be independent of if
> > we need a new, different, or second LSM hook.  Unless I missed
> > something the only real difference with this new hook is that is sits
> > behind a conditional checking if memory control groups are enabled and
> > if a transfer charge was specified; it seems like passing the @flags
> > parameter into the existing LSM hook would allow you to use the
> > existing hook (it is called before the new hook, right?)?
> >
> Ah yes, that sounds like it would work. Thank you.
>
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 3c5be76a9199..823ef14924bd 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -2066,6 +2066,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
> > > > >                             &ad);
> > > > >  }
> > > > >
> > > > > +static int selinux_binder_transfer_charge(const struct cred *from, const struct cred *to)
> > > > > +{
> > > > > +       return avc_has_perm(&selinux_state,
> > > > > +                           cred_sid(from), cred_sid(to),
> > > > > +                           SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
> > > > > +                           NULL);
> > > > > +}
> > > >
> > > > Generally speaking SELinux doesn't really worry about resource
> > > > accounting controls so this seems a bit out of place, but perhaps the
> > > > larger question is do you see this being sufficiently distinct from
> > > > the existing binder:transfer permission?  In other words, would you
> > > > ever want to grant a domain the ability to transfer a file *without*
> > > > also granting it the ability to transfer the memory charge?  You need
> > > > to help me explain why we need an additional permission for this,
> > > > because I don't currently see the need.
> > > >
> > > Yes, and that's actually more often the case than not. A file here
> > > means a file descriptor that points at any type of resource: file on
> > > disk, memfd, dmabuf, etc. Currently there exists policy that restricts
> > > which processes are allowed to interact with FDs over binder using the
> > > security_binder_transfer_file hook you reference. [1] However this new
> > > transfer_charge permission is meant to restrict the ability of a FD
> > > sender to transfer the memory charge associated with that FD (if one
> > > exists) to a recipient (who may or may not want to accept the memory
> > > charge). So the memory charge is independent of (potentially one-time,
> > > read-only) access to the FD.
> >
> > Without a more comprehensive set of LSM/SELinux access controls around
> > resource management (which would need discussion beyond just this
> > thread/patch) I'm not sure we want to start patching in one-off
> > controls like this.
>
> Understood, I'll try reusing security_binder_transfer_file.

Well, yes, it looks like you should reuse the existing hook, but that
is missing the point here - I'm not convinced we want this new SELinux
control without some additional discussion and work around the
desirability and practicality of adding SELinux controls to resource
management.

> > I haven't looked, but are there any traditional/DAC access controls
> > around transfering memory changes from one task to another?  It seems
> > like there *should* be, and if so, it seems like that would be the
> > right approach at the moment ... if you're not already doing that in
> > the other patches in the patchset.
>
> I'm not aware of controls associated with individual objects like
> dmabufs. While it's not quite the same thing, I do see that support
> for charge migration tied to task migration was intentionally dropped
> for cgroup2 and is now deprecated for cgroup1 because it's difficult
> and expensive. However that seems like a much bigger job than dealing
> with the memory backing an individual object when that object is
> handed off between processes (the object ownership moves, not the
> task).

I would suggest you should start talking to the cgroup folks about
this, that seems like a much better first step than jumping straight
to a LSM hook to control just one type of charge transfer.  At the
very least, that is the start of the much larger conversation that
would be needed to add resource management controls to SELinux (and
other LSMs that wanted to implement similar controls).

-- 
paul-moore.com
