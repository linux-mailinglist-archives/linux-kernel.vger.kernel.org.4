Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FF61A4E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKDWwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKDWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:52:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54A4E426
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:50:23 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so4751168ila.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQUV465XYKy6BEOy3Swc3M1CyT3Q1DkqUbMYNjsBM7w=;
        b=hx/aM3ISVNGkssGiZtC8lWGS/5SysCYUwbYKfpu+Ee+xKKhSiM7wg+QFLWZWB1RL0d
         qmKjDx5uwr0fu0r6BiiM1WrFU64G63y97kQV2FGXPWov+54zPJKDtnqYYFYVk0kZ+9BE
         F/D2P8UH1d9yRdOlAFFzNmNkM5aYBKPVlt/tvF7DNgKJbXKli8cPpGFGAOJP6R5ij+gH
         tP5YXyO91Em/kZvrYc4wR8TdTPweqcJ7DYUeyxovGnBxmumYJClt++y1Ogm/LhORLSFr
         xKStiTmOlG2+SJA1D5dAG9ZWTqIx8bEb2e41+okh76wW3d0T+m7/JOkj6Cssv1/Xg2uL
         gs1w==
X-Gm-Message-State: ACrzQf3WplLiJQgjwuUsF4bZC/TDWtLFf/6aqiQ4Td8f9BqktxB1B/rm
        Euej3L4UvvmbmHKDfIgNJbL34dFaJTTZcEMqXuA/CBbxuVBY
X-Google-Smtp-Source: AMsMyM5nTnIogJYJ095mPEs92Yep38gpfi+2iOs4VSUyK/pRUwAakFTI8laAK2zkHMNKd64/tVLlrFqFcjq22AiZc4BVcdLyhALO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2107:b0:375:ddb:54c0 with SMTP id
 n7-20020a056638210700b003750ddb54c0mr21194896jaj.244.1667602223078; Fri, 04
 Nov 2022 15:50:23 -0700 (PDT)
Date:   Fri, 04 Nov 2022 15:50:23 -0700
In-Reply-To: <0000000000009da4c705dcb87735@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002227cf05ecace68c@google.com>
Subject: Re: [syzbot] WARNING in check_map_prog_compatibility
From:   syzbot <syzbot+e3f8d4df1e1981a97abb@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, memxor@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1599d319880000
start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b664fba5e66c4bf
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f8d4df1e1981a97abb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165415a7080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1716f705080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Relax the requirement to use preallocated hash maps in tracing progs.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
