Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3352F6CF896
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjC3BNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjC3BNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:13:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C41737
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:13:37 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id m16so1353030ybk.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680138816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD7V827LGMQPDZbYWYTAu0xqEkrvaQm+VNiFn3rB9QQ=;
        b=EBrqm2rDlSB6FuiS8DTfp+/vWKwVt9hpV0zhN0JAOunLZZhcROqVbb0JQ0AaMUKqyT
         a4lV2L7GWtZwYSMcj9RkdeqD5UAu7Tg4SCPLsl9FOsecFPLjxbms6VjuN+PIraWEkCSo
         I1NLYy1TeIH8x2jsAnxo2e6to9SXQev011GxU2WqzyHpXaTgr1vEcYBHdSNXsdawOtOS
         6q9Y6OORsj+i3XlaMcLeGh00oPW1nRuHGrOUpDhGBMn9VsBXN53AExx62294YnB4sT0k
         AjOj8DA3wwqLLLdelTif+Em6PND78Xgooyq0dCFhFK5/Ux1B3vEFUyNdvfw73s6OvXFT
         ZN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680138816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD7V827LGMQPDZbYWYTAu0xqEkrvaQm+VNiFn3rB9QQ=;
        b=f7kA67TAetFGkIdIZBpUSvnVBRhZ/6qaOzaePWbric/3pbnSORqtTIyhyUslqeg/2d
         /M7MEgofpbj9vOPsN26Tr8br8pIZtsKNJBO2ViA45miHaAxEruFZcvLkdVoypug5b0In
         v0+35xzVxNqY6RmmXTAgY3gxkjc5lF4JMSwFFVilr5OhOh6gIugikauV/ynKAVpo/0If
         MM8Eowz0/mqNxN/kpGRUdvtiqYtubEqB7iUcl2q636LXc8JHLJ3eir9TNwY9S0QkfZue
         B78aWyxr6jGfwzeFGx35Kew3/Y1I1uSe8Z5N2HtIU6w6NPc/cXx54gBFK+tHBzfPQyhr
         yIBw==
X-Gm-Message-State: AAQBX9de7rrbqbMw6Mscmu4hoQAzTWOkR3CjG34GwT+VkDluImhQuhY2
        uusETDOYzw4jO8t84HnD9blyMQAjgmUtEnNCYfM6
X-Google-Smtp-Source: AKy350aLjsjvpAwhol6hTTKWeSJXqiTRC6amNQl3l2YyGTmzC92tDsow1wYnpDLkuu/ZTZRpeh+bHilakoLHCD8u+eY=
X-Received: by 2002:a05:6902:70a:b0:b6e:361a:c86 with SMTP id
 k10-20020a056902070a00b00b6e361a0c86mr11608972ybt.3.1680138816161; Wed, 29
 Mar 2023 18:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-8-casey@schaufler-ca.com>
In-Reply-To: <20230315224704.2672-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 21:13:25 -0400
Message-ID: <CAHC9VhT9j78jC66xv-pV1iPmgEK6=fHddFVaAS8Qmm_WyYMypQ@mail.gmail.com>
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

On Wed, Mar 15, 2023 at 6:50=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
>
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
>
> All are used in module specific components of LSM system calls.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 13 ++++++++++
>  security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>  security/security.c      | 31 ++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)

...

> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 6efbe244d304..55d849ad5d6e 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,57 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>
> +struct attr_map {
> +       char *name;
> +       u64 attr;
> +};
> +
> +static const struct attr_map lsm_attr_names[] =3D {
> +       {
> +               .name =3D "current",
> +               .attr =3D LSM_ATTR_CURRENT,
> +       },
> +       {
> +               .name =3D "exec",
> +               .attr =3D LSM_ATTR_EXEC,
> +       },
> +       {
> +               .name =3D "fscreate",
> +               .attr =3D LSM_ATTR_FSCREATE,
> +       },
> +       {
> +               .name =3D "keycreate",
> +               .attr =3D LSM_ATTR_KEYCREATE,
> +       },
> +       {
> +               .name =3D "prev",
> +               .attr =3D LSM_ATTR_PREV,
> +       },
> +       {
> +               .name =3D "sockcreate",
> +               .attr =3D LSM_ATTR_SOCKCREATE,
> +       },
> +};
> +
> +/**
> + * lsm_name_to_attr - map an LSM attribute name to its ID
> + * @name: name of the attribute
> + *
> + * Look the given @name up in the table of know attribute names.
> + *
> + * Returns the LSM attribute value associated with @name, or 0 if
> + * there is no mapping.
> + */
> +u64 lsm_name_to_attr(const char *name)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(lsm_attr_names); i++)
> +               if (!strcmp(name, lsm_attr_names[i].name))
> +                       return lsm_attr_names[i].attr;

I'm pretty sure this is the only place where @lsm_attr_names is used,
right?  If true, when coupled with the idea that these syscalls are
going to close the door on new LSM attributes in procfs I think we can
just put the mapping directly in this function via a series of
if-statements.

> +       return 0;
> +}
> +
>  /**
>   * sys_lsm_set_self_attr - Set current task's security module attribute
>   * @attr: which attribute to set
> diff --git a/security/security.c b/security/security.c
> index 2c57fe28c4f7..f7b814a3940c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct super_block *=
sb)
>         return 0;
>  }
>
> +/**
> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> + * @ctx: an LSM context to be filled
> + * @context: the new context value
> + * @context_size: the size of the new context value
> + * @id: LSM id
> + * @flags: LSM defined flags
> + *
> + * Fill all of the fields in a user space lsm_ctx structure.
> + * Caller is assumed to have verified that @ctx has enough space
> + * for @context.
> + * Returns 0 on success, -EFAULT on a copyout error.
> + */
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +                     size_t context_size, u64 id, u64 flags)
> +{
> +       struct lsm_ctx local;
> +       void __user *vc =3D ctx;
> +
> +       local.id =3D id;
> +       local.flags =3D flags;
> +       local.ctx_len =3D context_size;
> +       local.len =3D context_size + sizeof(local);
> +       vc +=3D sizeof(local);

See my prior comments about void pointer math.

> +       if (copy_to_user(ctx, &local, sizeof(local)))
> +               return -EFAULT;
> +       if (context_size > 0 && copy_to_user(vc, context, context_size))
> +               return -EFAULT;

Should we handle the padding in this function?

> +       return 0;
> +}

--
paul-moore.com
