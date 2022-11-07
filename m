Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A0C620151
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiKGVh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiKGVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:37:53 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262BE10FE8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:37:53 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13b23e29e36so14199585fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HejFlgHKmBGzk/mBIA87qRdy5PTiC31t5RYdgGHwS3o=;
        b=URdwkQQSLaYC2sgfRKTqDreHSK8nJLdGMGWE0eDM2e9LRCZqOQTSmI3XUalNFetIMN
         Blb67oK8zArpvcRPOgjEfbDXNdwWOsufnevc8c63x9kf8tKjYs9+IPL5/1s1sFlmKPLy
         l/kmuaT3yD3qmP2wNlYQaR5lEF3ATv1uPqC6deWIpSzyitSlp6d5ZtRl9FRWMghVBvLZ
         06rUqpoBTBbfu9fqypvJ/EEU2gbF9aV2IS0dHU1szUFmzcicldoCJB8vJst3pl1N+gyh
         tHTbanceg1gWZp6BJIiNqcQlehXm9/baD2yxqmeUcaCfFTTRWqq0ghHOkqC5xo7D2Tkl
         KJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HejFlgHKmBGzk/mBIA87qRdy5PTiC31t5RYdgGHwS3o=;
        b=eXeL70PiK5UWk7ChL8/7i8rnneZHyXdoVA+cYRFbTBSlwNLo2yHof6A2VpCT4qonTK
         UBmmW7eloj7fMe+gF8kiIZ4wk6am7Y+sE5BRWqv7q2OrEsa63xQOjSkpsX+vJzCZMe8k
         YO4xcfGng0O4HNbg3p+1Cp7EL5zU0t7G+n4sInD4GEM89TiicpoZ6070llbPC3NhjSSN
         nOv0mMvHzphEbnYvbOkeaN2P6CF2in2qTVWh3yMaIyKHPZ7Mc5OcHIx9hy4o/Y1RPBwj
         h/ICdcmHJzHIOsLiT5G5G2nTBVoslWsdzG6z0LTyCZooR/I2gmdIZIqngdEW0/JuRlJ1
         Nd+Q==
X-Gm-Message-State: ACrzQf2EG8p2iEE+pXcpbaUV+D2rpAa2fMnYbKv9ruMuS9MioMfVWEAH
        Wen3FeZZKYJ574TMKVZ0BjHtYM85tAl5eclzlundZw==
X-Google-Smtp-Source: AMsMyM48Ih0bnW2g8idkWTbJkUt3h7FZUwC1tdVNW6cLBRe9greBUQjyL5Oe+czHcLkK/F8jVcpFTbHM3Z/X62aTzgM=
X-Received: by 2002:a05:6870:b6a3:b0:13b:f4f1:7dec with SMTP id
 cy35-20020a056870b6a300b0013bf4f17decmr31266166oab.282.1667857072240; Mon, 07
 Nov 2022 13:37:52 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000bab2c05e95a81a3@google.com> <000000000000946f3005eca8cafe@google.com>
 <CACT4Y+bX40TE_rx0SFnixoQVd_vHuGih9mtJA4TB7-dDOeguew@mail.gmail.com> <CABBYNZKyjFE_oVFDMj-U9uSax79bMimUCi1JyGBmyR_ufCNAUw@mail.gmail.com>
In-Reply-To: <CABBYNZKyjFE_oVFDMj-U9uSax79bMimUCi1JyGBmyR_ufCNAUw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Nov 2022 13:37:40 -0800
Message-ID: <CACT4Y+a0ma3NRFFLTEHMOH_6Y6DqNet5sz6m6HQwVe8sTv2EQA@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in hci_conn_add_sysfs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     syzbot <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com,
        yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 at 22:39, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Sun, Nov 6, 2022 at 3:25 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, 4 Nov 2022 at 10:56, syzbot
> > <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot suspects this issue was fixed by commit:
> > >
> > > commit 448a496f760664d3e2e79466aa1787e6abc922b5
> > > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > Date:   Mon Sep 19 17:56:59 2022 +0000
> > >
> > >     Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1052f8fe880000
> > > start commit:   dc164f4fb00a Merge tag 'for-linus-6.0-rc7' of git://git.ke..
> > > git tree:       upstream
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110db8c880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e58aef080000
> > >
> > > If the result looks correct, please mark the issue as fixed by replying with:
> > >
> > > #syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> >
> > Looks reasonable based on subsystem and the patch:
> >
> > #syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
>
> Looks like I did add a different link when fixing it:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=448a496f760664d3e2e79466aa1787e6abc922b5
>
> Or perhaps they are duplicated?
>
> https://syzkaller.appspot.com/bug?id=da3246e2d33afdb92d66bc166a0934c5b146404a
> https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef


Yes, most likely differently looking crashes, but the same root cause.
It happens.
