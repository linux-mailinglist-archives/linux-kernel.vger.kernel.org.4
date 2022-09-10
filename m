Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11785B4A52
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 23:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIJVjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiIJViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 17:38:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECDF5A896
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:32:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f11so8637775lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dKuWr+7sFYqC4a6p2wuZ9+beEh0+LI5Ezol+4b3ZVAM=;
        b=aKVOBGiDsjP+bSXE/j9+8NcwX5xyWndNrR9GocIhv0td/3nc8c7bcqYrBbzPRGPmMp
         o0gWqyXgzz2V7gE9DTo+w8cSQQlU/ws36m/6v9ptbwvKbhUvvAjN7rY2h3g4V/dxHzZx
         Q5WtVRADG0Dl1nDCX4rWxhcOBxCDt4fXplKrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dKuWr+7sFYqC4a6p2wuZ9+beEh0+LI5Ezol+4b3ZVAM=;
        b=GNuo21emZX+ytqrFJ6FeXH0uD51xCQWWtBHcNtm6W4iS0UBdyYzFVXYgAS1J8k9M//
         K61P42rk2XEE2sxY6S/OQWgim/iPIlm2LO3t+6vD/0JOuKxzAk+fBIEyVpGdC42VIH5n
         kP6q7tKG5H8RdPF+PFtP+WPMr/uHyxIl8equudBS1G/xsDsqosGJrqvxNoiM5xYx+qQI
         7P43JGW1sb4/SAoK45grmZIPxTDStYKi9N4t9cYzcuETu4g5Ihgm98kHtKkDiTMoalXP
         yluHVcqp8InLcwyNkD0szH3kWqZpM82a5Dxjqf+waY0sDMwhRZr62JVWtVYtLRzRT093
         SsWQ==
X-Gm-Message-State: ACgBeo06cauOXS4TTzL2cmVOkuvLoBlpg26SVGQ3MdQ/uxaImro7DE2+
        sJkAFoGE67PnZ2g1o0bVcapDLKdeU0JaJb9R
X-Google-Smtp-Source: AA6agR74/nKzAZrynhOUmvtp0wb2S4np7VsLWAQrL/KE1hz5698n2zS0E68cxLtNJGQpF3b7BIZFhg==
X-Received: by 2002:a05:6512:1282:b0:492:cdcc:cbce with SMTP id u2-20020a056512128200b00492cdcccbcemr6279503lfs.16.1662845568295;
        Sat, 10 Sep 2022 14:32:48 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05651c168a00b0025e4ab170e0sm474202ljb.3.2022.09.10.14.32.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 14:32:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id q21so8731744lfo.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 14:32:47 -0700 (PDT)
X-Received: by 2002:a05:6512:eaa:b0:497:a1ed:6fa5 with SMTP id
 bi42-20020a0565120eaa00b00497a1ed6fa5mr6126107lfb.108.1662845567245; Sat, 10
 Sep 2022 14:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905125637.GA2630968@roeck-us.net> <CAHk-=whh=0FG6r_YJ4_1pq07b=bqN8gTExU5T_ys-SVn0CRDtQ@mail.gmail.com>
 <752fba06-8ccc-d1e7-68d8-f141eece1230@roeck-us.net>
In-Reply-To: <752fba06-8ccc-d1e7-68d8-f141eece1230@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Sep 2022 17:32:30 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj1obPoTu1AHj9Bd_BGYjdjDyPP+vT5WMj8eheb3A9WHw@mail.gmail.com>
Message-ID: <CAHk-=wj1obPoTu1AHj9Bd_BGYjdjDyPP+vT5WMj8eheb3A9WHw@mail.gmail.com>
Subject: Re: Linux 6.0-rc4
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's bring in the guilty party and related people..

It looks like b353b241f1eb9 ("net: fec: Use a spinlock to guard
`fep->ptp_clk_on`") is not sufficient to fix the problems caused by
f79959220fa5 ("fec: Restart PPS after link state change"), and in fact
just causes more issues.

By now I suspect that both of those just have to be reverted.

Hmm?

              Linus

On Sat, Sep 10, 2022 at 2:13 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/10/22 10:44, Linus Torvalds wrote:
> >
> >> Revert "fec: Restart PPS after link state change"
> >>      revert f79959220fa5
> >>      Rationale:
> >>          The patch results in various tracebacks and crashes.
> >
> > Hmm. No revert, but does commit b353b241f1eb ("net: fec: Use a
> > spinlock to guard `fep->ptp_clk_on`") fix it?
> >
>
> No. The m68k crash is still there as of v6.0-rc4-284-gce888220d5c7. The above patch
> changes fec_enet_clk_enable(), but the crash is elsewhere - or at least now it is
> elsewhere.
>
> *** ILLEGAL INSTRUCTION ***   FORMAT=4
> Current process id is 1
> BAD KERNEL TRAP: 00000000
> PC: [<00000000>] 0x0
> SR: 2704  SP: (ptrval)  a2: 40829628
> d0: 00002700    d1: 00000000    d2: 40829420    d3: 00000000
> d4: 00000000    d5: 402e81aa    a0: 00000000    a1: 00000012
> Process swapper (pid: 1, task=(ptrval))
> Frame format=4 eff addr=400681c2 pc=00000000
> Stack from 40831cf0:
>          40829420 00000000 40832000 402e81aa 40bae000 00000008 40829420 40829000
>          401b0e44 40829628 40829420 00000000 40831e0c 00000200 401dce0a 40884a50
>          401b14d6 40829598 4082970e 40347ee0 401ad2d6 40829420 40347eea 00000000
>          40831e0c 402e81aa 40bae000 00000008 40347ee0 40829000 fffffff8 4082944e
>          40829000 408294bb 00000002 00000000 00000000 00000000 00000000 00000000
>          00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> Call Trace: [<401b0e44>] fec_ptp_gettime+0x28/0x68
>   [<401dce0a>] __alloc_skb+0xb0/0x24c
>   [<401b14d6>] fec_ptp_save_state+0x12/0x3e
>   [<401ad2d6>] fec_restart+0x5a/0x770
>   [<401ae4c0>] fec_probe+0x732/0xcee
> ...
>
> On top of that, I now also see
>
> [   22.043994] BUG: sleeping function called from invalid context at drivers/clk/imx/clk-pllv3.c:68
> [   22.044249] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 272, name: ip
> [   22.044395] preempt_count: 1, expected: 0
> [   22.044485] 3 locks held by ip/272:
> [   22.044571]  #0: c1af1ce0 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0xbc/0x8f0
> [   22.044792]  #1: c40dc8e8 (&fep->tmreg_lock){....}-{2:2}, at: fec_enet_clk_enable+0x58/0x250
> [   22.045011]  #2: c1a71af8 (prepare_lock){+.+.}-{3:3}, at: clk_prepare_lock+0xc/0xd4
> [   22.045217] irq event stamp: 1460
> [   22.045295] hardirqs last  enabled at (1459): [<c1084cd8>] _raw_spin_unlock_irqrestore+0x50/0x64
> [   22.045454] hardirqs last disabled at (1460): [<c1084a98>] _raw_spin_lock_irqsave+0x64/0x68
> [   22.045623] softirqs last  enabled at (1444): [<c0e77268>] __dev_change_flags+0xa8/0x254
> [   22.045784] softirqs last disabled at (1442): [<c0e77238>] __dev_change_flags+0x78/0x254
> [   22.045944] CPU: 0 PID: 272 Comm: ip Tainted: G        W        N 6.0.0-rc4-00286-gb260ebd186c0 #1
> [   22.046113] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [   22.046235]  unwind_backtrace from show_stack+0x10/0x14
> [   22.046360]  show_stack from dump_stack_lvl+0x68/0x90
> [   22.046477]  dump_stack_lvl from __might_resched+0x17c/0x284
> [   22.046604]  __might_resched from clk_pllv3_wait_lock+0x4c/0xcc
> [   22.046735]  clk_pllv3_wait_lock from clk_core_prepare+0xc4/0x328
> [   22.046866]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.046992]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047118]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047243]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047368]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047493]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047618]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047744]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047868]  clk_core_prepare from clk_core_prepare+0x50/0x328
> [   22.047992]  clk_core_prepare from clk_prepare+0x20/0x30
> [   22.048110]  clk_prepare from fec_enet_clk_enable+0x68/0x250
> [   22.048235]  fec_enet_clk_enable from fec_enet_open+0x3c/0x3b8
> [   22.048360]  fec_enet_open from __dev_open+0xec/0x1ac
> [   22.048476]  __dev_open from __dev_change_flags+0x1bc/0x254
> [   22.048603]  __dev_change_flags from dev_change_flags+0x14/0x44
> [   22.048730]  dev_change_flags from devinet_ioctl+0x88c/0x8f0
> [   22.048854]  devinet_ioctl from inet_ioctl+0x194/0x258
> [   22.048971]  inet_ioctl from sock_ioctl+0x4b0/0x5cc
> [   22.049083]  sock_ioctl from sys_ioctl+0x548/0xf18
> [   22.049198]  sys_ioctl from ret_fast_syscall+0x0/0x1c
>
> in various arm boot tests. This is new since -rc4.
>
> Guenter
