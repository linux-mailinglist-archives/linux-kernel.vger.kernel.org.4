Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED786F5650
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjECKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjECKif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:38:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5271035A6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:38:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so7646e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683110312; x=1685702312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m6tIDIaRiKNsIqKtjMQi+s0SrWUkBcsj6Av85gJp2lM=;
        b=YhIagxbGgKIdNze0WYzl1bsUlbdGKL2AhxpmolEa15irRT/JaP5WGnxK+WqVYUma/t
         sPBgo3evjVuiJVjTSwHSnGNCqgkoNXTyHmdX0rJ4IETC0aZQZ1qVU1XtSoXkRX5M4hp0
         4WJQ7eH3TRebn8/Tv6wFsZE6PjwdQwJ6VrW1SYGtVb6J01fsfx0EIzNzVRJiwvWORdi9
         wZ8VPlqrCtScpEfJZ5sSGZNxy1s8ZtI4vMvarxbBU9ng3S90LpCR8KJtE5sPA/rVcvu4
         RcsarXStCebvNhCCes0gSHejeVeEXtkaKurM6fBMUK2Q21/lNBsv//9A2LbzIaNAYYzA
         a2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683110312; x=1685702312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6tIDIaRiKNsIqKtjMQi+s0SrWUkBcsj6Av85gJp2lM=;
        b=U3fTVt8vCJ6cLraZsj+qQp5WP3C7dROjqUoVkoaAvdenKNA48jzJvw1bgteY6NiVUg
         4vlElqtUGHfiRncvjtFtYLkBCcFQMv2y+SwVcc0Jj10ZTXJ0Pw16kBvEU8GeNKjYA4/i
         ipNssgQUVWS632t5pxgUq0iKE/g3vdmFTouMYX018v5PTdE5VUHfQ2IDlWNUrFP1UniG
         bKKvshTxfXlJINjezAEEmMdckKpM+yPxMLXffSBSOjjYE8ikB1XxCrC/9QYReS5k713a
         9PSxssKt+27GHPsVCr9RwqQr45vCxXFiqcjryB4g+Th5OcZHTIfOIEEnUB0X2BBkKJGu
         tUSA==
X-Gm-Message-State: AC+VfDy+AeQ17hgFZCxNeS6IoSYLbkRRLa0BClb3wbOdzXIQ4chBfrTG
        lr1o4FcP2gpwt7HOnm/G9x6KyfZTX1aoXsVSg6yY9Q==
X-Google-Smtp-Source: ACHHUZ6plspNJ1Clj0iGJK4HTVf8p2XdgXnlkdlRvwLEkw05imY2TkdjSkTNjQ+vwk0lJz3T6uGw8psbtvhTbPQ0KDU=
X-Received: by 2002:a05:6512:3d27:b0:4f0:10e6:b51 with SMTP id
 d39-20020a0565123d2700b004f010e60b51mr192349lfv.4.1683110312393; Wed, 03 May
 2023 03:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000281ae805faa4844e@google.com> <CACT4Y+Z+N9P6H8ZmF=TGfrC26r1LhHW7OT__UWKTh5VJOWnjEg@mail.gmail.com>
 <ZFI4ue1uzd0Il9yM@shell.armlinux.org.uk>
In-Reply-To: <ZFI4ue1uzd0Il9yM@shell.armlinux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 May 2023 12:38:19 +0200
Message-ID: <CACT4Y+Zxd87dozaOgKWQ=ROpnN8-4k+ErFByJEu_oxnJttmxMg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in psi_task_switch
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     syzbot <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com>,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, surenb@google.com,
        syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org,
        vschneid@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023 at 12:34, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, May 02, 2023 at 08:37:15AM +0200, Dmitry Vyukov wrote:
> > On Mon, 1 May 2023 at 18:43, syzbot
> > <syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    89d77f71f493 Merge tag 'riscv-for-linus-6.4-mw1' of git://..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1113550c280000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=4cc65ccad523b604
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0827f43974813b74e6db
> > > compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: arm
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0827f43974813b74e6db@syzkaller.appspotmail.com
> >
> > +arm mailing list
> >
> > Kernel started falling apart on arm during boot in various strange ways.
>
> Are these all the same hardware platform? If so, please check the
> hardware with a known working kernel. These look like spurious failts
> caused possibly the hardware platform failing.

It happens in the same qemu that used to work before. So "hardware" is
presumably working.
