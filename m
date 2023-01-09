Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A9B662DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjAIR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjAIR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:58:43 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F53C3B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:56:18 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id z8-20020a056e02088800b0030c247efc7dso6564860ils.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ppmVtulyeyyJUenOxxEN7joUogVk28fABWLQtu+Zrk=;
        b=yRwJwZ6F7qRKZ2e/qE0yq73Bg6ytYpMw6LQmXEMAuu7jGleDKuIOU81Of24+1QOZO1
         pg114p2+ZSsts1//gs3xXNuPyv4+CR3hHMccc/7H1AxgB1DKUxcPl3/gU7ROwU/VrfC8
         u6s+JISvx7Bw2dCAMPBHJWvdFtcUSqH1R2bB/7pq1PIW3a3R7H/VqaMzflzu9iMwYYgc
         pbTvtrjkii9lsH8TQ30Lvx4QrV9HWwX3r0iRCayDHS0VPXwQYOkkWjNpB1IqeLpNjFbp
         dxsq2kiaTW4XPr4CrID3TMxPObtXOU4/HbRWwJKMninySBlki2M9Kacy3DaB8jRN25Gp
         Dq0Q==
X-Gm-Message-State: AFqh2kpR+Qc1WIq9VE53vAdDTUSobxKr7vs/4ANEO8vP3vU5TFMccfuA
        AmwXWIwg8QeFwbohwJ247VMYXO8Kn9Xle1HOKHZL8FeExE09
X-Google-Smtp-Source: AMrXdXuYn5bcOBvwGt+nMca2O36qYU0o+TCzNmgGZL6gmSSi0E53OgM5oym9IOF7D3MqME8LX2I4TvnlzFCiQxD1N4jO3YQ7Yu+Y
MIME-Version: 1.0
X-Received: by 2002:a02:a513:0:b0:38a:1e93:c32f with SMTP id
 e19-20020a02a513000000b0038a1e93c32fmr4554759jam.212.1673286978314; Mon, 09
 Jan 2023 09:56:18 -0800 (PST)
Date:   Mon, 09 Jan 2023 09:56:18 -0800
In-Reply-To: <000000000000f0fb6005f1cfc17f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f328e405f1d87b38@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_wq_worker_wake
From:   syzbot <syzbot+b3ba2408ce0c74bb9230@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit af82425c6a2d2f347c79b63ce74fca6dc6be157f
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Jan 2 23:49:46 2023 +0000

    io_uring/io-wq: free worker if task_work creation is canceled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12cda5d2480000
start commit:   1fe4fd6f5cad Merge tag 'xfs-6.2-fixes-2' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11cda5d2480000
console output: https://syzkaller.appspot.com/x/log.txt?x=16cda5d2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b79b14037065d92
dashboard link: https://syzkaller.appspot.com/bug?extid=b3ba2408ce0c74bb9230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1388e5f2480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127f1aa4480000

Reported-by: syzbot+b3ba2408ce0c74bb9230@syzkaller.appspotmail.com
Fixes: af82425c6a2d ("io_uring/io-wq: free worker if task_work creation is canceled")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
