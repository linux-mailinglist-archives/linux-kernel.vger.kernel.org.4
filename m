Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254C46D289D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCaTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCaTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:25:08 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6E20335
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:25:06 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e65so28585415ybh.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680290705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q0TJVmS3vVIPjTPjvVobtYvTK8ND6CQrQVB0vMLp6E=;
        b=U6V7FVQ5JkuPBjlkb3OSLuDGKihB1vbiyPlsAh2QUDce9HZy3vvR483wpcRTClwhM+
         Gu3cW6hEs+iNjhxyClkFCHG4IVMsxSRH9dTXGYZLYqk5ENiKaZIp9D7BLjIMTbNxrnIK
         dzJJAA5LHRWMU2V38YxwWB6OlgJwc1WsfY4oTp1VzohUXApMdYHHh+fbza1ZE6Phmnc4
         NxgGVozKXS1DTPyC5tyL5ujTY/e9fm523jPUKXOhE8peuw4XJkLuj19hY9ea9Cblj9X1
         bF5PqqIoEL4gZeUa/MgcTlImtq84aF/bXhWf1iBpXdkfG1nJbD/B+b9tlfsb1i4IH9Vp
         UhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680290705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q0TJVmS3vVIPjTPjvVobtYvTK8ND6CQrQVB0vMLp6E=;
        b=lSAsueL4BT20Ym+CrtjsxgrQTNOSWevKao7E3FpZXrs5rYyIwUodYkY01FLNuweHEZ
         90vW7B/VzW7C8uQrQ+ExeWY8McjuXFlUQa8fqD7DIMTjzWC+QXX7jCyhiZ7fpD46hjeN
         Ed7IzKE1h1GJRb3tEztLH4Tl47W3SBZAwY17PgruECVY+DmXIy0dhGRSGqDF3zET+5Z3
         /n+/7Dd1DgKvLS8jZjpXaE6PgPF/z37YM3O4Q1vdcVs3BmteBwwRu0gc3ZPFUzFXW9EO
         qifGjSOw3XL63mbwc4gFYHEtcswj5O7U6lhN8P8WYWJPy2aCZYxak0x+vXh5eNjF3rSB
         jRIw==
X-Gm-Message-State: AAQBX9fspkrlYlgVSFeJ9+gnQ7d5bkAYDzlM9CFBa4HfrSDywfiGsQ31
        G0D+PPtflwAV/coIEKCR/DWKiAFGTEGpyJ9VHxEm
X-Google-Smtp-Source: AKy350ZHHo95Ey+z27seoBDWD4vs7lHYRSx4FnDucSGiVk4h1kA3/2xaxLRvjcQ6KQNt5RlBSIKuOdUw8pwbisOtFVQ=
X-Received: by 2002:a25:db91:0:b0:b75:8ac3:d5d9 with SMTP id
 g139-20020a25db91000000b00b758ac3d5d9mr18055125ybf.3.1680290705143; Fri, 31
 Mar 2023 12:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-8-casey@schaufler-ca.com>
 <CAHC9VhT9j78jC66xv-pV1iPmgEK6=fHddFVaAS8Qmm_WyYMypQ@mail.gmail.com>
 <c79a66f4-53c0-66f5-4539-4994365aa656@schaufler-ca.com> <CAHC9VhRVru1xK3SPp80cUX-jtVzpqhtieZ-RABjwJ8xi3GGm9Q@mail.gmail.com>
 <00efa1f2-e6ae-3ce3-2bf2-03b7846568f7@schaufler-ca.com>
In-Reply-To: <00efa1f2-e6ae-3ce3-2bf2-03b7846568f7@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 Mar 2023 15:24:54 -0400
Message-ID: <CAHC9VhRPiGs72CrUT1Fhoykfzx8wp13L7XVYEYOmdwoFk=kFnw@mail.gmail.com>
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

On Fri, Mar 31, 2023 at 12:56=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 3/30/2023 4:28 PM, Paul Moore wrote:
> > On Thu, Mar 30, 2023 at 4:42=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 3/29/2023 6:13 PM, Paul Moore wrote:
> >>> On Wed, Mar 15, 2023 at 6:50=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> >>>> Add lsm_name_to_attr(), which translates a text string to a
> >>>> LSM_ATTR value if one is available.
> >>>>
> >>>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> >>>> the trailing attribute value.
> >>>>
> >>>> All are used in module specific components of LSM system calls.
> >>>>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> ---
> >>>>  include/linux/security.h | 13 ++++++++++
> >>>>  security/lsm_syscalls.c  | 51 +++++++++++++++++++++++++++++++++++++=
+++
> >>>>  security/security.c      | 31 ++++++++++++++++++++++++
> >>>>  3 files changed, 95 insertions(+)
> >>> ..
> >>>
> >>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >>>> index 6efbe244d304..55d849ad5d6e 100644
> >>>> --- a/security/lsm_syscalls.c
> >>>> +++ b/security/lsm_syscalls.c
> >>>> @@ -17,6 +17,57 @@
> >>>>  #include <linux/lsm_hooks.h>
> >>>>  #include <uapi/linux/lsm.h>
> >>>>
> >>>> +struct attr_map {
> >>>> +       char *name;
> >>>> +       u64 attr;
> >>>> +};
> >>>> +
> >>>> +static const struct attr_map lsm_attr_names[] =3D {
> >>>> +       {
> >>>> +               .name =3D "current",
> >>>> +               .attr =3D LSM_ATTR_CURRENT,
> >>>> +       },
> >>>> +       {
> >>>> +               .name =3D "exec",
> >>>> +               .attr =3D LSM_ATTR_EXEC,
> >>>> +       },
> >>>> +       {
> >>>> +               .name =3D "fscreate",
> >>>> +               .attr =3D LSM_ATTR_FSCREATE,
> >>>> +       },
> >>>> +       {
> >>>> +               .name =3D "keycreate",
> >>>> +               .attr =3D LSM_ATTR_KEYCREATE,
> >>>> +       },
> >>>> +       {
> >>>> +               .name =3D "prev",
> >>>> +               .attr =3D LSM_ATTR_PREV,
> >>>> +       },
> >>>> +       {
> >>>> +               .name =3D "sockcreate",
> >>>> +               .attr =3D LSM_ATTR_SOCKCREATE,
> >>>> +       },
> >>>> +};
> >>>> +
> >>>> +/**
> >>>> + * lsm_name_to_attr - map an LSM attribute name to its ID
> >>>> + * @name: name of the attribute
> >>>> + *
> >>>> + * Look the given @name up in the table of know attribute names.
> >>>> + *
> >>>> + * Returns the LSM attribute value associated with @name, or 0 if
> >>>> + * there is no mapping.
> >>>> + */
> >>>> +u64 lsm_name_to_attr(const char *name)
> >>>> +{
> >>>> +       int i;
> >>>> +
> >>>> +       for (i =3D 0; i < ARRAY_SIZE(lsm_attr_names); i++)
> >>>> +               if (!strcmp(name, lsm_attr_names[i].name))
> >>>> +                       return lsm_attr_names[i].attr;
> >>> I'm pretty sure this is the only place where @lsm_attr_names is used,
> >>> right?  If true, when coupled with the idea that these syscalls are
> >>> going to close the door on new LSM attributes in procfs I think we ca=
n
> >>> just put the mapping directly in this function via a series of
> >>> if-statements.
> >> Ick. You're not wrong, but the hard coded if-statement approach goes
> >> against all sorts of coding principles. I'll do it, but I can't say I
> >> like it.
> > If it helps any, I understand and am sympathetic.  I guess I've gotten
> > to that point where in addition to "code elegance", I'm also very
> > concerned about defending against "code abuse", and something like an
> > nicely defined mapping array is ripe for someone to come along and use
> > that to justify further use of the attribute string names in some
> > other function/API.
> >
> > If you want to stick with the array - I have no problem with that -
> > make it local to lsm_name_to_attr().
> >
> >>>> +/**
> >>>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> >>>> + * @ctx: an LSM context to be filled
> >>>> + * @context: the new context value
> >>>> + * @context_size: the size of the new context value
> >>>> + * @id: LSM id
> >>>> + * @flags: LSM defined flags
> >>>> + *
> >>>> + * Fill all of the fields in a user space lsm_ctx structure.
> >>>> + * Caller is assumed to have verified that @ctx has enough space
> >>>> + * for @context.
> >>>> + * Returns 0 on success, -EFAULT on a copyout error.
> >>>> + */
> >>>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> >>>> +                     size_t context_size, u64 id, u64 flags)
> >>>> +{
> >>>> +       struct lsm_ctx local;
> >>>> +       void __user *vc =3D ctx;
> >>>> +
> >>>> +       local.id =3D id;
> >>>> +       local.flags =3D flags;
> >>>> +       local.ctx_len =3D context_size;
> >>>> +       local.len =3D context_size + sizeof(local);
> >>>> +       vc +=3D sizeof(local);
> >>> See my prior comments about void pointer math.
> >>>
> >>>> +       if (copy_to_user(ctx, &local, sizeof(local)))
> >>>> +               return -EFAULT;
> >>>> +       if (context_size > 0 && copy_to_user(vc, context, context_si=
ze))
> >>>> +               return -EFAULT;
> >>> Should we handle the padding in this function?
> >> This function fills in a lsm_ctx. The padding, if any, is in addition =
to
> >> the lsm_ctx, not part of it.
> > Okay, so where is the padding managed?  I may have missed it, but I
> > don't recall seeing it anywhere in this patchset ...
>
> Padding isn't being managed. There has been talk about using padding to
> expand the API, but there is no use for it now. Or is there?

I think two separate ideas are getting conflated, likely because the
'len' field is involved in both.

THe first issue is padding at the end of the lsm_ctx struct to ensure
that the next array element is aligned.  The second issue is the
potential for extending the lsm_ctx struct on a per-LSM basis through
creative use of the 'flags' and 'len' fields; in this case additional
information could be stashed at the end of the lsm_ctx struct after
the 'ctx' field.  The latter issue (extending the lsm_ctx) isn't
something we want to jump into, but it is something the syscall/struct
API would allow, and I don't want to exclude it as a possible future
solution to a yet unknown future problem.  The former issue (padding
array elements) isn't a strict requirement as the syscall/struct API
works either way, but it seems like a good thing to do.

--=20
paul-moore.com
