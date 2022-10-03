Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24C5F2BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiJCI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJCI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:27:55 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A997CB5A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:01:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q17so10854558lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sqPhdgc4x0rFX6jSUaMvQV/4rWzTW8uK47Qidhfh0rI=;
        b=tlabUIfMve+6gKvjEvInsOvpyRtCAySTN5+kPE7YCnehpxV0xE2GWdzDQ+BZnrAt8l
         PqqV9pxnTvNvD3TCP0bV41t/+x9XDdK8fcQvJ8tRlzZMr4ch5sJXRfG4Xcn8gI1gIVh/
         CWxJg5rDg7256CxPVRWZba5hFcqiJTRJ4TEXA/IqoejiABn01qaSppA8sQD5SjWRBdvk
         qkGgMQ9fvPiJWAbi8I2Zqkdg/cbeaGkxsOHnpMarEK1BF3adhnfHNNLFGSY37inzqi3x
         qrBx+jJQRiC3W751FH6G80BCenbtbbr42L7RiUFiObfWDN4qMB+cczYarumaL48d1AKI
         0LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sqPhdgc4x0rFX6jSUaMvQV/4rWzTW8uK47Qidhfh0rI=;
        b=JmxZ2Si1XWoS+PcsSqnXphSGytPugpHifAohWsy9L8nO2hhmlZ0TkHH07rd1mqXMm3
         v+fZlZr37aHb/X9mVwE0ICIZI8VhzsDzGgZ/kib0j7VSW9WtzT/WxXZQ9HgojUMbyaLm
         CfIiDS5EOXREi6qhZAWjwioKqcaVYvLaFFPuWu7YHhWt3fCJfutR+0dlAnuXj2fIqmuv
         EGpUm2uoKO/4DcvxyLg4mmDonlTuBLDqeC8oG4Wi0pzDee7FETL2BfRC42JmlHAgDiqD
         l/yCjkYG6INI/jRUy/8lcdWH6wpmTDp7tYx348bZehw+Ue6ZEbP4XXc2kbW527QtE9tm
         BhhA==
X-Gm-Message-State: ACrzQf0MrRk1WH7T5BAzOhr0/8buE2Q89Df+kF+vUYSOmVucvKHgdbMR
        6rkJe/kwdnB+D1JnhyDmI5524uScUq9wusuOn0P7yg==
X-Google-Smtp-Source: AMsMyM4dt3pJrT4PgxmqCYV2z1aCasIondPwtpfZEkJ4PTEsPdRIfBppS6R3jxg2Dr+hZoQbPVgIS6TGUOFNB/Q0omo=
X-Received: by 2002:a2e:9b85:0:b0:26d:295f:dfc3 with SMTP id
 z5-20020a2e9b85000000b0026d295fdfc3mr6344840lji.363.1664784031692; Mon, 03
 Oct 2022 01:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001850d105e9f9e6de@google.com> <026ada86847b6f5a9f89cf005b5d75d035ff6a19.camel@sipsolutions.net>
In-Reply-To: <026ada86847b6f5a9f89cf005b5d75d035ff6a19.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Oct 2022 10:00:20 +0200
Message-ID: <CACT4Y+bxKRmaFC1qvFBWoPS8gqJ+5Uvf_tv1HLx1o0pd-SeULg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: lock held when returning to user space in ieee80211_change_mac
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     syzbot <syzbot+4ef359e6b423499fa4e1@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

On Sun, 2 Oct 2022 at 22:02, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Sat, 2022-10-01 at 07:26 -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    6627a2074d5c net/smc: Support SO_REUSEPORT
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10183a70880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d4d64087513b5aa1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4ef359e6b423499fa4e1
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9ecb75606956/disk-6627a207.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1073865fcb40/vmlinux-6627a207.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4ef359e6b423499fa4e1@syzkaller.appspotmail.com
> >
> > ================================================
> > WARNING: lock held when returning to user space!
> > 6.0.0-rc6-syzkaller-01407-g6627a2074d5c #0 Not tainted
> > ------------------------------------------------
> > syz-executor.3/10164 is leaving the kernel with locks still held!
> > 1 lock held by syz-executor.3/10164:
> >  #0: ffff888147acaa88 (&local->mtx){+.+.}-{3:3}, at: ieee80211_can_powered_addr_change net/mac80211/iface.c:217 [inline]
> >  #0: ffff888147acaa88 (&local->mtx){+.+.}-{3:3}, at: ieee80211_change_mac+0x9b4/0xf40 net/mac80211/iface.c:264
> >
>
> Uh, right. Pretty sure this will fix it once I merge it:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/Yx9LJFA7PDSRmb/M@kili/
>
> johannes

Let's tell syzbot about the fix:

#syz fix:
wifi: mac80211: unlock on error in ieee80211_can_powered_addr_change()
