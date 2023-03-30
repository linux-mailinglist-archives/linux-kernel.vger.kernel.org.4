Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9706D134E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjC3X3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjC3X3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:29:08 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8F12BC8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:28:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n125so25549151ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680218915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3qDFqYlzMY39DpBJCz3fFVstIQismbY/XL88bC6N5Y=;
        b=UQmICd6EXGXvRyObWEMxhbOxki8UR0CbKRLKyHFsqP2c1B0Y6XoY7QZR5YBvOxJQom
         EJM/mU684qPiHTU0Dh4vncs0CFu0pRFlyoGMbGp8U7jyUb5NPx7EC+jlMyYPN92PksrF
         TfVDTi7CopzDgKk5yytYwqFdrm5K1RlTNgoOYjI5W/UuL1/xLgY7ZZFgDJECStcMkJWR
         QThvJCp6C4W2HouW6jucjJTXyvQUGitAdjHh0wyhxrwaoBZuUbmyQhTXHnzqcKfDNDRB
         uMQvN9rNwC5iNF4vDin/2B3k+yFK8ngzPgANNvViRIdjV7pjbf/39HA/HUC38Bg11gLz
         NxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680218915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3qDFqYlzMY39DpBJCz3fFVstIQismbY/XL88bC6N5Y=;
        b=DFtoYqUGlt9CBxAke4jCInaLqrCRjfrGTXlGTCs0hfSaL8FxkoVyPsP1Tz24ZAvWix
         gJmt0H2/t300Csr6p1xiC081CX5oR1ai9K9FXNEkO95gBCZ8+8xZYSf6f9IrL00rDgSu
         Q42ai6MBQiRG7201WixTLr2s5AwAf6x9GoGnRrOc1sYQDtq1wlxjVbILPzZ6y1GczqZA
         0RExL52VRufoVNvBLtwYJEiyP+yFJrJuiIy4U7vnxV5E2czuNVJ/ZiWQlZlM5SUptrNM
         t7GjA+XVrXTjT1NcsQiMf665mKp2H5v4uyG71XeNzPlzi2TdI6ZSxbZ/LSBUPDDC8LfE
         AC7Q==
X-Gm-Message-State: AAQBX9c7xUyQHnO+zh21KFoRU/M+4W/ggEx+P8jJT/0E3a9WOT2EQP7C
        q+UzThvm3pnsd5uvBNxB76idbEnimbHYn18kMSN0
X-Google-Smtp-Source: AKy350bAByAu2U4yJTd5j+tf5f2sReiTnrCAPantsLnhpfA88T4dH5EmL4dUb0hSt/fut5A5x2NhPCcDgvbFVyoJfrM=
X-Received: by 2002:a25:344:0:b0:b27:4632:f651 with SMTP id
 65-20020a250344000000b00b274632f651mr12362193ybd.3.1680218914733; Thu, 30 Mar
 2023 16:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-8-casey@schaufler-ca.com>
 <CAHC9VhT9j78jC66xv-pV1iPmgEK6=fHddFVaAS8Qmm_WyYMypQ@mail.gmail.com> <c79a66f4-53c0-66f5-4539-4994365aa656@schaufler-ca.com>
In-Reply-To: <c79a66f4-53c0-66f5-4539-4994365aa656@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Mar 2023 19:28:24 -0400
Message-ID: <CAHC9VhRVru1xK3SPp80cUX-jtVzpqhtieZ-RABjwJ8xi3GGm9Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an lsm_ctx
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

On Thu, Mar 30, 2023 at 4:42=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 3/29/2023 6:13 PM, Paul Moore wrote:
> > On Wed, Mar 15, 2023 at 6:50=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> Add lsm_name_to_attr(), which translates a text string to a
> >> LSM_ATTR value if one is available.
> >>
> >> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> >> the trailing attribute value.
> >>
> >> All are used in module specific components of LSM system calls.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/security.h | 13 ++++++++++
> >>  security/lsm_syscalls.c  | 51 +++++++++++++++++++++++++++++++++++++++=
+
> >>  security/security.c      | 31 ++++++++++++++++++++++++
> >>  3 files changed, 95 insertions(+)
> > ..
> >
> >> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >> index 6efbe244d304..55d849ad5d6e 100644
> >> --- a/security/lsm_syscalls.c
> >> +++ b/security/lsm_syscalls.c
> >> @@ -17,6 +17,57 @@
> >>  #include <linux/lsm_hooks.h>
> >>  #include <uapi/linux/lsm.h>
> >>
> >> +struct attr_map {
> >> +       char *name;
> >> +       u64 attr;
> >> +};
> >> +
> >> +static const struct attr_map lsm_attr_names[] =3D {
> >> +       {
> >> +               .name =3D "current",
> >> +               .attr =3D LSM_ATTR_CURRENT,
> >> +       },
> >> +       {
> >> +               .name =3D "exec",
> >> +               .attr =3D LSM_ATTR_EXEC,
> >> +       },
> >> +       {
> >> +               .name =3D "fscreate",
> >> +               .attr =3D LSM_ATTR_FSCREATE,
> >> +       },
> >> +       {
> >> +               .name =3D "keycreate",
> >> +               .attr =3D LSM_ATTR_KEYCREATE,
> >> +       },
> >> +       {
> >> +               .name =3D "prev",
> >> +               .attr =3D LSM_ATTR_PREV,
> >> +       },
> >> +       {
> >> +               .name =3D "sockcreate",
> >> +               .attr =3D LSM_ATTR_SOCKCREATE,
> >> +       },
> >> +};
> >> +
> >> +/**
> >> + * lsm_name_to_attr - map an LSM attribute name to its ID
> >> + * @name: name of the attribute
> >> + *
> >> + * Look the given @name up in the table of know attribute names.
> >> + *
> >> + * Returns the LSM attribute value associated with @name, or 0 if
> >> + * there is no mapping.
> >> + */
> >> +u64 lsm_name_to_attr(const char *name)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i =3D 0; i < ARRAY_SIZE(lsm_attr_names); i++)
> >> +               if (!strcmp(name, lsm_attr_names[i].name))
> >> +                       return lsm_attr_names[i].attr;
> > I'm pretty sure this is the only place where @lsm_attr_names is used,
> > right?  If true, when coupled with the idea that these syscalls are
> > going to close the door on new LSM attributes in procfs I think we can
> > just put the mapping directly in this function via a series of
> > if-statements.
>
> Ick. You're not wrong, but the hard coded if-statement approach goes
> against all sorts of coding principles. I'll do it, but I can't say I
> like it.

If it helps any, I understand and am sympathetic.  I guess I've gotten
to that point where in addition to "code elegance", I'm also very
concerned about defending against "code abuse", and something like an
nicely defined mapping array is ripe for someone to come along and use
that to justify further use of the attribute string names in some
other function/API.

If you want to stick with the array - I have no problem with that -
make it local to lsm_name_to_attr().

> >> +/**
> >> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> >> + * @ctx: an LSM context to be filled
> >> + * @context: the new context value
> >> + * @context_size: the size of the new context value
> >> + * @id: LSM id
> >> + * @flags: LSM defined flags
> >> + *
> >> + * Fill all of the fields in a user space lsm_ctx structure.
> >> + * Caller is assumed to have verified that @ctx has enough space
> >> + * for @context.
> >> + * Returns 0 on success, -EFAULT on a copyout error.
> >> + */
> >> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> >> +                     size_t context_size, u64 id, u64 flags)
> >> +{
> >> +       struct lsm_ctx local;
> >> +       void __user *vc =3D ctx;
> >> +
> >> +       local.id =3D id;
> >> +       local.flags =3D flags;
> >> +       local.ctx_len =3D context_size;
> >> +       local.len =3D context_size + sizeof(local);
> >> +       vc +=3D sizeof(local);
> > See my prior comments about void pointer math.
> >
> >> +       if (copy_to_user(ctx, &local, sizeof(local)))
> >> +               return -EFAULT;
> >> +       if (context_size > 0 && copy_to_user(vc, context, context_size=
))
> >> +               return -EFAULT;
> > Should we handle the padding in this function?
>
> This function fills in a lsm_ctx. The padding, if any, is in addition to
> the lsm_ctx, not part of it.

Okay, so where is the padding managed?  I may have missed it, but I
don't recall seeing it anywhere in this patchset ...

--=20
paul-moore.com
