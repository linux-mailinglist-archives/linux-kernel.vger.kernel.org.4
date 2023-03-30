Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2656D1356
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 01:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjC3XdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 19:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjC3XdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:33:08 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22023901C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:33:06 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-544787916d9so383964847b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680219185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94cHCZl82A9XHBdyuyycOrzigntjL6kSnbJJ+8pRS1I=;
        b=NE11GM+BTf/CpwCQcIfcVI9o0qRstmxulk194Pff9YhZcy0tnuk7ZQvpOVMGLkupU2
         RFsUMuoXtd15daP5ryZm8upTsP+BgSm3SdNW3GO5bmIYndnRlOtfJwfiJX5r/Nvw6UOx
         t/c7Ip4kHZaF1gb8r3FTaKaLhF4k/pZUJF73ZlyM9JTyt4rStTshwwU/WZunumRIsA4B
         YBv7bnMdd7tlF0/oNG5YhZ2lvfVG/AHpgeot/r5b9t2fXlyCIXtAyezvdQoLFSUxGjeF
         PpnvYfbq77h+u4OvzfjEKg/mzVpZufuR9ygDifBygXiG0Gdzm3MQ/7D6QJanR2HNW2Eg
         Ou+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680219185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94cHCZl82A9XHBdyuyycOrzigntjL6kSnbJJ+8pRS1I=;
        b=0Dya9DuHoGMh0HI0rpfK/308H2H4sfAAA74K7cs+0xzoB5B5HsstmuXKrUlL54FOYf
         XnBwMh6qIVHo32rD/e4DqJmYFN8+Z+06NWXuCCUD6RCT0F95pw33I0HsLkY9afpS5B4Q
         ewLohkUoBYq450pb5A1wbIRifwEQrVSIEll5PXU6b8+GXgiLFsZ9tHboLavZcuErJjCk
         nzqIjMBcjtwy71vsDcU1CeSJ/7U+No/aazxvj+hEnpIPMlC8ihEo/ZyTiFSSOUjI0Eqh
         rvyPTFEFWh8h6EMN4Ls0AlPt6XHspAxGi3h/RTwQUIaStXLDNdCWIZ3mo2+aNOatc37Q
         VPZg==
X-Gm-Message-State: AAQBX9flmCHT2WvdjvzPsA3aCRxjSrgqQNCmzFAf+F6Ui0DVFpT21u9k
        4Y1H6tc1arsatj58PhHNd67r4GW9lVDGqV9elTvD
X-Google-Smtp-Source: AKy350b1RGVoSJMOnOcg7Dlzg2s61atlBq/+cwye4xYhjekc2h3Kv8aLYSQgc4ZC5+nT125pSGhat9ufNhuNmhCveTg=
X-Received: by 2002:a81:e405:0:b0:544:d5ce:eb33 with SMTP id
 r5-20020a81e405000000b00544d5ceeb33mr11851343ywl.8.1680219185107; Thu, 30 Mar
 2023 16:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-11-casey@schaufler-ca.com>
 <CAHC9VhTyMmyB5Yr8Zp+Xg3R=J9VLp-oChxJPcAv+fL8czVzcYg@mail.gmail.com> <61d21f68-8e84-ad85-ef20-fced8c8b916d@schaufler-ca.com>
In-Reply-To: <61d21f68-8e84-ad85-ef20-fced8c8b916d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Mar 2023 19:32:54 -0400
Message-ID: <CAHC9VhS+rh-pRshAQcJPGYBx98=NW17XPKSAM8d7ahPBTv3_2A@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] SELinux: Add selfattr hooks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, selinux@vger.kernel.org
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

On Thu, Mar 30, 2023 at 4:55=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 3/29/2023 6:13 PM, Paul Moore wrote:
> > On Wed, Mar 15, 2023 at 6:52=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> Add hooks for setselfattr and getselfattr. These hooks are not very
> >> different from their setprocattr and getprocattr equivalents, and
> >> much of the code is shared.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Cc: selinux@vger.kernel.org
> >> Cc: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  security/selinux/hooks.c | 147 +++++++++++++++++++++++++++++++-------=
-
> >>  1 file changed, 117 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 9403aee75981..8896edf80aa9 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -6348,8 +6348,7 @@ static void selinux_d_instantiate(struct dentry =
*dentry, struct inode *inode)
> >>                 inode_doinit_with_dentry(inode, dentry);
> >>  }
> >>
> >> -static int selinux_getprocattr(struct task_struct *p,
> >> -                              const char *name, char **value)
> >> +static int do_getattr(unsigned int attr, struct task_struct *p, char =
**value)
> > Are you ready for more naming nitpicks? ;)
>
> I would expect nothing less. :)
>
> > Let's call this 'selinux_lsm_getattr()', and the matching setter
> > should be 'selinux_lsm_setattr()'.
>
> As you wish. It's your LSM.
>
>
> >>  {
> >>         const struct task_security_struct *__tsec;
> >>         u32 sid;
> >> @@ -6367,20 +6366,27 @@ static int selinux_getprocattr(struct task_str=
uct *p,
> >>                         goto bad;
> >>         }
> >>
> >> -       if (!strcmp(name, "current"))
> >> +       switch (attr) {
> >> +       case LSM_ATTR_CURRENT:
> >>                 sid =3D __tsec->sid;
> >> -       else if (!strcmp(name, "prev"))
> >> +               break;
> >> +       case LSM_ATTR_PREV:
> >>                 sid =3D __tsec->osid;
> >> -       else if (!strcmp(name, "exec"))
> >> +               break;
> >> +       case LSM_ATTR_EXEC:
> >>                 sid =3D __tsec->exec_sid;
> >> -       else if (!strcmp(name, "fscreate"))
> >> +               break;
> >> +       case LSM_ATTR_FSCREATE:
> >>                 sid =3D __tsec->create_sid;
> >> -       else if (!strcmp(name, "keycreate"))
> >> +               break;
> >> +       case LSM_ATTR_KEYCREATE:
> >>                 sid =3D __tsec->keycreate_sid;
> >> -       else if (!strcmp(name, "sockcreate"))
> >> +               break;
> >> +       case LSM_ATTR_SOCKCREATE:
> >>                 sid =3D __tsec->sockcreate_sid;
> >> -       else {
> >> -               error =3D -EINVAL;
> >> +               break;
> >> +       default:
> >> +               error =3D -EOPNOTSUPP;
> > The error should probably be -EINVAL.
>
> It's possible that we may add an attribute that SELinux doesn't
> support, say LSM_ATTR_CRYPTO_KEY, that another LSM does. This is
> the same behavior the other LSMs exhibit in the face of a request
> for attributes such as LSM_ATTR_KEYCREATE that they don't support.

Okay, I'll accept that argument, but I would ask that add some
additional handling in selinux_getprocattr() so that it returns
-EINVAL in this case just as it does today.

> >>                 goto bad;
> >>         }
> >>         rcu_read_unlock();
> >> @@ -6398,7 +6404,7 @@ static int selinux_getprocattr(struct task_struc=
t *p,
> >>         return error;
> >>  }
> >>
> >> -static int selinux_setprocattr(const char *name, void *value, size_t =
size)
> >> +static int do_setattr(u64 attr, void *value, size_t size)
> >>  {
> >>         struct task_security_struct *tsec;
> >>         struct cred *new;
> >> @@ -6409,28 +6415,36 @@ static int selinux_setprocattr(const char *nam=
e, void *value, size_t size)
> >>         /*
> >>          * Basic control over ability to set these attributes at all.
> >>          */
> >> -       if (!strcmp(name, "exec"))
> >> +       switch (attr) {
> >> +       case LSM_ATTR_CURRENT:
> >> +               error =3D avc_has_perm(&selinux_state,
> >> +                                    mysid, mysid, SECCLASS_PROCESS,
> >> +                                    PROCESS__SETCURRENT, NULL);
> >> +               break;
> >> +       case LSM_ATTR_EXEC:
> >>                 error =3D avc_has_perm(&selinux_state,
> >>                                      mysid, mysid, SECCLASS_PROCESS,
> >>                                      PROCESS__SETEXEC, NULL);
> >> -       else if (!strcmp(name, "fscreate"))
> >> +               break;
> >> +       case LSM_ATTR_FSCREATE:
> >>                 error =3D avc_has_perm(&selinux_state,
> >>                                      mysid, mysid, SECCLASS_PROCESS,
> >>                                      PROCESS__SETFSCREATE, NULL);
> >> -       else if (!strcmp(name, "keycreate"))
> >> +               break;
> >> +       case LSM_ATTR_KEYCREATE:
> >>                 error =3D avc_has_perm(&selinux_state,
> >>                                      mysid, mysid, SECCLASS_PROCESS,
> >>                                      PROCESS__SETKEYCREATE, NULL);
> >> -       else if (!strcmp(name, "sockcreate"))
> >> +               break;
> >> +       case LSM_ATTR_SOCKCREATE:
> >>                 error =3D avc_has_perm(&selinux_state,
> >>                                      mysid, mysid, SECCLASS_PROCESS,
> >>                                      PROCESS__SETSOCKCREATE, NULL);
> >> -       else if (!strcmp(name, "current"))
> >> -               error =3D avc_has_perm(&selinux_state,
> >> -                                    mysid, mysid, SECCLASS_PROCESS,
> >> -                                    PROCESS__SETCURRENT, NULL);
> >> -       else
> >> -               error =3D -EINVAL;
> >> +               break;
> >> +       default:
> >> +               error =3D -EOPNOTSUPP;
> > Same as above, should be -EINVAL.
>
> Same as above, there may be attributes SELinux doesn't support.

Also, same as above.

> >> +               break;
> >> +       }
> >>         if (error)
> >>                 return error;
> >>
> >> @@ -6442,13 +6456,14 @@ static int selinux_setprocattr(const char *nam=
e, void *value, size_t size)
> >>                 }
> >>                 error =3D security_context_to_sid(&selinux_state, valu=
e, size,
> >>                                                 &sid, GFP_KERNEL);
> >> -               if (error =3D=3D -EINVAL && !strcmp(name, "fscreate"))=
 {
> >> +               if (error =3D=3D -EINVAL && attr =3D=3D LSM_ATTR_FSCRE=
ATE) {
> >>                         if (!has_cap_mac_admin(true)) {
> >>                                 struct audit_buffer *ab;
> >>                                 size_t audit_size;
> >>
> >> -                               /* We strip a nul only if it is at the=
 end, otherwise the
> >> -                                * context contains a nul and we shoul=
d audit that */
> >> +                               /* We strip a nul only if it is at the=
 end,
> >> +                                * otherwise the context contains a nu=
l and
> >> +                                * we should audit that */
> > You *do* get gold stars for fixing line lengths in close proximity ;)
>
> I guess I'm the Last User of the 80 character terminal.

I'm still a big fan and I'm sticking to the 80 char limit for the LSM
layer as well as the SELinux, audit, and labeled networking
subsystems.  Longer lines either predate me or I simply didn't catch
them during review/merge.

--=20
paul-moore.com
