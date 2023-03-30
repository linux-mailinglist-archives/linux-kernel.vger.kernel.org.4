Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787D66CF890
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjC3BMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjC3BMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:12:40 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ABE59CC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:12:31 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j7so21711122ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680138751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEMjdptj1aeYOde4KKpmaWFlPVWLys6rNoXIXrgK1Vo=;
        b=ThfHDKDfyVueGGEn4cbK/4w8lhx05FTYZjAfqMflR0ryJM7zLRC3n+76Td4HEyeicc
         QPgguP006r2Q2bW7bJV64T+Fm3sE46L3+9LSUQWrDdsg2O3ds4NSuSt2lsUcr3K76Ovl
         /t1QRlcAcSmh+nscqyGFzgy1vFqBZzbuNbjsONPdeOtpf2l8+xf1Bk/PVgHsN0BMVdaf
         ml/oo41bSq1xfY8TDvA3KKjVBsSZNARwsY4fs07vsDMou7fGE5T1VviDGRj3iSi7ufUk
         5g45mlVcFpiG595nIUC/gyGTn7cLSxBeyzzBDbpvdMewHoeh8l2cR5SY6L8vOt6t9cp0
         /n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680138751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEMjdptj1aeYOde4KKpmaWFlPVWLys6rNoXIXrgK1Vo=;
        b=iJN5k9e9UN9WNptxnLh6Xro5GFWIpB+7Jtzlqg0KWFHRR0e0CNHm9t4sgOQWrCMZQh
         K7Lx9LwpLm0fXdx9SgYkcOHSoNDSwUHQvCs4A6DmV93HNhvIYs11f9LSYgIl4l4qNfvq
         u4F8dDP5s7cVVEk1nii+BKD4OLgqUhbPqyyDjvUnaVPZp0UGed0NMN86iNtWeLB+jak8
         3zjpjU6tzAjCGh5LMrkkN0nfJX9/WrXJ1RkHAvrHjrdhi+uZTekA231P3CyruhVDnx+k
         ZNv0ITYqPMVtvB/MHAiowYGFcFygc0XgR9TM43Q+cdWmdc3z5pmJTWxeIhGDA+x7FqdA
         Rn3w==
X-Gm-Message-State: AAQBX9edC6Vkdtm+rFt32Lxn2kVkBlSQxBZafwCAvqQFmtSMcXDLvceQ
        pAfQCeHw2cPTOfyKMFskr5NtLKRwTULVrtz05b3p
X-Google-Smtp-Source: AKy350bsyWvDI5AJUfxoyRQkgdeX5/Dug62tF1cIFnbl3hMROufwJMveEwYTfk98oFri0qqvKdbQAUZPoXKpFNDxCjc=
X-Received: by 2002:a05:6902:18c2:b0:b78:5662:d5bb with SMTP id
 ck2-20020a05690218c200b00b785662d5bbmr10475761ybb.3.1680138750879; Wed, 29
 Mar 2023 18:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-5-casey@schaufler-ca.com>
In-Reply-To: <20230315224704.2672-5-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 21:12:19 -0400
Message-ID: <CAHC9VhRuKqaYD=WCzuuk4=+qFSvCjCEMEsPjAh9pQe-=LyMthA@mail.gmail.com>
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

On Wed, Mar 15, 2023 at 6:48=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
>
> The attribute value is provided in a lsm_ctx structure. The structure
> identifys the size of the attribute, and the attribute value. The format

"identifies"

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
>  include/uapi/linux/lsm.h            | 33 ++++++++++
>  kernel/sys_ni.c                     |  4 ++
>  security/Makefile                   |  1 +
>  security/lsm_syscalls.c             | 55 ++++++++++++++++
>  security/security.c                 | 97 +++++++++++++++++++++++++++++
>  10 files changed, 242 insertions(+)
>  create mode 100644 security/lsm_syscalls.c

...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 32285ce65419..3c2c4916bd53 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -503,6 +504,14 @@
>   *     and writing the xattrs as this hook is merely a filter.
>   * @d_instantiate:
>   *     Fill in @inode security information for a @dentry if allowed.
> + * @getselfattr:
> + *     Read attribute @attr for the current process and store it into @c=
tx.
> + *     Return 0 on success, -EOPNOTSUPP if the attribute is not supporte=
d,
> + *     or another negative value otherwise.
> + * @setselfattr:
> + *     Set attribute @attr for the current process.
> + *     Return 0 on success, -EOPNOTSUPP if the attribute is not supporte=
d,
> + *     or another negative value otherwise.
>   * @getprocattr:
>   *     Read attribute @name for process @p and store it into @value if a=
llowed.
>   *     Return the length of @value on success, a negative value otherwis=
e.

I'm sure you're already aware of this, but the above will need to be
moved to security.c due to the changes in the lsm/next branch.  That
said, if you're basing on Linus' tree that's fine too, I'll fix it up
during the merge; thankfully it's not a significant merge conflict.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 8faed81fc3b4..329cd9d2be50 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1343,6 +1348,20 @@ static inline void security_d_instantiate(struct d=
entry *dentry,
>                                           struct inode *inode)
>  { }
>
> +static inline int security_getselfattr(unsigned int __user attr,
> +                                      struct lsm_ctx __user *ctx,
> +                                      size_t __user *size, u32 __user fl=
ags)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int security_setselfattr(unsigned int __user attr,
> +                                      struct lsm_ctx __user *ctx,
> +                                      size_t __user size, u32 __user fla=
gs)
> +{
> +       return -EINVAL;
> +}

It seems like EOPNOTSUPP might be more appropriate than EINVAL for
both of these dummy implementations.

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 33a0ee3bcb2e..3feca00cb0c1 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flag=
s);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigne=
d long len,
>                                             unsigned long home_node,
>                                             unsigned long flags);
> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx =
*ctx,
> +                                     size_t *size, __u64 flags);
> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx =
*ctx,
> +                                     __u64 flags);

As the kernel test robot already pointed out, the above needs to be updated=
.

>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index aa3e01867739..adfb55dce2fd 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,39 @@
>  #ifndef _UAPI_LINUX_LSM_H
>  #define _UAPI_LINUX_LSM_H
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
> +
> +#include <linux/types.h>
> +#include <linux/unistd.h>

I'm pretty sure the repeated #includes are a typo, right?  Or is there
some uapi trick I'm missing ...

> diff --git a/security/security.c b/security/security.c
> index 87c8796c3c46..2c57fe28c4f7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2168,6 +2168,103 @@ void security_d_instantiate(struct dentry *dentry=
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
> +       void __user *base =3D (void *)ctx;

The casting seems wrong for a couple of reasons: I don't believe you
need to cast the right side when the left side is a void pointer, and
the right side cast drops the '__user' attribute when the left side is
also a '__user' pointer value.

That said, I think we may want @base to be 'u8 __user *base', more on
that below ...

> +       size_t total =3D 0;
> +       size_t this;

Naming is hard, but 'this'?  You can do better ...

> +       size_t left;
> +       bool istoobig =3D false;

Sorry, more naming nits and since it looks like you need to respin
anyway ... please rename @istoobig to @toobig or something else.  The
phrases-as-variable-names has always grated on me.

> +       int count =3D 0;
> +       int rc;
> +
> +       if (attr =3D=3D 0)
> +               return -EINVAL;
> +       if (flags !=3D 0)
> +               return -EINVAL;
> +       if (size =3D=3D NULL)
> +               return -EINVAL;
> +       if (get_user(left, size))
> +               return -EFAULT;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) =
{
> +               this =3D left;
> +               if (base)
> +                       ctx =3D (struct lsm_ctx __user *)(base + total);

Pointer math on void pointers always makes me nervous.  Why not set
@base's type to a 'u8' just to remove any concerns?

> +               rc =3D hp->hook.getselfattr(attr, ctx, &this, flags);
> +               switch (rc) {
> +               case -EOPNOTSUPP:
> +                       rc =3D 0;
> +                       continue;
> +               case -E2BIG:
> +                       istoobig =3D true;
> +                       left =3D 0;
> +                       break;
> +               case 0:
> +                       left -=3D this;
> +                       break;
> +               default:
> +                       return rc;

I think the @getselfattr hook should behave similarly to the
associated syscall, returning a non-negative number should indicate
that @rc entries have been added to the @ctx array.  Right now all the
LSMs would just be adding one entry to the array, but we might as well
code this up to be flexible.

> +               }
> +               total +=3D this;
> +               count++;
> +       }
> +       if (count =3D=3D 0)
> +               return LSM_RET_DEFAULT(getselfattr);
> +       if (put_user(total, size))
> +               return -EFAULT;
> +       if (rc)
> +               return rc;

Is the 'if (rc)' check needed here?  Shouldn't the switch-statement
after the hook catch everything that this check would catch?

> +       if (istoobig)
> +               return -E2BIG;
> +       return count;
> +}
> +
> +/**
> + * security_setselfattr - Set an LSM attribute on the current process.
> + * @attr: which attribute to set
> + * @ctx: the user-space source for the information
> + * @size: the size of the data
> + * @flags: reserved for future use, must be 0
> + *
> + * Set an LSM attribute for the current process. The LSM, attribute
> + * and new value are included in @ctx.
> + *
> + * Returns 0 on success, an LSM specific value on failure.
> + */
> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user=
 *ctx,
> +                        size_t __user size, u32 __user flags)
> +{
> +       struct security_hook_list *hp;
> +       struct lsm_ctx lctx;

Shouldn't we check @attr for valid values and return -EINVAL if bogus?

> +       if (flags !=3D 0)
> +               return -EINVAL;
> +       if (size < sizeof(*ctx))
> +               return -EINVAL;

If we're only going to support on 'lsm_ctx' entry in this function we
should verify that the 'len' and 'ctx_len' fields are sane.  Although
more on this below ...

> +       if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
> +               return -EFAULT;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +               if ((hp->lsmid->id) =3D=3D lctx.id)
> +                       return hp->hook.setselfattr(attr, ctx, size, flag=
s);

Can anyone think of any good reason why we shouldn't support setting
multiple LSMs in one call, similar to what we do with
security_getselfattr()?  It seems like it might be a nice thing to
have ...

> +       return LSM_RET_DEFAULT(setselfattr);
> +}
> +
>  int security_getprocattr(struct task_struct *p, int lsmid, const char *n=
ame,
>                          char **value)
>  {
> --
> 2.39.2

--
paul-moore.com
