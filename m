Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0568E5BBB28
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 04:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIRC3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 22:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIRC3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 22:29:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13541BC16
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 19:29:40 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p5so30071317ljc.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=w+2lDco2F7c9n1uxvA1XW8TAI9bgDHuebUSxEuIOFUM=;
        b=mx8wRkRvoSkfin2CJgLtPl8TbJRzt0YvTTxR+3eE0E4W5gDx3Yyn4tXPCvssJDNIiU
         2MmNHTd3wKgkFwg8Zo74+z6FaeA+Q3g1HwgaJaGAWdrGeH8sbaedSkilJkxruF9E8oS7
         lQtws9dUDn5vKftdzG+cRQErAbIVXTTkX27vV6HB5j6cEsudSeeFr9cX4c9SIzGWusRE
         Q+6rIAkMJqkIhk2upJ9IPMNXVD3tRogAV9VgCb8UAbchUYqNcvbbTWD8x8Bwn8QYuM8b
         lM51urlVI69ZMgyt7YxNhAmSzkBd3QbC+T9tI7JginQkked3b8cevSejN5GVw2g9Vr+2
         MlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w+2lDco2F7c9n1uxvA1XW8TAI9bgDHuebUSxEuIOFUM=;
        b=IBZ+OZFVdQC72A6ZiwA0sFAJ5cO5FixTzUTVhoWVdRG41SZSP0HFd7NNCYfK1vhwAK
         KXg4Bn3FeUKRzj68k6JHjuw9PFaM7X8+/CvIJhAqipxoEIS9X0dTU7S5uNgtrML1+YrR
         TQlBLTc1jj57s1h0KCtYUQi9TnlU6yPxWBTEq/9qYJ8T/nrn22dsemvZ+KQO8Ep0B63/
         eTLQvCEA2DhhbUl+UfsBiWfD0j/6ammp9Ilz8JD2Gxa1hQ4l8a8Y4CedCal4m5n2fYDG
         2Px+x3Szb9+RcJr9fZol+sr/DnCzR/VV52HDJjMysNehRNlx2h30R+gH/rKwTwjlER95
         VJnA==
X-Gm-Message-State: ACrzQf2Q0sFcUb2MNU/HNHBik3FWivZzi0j1Omzi0cgCogh5bJPcDvkF
        UdRymc+F0dS8Bej4uLYlVZ2cZnKhZaqNs5VwKYQd2J1p
X-Google-Smtp-Source: AMsMyM5JmNgOj20B5fMv7nfXqt1pWAuW3ruaWVQjBaue2Q8v8OnUV4+ShvxukzT0ro+UQvgEPx3ds7+qOBFYaKMO+Hg=
X-Received: by 2002:a05:651c:222c:b0:26b:dec5:a4f0 with SMTP id
 y44-20020a05651c222c00b0026bdec5a4f0mr3577440ljq.359.1663468178285; Sat, 17
 Sep 2022 19:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <1661842523-26716-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1661842523-26716-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sun, 18 Sep 2022 10:29:10 +0800
Message-ID: <CAGWkznE5LhYq6dWB0zFkF2XdD-gd3MBcQ9fnUJmW59YL1GisMQ@mail.gmail.com>
Subject: Re: [PATCH] fs: use kvmalloc for big coredump file
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop Eric W

On Tue, Aug 30, 2022 at 2:56 PM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> High order page allocation observed which even introduce kernel panic when generating
> coredump file, use kvmalloc_array instead of kmalloc_array
>
> [68058.982108] init: Untracked pid 3847 exited with status 0
> [68058.982343] init: Untracked pid 3847 did not have an associated service entry and will not be reaped
> [68059.038127] warn_alloc: 29 callbacks suppressed
> [68059.038132] TimerThread: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=foreground,mems_allowed=0
> [68059.038155] CPU: 6 PID: 3597 Comm: TimerThread Tainted: G        W  OE     5.15.41-android13-8-01198-g03458ee9a090-ab000039 #1
> [68059.038159] Hardware name: Unisoc UMS9620-base Board (DT)
> [68059.038161] Call trace:
> [68059.038163]  dump_backtrace.cfi_jt+0x0/0x8
> [68059.038169]  dump_stack_lvl+0x98/0xe8
> [68059.038174]  warn_alloc+0x164/0x200
> [68059.038180]  __alloc_pages_slowpath+0x9d4/0xb64
> [68059.038183]  __alloc_pages+0x21c/0x39c
> [68059.038186]  kmalloc_order+0x4c/0x13c
> [68059.038189]  kmalloc_order_trace+0x34/0x154
> [68059.038192]  __kmalloc+0x600/0x8a8
> [68059.038196]  elf_core_dump+0x7c4/0x15d8
> [68059.038201]  do_coredump+0x680/0xe54
> [68059.038203]  get_signal+0x610/0x988
> [68059.038209]  do_signal+0xd4/0x2bc
> [68059.038213]  do_notify_resume+0xa0/0x1c8
> [68059.038216]  el0_svc+0x68/0x90
> [68059.038219]  el0t_64_sync_handler+0x88/0xec
> [68059.038222]  el0t_64_sync+0x1b4/0x1b8
>
> Reported-by: Guanglu Xu <guanglu.xu@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  fs/coredump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index ebc43f9..ed9b191 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -213,7 +213,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>
>         if (ispipe) {
>                 int argvs = sizeof(core_pattern) / 2;
> -               (*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
> +               (*argv) = kvmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
>                 if (!(*argv))
>                         return -ENOMEM;
>                 (*argv)[(*argc)++] = 0;
> @@ -612,7 +612,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                         goto fail_dropcount;
>                 }
>
> -               helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
> +               helper_argv = kvmalloc_array(argc + 1, sizeof(*helper_argv),
>                                             GFP_KERNEL);
>                 if (!helper_argv) {
>                         printk(KERN_WARNING "%s failed to allocate memory\n",
> --
> 1.9.1
>
