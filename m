Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB766CF89A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjC3BOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjC3BOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:14:06 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F2E10F3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:14:04 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-544f7c176easo326773927b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680138843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uh3VI/HwfpxNl56FT1xl9IqF6BAOl2dSM/wtTtC3bw=;
        b=JeZYP8GHQDMbu9LrTwpy3QA9QOUq0gJbeCfe6uOonoTC81udPCflAYQesKIMRi5JIO
         fOx5Y52BIjQOE9vcXGlf6vFyu3GFhI/6SELZveaH20/uC7U96vVbK/QzDZd3sO1Ha01R
         3tq+/pysm4ev45l/P4rAMNxOyuOTzlxqSuWY/WDAEQ/xPs3CnJcCerhWyVN7eu1X5haH
         x/xohxsLoa/udipQ89vD7Zn1vEnZa1QKlCoio47Ayv7BoACrTIHUN69MWdgbaZMpuZkI
         WrFpKmdwZW4yUDqDwysXPhz9g7yqulUmyt49808lR2CRhucpxamGSD2RnNxl+CdH/Cln
         it5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680138843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uh3VI/HwfpxNl56FT1xl9IqF6BAOl2dSM/wtTtC3bw=;
        b=rS5oNJ/tVtkmgdv5KDr8iashgJds/qvxk3NTki7fNe41oP7VtOQc82qHzneEPMUaUa
         yAWaSIhLRbdtcPx7n2jUNcJUm2l6zc2RC6HnEQsfzclxRi7UsnJaTdhYu/ZT0mCehTWM
         3oZrT8203k4SZ7u/ihpgnBXBWHZbE5/9mb4w54eM+shFUPwM+0QaE58oZ2gMg+KGHciD
         LNNyzmb1unZDZgHLOCSRnV0N8ENirVTOv+/usYOdaxpyNBpXsZEdyvERGjtXcXsoeAPH
         i9bQ6/I+u9h3ozDIR4JHp4oGE53iicBlNtjy9UWcy/2ZD7Vh8QRxand5p+dk2fgYax1B
         xKWA==
X-Gm-Message-State: AAQBX9fxcgUaU83rV9mj2rn2byem3W4cZoGGaMJ+8ITXq1q2grfYg5jV
        qC7ZKd9i5R8xM1LDnsCIIMyvG0GRoIVHTqCphWBC
X-Google-Smtp-Source: AKy350Y0gWk+uePKIPIJJoNpZDeRtLoxl6/NYOTwgxDyy8zUIat6be29joBLDaG3UBQL1+iuAKia6YHoPvP7wdjta3I=
X-Received: by 2002:a81:bd4d:0:b0:541:359c:103a with SMTP id
 n13-20020a81bd4d000000b00541359c103amr10381430ywk.8.1680138843461; Wed, 29
 Mar 2023 18:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-11-casey@schaufler-ca.com>
In-Reply-To: <20230315224704.2672-11-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 21:13:52 -0400
Message-ID: <CAHC9VhTyMmyB5Yr8Zp+Xg3R=J9VLp-oChxJPcAv+fL8czVzcYg@mail.gmail.com>
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

On Wed, Mar 15, 2023 at 6:52=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 147 +++++++++++++++++++++++++++++++--------
>  1 file changed, 117 insertions(+), 30 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9403aee75981..8896edf80aa9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6348,8 +6348,7 @@ static void selinux_d_instantiate(struct dentry *de=
ntry, struct inode *inode)
>                 inode_doinit_with_dentry(inode, dentry);
>  }
>
> -static int selinux_getprocattr(struct task_struct *p,
> -                              const char *name, char **value)
> +static int do_getattr(unsigned int attr, struct task_struct *p, char **v=
alue)

Are you ready for more naming nitpicks? ;)

Let's call this 'selinux_lsm_getattr()', and the matching setter
should be 'selinux_lsm_setattr()'.

>  {
>         const struct task_security_struct *__tsec;
>         u32 sid;
> @@ -6367,20 +6366,27 @@ static int selinux_getprocattr(struct task_struct=
 *p,
>                         goto bad;
>         }
>
> -       if (!strcmp(name, "current"))
> +       switch (attr) {
> +       case LSM_ATTR_CURRENT:
>                 sid =3D __tsec->sid;
> -       else if (!strcmp(name, "prev"))
> +               break;
> +       case LSM_ATTR_PREV:
>                 sid =3D __tsec->osid;
> -       else if (!strcmp(name, "exec"))
> +               break;
> +       case LSM_ATTR_EXEC:
>                 sid =3D __tsec->exec_sid;
> -       else if (!strcmp(name, "fscreate"))
> +               break;
> +       case LSM_ATTR_FSCREATE:
>                 sid =3D __tsec->create_sid;
> -       else if (!strcmp(name, "keycreate"))
> +               break;
> +       case LSM_ATTR_KEYCREATE:
>                 sid =3D __tsec->keycreate_sid;
> -       else if (!strcmp(name, "sockcreate"))
> +               break;
> +       case LSM_ATTR_SOCKCREATE:
>                 sid =3D __tsec->sockcreate_sid;
> -       else {
> -               error =3D -EINVAL;
> +               break;
> +       default:
> +               error =3D -EOPNOTSUPP;

The error should probably be -EINVAL.

>                 goto bad;
>         }
>         rcu_read_unlock();
> @@ -6398,7 +6404,7 @@ static int selinux_getprocattr(struct task_struct *=
p,
>         return error;
>  }
>
> -static int selinux_setprocattr(const char *name, void *value, size_t siz=
e)
> +static int do_setattr(u64 attr, void *value, size_t size)
>  {
>         struct task_security_struct *tsec;
>         struct cred *new;
> @@ -6409,28 +6415,36 @@ static int selinux_setprocattr(const char *name, =
void *value, size_t size)
>         /*
>          * Basic control over ability to set these attributes at all.
>          */
> -       if (!strcmp(name, "exec"))
> +       switch (attr) {
> +       case LSM_ATTR_CURRENT:
> +               error =3D avc_has_perm(&selinux_state,
> +                                    mysid, mysid, SECCLASS_PROCESS,
> +                                    PROCESS__SETCURRENT, NULL);
> +               break;
> +       case LSM_ATTR_EXEC:
>                 error =3D avc_has_perm(&selinux_state,
>                                      mysid, mysid, SECCLASS_PROCESS,
>                                      PROCESS__SETEXEC, NULL);
> -       else if (!strcmp(name, "fscreate"))
> +               break;
> +       case LSM_ATTR_FSCREATE:
>                 error =3D avc_has_perm(&selinux_state,
>                                      mysid, mysid, SECCLASS_PROCESS,
>                                      PROCESS__SETFSCREATE, NULL);
> -       else if (!strcmp(name, "keycreate"))
> +               break;
> +       case LSM_ATTR_KEYCREATE:
>                 error =3D avc_has_perm(&selinux_state,
>                                      mysid, mysid, SECCLASS_PROCESS,
>                                      PROCESS__SETKEYCREATE, NULL);
> -       else if (!strcmp(name, "sockcreate"))
> +               break;
> +       case LSM_ATTR_SOCKCREATE:
>                 error =3D avc_has_perm(&selinux_state,
>                                      mysid, mysid, SECCLASS_PROCESS,
>                                      PROCESS__SETSOCKCREATE, NULL);
> -       else if (!strcmp(name, "current"))
> -               error =3D avc_has_perm(&selinux_state,
> -                                    mysid, mysid, SECCLASS_PROCESS,
> -                                    PROCESS__SETCURRENT, NULL);
> -       else
> -               error =3D -EINVAL;
> +               break;
> +       default:
> +               error =3D -EOPNOTSUPP;

Same as above, should be -EINVAL.

> +               break;
> +       }
>         if (error)
>                 return error;
>
> @@ -6442,13 +6456,14 @@ static int selinux_setprocattr(const char *name, =
void *value, size_t size)
>                 }
>                 error =3D security_context_to_sid(&selinux_state, value, =
size,
>                                                 &sid, GFP_KERNEL);
> -               if (error =3D=3D -EINVAL && !strcmp(name, "fscreate")) {
> +               if (error =3D=3D -EINVAL && attr =3D=3D LSM_ATTR_FSCREATE=
) {
>                         if (!has_cap_mac_admin(true)) {
>                                 struct audit_buffer *ab;
>                                 size_t audit_size;
>
> -                               /* We strip a nul only if it is at the en=
d, otherwise the
> -                                * context contains a nul and we should a=
udit that */
> +                               /* We strip a nul only if it is at the en=
d,
> +                                * otherwise the context contains a nul a=
nd
> +                                * we should audit that */

You *do* get gold stars for fixing line lengths in close proximity ;)


>                                 if (str[size - 1] =3D=3D '\0')
>                                         audit_size =3D size - 1;
>                                 else
> @@ -6459,7 +6474,8 @@ static int selinux_setprocattr(const char *name, vo=
id *value, size_t size)
>                                 if (!ab)
>                                         return error;
>                                 audit_log_format(ab, "op=3Dfscreate inval=
id_context=3D");
> -                               audit_log_n_untrustedstring(ab, value, au=
dit_size);
> +                               audit_log_n_untrustedstring(ab, value,
> +                                                           audit_size);
>                                 audit_log_end(ab);
>
>                                 return error;
> @@ -6483,11 +6499,11 @@ static int selinux_setprocattr(const char *name, =
void *value, size_t size)
>            checks and may_create for the file creation checks. The
>            operation will then fail if the context is not permitted. */
>         tsec =3D selinux_cred(new);
> -       if (!strcmp(name, "exec")) {
> +       if (attr =3D=3D LSM_ATTR_EXEC) {
>                 tsec->exec_sid =3D sid;
> -       } else if (!strcmp(name, "fscreate")) {
> +       } else if (attr =3D=3D LSM_ATTR_FSCREATE) {
>                 tsec->create_sid =3D sid;
> -       } else if (!strcmp(name, "keycreate")) {
> +       } else if (attr =3D=3D LSM_ATTR_KEYCREATE) {
>                 if (sid) {
>                         error =3D avc_has_perm(&selinux_state, mysid, sid=
,
>                                              SECCLASS_KEY, KEY__CREATE, N=
ULL);
> @@ -6495,9 +6511,9 @@ static int selinux_setprocattr(const char *name, vo=
id *value, size_t size)
>                                 goto abort_change;
>                 }
>                 tsec->keycreate_sid =3D sid;
> -       } else if (!strcmp(name, "sockcreate")) {
> +       } else if (attr =3D=3D LSM_ATTR_SOCKCREATE) {
>                 tsec->sockcreate_sid =3D sid;
> -       } else if (!strcmp(name, "current")) {
> +       } else if (attr =3D=3D LSM_ATTR_CURRENT) {
>                 error =3D -EINVAL;
>                 if (sid =3D=3D 0)
>                         goto abort_change;
> @@ -6542,6 +6558,75 @@ static int selinux_setprocattr(const char *name, v=
oid *value, size_t size)
>         return error;
>  }
>
> +static int selinux_getselfattr(unsigned int __user attr,
> +                              struct lsm_ctx __user *ctx, size_t *size,
> +                              u32 __user flags)
> +{
> +       char *value;
> +       size_t total_len;
> +       int len;
> +       int rc =3D 0;
> +
> +       len =3D do_getattr(attr, current, &value);
> +       if (len < 0)
> +               return len;
> +
> +       total_len =3D len + sizeof(*ctx);
> +
> +       if (total_len > *size)
> +               rc =3D -E2BIG;
> +       else
> +               lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> +
> +       *size =3D total_len;
> +       return rc;
> +}
> +
> +static int selinux_setselfattr(unsigned int __user attr,
> +                              struct lsm_ctx __user *ctx, size_t __user =
size,
> +                              u32 __user flags)
> +{
> +       struct lsm_ctx *lctx;
> +       void *context;
> +       int rc;
> +
> +       context =3D kmalloc(size, GFP_KERNEL);
> +       if (context =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       lctx =3D (struct lsm_ctx *)context;
> +       if (copy_from_user(context, ctx, size))
> +               rc =3D -EFAULT;
> +       else if (lctx->ctx_len > size)
> +               rc =3D -EINVAL;
> +       else
> +               rc =3D do_setattr(attr, lctx + 1, lctx->ctx_len);
> +
> +       kfree(context);
> +       if (rc > 0)
> +               return 0;
> +       return rc;
> +}
> +
> +static int selinux_getprocattr(struct task_struct *p,
> +                              const char *name, char **value)
> +{
> +       unsigned int attr =3D lsm_name_to_attr(name);
> +
> +       if (attr)
> +               return do_getattr(attr, p, value);
> +       return -EINVAL;
> +}
> +
> +static int selinux_setprocattr(const char *name, void *value, size_t siz=
e)
> +{
> +       int attr =3D lsm_name_to_attr(name);
> +
> +       if (attr)
> +               return do_setattr(attr, value, size);
> +       return -EINVAL;
> +}
> +
>  static int selinux_ismaclabel(const char *name)
>  {
>         return (strcmp(name, XATTR_SELINUX_SUFFIX) =3D=3D 0);
> @@ -7183,6 +7268,8 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
>
>         LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
>
> +       LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
> +       LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
>         LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
>         LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
>
> --
> 2.39.2

--
paul-moore.com
