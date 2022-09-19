Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7555BC259
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiISEuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiISEuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:50:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51A12D35
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:50:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j16so18028563lfg.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/yZZiOrCpRLwKnyPBye99y+fLuXC1QlTVjHQzC5H4zc=;
        b=r50KtvDopnWBTthHoq0HJtxdwsyr3bLaMc8vbIQv4HiV/x4DjypRcoAfBrxST5JldQ
         WOtxYwd7lXYwjgKt9W7gbkYt+K0CHmoTkwJlLhMQ2KIMqSnyiv/M6E7bGdjIQUbH/AIJ
         EywxpIraHZ9oUMWgPb5Huru1Owr49VxDVym82AAP83UzV+l3hNaoWYcxrkc8QTanqZqm
         W3t9dwvyTVTbQVzaqWf02dG+Ub6MVJXRsA+CVDODNRMuda4Nhl9gogzw4kd+Thpf2oFc
         1qeGuT8OnNKpAJ6BNId39hVyg9VWRh7iGzs3Pweb8Xscv47+hW3njD4UeX0lKo+QvWA3
         5OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/yZZiOrCpRLwKnyPBye99y+fLuXC1QlTVjHQzC5H4zc=;
        b=L7tfcgF3YY1l0hf7OvDogyit4AZb7hN3YF5+lNVDGUfW0rYdb4K+zgbrnp/XK4YSUv
         401unYHc16Sv1VR2HfwhsK4qJEAtZ5sj0rtacBKH6KsrHGO4B0YJvPc+tPqr7cvEbBq1
         zNnk+GAbVJtSHGBlpm+ZRDYk0l81yVHojSj0VcCa0RiURPIZqYo15oNhahcNcxNWSiPg
         1dO1jelVokuZPmwZyuJNaFjHTUZnUCX9iYzL65M4B84eqmE9SxCAAG/GD4Pyma/iBmiK
         8hYwwFsYyCSPSc3wSMH0MUFhqHHzM6046xaQ96CWvNOTnw1ITFDCFRF7Ccy4Eaq+mWMz
         YORw==
X-Gm-Message-State: ACrzQf36KZAYPWs+7L6AyEUpvnYsTmtWn/rF42UxYsOJGtU8qI8E5agu
        pfmLI+/s0cZ1dE0PPCojVFUuxf5IG1uOsQUztkJQCw==
X-Google-Smtp-Source: AMsMyM5bsp2Nl8b4QHVERN8943cc83ixkbIeHc9b8300BTlW4PgPwzFE/IwTzbSeyCX76UK40WZCjSsIPWtpLT+BAnY=
X-Received: by 2002:a05:6512:4016:b0:49a:81b3:808f with SMTP id
 br22-20020a056512401600b0049a81b3808fmr5934725lfb.137.1663563036519; Sun, 18
 Sep 2022 21:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000443a7205e8ece1d9@google.com> <20220918110253.947-1-hdanton@sina.com>
In-Reply-To: <20220918110253.947-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 19 Sep 2022 06:50:25 +0200
Message-ID: <CACT4Y+YqSwZyBi7Pj8o=QXCa1YWzFO2J9wFi31FDvKuEMrbA4Q@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in tx
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+5e87db90e68fbc4707c6@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

On Sun, 18 Sept 2022 at 13:03, Hillf Danton <hdanton@sina.com> wrote:
>
> On 17 Sep 2022 22:29:32 -0700
> > syzbot found the following issue on:
> >
> > HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=176b1680880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b22b10880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fce87f080000
>
> Remove the soft hog in caif uart.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  a6b443748715
>
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -210,6 +210,7 @@ static int handle_tx(struct ser_device *
>         struct tty_struct *tty;
>         struct sk_buff *skb;
>         int tty_wr, len, room;
> +       unsigned long ts;
>
>         tty = ser->tty;
>         ser->tx_started = true;
> @@ -218,8 +219,11 @@ static int handle_tx(struct ser_device *
>         if (test_and_set_bit(CAIF_SENDING, &ser->state))
>                 return 0;
>
> +       ts = jiffies + 2;
>         /* skb_peek is safe because handle_tx is called after skb_queue_tail */
>         while ((skb = skb_peek(&ser->head)) != NULL) {
> +               if (jiffies > ts)
> +                       break;
>
>                 /* Make sure you don't write too much */
>                 len = skb->len;

Hi Hillf,

I don't know if it's a good fix on its own or not,
but arm64 command line parsing is currently broken and does not allows
us to increase stall timeouts:
https://groups.google.com/g/syzkaller-bugs/c/QoFsDszFLxY/m/mnnUTKuJAAAJ
This may lead to some false stall reports (the timeout is 22s, but we
set it to 300s on syzbot).
