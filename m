Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A06DCE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjDKAcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjDKAcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:32:11 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3626B0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:32:09 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id bv15so4618088ybb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681173128; x=1683765128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWQ9G0NQhiUwUGFObFakqkMlVOJbAJgQnb6NV+yeJ6o=;
        b=LnOn76YoPjARpgeLfjyyqLMfbKqpjPxWKqUZ5fmBcwsbTUQ8fJgEoXqqDVhFwS9C8m
         L3/j/U8JEPqK5yYKItEQ5ErdpcHVo0r9s6jUBbbG6+kVILDpsT9+Xy/GkDkfHpldVAwv
         mLz9aYENpe4aPO0q1K+VJ6HTIR7Z9CjHImSRuv5T85VtJtzdnK6Odwgl8+O57yMUvgLA
         1uUbgPtNx6yHFR8otgxpJxjWWsdxSM8r9hVxS+2V50OcRtFAkjEAZzmaVncOoteCe1Vb
         Y8G/QgFCBg5YAAxwQrgO9vWAwEWMfESmIR1SXkjNvnU48bpO+GKgmh9cyUFZKP72D+1I
         OOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681173128; x=1683765128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWQ9G0NQhiUwUGFObFakqkMlVOJbAJgQnb6NV+yeJ6o=;
        b=rYH+f5k6OdSly/4zhjEu43URtE41UGRg2VnqaGQCAx43VCuqkR7O12hSGLEAddR81+
         4yzTo0tchNxXNM2VBrft381NFGdd9PWsx10HepESn7qhpeIBSQGmBQe7AtMjkh4ZyCvK
         nOjg9Jpr+i3sKn68yL2g2U5Gtnl2mMk9YtlsL4wz/tiFAsP9WZo3JOA+acCn/Hdtl5MC
         HD3FJ86IJ2Q4G8KCU+/gmRy5x3VH2LNrUtG1dhP/LsPd5u3AHEg8dSbSV26zWACQxXY4
         JK8sbxsxSn7ECmxtPMOwqc5NnAJA+lbSUZUkinvF1nD0yq4/j7YSDdurncwFwkoPxPdr
         66WA==
X-Gm-Message-State: AAQBX9fdifv99/8G1xDP2rMFvs14qhm2HNK4fkBp5K5azWwNXguiBd+E
        6ktGaJT/SkfpyHCLNfZ4kbKF7Eq/00dKV0ThoTmBDKP06EnJGg4=
X-Google-Smtp-Source: AKy350bKOGBpKXG92fJ6JEROfwpmoGw5IaydqkouD3+4eDyGSvV8Qa7RGgIwuVn9kudcZSex+znUZioOY8F3Jmv4GOI=
X-Received: by 2002:a25:e0c5:0:b0:b8b:fd23:5028 with SMTP id
 x188-20020a25e0c5000000b00b8bfd235028mr353362ybg.3.1681173128224; Mon, 10 Apr
 2023 17:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-5-casey@schaufler-ca.com>
 <b63f1957-d3d5-28f9-fd27-c0e629456a9f@digikod.net>
In-Reply-To: <b63f1957-d3d5-28f9-fd27-c0e629456a9f@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Apr 2023 20:31:57 -0400
Message-ID: <CAHC9VhR8aNaDqjuv-K3VB7nG3jA+yBB0Ai8n0sCj46sDnx-mXw@mail.gmail.com>
Subject: Re: [PATCH v7 04/11] LSM: syscalls for current process attributes
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
> On 15/03/2023 23:46, Casey Schaufler wrote:
> > Create a system call lsm_get_self_attr() to provide the security
> > module maintained attributes of the current process.
> > Create a system call lsm_set_self_attr() to set a security
> > module maintained attribute of the current process.
> > Historically these attributes have been exposed to user space via
> > entries in procfs under /proc/self/attr.
> >
> > The attribute value is provided in a lsm_ctx structure. The structure
> > identifys the size of the attribute, and the attribute value. The forma=
t
> > of the attribute value is defined by the security module. A flags field
> > is included for LSM specific information. It is currently unused and mu=
st
> > be 0. The total size of the data, including the lsm_ctx structure and a=
ny
> > padding, is maintained as well.
> >
> > struct lsm_ctx {
> >          __u64   id;
> >          __u64   flags;
> >          __u64   len;
> >          __u64   ctx_len;
> >          __u8    ctx[];
> > };
> >
> > Two new LSM hooks are used to interface with the LSMs.
> > security_getselfattr() collects the lsm_ctx values from the
> > LSMs that support the hook, accounting for space requirements.
> > security_setselfattr() identifies which LSM the attribute is
> > intended for and passes it along.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >   Documentation/userspace-api/lsm.rst | 15 +++++
> >   include/linux/lsm_hook_defs.h       |  4 ++
> >   include/linux/lsm_hooks.h           |  9 +++
> >   include/linux/security.h            | 19 ++++++
> >   include/linux/syscalls.h            |  5 ++
> >   include/uapi/linux/lsm.h            | 33 ++++++++++
> >   kernel/sys_ni.c                     |  4 ++
> >   security/Makefile                   |  1 +
> >   security/lsm_syscalls.c             | 55 ++++++++++++++++
> >   security/security.c                 | 97 ++++++++++++++++++++++++++++=
+
> >   10 files changed, 242 insertions(+)
> >   create mode 100644 security/lsm_syscalls.c
>
> [...]
>
> > diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> > new file mode 100644
> > index 000000000000..feee31600219
> > --- /dev/null
> > +++ b/security/lsm_syscalls.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * System calls implementing the Linux Security Module API.
> > + *
> > + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> > + *  Copyright (C) 2022 Intel Corporation
> > + */
> > +
> > +#include <asm/current.h>
> > +#include <linux/compiler_types.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/security.h>
> > +#include <linux/stddef.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/types.h>
> > +#include <linux/lsm_hooks.h>
> > +#include <uapi/linux/lsm.h>
> > +
> > +/**
> > + * sys_lsm_set_self_attr - Set current task's security module attribut=
e
> > + * @attr: which attribute to set
> > + * @ctx: the LSM contexts
> > + * @size: size of @ctx
> > + * @flags: reserved for future use
> > + *
> > + * Sets the calling task's LSM context. On success this function
> > + * returns 0. If the attribute specified cannot be set a negative
> > + * value indicating the reason for the error is returned.
>
> Do you think it is really worth it to implement syscalls that can get
> and set attributes to several LSMs at the same time, instead of one at a
> time?

As mentioned elsewhere, the "set" operations pretty much have to be
one LSM at a time; the error handling is almost impossible otherwise.

However, it would be possible to have a single LSM "get" operation.
We could do this with the proposed lsm_get_self_attr() syscall and a
flag to indicate that only a single LSM's attribute information is
being requested, and that the desired LSM is indicated by the
lsm_ctx::id field (populated by the userspace caller).  I'm imagining
something like this:

  lsm_ctx->id =3D LSM_ID_MYFAVORITELSM;
  lsm_get_self_attr(LSM_ATTR_CURRENT,
                    lsm_ctx, &lsm_ctx_size, LSM_FLG_SINGLE);

> LSM-specific tools don't care about other LSMs.

That's why they are called "LSM-specific tools" ;)  I think it is a
reasonable request to provide optimizations for that, the
discussion/example above, but I think we also want to support tools
which are LSM "aware" but don't need to be made specific to any one
particular LSM.  Thankfully, I think we can do both.

> I still think it
> would be much simpler (for kernel and user space) to pass an LSM ID to
> both syscalls. This would avoid dealing with variable arrays of variable
> element lengths, to both get or set attributes.

I think we should support "get" operations that support getting an
attribute from multiple LSMs, but I'm perfectly fine with also
supporting a single LSM "get" operation as described in the example
above.

> Furthermore, considering the hypotetical LSM_ATTR_MAGICFD that was
> previously talked about, getting an unknown number of file descriptor
> doesn't look good neither.

We are already in a place where not all LSMs support all of the
attributes, and we handle that.  If you are concerned about a specific
LSM returning some additional, or "richer", attribute data, the
syscall does support that; it is just a matter of the userspace caller
being able to understand the LSM-specific data ... which is true for
even the simple/standard case.

> > + */
> > +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx =
__user *,
> > +             ctx, size_t __user, size, u32, flags)
> > +{
> > +     return security_setselfattr(attr, ctx, size, flags);
> > +}
> > +
> > +/**
> > + * sys_lsm_get_self_attr - Return current task's security module attri=
butes
> > + * @attr: which attribute to set
>
> attribute to *get*
>
> > + * @ctx: the LSM contexts
> > + * @size: size of @ctx, updated on return
>
> I suggest to use a dedicated argument to read the allocated size, and
> another to write the actual/written size.

Can you elaborate on this?  There is plenty of precedence for this approach=
.

> This would not be required with an LSM ID passed to the syscall because
> attribute sizes should be known by user space, and there is no need to
> help them probe this information.

No.  As we move forward, and LSMs potentially introduce additional
attribute information/types/etc., there will be cases where the kernel
could need more buffer space than userspace would realize.  Keeping
the length flexible allows this, with the extra information ignored by
"legacy" userspace, and utilized by "new" userspace.

> > + * @flags: reserved for future use
> > + *
> > + * Returns the calling task's LSM contexts. On success this
> > + * function returns the number of @ctx array elements. This value
> > + * may be zero if there are no LSM contexts assigned. If @size is
> > + * insufficient to contain the return data -E2BIG is returned and
> > + * @size is set to the minimum required size.
>
> Doing something (updating a buffer) even when returning an error doesn't
> look right.

We could zero the buffer on error/E2BIG if that is a concern, but
unfortunately due the nature of the LSM it is not possible to safely
(no races) determine the size of the buffer before populating it.

> These sizes should be well-known to user space and part of
> the ABI/UAPI.

That may be true for specific LSMs at this point in time, but I
believe it would be a serious mistake to impose that constraint on
these syscalls.

--=20
paul-moore.com
