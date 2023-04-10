Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A976DCE30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDJXhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDJXhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:37:38 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C66211D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:37:36 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54c17fa9ae8so226980087b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681169855; x=1683761855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qkw/GA6UPO3IeieC5vFxNvGmDfYC7bPD9QqzFQab+/A=;
        b=TsNPZRbUvQKu8rdv8WHHOjgEI2Vh/ZxByO8VbKKnAhM29PQ0hinEhMt031q2oqG0+a
         SrI7Pe7gleMIKkcgkWYfEyIXTKDGzVSEe0CeVawfz54jOpMXumviSv+XDXG1IAFQl37u
         xA7P3S5qQOGCyBoi1jMyLYvIZ9t24Qb5isocQYA0uOkcobUzJ7DWs4XmoeHFcFAJidJm
         eo3ZuOLDffu42qvK0u5T5XmQvyrWrXX2mL2w/gMkNp7+mUgs29e9euJ3giiRG7Hr3HJV
         5g1IlQrnGVppRR0yLFvmURAA7sz/60naeTsLX7OpmQjbQMzFYqY+E28EmdeN4GEEEbVx
         CZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169855; x=1683761855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qkw/GA6UPO3IeieC5vFxNvGmDfYC7bPD9QqzFQab+/A=;
        b=SEmDZIb1i6L9wXw8y1fEq/y0R2ZpokLEjYT+uR7VkeSRfp4rYsvK5Zc6hPxbldiYv6
         sxSoGfMShOznD6a7De/GqYsckiTqSymn4p8jF2Kc0GR2DUS1iFoGMq95PhFXJnW4V5A0
         rprVxzotsc/XKT3IbD6ndEZXeIpgda8MOpMY7I429pCEg9SxtlpSSGFC1S7K0hT+yChW
         mHW2gNMzjnHRZTHOr1CoKhkYVyMmI2s11Yvpw7aOw4gewWmljLXCmfnWLR4Sa9n09Kbk
         0dEusOQzAWECYR0ff6VQOWEoLeCKLfzyxOMrQhy4kL+HyX5Ae1RDeh0D/b5hX1UOh/AV
         6PmQ==
X-Gm-Message-State: AAQBX9cc4YgwfB8iRgIikkaXd9j+JhtT4F/q7EnnMUmIvK/0CeG0MGlH
        c6AFxzp4H8xFtEbd3RsO1AfmzUtxs3PCoG8eKb2A
X-Google-Smtp-Source: AKy350a7yXm+bCF4ZoCGOrShl5BFD8zTaOuAbrQ7yu3iKh9GQ5HwpMIKURSzmPRoxkJP/5q7wwcRMYPd+ZHAcBIOJQA=
X-Received: by 2002:a81:ae57:0:b0:54e:dbe5:933b with SMTP id
 g23-20020a81ae57000000b0054edbe5933bmr4776815ywk.8.1681169855531; Mon, 10 Apr
 2023 16:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-6-casey@schaufler-ca.com>
 <80cd055f-3bd9-b89a-029b-7a63924b5bde@digikod.net>
In-Reply-To: <80cd055f-3bd9-b89a-029b-7a63924b5bde@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Apr 2023 19:37:24 -0400
Message-ID: <CAHC9VhTs=cHcsi15qFsMqtGZxm2bkTb2AOsbrERePwUT3N0uJQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] LSM: Create lsm_list_modules system call
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 8:04=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> It looks like you missed my preview reviews on these patches.

For reference, I believe this is Micka=C3=ABl's review of the associated v6=
 patch:

https://lore.kernel.org/linux-security-module/1ca41f67-ffa1-56c2-b4ee-f5dee=
ce95130@digikod.net/

> On 15/03/2023 23:46, Casey Schaufler wrote:
> > Create a system call to report the list of Linux Security Modules
> > that are active on the system. The list is provided as an array
> > of LSM ID numbers.
> >
> > The calling application can use this list determine what LSM
> > specific actions it might take. That might include chosing an
> > output format, determining required privilege or bypassing
> > security module specific behavior.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >   Documentation/userspace-api/lsm.rst |  3 +++
> >   include/linux/syscalls.h            |  1 +
> >   kernel/sys_ni.c                     |  1 +
> >   security/lsm_syscalls.c             | 39 ++++++++++++++++++++++++++++=
+
> >   4 files changed, 44 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/usersp=
ace-api/lsm.rst
> > index b45e402302b3..a86e3817f062 100644
> > --- a/Documentation/userspace-api/lsm.rst
> > +++ b/Documentation/userspace-api/lsm.rst
> > @@ -63,6 +63,9 @@ Get the specified security attributes of the current =
process
> >   .. kernel-doc:: security/lsm_syscalls.c
> >       :identifiers: sys_lsm_get_self_attr
> >
> > +.. kernel-doc:: security/lsm_syscalls.c
> > +    :identifiers: sys_lsm_list_modules
> > +
> >   Additional documentation
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 3feca00cb0c1..f755c583f949 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned in=
t attr, struct lsm_ctx *ctx,
> >                                     size_t *size, __u64 flags);
> >   asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_c=
tx *ctx,
> >                                     __u64 flags);
> > +asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags=
);
> >
> >   /*
> >    * Architecture-specific system calls
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index d03c78ef1562..ceb3d21a62d0 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
> >   /* security/lsm_syscalls.c */
> >   COND_SYSCALL(lsm_get_self_attr);
> >   COND_SYSCALL(lsm_set_self_attr);
> > +COND_SYSCALL(lsm_list_modules);
> >
> >   /* security/keys/keyctl.c */
> >   COND_SYSCALL(add_key);
> > diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> > index feee31600219..6efbe244d304 100644
> > --- a/security/lsm_syscalls.c
> > +++ b/security/lsm_syscalls.c
> > @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, att=
r, struct lsm_ctx __user *,
> >   {
> >       return security_getselfattr(attr, ctx, size, flags);
> >   }
> > +
> > +/**
> > + * sys_lsm_list_modules - Return a list of the active security modules
> > + * @ids: the LSM module ids
> > + * @size: size of @ids, updated on return
> > + * @flags: reserved for future use, must be zero
> > + *
> > + * Returns a list of the active LSM ids. On success this function
> > + * returns the number of @ids array elements. This value may be zero
> > + * if there are no LSMs active. If @size is insufficient to contain
> > + * the return data -E2BIG is returned and @size is set to the minimum
> > + * required size. In all other cases a negative value indicating the
> > + * error is returned.
> > + */
> > +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, =
size,
> > +             u32, flags)
> > +{
> > +     size_t total_size =3D lsm_active_cnt * sizeof(*ids);
> > +     size_t usize;
> > +     int i;
> > +
> > +     if (flags)
> > +             return -EINVAL;
> > +
> > +     if (get_user(usize, size))
> > +             return -EFAULT;
> > +
> > +     if (put_user(total_size, size) !=3D 0)
> > +             return -EFAULT;
> > +
> > +     if (usize < total_size)
> > +             return -E2BIG;
> > +
> > +     for (i =3D 0; i < lsm_active_cnt; i++)
> > +             if (put_user(lsm_idlist[i]->id, ids++))
> > +                     return -EFAULT;
> > +
> > +     return lsm_active_cnt;
> > +}

--=20
paul-moore.com
