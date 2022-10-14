Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95AC5FF17D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJNPgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJNPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:36:05 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462AC2A711
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:36:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y17so2693331ilq.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytj3+kIoMyv4FX1lyc9tQ8OGwlhuPVWv2RqpKd5YyDU=;
        b=JR0xr0fIsskJTzO427SqrUgqb1DWjVVtwkmODGGjkSZJ4FMfX2ZsXK6Mm2spguP5Fi
         nyMmB82X0MA3h2JOCrtW3gl25dxsj4jiveXGKR6Z8STGPeeVjmS2VTjycP+RBn0tVhJl
         RTnAEkh5Qc5sIHtelNV80ZV0a1sV1g2AGrc8jU/2ZL2m19qrw9p6cxMlxHCX1YxptKvv
         NWg2UfEw3P0qeI86qPSMdLeiUDU5LTngBxTc3KHC3yReE92Ufkh4RP9JTPdhqddOZWDg
         6zCkai4UfclKgR3ffQ4VMj7CkN9eR7ciGLAV2JgtjXPGADfXQqzzW05FazqVHzwOwv/N
         dRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytj3+kIoMyv4FX1lyc9tQ8OGwlhuPVWv2RqpKd5YyDU=;
        b=k+0nc0GmQDkmfqgApUYFT2eRxOrI6r56VX+FjID+cAA/4ySRUFQMbVMZBfinwPW9zH
         cCY6HR7bW6nAhAZ7ISVIuRH25XUZuydOz8lURp/sYAJ8uKCFVRDXXtPcbtEnlAQQMonG
         pJQwrrq5NQJqt+ZCCAG8y80H1G34sFc0xArq0voLk6NyzUJgSGN+0mFwwNV5r+36nzSV
         8QuqVvTo7T5GWeuWoDzxDpIFInmoAumB9aFidvABvKpgh9GJdWUt/HVoXLSrYEMZLfA3
         w9R6vKmSeOVfDcNkV2uLcAaU4WLKsWye6hg/qPr2Bav/A/69tWFaSTyyR5zqn/335KqU
         Ffhg==
X-Gm-Message-State: ACrzQf2q05Kw9RUP7sUgBlrCnkcFCOCSG6SIHc+ubz5uOsBLlPI3DR9U
        W/1TYEbN2jFBzRIpQ6yeLC2N61oYll4H4SGRLS2zAw==
X-Google-Smtp-Source: AMsMyM7SIvsGjFVFdZwPi/xpWspvv9GkH6JpuhbcRadzt8f/XtARZ9xDpqKEwls7AQ8KnXFNx+6y9OAVQ6OkLrOgJ1E=
X-Received: by 2002:a05:6e02:1c27:b0:2fc:6aa7:edda with SMTP id
 m7-20020a056e021c2700b002fc6aa7eddamr2701536ilh.177.1665761762432; Fri, 14
 Oct 2022 08:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com> <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com>
In-Reply-To: <2032f766-1704-486b-8f24-a670c0b3cb32@app.fastmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Oct 2022 17:35:26 +0200
Message-ID: <CAG48ez3hM+-V39QpFaNfRJxVrQVBu2Dm-B-xFN2GEt9p81Vd2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 5:18 AM Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Oct 6, 2022, at 7:13 AM, Jann Horn wrote:
> > On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> =
wrote:
> >> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> >> > The check_unsafe_exec() counting of n_fs would not add up under a he=
avily
> >> > threaded process trying to perform a suid exec, causing the suid por=
tion
> >> > to fail. This counting error appears to be unneeded, but to catch an=
y
> >> > possible conditions, explicitly unshare fs_struct on exec, if it end=
s up
> >>
> >> Isn't this a potential uapi break? Afaict, before this change a call t=
o
> >> clone{3}(CLONE_FS) followed by an exec in the child would have the
> >> parent and child share fs information. So if the child e.g., changes t=
he
> >> working directory post exec it would also affect the parent. But after
> >> this change here this would no longer be true. So a child changing a
> >> workding directoro would not affect the parent anymore. IOW, an exec i=
s
> >> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc b=
ut
> >> it seems like a non-trivial uapi change but there might be few users
> >> that do clone{3}(CLONE_FS) followed by an exec.
> >
> > I believe the following code in Chromium explicitly relies on this
> > behavior, but I'm not sure whether this code is in active use anymore:
> >
> > https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/=
suid/sandbox.c;l=3D101?q=3DCLONE_FS&sq=3D&ss=3Dchromium
>
> Wait, this is absolutely nucking futs.  On a very quick inspection, the s=
harable things like this are fs, files, sighand, and io.    files and sigha=
nd get unshared, which makes sense.  fs supposedly checks for extra refs an=
d prevents gaining privilege.  io is... ignored!  At least it's not immedia=
tely obvious that io is a problem.
>
> But seriously, this makes no sense at all.  It should not be possible to =
exec a program and then, without ptrace, change its cwd out from under it. =
 Do we really need to preserve this behavior?

I agree that this is pretty wild.

The single user I'm aware of is Chrome, and as far as I know, they use
it for establishing their sandbox on systems where unprivileged user
namespaces are disabled - see
<https://chromium.googlesource.com/chromium/src/+/main/docs/linux/suid_sand=
box.md>.
They also have seccomp-based sandboxing, but IIRC there are some small
holes that mean it's still useful for them to be able to set up
namespaces, like how sendmsg() on a unix domain socket can specify a
file path as the destination address.

(By the way, I think maybe Chrome wouldn't need this wacky trick with
the shared fs_struct if the "NO_NEW_PRIVS permits chroot()" thing had
ever landed that you
(https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327=
858005.git.luto@amacapital.net/)
and Micka=C3=ABl Sala=C3=BCn proposed in the past... or alternatively, if t=
here
was a way to properly filter all the syscalls that Chrome has to
permit for renderers.)

(But also, to be clear, I don't speak for Chrome, this is just my
understanding of how their stuff works.)
