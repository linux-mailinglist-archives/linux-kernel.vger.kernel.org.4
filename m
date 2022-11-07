Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361F661F123
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKGKsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKGKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:48:20 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6C19022
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:48:19 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z139-20020a6bc991000000b006dac0d359edso1584696iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HymTYv1Z6I3VvgCZ0iLRhqEFf+ukVe1UdjyszgmAxI=;
        b=FYemcglydKGEd9rkIn/NJuWA7rZXGz41KF/v2raagrBIvWGS3zLx/X9btNt1rSDu9b
         8g9IrVsyVufVymlvZg7TuL6symUYjxVyrQKP22z+tvuKGVLnylesPF4cefaZ4iOCvcnS
         PXcs0ITCfUYWBp31Tm/LSazqtlzVVIzWI+65Coqzuhmps0knHZwbjnA+ZNVNCfZYF3kn
         FgvSPD/aB7nDa2CxBcG2yh4P2MC+vAHIv/y50vgw3hBc85JKwHlHh9JIFurY6djyutVX
         dO7f8kAYmpGaXESHRHp9gTBGYw8fHRIiJTJFr5VWNBx1Goh0eAXbuHhCnpi4iShOvyx0
         h2QQ==
X-Gm-Message-State: ANoB5pnIUumXmAU+JgzwZKqSxZ12lyfm5WRg6u1edj70Yj+/xLWp+mqx
        KnXnfuesVH/hEu/wYJE66PaIbG2ImIGSf5LekTQfa0YGTRa9
X-Google-Smtp-Source: AA0mqf7r1E4MKid00wX0yDhGFAGS6Xo1k+8PsoDNvQMQNAUP6OuSDpJhigPiU3WHs+JavxGKKAry0mzKRG/vb8O76Qox/AZOd5qM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:302:c61:4c38 with SMTP id
 k5-20020a056e02156500b003020c614c38mr4401538ilu.76.1667818098935; Mon, 07 Nov
 2022 02:48:18 -0800 (PST)
Date:   Mon, 07 Nov 2022 02:48:18 -0800
In-Reply-To: <000000000000dc81b705a0af279c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000564bd705ecdf291f@google.com>
Subject: Re: [syzbot] WARNING in bpf_check (3)
From:   syzbot <syzbot+245129539c27fecf099a@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, memxor@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        shanavas@crystalwater.ae, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        trix@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 34dd3bad1a6f1dc7d18ee8dd53f1d31bffd2aee8
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Sep 2 21:10:47 2022 +0000

    bpf: Relax the requirement to use preallocated hash maps in tracing progs.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1232e176880000
start commit:   506357871c18 Merge tag 'spi-fix-v6.0-rc4' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b95a17a5bfb1521
dashboard link: https://syzkaller.appspot.com/bug?extid=245129539c27fecf099a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10940477080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177e8f43080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Relax the requirement to use preallocated hash maps in tracing progs.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
