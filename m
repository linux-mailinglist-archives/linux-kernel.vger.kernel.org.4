Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA269A7CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBQJGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBQJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:06:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749055FBFE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:06:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z18so1030520lfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R2Pe5eJ8mXG882/oIneNK2AU1N9QB7QTc3Dg4lQRToU=;
        b=eUtfVt2QfCYzrIE+EO3zlTaxh9C/8Bu2h3xrjGEj2GmZtcoQoAjlg5fzGootcpAm1d
         YdOR6DBQXuVCNztspRC3mV/odWaHwQ2RjfZDZnjHOsx7rnS64xduCaKp5V9MoyrLsSWi
         V0OuMcJlNoDIV1hYXfpzETn+/2cAH23KmfRtggk5txnC2RKTWrQdWmy1HR7EjKnGZJRE
         s1uIMl2nOYe0ASqqLIfkbMgc4B8rk8pVnEyVF8w6z9EWmANbZ6vkKzy/Q7OrioEsPlOA
         3oPLq253dTc63r89cgrM0lO7I1sT8r2XrHeG0BvEYyJvSupgn9wUTc5kxOsJ2Q7rIRHU
         4ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2Pe5eJ8mXG882/oIneNK2AU1N9QB7QTc3Dg4lQRToU=;
        b=cNmIzEPq5NDkIYjL230F9dbFOEEAqodpEF3540loxuuftoCxuRvqHx+lUvjtWZqdH6
         CeX8asrXK8IMCI69xuWNQZII9jkZ7GodE9rLUNX5m/wzVUZWekqmWErkJ2YhrPCd+CML
         iJ3eBxEuKc4AKs1yKCfKWuqU6bajK2SnzCEqHIcspbMnYZs2tLaKT5edFXIqGd616j4+
         ylcLD5fZbct/XbKbuvtPUG5krgWMFrgM0xtym5EVl+uRpY1op/a08BPZ/AOKTSDP/u5k
         UbWfkDaYWGcpGyBw4h+htmVibf8/QkMUbnJ8iUFiiQSQRjDZfgmeyqF2lXjgGC9qN7vl
         +uLg==
X-Gm-Message-State: AO0yUKUkiYue4MfMT28DbKgYkEMoNFr9tcp1hpEHonWH2KO/2KmLKVB2
        I7iBpBKKab7snI2YP7AMHS8mz0Ew1enWyf/E/9pMxQ==
X-Google-Smtp-Source: AK7set/4WgvF8R8p4Gk6f0Bg0y33W3iWubV1X3k/OUD6aHHiiBnv+LZPp0MBV37GM3sdF5lGndve4gV4wBMFgIBtIm0=
X-Received: by 2002:ac2:55ab:0:b0:4db:3353:c891 with SMTP id
 y11-20020ac255ab000000b004db3353c891mr282115lfg.3.1676624764576; Fri, 17 Feb
 2023 01:06:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ff304105f4d1cd36@google.com> <CACT4Y+Yq1knodAhoBnUe-Tf6QLrQCrGV5gyWC7An8poQDcfv6g@mail.gmail.com>
 <20230216185144.u5zijpev6o77xhaz@treble> <20230216202607.c2nfp6exhoomjckp@treble>
In-Reply-To: <20230216202607.c2nfp6exhoomjckp@treble>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Feb 2023 10:05:52 +0100
Message-ID: <CACT4Y+aBV3d7kLjAZ1hHHbX=y8gTvfwrPsiohwV81PzRRjGkGQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: can't access registers at entry_SYSCALL_64_after_hwframe
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     syzbot <syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
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

On Thu, 16 Feb 2023 at 21:26, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    9d9019bcea1a Add linux-next specific files for 20230215
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=144edcc8c80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a64cbb8ad0da425e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=dac365e3ce07c3d0e496
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/70f0c6bb5351/disk-9d9019bc.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/7eed8686df34/vmlinux-9d9019bc.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/84bb6da6b00e/bzImage-9d9019bc.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com
> > > >
> > > > WARNING: can't access registers at entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > >
> > > This is another splat of reports we started getting recently. Looks
> > > like this may be ORC unwinder related as well.
> >
> > Yeah... Also:
> >
> >   https://lkml.kernel.org/lkml/202302161616.85f13863-oliver.sang@intel.com
> >   https://lkml.kernel.org/lkml/CACT4Y+YzZb2vscjBLiJ-p-ghbu77o851gbESfE=nZebXqfgE4g@mail.gmail.com
> >
> > The problem seems to be commit ffb1b4a41016 ("x86/unwind/orc: Add
> > 'signal' field to ORC metadata") but right now I don't know why.
>
> Ah, figured it out:
>
> $ tools/objtool/objtool --dump=orc vmlinux |grep signal:1 |wc -l
> 0
>
> The 'signal' bit isn't getting propagated from the unwind hints to the
> ORC entries :-(
>
> Will post a fix shortly.

Thanks for the quick fix!

Let's tell syzbot:

#syz fix: objtool: Fix ORC 'signal' propagation
