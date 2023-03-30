Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A66D12F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjC3XWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjC3XWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:22:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C7E10AAB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:22:46 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p15so25539071ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680218566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMhDdox3W6ZIpkSlsW/BA/8XmIJaV3zHEa/CJlMiH7M=;
        b=J76GzjE5TC+pSOYCnZvNrSwZ6X6nysFTbLxIX+36/1Jj8YkzgsyxWXhttdD+ND9jRD
         111BroVdHtD4lXOTuT6/WnO718jwyhlplePid3M0LMNuLIlY/yRgyQ/bQW+/c/yZD/r8
         NLku3KwJzd+r9ESePy4ckt5AG6o4N513/ISD2I5UF42PIzZ0YUO9SGSsIu0j+fCspYtz
         ERizQa32z+NonKjzYZOPvWtUf+WUlNP67qtTdmZqRwgxVGp5LiQtk0svTx04kMjj0PPQ
         OlhbI4U5sBWL7fDx0oB3masRv/FMd4Cn6+Dtw00cEVwIwlQDa5hTF/o5BUhp/aYcuCYm
         r8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMhDdox3W6ZIpkSlsW/BA/8XmIJaV3zHEa/CJlMiH7M=;
        b=iDpQJSoVlXgoT6PvpmCvFalNaQosieNj+jtP35Etcvzp/JD8F7w2SydGJZTvsih3az
         p21pPLts1JTZkcIhBUs5OfUr9iy5MCXT8FTiHtaOfZmrqH34rceX+f5935syFpQxMzuH
         k8C35f2iwocAsBo508dJnkjM9Fw9PUXz/HoKaoxDkZbSx/Hiuy8eH2sgeUibIgrjA/+Y
         yq2WKU2KRXTh0Whf2LAKBrT3M73qCG3c9wvvw7e1RtSGTDc0+wAJIqVOsiXnucqZ8qdD
         D9x5NthMYcBpKXsM7Ca333TPMD1mIyLYUrjObVMkKVRFwHDqPbahQvA1PXvLGQaT8vRN
         mMnA==
X-Gm-Message-State: AAQBX9c7Uh4PNYNlvmJAoaZVZ23BKPWaD++XTn8/7bom4ttdVaqQoYRh
        TjGFWyUTwGN+g6bAUA2GmGrtuenKbraJpEsPQnC7
X-Google-Smtp-Source: AKy350aq24t2w2OhIGe2kGoA2xukhf/xqmX4JD/k57QmXbMzxfViay53AQkkHh6S0hxO52L1pgS/CuorGsEqBVw46to=
X-Received: by 2002:a05:6902:72e:b0:b6c:f26c:e5ab with SMTP id
 l14-20020a056902072e00b00b6cf26ce5abmr17352852ybt.3.1680218565951; Thu, 30
 Mar 2023 16:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-5-casey@schaufler-ca.com>
 <CAHC9VhRuKqaYD=WCzuuk4=+qFSvCjCEMEsPjAh9pQe-=LyMthA@mail.gmail.com> <6cbbe6eb-d808-7a99-9ca9-43f816b99833@schaufler-ca.com>
In-Reply-To: <6cbbe6eb-d808-7a99-9ca9-43f816b99833@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Mar 2023 19:22:34 -0400
Message-ID: <CAHC9VhSoecHCmuxCeiTvYxjRb+D=jw4TXyYs5P9hnXOjjGGDQQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/11] LSM: syscalls for current process attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
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

On Thu, Mar 30, 2023 at 4:00=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 3/29/2023 6:12 PM, Paul Moore wrote:
> > On Wed, Mar 15, 2023 at 6:48=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> Create a system call lsm_get_self_attr() to provide the security
> >> module maintained attributes of the current process.
> >> Create a system call lsm_set_self_attr() to set a security
> >> module maintained attribute of the current process.
> >> Historically these attributes have been exposed to user space via
> >> entries in procfs under /proc/self/attr.
> >>
> >> The attribute value is provided in a lsm_ctx structure. The structure
> >> identifys the size of the attribute, and the attribute value. The form=
at
> > "identifies"
> >
> >> of the attribute value is defined by the security module. A flags fiel=
d
> >> is included for LSM specific information. It is currently unused and m=
ust
> >> be 0. The total size of the data, including the lsm_ctx structure and =
any
> >> padding, is maintained as well.
> >>
> >> struct lsm_ctx {
> >>         __u64   id;
> >>         __u64   flags;
> >>         __u64   len;
> >>         __u64   ctx_len;
> >>         __u8    ctx[];
> >> };
> >>
> >> Two new LSM hooks are used to interface with the LSMs.
> >> security_getselfattr() collects the lsm_ctx values from the
> >> LSMs that support the hook, accounting for space requirements.
> >> security_setselfattr() identifies which LSM the attribute is
> >> intended for and passes it along.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  Documentation/userspace-api/lsm.rst | 15 +++++
> >>  include/linux/lsm_hook_defs.h       |  4 ++
> >>  include/linux/lsm_hooks.h           |  9 +++
> >>  include/linux/security.h            | 19 ++++++
> >>  include/linux/syscalls.h            |  5 ++
> >>  include/uapi/linux/lsm.h            | 33 ++++++++++
> >>  kernel/sys_ni.c                     |  4 ++
> >>  security/Makefile                   |  1 +
> >>  security/lsm_syscalls.c             | 55 ++++++++++++++++
> >>  security/security.c                 | 97 ++++++++++++++++++++++++++++=
+
> >>  10 files changed, 242 insertions(+)
> >>  create mode 100644 security/lsm_syscalls.c

...

> >> +       int count =3D 0;
> >> +       int rc;
> >> +
> >> +       if (attr =3D=3D 0)
> >> +               return -EINVAL;
> >> +       if (flags !=3D 0)
> >> +               return -EINVAL;
> >> +       if (size =3D=3D NULL)
> >> +               return -EINVAL;
> >> +       if (get_user(left, size))
> >> +               return -EFAULT;
> >> +
> >> +       hlist_for_each_entry(hp, &security_hook_heads.getselfattr, lis=
t) {
> >> +               this =3D left;
> >> +               if (base)
> >> +                       ctx =3D (struct lsm_ctx __user *)(base + total=
);
> > Pointer math on void pointers always makes me nervous.  Why not set
> > @base's type to a 'u8' just to remove any concerns?
>
> I can do that. I made it a void pointer to reflect the notion that
> the attributes aren't necessarily strings. Making it a u8 may suggest tha=
t
> the data is a string to some developers.

That's a fair concern, but there is plenty of precedence of binary
blobs being stored in 'unsigned char' arrays to make it easier to
pluck data out at random byte offsets.

> >> +               rc =3D hp->hook.getselfattr(attr, ctx, &this, flags);
> >> +               switch (rc) {
> >> +               case -EOPNOTSUPP:
> >> +                       rc =3D 0;
> >> +                       continue;
> >> +               case -E2BIG:
> >> +                       istoobig =3D true;
> >> +                       left =3D 0;
> >> +                       break;
> >> +               case 0:
> >> +                       left -=3D this;
> >> +                       break;
> >> +               default:
> >> +                       return rc;
> > I think the @getselfattr hook should behave similarly to the
> > associated syscall, returning a non-negative number should indicate
> > that @rc entries have been added to the @ctx array.  Right now all the
> > LSMs would just be adding one entry to the array, but we might as well
> > code this up to be flexible.
>
> Yes, some LSM may decide to have multiple "contexts".
>
> >> +               }
> >> +               total +=3D this;
> >> +               count++;
> >> +       }
> >> +       if (count =3D=3D 0)
> >> +               return LSM_RET_DEFAULT(getselfattr);
> >> +       if (put_user(total, size))
> >> +               return -EFAULT;
> >> +       if (rc)
> >> +               return rc;
> > Is the 'if (rc)' check needed here?  Shouldn't the switch-statement
> > after the hook catch everything that this check would catch?
>
> It's necessary because of BPF, which doesn't follow the LSM rules.

I thought if it made it this far in the function the LSM, BPF or not,
would still have gone through the switch statement above which would
have returned early if the the value was something other than one of
the accepted return codes ... right?

> >> +       if (istoobig)
> >> +               return -E2BIG;
> >> +       return count;
> >> +}
> >> +
> >> +/**
> >> + * security_setselfattr - Set an LSM attribute on the current process=
.
> >> + * @attr: which attribute to set
> >> + * @ctx: the user-space source for the information
> >> + * @size: the size of the data
> >> + * @flags: reserved for future use, must be 0
> >> + *
> >> + * Set an LSM attribute for the current process. The LSM, attribute
> >> + * and new value are included in @ctx.
> >> + *
> >> + * Returns 0 on success, an LSM specific value on failure.
> >> + */
> >> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx __u=
ser *ctx,
> >> +                        size_t __user size, u32 __user flags)
> >> +{
> >> +       struct security_hook_list *hp;
> >> +       struct lsm_ctx lctx;
> > Shouldn't we check @attr for valid values and return -EINVAL if bogus?
>
> Sure.
>
> >> +       if (flags !=3D 0)
> >> +               return -EINVAL;
> >> +       if (size < sizeof(*ctx))
> >> +               return -EINVAL;
> > If we're only going to support on 'lsm_ctx' entry in this function we
> > should verify that the 'len' and 'ctx_len' fields are sane.  Although
> > more on this below ...
>
> The LSM is going to have to do its own version of sanity checking. Having
> sanity checking here as well seems excessive.

Yes, the LSM will probably need to do some checks, but we can safely
do the length checking here so we might as well do it simply so every
LSM doesn't have to duplicate the length checks.

> >> +       if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
> >> +               return -EFAULT;
> >> +
> >> +       hlist_for_each_entry(hp, &security_hook_heads.setselfattr, lis=
t)
> >> +               if ((hp->lsmid->id) =3D=3D lctx.id)
> >> +                       return hp->hook.setselfattr(attr, ctx, size, f=
lags);
> > Can anyone think of any good reason why we shouldn't support setting
> > multiple LSMs in one call, similar to what we do with
> > security_getselfattr()?  It seems like it might be a nice thing to
> > have ...
>
> If you're setting the context for multiple LSMs ...

See my follow-up to my original reply sent earlier today.

--=20
paul-moore.com
