Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3B6E6E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjDRVtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjDRVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:49:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D7A255
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:49:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id b10so2613075ybk.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681854570; x=1684446570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUFioIO6+Gfivg0QlExeukIgnfxGonlAjFrGsH1q5aw=;
        b=NZMrqcLdceR57TXDLzfcql6RvWMtNj8NDqmPZbNF4rowum4AL3WAySl4/V4v5S0Kwg
         ZrOtkKAFnL/6Mr6PnZGHWUlht64IhZUMhkjm4EJv8nRq4vEaicwoDAh0FZxevYyfhYLI
         t0zIHs/Bnlf3ILnv46Y5DIr5bmpPLbU5W1d6+azJTJXFoG3u/pkB6I+O4NYMFchrth8t
         sLopW2IvL4iJU5uPMKMVDUE3Ppe57b1y7DdzGYKwbRBCL/e+DCj5mEeI8/pOhL1SC2GJ
         KlG/RLhDLRAYStkA0ugIr8mgGQQuGS2QQjYJIkd1YD/O9M3LjSD0S7wH6MRsk1p/N7B4
         kocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854570; x=1684446570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUFioIO6+Gfivg0QlExeukIgnfxGonlAjFrGsH1q5aw=;
        b=hd1E9jnSufR+x/28BDVKQwHYSsDfl8bExxngHMcRCHJRkjcudVOeKkgT1dm+b/yole
         +Ai+kAA5TTPkwsFwBCRbzdnd/o9QRBpiQgRy5iJBsQInPgdJPoFL4EvELdMmvCWUliM3
         UA6zmlWet8ZsQOQYQ+m9JEEWz3ztyJZ6FiX7W+guhiZTobkRrCyisr4zaOZi7vKM3Zsl
         Nv31KCpN0iTGPU2uYPoaDLBQa+rAcJnytRfyYVbtmIc25p0ImOTAfankSBe/AeDEUbN8
         FnEwvXpoZWutRrIE1grolMvW8pWGBv6f67/DJbu5dmK0oxLFTIrphyKflLMMpj9nj2i8
         3jGA==
X-Gm-Message-State: AAQBX9cEgfzEwegEe/81zlXS0XPyurb9ggZDYOgiW0ANHHdhgQy2ksAi
        3n3ViTgTELer9jn8VdPEcVkpm0T1uUBYIrxm6zwj
X-Google-Smtp-Source: AKy350Z/xp6HDwwoiVwo7KzIasSilB5xawwh6HMqf+lpgInlltHmQ9jMCnak/jWg4wXZV40ITtDHfSQeE33csEirkmU=
X-Received: by 2002:a25:3354:0:b0:b8f:53a2:a34f with SMTP id
 z81-20020a253354000000b00b8f53a2a34fmr10265225ybz.3.1681854570289; Tue, 18
 Apr 2023 14:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230411155921.14716-1-casey@schaufler-ca.com> <20230411155921.14716-5-casey@schaufler-ca.com>
In-Reply-To: <20230411155921.14716-5-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Apr 2023 17:49:19 -0400
Message-ID: <CAHC9VhQHxEzv9bQJQzTiSQZvGiMO86+HizRtaR=2LW=KwsDvfg@mail.gmail.com>
Subject: Re: [PATCH v8 04/11] LSM: syscalls for current process attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:01=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
>
> The attribute value is provided in a lsm_ctx structure. The structure
> identifies the size of the attribute, and the attribute value. The format
> of the attribute value is defined by the security module. A flags field
> is included for LSM specific information. It is currently unused and must
> be 0. The total size of the data, including the lsm_ctx structure and any
> padding, is maintained as well.
>
> struct lsm_ctx {
>         __u64   id;
>         __u64   flags;
>         __u64   len;
>         __u64   ctx_len;
>         __u8    ctx[];
> };
>
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/userspace-api/lsm.rst | 15 +++++
>  include/linux/lsm_hook_defs.h       |  4 ++
>  include/linux/lsm_hooks.h           |  9 +++
>  include/linux/security.h            | 19 ++++++
>  include/linux/syscalls.h            |  5 ++
>  include/uapi/linux/lsm.h            | 30 +++++++++
>  kernel/sys_ni.c                     |  4 ++
>  security/Makefile                   |  1 +
>  security/lsm_syscalls.c             | 55 ++++++++++++++++
>  security/security.c                 | 98 +++++++++++++++++++++++++++++
>  10 files changed, 240 insertions(+)
>  create mode 100644 security/lsm_syscalls.c

...

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 33a0ee3bcb2e..97487d66dca9 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -71,6 +71,7 @@ struct clone_args;
>  struct open_how;
>  struct mount_attr;
>  struct landlock_ruleset_attr;
> +struct lsm_ctx;
>  enum landlock_rule_type;
>
>  #include <linux/types.h>
> @@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flag=
s);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigne=
d long len,
>                                             unsigned long home_node,
>                                             unsigned long flags);
> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx =
*ctx,
> +                                     size_t *size, __u32 flags);
> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx =
*ctx,
> +                                     __u32 flags);

As pointed out by the kernel test robot, the above declaration is
missing the @size parameter.

> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index f27c9a9cc376..b10dfab8a4d9 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,36 @@
> #ifndef _UAPI_LINUX_LSM_H
> #define _UAPI_LINUX_LSM_H
>
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context information
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: LSM specific flags
> + * @len: length of the lsm_ctx struct, @ctx and any other data or paddin=
g
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context value
> + *
> + * The @len field MUST be equal to the size of the lsm_ctx struct
> + * plus any additional padding and/or data placed after @ctx.
> + *
> + * In all cases @ctx_len MUST be equal to the length of @ctx.
> + * If @ctx is a string value it should be nul terminated with
> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
> + * supported.
> + *
> + * The @flags and @ctx fields SHOULD only be interpreted by the
> + * LSM specified by @id; they MUST be set to zero/0 when not used.
> + */
> +struct lsm_ctx {
> +       __u64   id;
> +       __u64   flags;
> +       __u64   len;
> +       __u64   ctx_len;
> +       __u8    ctx[];
> +};

Sorry, style nitpick since this needs to be respun anyway for the
syscalls.h fix at the very least ... I *really* dislike when variable
declarations, and field declarations in the case composite variables,
are aligned with the vertically neighboring declarations; just use a
single space please:

  struct lsm_ctx {
  <tab>__u64 id;
  <tab>__u64 flags;
  <tab>__u64 len;
  <tab>__u64 ctx_len;
  <tab>__u8 ctx[];
  }

> diff --git a/security/security.c b/security/security.c
> index 38ca0e646cac..bfe9a1a426b2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2167,6 +2167,104 @@ void security_d_instantiate(struct dentry *dentry=
, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>
> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @ctx: the user-space destination for the information, or NULL
> + * @size: the size of space available to receive the data
> + * @flags: reserved for future use, must be 0
> + *
> + * Returns the number of attributes found on success, negative value
> + * on error. @size is reset to the total size of the data.
> + * If @size is insufficient to contain the data -E2BIG is returned.
> + */
> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx __user=
 *ctx,
> +                        size_t __user *size, u32 __user flags)
> +{
> +       struct security_hook_list *hp;
> +       u8 __user *base =3D (u8 __user *)ctx;
> +       size_t total =3D 0;
> +       size_t entrysize;
> +       size_t left;
> +       bool toobig =3D false;
> +       int count =3D 0;
> +       int rc;
> +
> +       if (attr =3D=3D 0)
> +               return -EINVAL;
> +       if (flags)
> +               return -EINVAL;

I like Micka=C3=ABl's idea of supporting a flag (LSM_FLG_SINGLE?) which
allows one to request a single LSM's attribute.  I don't think that
support has to be part of this initial patchset, but I do think it
would be good to have it in the same PR that goes up to Linus during
the merge window.  If that's not something you want to do, let me know
and I'll write up a quick patch on top of this patchset.

> +       if (size =3D=3D NULL)
> +               return -EINVAL;
> +       if (get_user(left, size))
> +               return -EFAULT;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) =
{
> +               entrysize =3D left;
> +               if (base)
> +                       ctx =3D (struct lsm_ctx __user *)(base + total);
> +               rc =3D hp->hook.getselfattr(attr, ctx, &entrysize, flags)=
;
> +               if (rc =3D=3D -EOPNOTSUPP) {
> +                       rc =3D 0;
> +                       continue;
> +               }
> +               if (rc =3D=3D -E2BIG) {
> +                       toobig =3D true;
> +                       left =3D 0;
> +                       break;

It just occurred to me while reading this that we stop calculating the
potential lsm_ctx size after we hit the first LSM where we go beyond
the size given, `rc =3D=3D -E2BIG`.  I realize that the required size may
change between calls to lsm_get_self_attr(2), but it seems like we
should at least run through all the LSMs and total up the required
buffer size, no?

I may have missed something in the snippet below, but I think the code
change should be pretty minor:

  if (rc =3D=3D -EOPNOTSUPP) {
    rc =3D 0;
    continue;
  } else if (rc =3D=3D -E2BIG) {
    toobig =3D true;
    base =3D NULL;
  } else if (rc < 0) {
    return rc;
  }
  left =3D (toobig ? 0 : left - entrysize);
  total +=3D entrysize;

  count +=3D rc;

> +               }
> +               if (rc < 0)
> +                       return rc;
> +
> +               left -=3D entrysize;
> +               total +=3D entrysize;
> +               count +=3D rc;
> +       }
> +       if (count =3D=3D 0)
> +               return LSM_RET_DEFAULT(getselfattr);
> +       if (put_user(total, size))
> +               return -EFAULT;
> +       if (toobig)
> +               return -E2BIG;
> +       return count;
> +}

--
paul-moore.com
