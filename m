Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0486533C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiLUQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLUQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:10:31 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23D321E07
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:10:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so10346474ilj.14
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=la4vkjbmp/hoBiwyPidnlDXslDjnZqNzD4iiQiAwR94=;
        b=RzMSnvr5LmhCL3DhUWc77Jaxfmnjswtw1e0TL6Gkp6AjG1tHBRyspb8Fs05Kc9Mx64
         7IjeDbIzXRYLp79ImmSt2zkdAHDNIVS+DUJlb3e1FwcTDO6qlbvrHMSH7vukJWXze2IV
         tgKEZwjGcPCUiWFYLgJV8SS6a4X78Cp25n4kzqhqn5R60chrIt4Bv/hH56EVogppnkzs
         0sOb/MN9mxh6aOdn5UhSJOwMaBS6GxbuinL2qFOKcmnyd92yA9D2RVgcjeOaxlGLIuXV
         B9KbQDIIzuiLCdxIUHpLuH7+pdV2+WQpeB9vHKhIx91vjMqUEgGGTKGD6ztUO5vRI+Ac
         Ojqw==
X-Gm-Message-State: AFqh2kq9mgubQdCceQUURvOY9T27TyomM7nUn26bicLsuwQMu5xKPhMB
        D1BtZZgay/0HuYo8vaZM9dQQkxKWf/KOAup9ZKI5rQk/Zjg2
X-Google-Smtp-Source: AMrXdXvTaIHDV02F+gBN/7BxU/Jg7ssMmiZ9326P326GYCmN7SMnumn5KR5+R2sxh6DqFQF8gNFqXa0r5U+3Zef+PScetgItthKv
MIME-Version: 1.0
X-Received: by 2002:a92:d602:0:b0:30b:dae5:c56 with SMTP id
 w2-20020a92d602000000b0030bdae50c56mr101654ilm.99.1671639029041; Wed, 21 Dec
 2022 08:10:29 -0800 (PST)
Date:   Wed, 21 Dec 2022 08:10:29 -0800
In-Reply-To: <7c89b1c8-f012-3965-ab77-3bc19b3cedaa@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084d53b05f058cabc@google.com>
Subject: Re: [syzbot] WARNING in io_sync_cancel
From:   syzbot <syzbot+7df055631cd1be4586fd@syzkaller.appspotmail.com>
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5778 } 2634 jiffies s: 2893 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         071531e9 io_uring/cancel: mark task running before re-..
git tree:       git://git.kernel.dk/linux.git io_uring-6.2
console output: https://syzkaller.appspot.com/x/log.txt?x=13042ae8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2edd87fe5cbdf43f
dashboard link: https://syzkaller.appspot.com/bug?extid=7df055631cd1be4586fd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
