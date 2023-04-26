Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E88F6EEE64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjDZGeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbjDZGeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:34:22 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A77270B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:34:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4efea87c578so7066e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682490858; x=1685082858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XekK5PekC7GoeZPCg+JQ/nn8VHa69nWLh19xCdeTJX8=;
        b=tNobsBe8wdLBadc9rDYBW9mMu9SV1Pa4ANSSxEBEcmKyXI5i9RZTFE2JLVFX2djq3M
         /fVF1Gih5smO/7k+3WrWaZg7nIUyDHQsOkAMRclD6F7wR4W9xj9qg+Fi5D4yqH2PSVUg
         zRypLAW3/GVV2HdQk3Zo6oeK9ZrLiPB6V7aSDXYEMXfJ3QqrgyxavVT/Y8gfh6L4UQUu
         477lIryfWrqBaJxGZ3CjaK6IFAXTek82lKqy51o9MVPJOIcyLb7SgCnq4Uk25Kg0z9ho
         FOn+1/cwleiYiDUrNkiOtSsVctAV5OOOIJdpYttNgOQ2x36nPx40HPtAO4KXAuDERZt1
         nMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682490858; x=1685082858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XekK5PekC7GoeZPCg+JQ/nn8VHa69nWLh19xCdeTJX8=;
        b=ebxqikHZWxqoic8/3hjg+8Et6A2JLPld0/ZIiFMVDak3ixh8UuDDmKXyrcgDWX9P4J
         iN+bqg8WF9uwaK/bOYFCfBbOTIUk6v8Bl+kPt+oCCZQpcUklveW9fBRBYszQY7H+vfGe
         R8mAFZ04Pm5opYsOYvQ7bJ7qYrxFSB0PoE155Cb+20LJCuHRCFeqmiYTg6gquOsxC9VS
         Eax9EVwhoBHDkNl9e7pWG3L3D0u7GarvD2oawifCOArvR41jXx2rgsmLwMV/eRFhf1/n
         0u92An1cArUCdLkNFVADkO/z1dCfdn9FO3EJvhcce7/dSD9EpnjFl5L6T93hzQH0adPX
         v2Bw==
X-Gm-Message-State: AC+VfDzOqUEMgY66wZHrVVSvM0MVsfvzly3h3NdBbcKS1ETwMMt4ozsU
        W0VxiogLL1j6SH2YWUozbWXYSzKtLs+FSTjKIjmzxA==
X-Google-Smtp-Source: ACHHUZ5a3/l9GMjyHQhJHM3/n5Wle1SDQKtgzHRC2aZgoZGtyH4dB5Vj7wN0dpP43pA24oEUaBPjG0HUmgIGEYHDH8M=
X-Received: by 2002:a05:6512:3c8b:b0:4e8:5117:71ae with SMTP id
 h11-20020a0565123c8b00b004e8511771aemr80332lfv.3.1682490858408; Tue, 25 Apr
 2023 23:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
In-Reply-To: <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Apr 2023 08:34:05 +0200
Message-ID: <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     syzkaller@googlegroups.com, alex.gaynor@gmail.com,
        andriy.shevchenko@linux.intel.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 at 23:36, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi syzbot engineers,
>
> On Tue, Apr 25, 2023 at 10:06=E2=80=AFPM syzbot
> <syzbot+d692037148a8169fc9dd@syzkaller.appspotmail.com> wrote:
> >
> > HEAD commit:    de10553fce40 Merge tag 'x86-apic-2023-04-24' of git://g=
it...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14bdae68280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D975b8311f6b=
96bca
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd692037148a81=
69fc9dd
> > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110=
, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: arm
>
> I am not sure what triggered the bot to consider Rust here -- the
> config does not enable it.
>
> What am I missing?

Hi Miguel,

The crash is in lib/vsprintf.c and:

$ scripts/get_maintainer.pl -f lib/vsprintf.c
...
rust-for-linux@vger.kernel.org (open list:RUST)
...
