Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1456D5F8D47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiJISnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJISnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:43:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81025E86
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:43:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26-20020a7bcc9a000000b003c384e59047so3274791wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTptt1W09idFMS+rLbJl5PLPMmSHCElX2/TSniLH/8g=;
        b=thbsNcRGKjqPIwsobQXfLXoUIDBQSBB504od90dhebRdyWSHFpcFj+aMQSge9MFSHL
         vRmwyCD767NUh/Cd79Vs7TMv2zv+t2iXDAeoWLky5d9iJnKHBks9hRSmKvZZ1dt14pB3
         LNFmZxfP6P2uEi7Sl2C/HJqmMFrpgnVNSNU441vR9S0tTWYI74lGG+A+oPuQgud3lJtM
         38UlxH9zOoT7dt12l4g3gGZPLEGaGtoX1ME3Oj1xz4uYatuKai3DJvaZyD5kHV8zW99U
         ngdvLikMpsXc3XaPI4q57DyoAGdySRLbE8UwP2Yeq9dgJNxr28yuBj7ozrZM+m0P/JIn
         yYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTptt1W09idFMS+rLbJl5PLPMmSHCElX2/TSniLH/8g=;
        b=eALoc8pcN6nGy9YR8Rv5JR3PL6Mlmvb01ZBZ9dUWMapJZTRiGVwKVyUGN0Xa2WMo5o
         lDOzhvMOdydiDXubJJ/lt8NRRezzJDBRwbc243mu9TKtEp4sJ81NGHSzXGKUAwB9AzR0
         njv9A0nIa/S7OUomTvRU+B/w2gg6A2MvPojXyeoxYYBpnvb83WXFvwjQp6taVJ2ZbvGT
         WFJKdKO16ML4CfoVem2WNG0ThWdf8nko7UpZKFYOa3xhrsYhO+PfY2d1X6aN30wP0Uo5
         H0TyH/7/ncviazkj9Saf4ALoBg/kGbPk77bMAdNjVOniBzZ15gzgEH6V+lzMm612yJ8X
         zr+w==
X-Gm-Message-State: ACrzQf1KZ1+2IMtEd6OQegzzFpgYwFEMlRpjCiNMU1+11t6RPpWDIEBE
        caV+nfwsY8DygWy0y56epy9Z4recSThh4n/HyoaHYg==
X-Google-Smtp-Source: AMsMyM7yuyOUnHNHbwjRAR2T4wV32eCL4nIRnjXcCI2J78gBD2N+klea2pOETLZBRdsTrgffHLQPgjzpfcd1+2H5v/I=
X-Received: by 2002:a7b:cb92:0:b0:3c4:cf60:7a7 with SMTP id
 m18-20020a7bcb92000000b003c4cf6007a7mr5213828wmi.24.1665340995066; Sun, 09
 Oct 2022 11:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000385cbf05ea3f1862@google.com> <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org> <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein> <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
In-Reply-To: <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 9 Oct 2022 11:42:38 -0700
Message-ID: <CAJD7tkaQSMSmrb3Nt17-NPAPkvEoUp5tJBg8e4UYn0eU6x-Gqw@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
To:     "Christian A. Ehrhardt" <lk@c--e.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 6:10 AM Christian A. Ehrhardt <lk@c--e.de> wrote:
>
>
> Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
> error when used with CLONE_INTO_CGROUP. However, the permission
> checks performed during clone assume a Version 2 cgroup.
>
> Restore the error check for V1 cgroups in the clone() path.
>
> Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
> Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")

Thanks for fixing this, and sorry if this caused a mess.

cgroup_get_from_file() independently seemed like it can support
cgroup1, I didn't realize that some of the callers depend on the fact
that it only supports cgroup2.

+Andrii Nakryiko +Alexei Starovoitov +Martin KaFai Lau +bpf
I wonder if BPF users have this dependency. Does cgroup_bpf_attach()
also depend on cgroup_get_from_fd() (which calls
cgroup_get_from_file()) eliminating v1 cgroups?

It seems like cgroup storages (and some other places) use cgroup ids.
Collisions can happen in cgroup1 ids so I am assuming we want to add a
check there as well. Perhaps in cgroup_bpf_attach() ?

I can send a patch for this if that's the case.

> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  kernel/cgroup/cgroup.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index b6e3110b3ea7..f7fc3afa88c1 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6244,6 +6244,11 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
>                 goto err;
>         }
>
> +       if (!cgroup_on_dfl(dst_cgrp)) {
> +               ret = -EBADF;
> +               goto err;
> +       }
> +
>         if (cgroup_is_dead(dst_cgrp)) {
>                 ret = -ENODEV;
>                 goto err;
> --
> 2.34.1
>
