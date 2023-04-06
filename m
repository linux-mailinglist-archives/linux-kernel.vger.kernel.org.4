Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56856D8E06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjDFDmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDFDmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524737AA5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC3D06280A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C377C433D2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680752538;
        bh=tkcbyvy42ckFynftzNW3TBH4ij1zYS+W0ij1NQb65kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MJI/TUijxqdRHnAasYInmIJwbywTVov6aZ7BAqDvW9jgg+weGkPCYuc53lplWJZ55
         sgeFvdaxxiZdyALcjhQLEyob4JCm4HDcgTxhCo7xkB5aG7+8BwbJ8AGNclu7/AyyI/
         EROikHW1RfMwKFUgBC5ymIscEXB/La2USgVxcdDQLfhxp20PH5Y3VB9haZPu6DOpUi
         WcWuAoGBAosPNCRCQPQhT7KSPgWqTsBZJt5s5DCoK0OKFMs87NwEBoo87sP4JUruL1
         PT8NEyhVteXJJ97wUrDi6ej0mUP9Kh2GHHqQ/eEZAteAIE1jj2BiXsr8ZXLXoF5Nss
         s67dASTTDL1Mg==
Received: by mail-ed1-f53.google.com with SMTP id ew6so145992147edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 20:42:18 -0700 (PDT)
X-Gm-Message-State: AAQBX9cZ7jdKY+l2Q+mS36o+phTMn0dpaV0JlnfWvJmFPnuxrCa1lcnN
        Fe7L8HTFKkRdQUMv2EDPmOp7BBVSmQWXSrcoRK0MZg==
X-Google-Smtp-Source: AKy350YKfqJtc4qwBUnO9M24WRdeQRKdo/8evv79d/oFImW/S4DeLnOhk16mmil3PL/bNsYNp2WXWwWSZBcqWtkJjyg=
X-Received: by 2002:a17:906:6a8c:b0:926:5020:1421 with SMTP id
 p12-20020a1709066a8c00b0092650201421mr2645654ejr.9.1680752536333; Wed, 05 Apr
 2023 20:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230308073201.3102738-5-avagin@google.com>
In-Reply-To: <20230308073201.3102738-5-avagin@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Apr 2023 20:42:04 -0700
X-Gmail-Original-Message-ID: <CALCETrUB_rCCBa9TPt+7x0MBfKP9L5e8JXva-rDzE3B-AGEzNA@mail.gmail.com>
Message-ID: <CALCETrUB_rCCBa9TPt+7x0MBfKP9L5e8JXva-rDzE3B-AGEzNA@mail.gmail.com>
Subject: Re: [PATCH 4/6] seccomp: add the synchronous mode for seccomp_unotify
To:     Andrei Vagin <avagin@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, avagin@gmail.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 11:32=E2=80=AFPM Andrei Vagin <avagin@google.com> wr=
ote:
>
> seccomp_unotify allows more privileged processes do actions on behalf
> of less privileged processes.
>
> In many cases, the workflow is fully synchronous. It means a target
> process triggers a system call and passes controls to a supervisor
> process that handles the system call and returns controls to the target
> process. In this context, "synchronous" means that only one process is
> running and another one is waiting.
>
> There is the WF_CURRENT_CPU flag that is used to advise the scheduler to
> move the wakee to the current CPU. For such synchronous workflows, it
> makes context switches a few times faster.
>
> Right now, each interaction takes 12=C2=B5s. With this patch, it takes ab=
out
> 3=C2=B5s.

This is great, but:

>
> This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
> it used to enable the sync mode.

Other than being faster, what does this flag actually do in terms of
user-visible semantics?

>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  include/uapi/linux/seccomp.h |  4 ++++
>  kernel/seccomp.c             | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 0fdc6ef02b94..dbfc9b37fcae 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -115,6 +115,8 @@ struct seccomp_notif_resp {
>         __u32 flags;
>  };
>
> +#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
> +
>  /* valid flags for seccomp_notif_addfd */
>  #define SECCOMP_ADDFD_FLAG_SETFD       (1UL << 0) /* Specify remote fd *=
/
>  #define SECCOMP_ADDFD_FLAG_SEND                (1UL << 1) /* Addfd and r=
eturn it, atomically */
> @@ -150,4 +152,6 @@ struct seccomp_notif_addfd {
>  #define SECCOMP_IOCTL_NOTIF_ADDFD      SECCOMP_IOW(3, \
>                                                 struct seccomp_notif_addf=
d)
>
> +#define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
> +
>  #endif /* _UAPI_LINUX_SECCOMP_H */
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 9fca9345111c..d323edeae7da 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -143,9 +143,12 @@ struct seccomp_kaddfd {
>   *           filter->notify_lock.
>   * @next_id: The id of the next request.
>   * @notifications: A list of struct seccomp_knotif elements.
> + * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
>   */
> +
>  struct notification {
>         atomic_t requests;
> +       u32 flags;
>         u64 next_id;
>         struct list_head notifications;
>  };
> @@ -1117,7 +1120,10 @@ static int seccomp_do_user_notification(int this_s=
yscall,
>         INIT_LIST_HEAD(&n.addfd);
>
>         atomic_inc(&match->notif->requests);
> -       wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> +       if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> +               wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLR=
DNORM);
> +       else
> +               wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
>
>         /*
>          * This is where we wait for a reply from userspace.
> @@ -1593,7 +1599,10 @@ static long seccomp_notify_send(struct seccomp_fil=
ter *filter,
>         knotif->error =3D resp.error;
>         knotif->val =3D resp.val;
>         knotif->flags =3D resp.flags;
> -       complete(&knotif->ready);
> +       if (filter->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> +               complete_on_current_cpu(&knotif->ready);
> +       else
> +               complete(&knotif->ready);
>  out:
>         mutex_unlock(&filter->notify_lock);
>         return ret;
> @@ -1623,6 +1632,22 @@ static long seccomp_notify_id_valid(struct seccomp=
_filter *filter,
>         return ret;
>  }
>
> +static long seccomp_notify_set_flags(struct seccomp_filter *filter,
> +                                   unsigned long flags)
> +{
> +       long ret;
> +
> +       if (flags & ~SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
> +               return -EINVAL;
> +
> +       ret =3D mutex_lock_interruptible(&filter->notify_lock);
> +       if (ret < 0)
> +               return ret;
> +       filter->notif->flags =3D flags;
> +       mutex_unlock(&filter->notify_lock);
> +       return 0;
> +}
> +
>  static long seccomp_notify_addfd(struct seccomp_filter *filter,
>                                  struct seccomp_notif_addfd __user *uaddf=
d,
>                                  unsigned int size)
> @@ -1752,6 +1777,8 @@ static long seccomp_notify_ioctl(struct file *file,=
 unsigned int cmd,
>         case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
>         case SECCOMP_IOCTL_NOTIF_ID_VALID:
>                 return seccomp_notify_id_valid(filter, buf);
> +       case SECCOMP_IOCTL_NOTIF_SET_FLAGS:
> +               return seccomp_notify_set_flags(filter, arg);
>         }
>
>         /* Extensible Argument ioctls */
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
