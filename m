Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045505F0C81
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiI3Nfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiI3Nfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:35:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D76DDDB9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:35:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sb3so9048663ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xbwwQvs7Es/IfuPNgu1HYISV33EntoJpWTb2Zge+oZY=;
        b=jOEDagm+mlFgmI0C1n7cL+Iht2bShDqc+74swBCEO2E+2M8Qpxd4cSNGUO7xYP3Bz/
         notzR5PxoOGhITIdL61d6rTzKckTSlr4IjIsuJVT/Oj9gZ1VRUZLFdEMab2VeVqLAqqz
         HUyh+9zYyXepQ89bwASgxzpAxQxvYTRoyeFwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xbwwQvs7Es/IfuPNgu1HYISV33EntoJpWTb2Zge+oZY=;
        b=l2FIf+IOwszGo7hBlp0Au/qZxcfjKsp9m/Mp0R60dHkkP3WVZH8dewzO9VZBRCBLre
         bs7nlTUaJghywk8zPhzJulOtNMXraCGfY/OF7EShKG9f/UZrz0Z6oigdIHag+9arHisg
         mw/9NAyN2Y1WWE0XbDyF+5slVAoOcyiMdpD/azejQOznjFmLPQGsDZnQuvkwtIWxVErh
         q5Gye1QJ5/M7oaWkKJlTR/FVSGHZatxbQyTQut5B0OBnEzFfbCcHc7UM+ptIZOzrFAIN
         YW3Br6CtUPcHpgZk47YNtIkv+BQ9pKlVLo3AURAPa8h1Nvsoe1lSEuwUfNW+w59BBZdG
         bl8A==
X-Gm-Message-State: ACrzQf00NKVUL0MSrvCNiExnN6sMzEL1yTBujzwz2NR14vXYJvh+WCi1
        2dgDR9mIPKJKQYZwjaihGixixUHTDsXFgB+OrCd3pjzygYs=
X-Google-Smtp-Source: AMsMyM6ihHh911v8t8zCLI0X+d9i/kVgwQECYF3OBl0pnl6QU9bR7sn2CHcgZpvcp9nEKe3NT1OoDOIP02/UJiR8Lhc=
X-Received: by 2002:a17:907:a0c6:b0:787:8250:f90e with SMTP id
 hw6-20020a170907a0c600b007878250f90emr6567114ejc.8.1664544928084; Fri, 30 Sep
 2022 06:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
 <20220929163944.195913-1-tycho@tycho.pizza>
In-Reply-To: <20220929163944.195913-1-tycho@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 15:35:16 +0200
Message-ID: <CAJfpegtcHW8AwjfjDSm8Y7OXbesrw=ZpX-CMujJ=1Zz_Ly2FdQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: In fuse_flush only wait if someone wants the
 return code
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 18:40, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> If a fuse filesystem is mounted inside a container, there is a problem
> during pid namespace destruction. The scenario is:
>
> 1. task (a thread in the fuse server, with a fuse file open) starts
>    exiting, does exit_signals(), goes into fuse_flush() -> wait

Can't the same happen through

  fuse_flush -> fuse_sync_writes -> fuse_set_nowrite -> wait

?


> 2. fuse daemon gets killed, tries to wake everyone up
> 3. task from 1 is stuck because complete_signal() doesn't wake it up, since
>    it has PF_EXITING.
>
> The result is that the thread will never be woken up, and pid namespace
> destruction will block indefinitely.
>
> To add insult to injury, nobody is waiting for these return codes, since
> the pid namespace is being destroyed.
>
> To fix this, let's not block on flush operations when the current task has
> PF_EXITING.
>
> This does change the semantics slightly: the wait here is for posix locks
> to be unlocked, so the task will exit before things are unlocked. To quote
> Miklos: https://lore.kernel.org/all/CAJfpegsTmiO-sKaBLgoVT4WxDXBkRES=HF1YmQN1ES7gfJEJ+w@mail.gmail.com/
>
> > "remote" posix locks are almost never used due to problems like this,
> > so I think it's safe to do this.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> Link: https://lore.kernel.org/all/YrShFXRLtRt6T%2Fj+@risky/
> ---
> v2: drop the fuse_flush_async() function and just re-use the already
>     prepared args; add a description of the problem+note about posix locks
> ---
>  fs/fuse/file.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 05caa2b9272e..20bbe3e1afc7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -464,6 +464,34 @@ static void fuse_sync_writes(struct inode *inode)
>         fuse_release_nowrite(inode);
>  }
>
> +struct fuse_flush_args {
> +       struct fuse_args args;
> +       struct fuse_flush_in inarg;
> +       struct inode *inode;
> +       struct fuse_file *ff;
> +};
> +
> +static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
> +{
> +       struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
> +
> +       if (err == -ENOSYS) {
> +               fm->fc->no_flush = 1;
> +               err = 0;
> +       }
> +
> +       /*
> +        * In memory i_blocks is not maintained by fuse, if writeback cache is
> +        * enabled, i_blocks from cached attr may not be accurate.
> +        */
> +       if (!err && fm->fc->writeback_cache)
> +               fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);

This is still duplicating code, can you please create a helper?

Thanks,
Miklos
