Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA16BB066
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjCOMRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjCOMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:17:44 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF639312E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:17:35 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3179d0e6123so261875ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678882655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOEBJJjpeu2yJ4Ls4bN0CMp6WWvCn58ODvtWGqyLB7c=;
        b=ByhM2b4erxzocJBDPCEENJ2nmeLhi+QCN7yAeVUz5EPg2dHqSkCDS0GJiunlZsSVmG
         WdOI7Wkl90qy/ErggNGz2BvcygQzA4kUdipq5MaUlyVcl41p4sXpCIXIQrtgcxgL/+Py
         Dlk/g78gPI3uvn4NdwLz+bznGEGvlgwZ2mpyHHPkLIYWLlrBUESIKpjRkQejAonWqjLY
         xP8+d3psDg0RCsvIMNkSAnrvLSK7Bu2h8/Gok8aWAguU8v9xOF6Ql3HJMx43Hq6n68Gp
         YriembeM+xEM/Bdd8/OsVpGdfrLqSR2isLm9nEURugeG934yVbCeslqUZTxo/6JFUsOA
         ocTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOEBJJjpeu2yJ4Ls4bN0CMp6WWvCn58ODvtWGqyLB7c=;
        b=FDWdTTozfCCDqCuuZA5bbpMTvoZg6ucJ6WFBhzhd7ONjD4CPRwyA18U61iQbM1JR6E
         FITY+FJHVVf3rq0CCHQbWaSA/wG/EJkHFC0+CSLrftd9dSSm8RBZwgQQVDlQUXcdC1JH
         yzFkopejTyZ82bxkZceAHrYyEdeDG3nqwWE5vRM1p5b/fP/nNO+qxlvRqNOWxQUOLD5L
         wf3JNOC398aGlwPReB70kmG8qBrMVNvcg5hvsDnpZr6+PlFsAsSeGTWNpbCJvIK+cY8O
         v2XRkhS/Vy7Ivc4xL0zSvXfhWDSBCduXtb6WA6YsF67rQ4BFso2dMIjMIhpYgFqwZeNB
         sJag==
X-Gm-Message-State: AO0yUKXW9Ai87EmgPxYS0ttlxJkxuQhIEyxd1OiXkz6uE09thLSziDxl
        qJaLDlDiQxmZxKab6YdOpHxF0+FCDtUGdEbO799vsg==
X-Google-Smtp-Source: AK7set+Nnm7GWwFfe3tQQiuSqHlu4TKuZa8R+aFLgMk1QRKgM4C+7rZYkRdfs9Ol3UkwhulMj4xVNo6Ns3x6lDqEgkA=
X-Received: by 2002:a05:6e02:1aaf:b0:322:c312:3bbb with SMTP id
 l15-20020a056e021aaf00b00322c3123bbbmr97902ilv.15.1678882654910; Wed, 15 Mar
 2023 05:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000097fc2305f1ce87d9@google.com> <0000000000001497d605f6e9b6e6@google.com>
In-Reply-To: <0000000000001497d605f6e9b6e6@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 15 Mar 2023 13:17:23 +0100
Message-ID: <CANp29Y4WhUTNjUF1BPKDcSzUFx4Jb2uMHRsuezSewWZ9czWwtA@mail.gmail.com>
Subject: Re: [syzbot] [io-uring?] KASAN: use-after-free Read in io_worker_get
To:     syzbot <syzbot+55cc59267340fad29512@syzkaller.appspotmail.com>
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks reasonable

#syz fix: io_uring/io-wq: only free worker if it was allocated for creation


On Wed, Mar 15, 2023 at 6:35=E2=80=AFAM syzbot
<syzbot+55cc59267340fad29512@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit e6db6f9398dadcbc06318a133d4c44a2d3844e61
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Sun Jan 8 17:39:17 2023 +0000
>
>     io_uring/io-wq: only free worker if it was allocated for creation
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D108bc2e2c8=
0000
> start commit:   a689b938df39 Merge tag 'block-2023-01-06' of git://git.ke=
r..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D33ad6720950f9=
96d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D55cc59267340fad=
29512
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1532ef72480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10b43f3a48000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: io_uring/io-wq: only free worker if it was allocated for creati=
on
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
