Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA46566F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 04:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiL0DBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 22:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0DBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 22:01:20 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F611EE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:01:15 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso8012691ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 19:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7ulOfjm9DCk3UwPYZwJhK1jc5u84FUbYu/LfJnq/AA=;
        b=EIcjKodGF0RUpjfQHQk56hQ/H9D3ZqRCi0FkWBljGwxgo6BBO+V44w5AY7k/sZVkOz
         pDcUwm/nDVaKca/KAnVY3hXiMP49DfCl0z/8cD6b2M5YBAcbP/y2CV9zYSncdJp5B+U9
         O4lhFNpXRHRZz0SjPA/GRDYfxf56j5ga9NGpey1hbVZNkMq5Q/te5D1I/sviMbc9Ws3g
         SvkC8HEwShpczVx7ksjrvMIJi4wHhRUihIm951cchmXLGXcfNiBhoRXt6llzHcNI8eYd
         L65p3vu2jsl3IS73hhPLMsrLszsMLqjtym1h/Q5Ov764DB0tlq8p2t6pBkLgpqjqMbZW
         rHmQ==
X-Gm-Message-State: AFqh2kp2ZTzUdk6mWus1htZlMf3fp3KzCjCIoAHrX4vqTf3c+XY7GM/c
        dSTlnjOtLyjIOWjMAhxbRwVqFrioH3cSEfjYZkgno2rTh7yB
X-Google-Smtp-Source: AMrXdXsgBsexqP8LlU5y2eOwUzbmCelU/z/iqmHj5VwsDVxswPP3XgY9I8isiYNiBv7Xfm+D55ToGt5XHV3EuaLk9cl0p1vfSi79
MIME-Version: 1.0
X-Received: by 2002:a02:b1cd:0:b0:38a:7518:fb66 with SMTP id
 u13-20020a02b1cd000000b0038a7518fb66mr1559232jah.253.1672110074845; Mon, 26
 Dec 2022 19:01:14 -0800 (PST)
Date:   Mon, 26 Dec 2022 19:01:14 -0800
In-Reply-To: <20221227005014.2528-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009646f05f0c67747@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in
 __lock_acquire (5)
From:   syzbot <syzbot+0bc4c0668351ce1cab8f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P3563 } 2660 jiffies s: 2105 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         a5541c08 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=109b22a8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc4c0668351ce1cab8f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c2eba8480000

