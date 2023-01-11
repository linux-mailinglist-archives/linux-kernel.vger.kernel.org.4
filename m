Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC16666E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjAKXAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjAKXAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:00:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCBBC3E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:00:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id dw9so15926030pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ebfhkl4yBdhs2NPEuQ8sKu6oy3fhHQBZ7zNUPdmzi5U=;
        b=WWwN1Rz/mVHLJtVVeu33a2EjLkp3CQdgLmekjiRzSh/R37LSqXUbEnHE8KCzTuC47U
         yCvIq6wviRwJJeEXsenXvC6mmIOOZyDqGIN84RWl2iI0SsCRyRHYvr3gmacfU6dFy0B+
         xnoAkNuSwvTbAqi/a+n7CtpYDGIFrZTmLAmkBJppZpTiJL/5FNtLyNideGNg9xK2eGM+
         sg3nIzshBzzDAS4YSU5qD1vsfacW1zFvY2xVAUtJWiQwwVGeK1h5w7mP2bMOGUsoecZC
         SalaqGfE6TTc7OIjoD+IPyVkdfoSWM+6zvMzWk+PayTUHTCQAwRz9ET+IxlbZ+xarJPw
         0VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ebfhkl4yBdhs2NPEuQ8sKu6oy3fhHQBZ7zNUPdmzi5U=;
        b=1UZbYnDWEyaYcXbO67L/l9RZpWDBz22UeYhFAPqijXVfquOMG81gCBe8lH2XGsFogi
         G1sKT8QW+IqpdG0A9g03jtqKmU1o71/C1ElgEZaoQEadsBf6pAo/iG5UDVIsgjexU11B
         KRhlqJ0OKRadqgb05JrHZj7Xdz2JSiNnTss2+jC4CEF8Ud1ADfM4Ta6JdrPHJRKWqM3b
         fcbEfAfrkPii4YmF0B2O0hLanUOdYbaOxyXrlDP9YZW+9ymy2t+VgTaXJksCTKMLSK7s
         dM7gxC/k9n0+kQXnZVGUkXa6y2IKm3oOl8v5jSBsYtA5hXuedvC99tzFlaKdQUZ+gKG9
         InmQ==
X-Gm-Message-State: AFqh2koa/yjzLOxBrNMR3Ob50NwW/pw9aSdBecI3TrNWDcnH8oHn9NNF
        Gq5RRZrtWd3JAkF4yXWLBoFEbjOCUgN/wA9DZE5W
X-Google-Smtp-Source: AMrXdXt4it48Wez5pJu3mLq3VnTOiPl8RyWCMdckWz6o4zovM0aSVTVfPc695JHwFqyMFC6ileh4Ualvz69IQ6IuXh8=
X-Received: by 2002:a17:902:968a:b0:192:7a00:c790 with SMTP id
 n10-20020a170902968a00b001927a00c790mr4788788plp.12.1673478018644; Wed, 11
 Jan 2023 15:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com> <20230109213809.418135-5-tjmercier@google.com>
In-Reply-To: <20230109213809.418135-5-tjmercier@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Jan 2023 18:00:07 -0500
Message-ID: <CAHC9VhT+5oE4DZzxqCGFDoHjkP+5GcKU1R2BBW29uUu8BcgiAg@mail.gmail.com>
Subject: Re: [PATCH 4/4] security: binder: Add transfer_charge SElinux hook
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 4:38 PM T.J. Mercier <tjmercier@google.com> wrote:
>
> Any process can cause a memory charge transfer to occur to any other
> process when transmitting a file descriptor through binder. This should
> only be possible for central allocator processes, so a new SELinux
> permission is added to restrict which processes are allowed to initiate
> these charge transfers.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  drivers/android/binder.c            | 5 +++++
>  include/linux/lsm_hook_defs.h       | 2 ++
>  include/linux/lsm_hooks.h           | 6 ++++++
>  include/linux/security.h            | 2 ++
>  security/security.c                 | 6 ++++++
>  security/selinux/hooks.c            | 9 +++++++++
>  security/selinux/include/classmap.h | 2 +-
>  7 files changed, 31 insertions(+), 1 deletion(-)

Hi T.J.,

A few things come to mind when looking at this patchset, but let me
start with the big one first: you only sent 0/4 and 4/4 to the LSM and
SELinux lists, so that's all I'm seeing in my inbox to review, and
it's hard to make sense of what you want to do with just these
snippets.  This makes me cranky, and less inclined to spend the time
to give this a proper review, because there are plenty of other things
which need attention and don't require me having to hunt down missing
pieces.  Yes, I'm aware of b4/lei, and while they are great tools, my
workflow was pretty well established before they came into existence
and I still do things the good ol' fashioned way with mailing lists,
etc.

Make the patch reviewer's life easy whenever you can, it will rarely
(ever?) backfire, I promise.

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 9830848c8d25..9063db04826d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2279,6 +2279,11 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
>         if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
>                 struct dma_buf *dmabuf;
>
> +               if (security_binder_transfer_charge(proc->cred, target_proc->cred)) {
> +                       ret = -EPERM;
> +                       goto err_security;
> +               }

This is where I believe I'm missing the proper context, as this
version of binder_translate_fd() differs from what I see in Linus'
tree.  However, the version in Linus' tree does have a LSM hook,
security_binder_transfer_file(), which is passed both the credentials
you are using above and based solely on the level of indentation shown
in the chunk of code above, it seems like the existing hook might be
suitable?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3c5be76a9199..823ef14924bd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2066,6 +2066,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
>                             &ad);
>  }
>
> +static int selinux_binder_transfer_charge(const struct cred *from, const struct cred *to)
> +{
> +       return avc_has_perm(&selinux_state,
> +                           cred_sid(from), cred_sid(to),
> +                           SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
> +                           NULL);
> +}

Generally speaking SELinux doesn't really worry about resource
accounting controls so this seems a bit out of place, but perhaps the
larger question is do you see this being sufficiently distinct from
the existing binder:transfer permission?  In other words, would you
ever want to grant a domain the ability to transfer a file *without*
also granting it the ability to transfer the memory charge?  You need
to help me explain why we need an additional permission for this,
because I don't currently see the need.

>  static int selinux_ptrace_access_check(struct task_struct *child,
>                                        unsigned int mode)
>  {
> @@ -7052,6 +7060,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>         LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>         LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
>         LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
> +       LSM_HOOK_INIT(binder_transfer_charge, selinux_binder_transfer_charge),
>
>         LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
>         LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..2eef180d10d7 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
>         { "tun_socket",
>           { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>         { "binder", { "impersonate", "call", "set_context_mgr", "transfer",
> -                     NULL } },
> +                     "transfer_charge", NULL } },
>         { "cap_userns",
>           { COMMON_CAP_PERMS, NULL } },
>         { "cap2_userns",
> --
> 2.39.0.314.g84b9a713c41-goog

--
paul-moore.com
