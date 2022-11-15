Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF66291C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiKOGMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKOGMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:12:37 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFFF2AEE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:12:36 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bef14ea06so15162439fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdzdAEDTp4IXZ6o8IRPqc08B1bs5p5D2LmF4e0f0f/0=;
        b=lSFfp1cVhVvY0nPB8cFYSrRGxuwWsgf4A6qX3A9M1F5GPPoqEHlnBLwHftVSWUUqtN
         LmuqXbiwxJx5W4uBFpY4exoM0rI5kDOnNc4azCxHTtB0RiYGH1luul0jkgZVpLbTLI3C
         9A1tc22pWK62q9gf1yRjfljtohlCzsAGcdQflzs276hu25IwlbOCkZxYrq7jQPT1GQQx
         OX3GZ8nDrSFudb4jZ9189Xk4NZjW6xRWfUinLgxpCuqeaUVXoY4gGiXSwyAWfHXD0Om4
         ABr46wvFsxN1bgvy2EJMgRdKt8X9K1NfWHfNbXJF928e8TEpuY+l9jr3/FalfGsyT4bX
         T6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdzdAEDTp4IXZ6o8IRPqc08B1bs5p5D2LmF4e0f0f/0=;
        b=nFILsi1EOj6yrXXy+9237Mlu6NX2qGY4cT7eJkDvm2ekfq3+dMAfPrG2mETMpkqk8N
         /SMjuCWgybNap2CcGlAd0Kq72FnY5uIN+ur1Ipu4j8fl5QaZuDMCQrvYqJl+rpEJRqi1
         HgaytqWgK3Cv7rfVo07X0bNdfqwcsYcJJQh3vUs1c+x22/hflcgcX2q09VM7VMwV8uK9
         V3BBRESm06gKk5dHG/VA2zs8yx9oPpla7ZN6s+trTpDbUdAu+oKN+1aPQHcxuloSUlQD
         B9IYyTNEp69IE4DlgWR9Qp1qRrUJbrlTemAfu183OoekMTLe7RWkX9w+V+RXXEONUDs+
         pWeg==
X-Gm-Message-State: ANoB5pk1hpVm/lnAN74duQ7d14HLDW61e2FjrQcgCGbLrRiqyu3J3DgW
        uoSPuABXCnu4AROMH4gWkIU2NmxAtCwqrSocHZHA1g==
X-Google-Smtp-Source: AA0mqf6EBC0mh0n8X88h7Xyk4Is82N10++ebwcIADisW3zucafAu+m8NFqMq8J4tIgmChbUBiCObirKVqrzL8vz39Zc=
X-Received: by 2002:a05:6871:4605:b0:13d:a22b:3503 with SMTP id
 nf5-20020a056871460500b0013da22b3503mr45269oab.233.1668492755625; Mon, 14 Nov
 2022 22:12:35 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e4e4fe05ed5bf2b0@google.com> <Y3K2V6hwifLlBDfA@slm.duckdns.org>
In-Reply-To: <Y3K2V6hwifLlBDfA@slm.duckdns.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Nov 2022 07:12:24 +0100
Message-ID: <CACT4Y+bD72vupKkvnbCH8KxVH3wmu7frNj0ycfCE0SK+CxjeZw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_activate (2)
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+782984d6f1701b526edb@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
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

On Mon, 14 Nov 2022 at 22:42, Tejun Heo <tj@kernel.org> wrote:
>
> On Sun, Nov 13, 2022 at 07:40:56AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    59f2f4b8a757 fs/userfaultfd: Fix maple tree iterator in us..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14e836fa880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=480ba0fb2fd243ac
> > dashboard link: https://syzkaller.appspot.com/bug?extid=782984d6f1701b526edb
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/619de907b82c/disk-59f2f4b8.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/bcd0dc7d69ef/vmlinux-59f2f4b8.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a8dbe0bc7228/bzImage-59f2f4b8.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+782984d6f1701b526edb@syzkaller.appspotmail.com
> >
> > usb 4-1: Direct firmware load for ueagle-atm/eagleII.fw failed with error -2
> > usb 4-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
> > ==================================================================
> > BUG: KASAN: use-after-free in kernfs_root fs/kernfs/kernfs-internal.h:66 [inline]
> > BUG: KASAN: use-after-free in kernfs_next_descendant_post fs/kernfs/dir.c:1289 [inline]
> > BUG: KASAN: use-after-free in kernfs_activate+0xd0/0x3a0 fs/kernfs/dir.c:1344
> > Read of size 8 at addr ffff888079194b10 by task kworker/1:12/5383
>
> Likely the same one as:
>
>  http://lkml.kernel.org/r/0000000000003a95ce05cd867417@google.com
>
> This is a bug on the firmware loader side.

#syz dup: KASAN: use-after-free Read in kernfs_next_descendant_post (2)
