Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CD66611DC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjAGVuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 16:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGVuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:50:17 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF11EAD4
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 13:50:16 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id o16-20020a056602225000b006e032e361ccso2624750ioo.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 13:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6k+H6lhwQBNIKrh/bVF8+cjR/i/05AANvEicWqMt7Kk=;
        b=B22l6JKCJQE79/4wK0qj9bOq5LU9o83A7EhJWcq6CD41i7ClVOXpHkxDOwooq54wB/
         kpoRQw75riKwY5Sdrz/IfVG5UaPKPV3WMuv3GYpbQLJlrjE1dWncf8tdAnhQruRMWgrO
         fMmq7iusyx0ne7M+qzJ37GVZQzDGClMZu7DO5Vd1CrOPYMVLd0xxpcexBJ8p4HtGZ1Hu
         5DDMC+gfILfDdamoe+gyhkJinIG4N6JoW5lkqKtCs+3NQxgpTLUC7yVMG1ti5zH836vv
         O75kPSH5zJ5SghIiJXGUrSP5homjjbkYqrABFkxxfKPy06p2/WjfRShFGdgeelDBt5Rn
         o7oQ==
X-Gm-Message-State: AFqh2kpM6ouNbGzBI1iVUldhix2EzH4oVpiG5JJyWpZnsFAfIHqJjZuo
        dwABPwkqHJLir1rpgcW2ikG8CX9Yy54GwEcYqJbu1LpZU4Ux
X-Google-Smtp-Source: AMrXdXt1YpgWIytNhVMXcFWTVWTPXUC9kyNS+ULIT/oAYW8rhwrRJ9ibX2IfGy1HUaj1A3IDB0Q0xXVgrVO+0RUqulWfMP/MF3Se
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349c:b0:30c:5345:1b6c with SMTP id
 bp28-20020a056e02349c00b0030c53451b6cmr2426410ilb.76.1673128216206; Sat, 07
 Jan 2023 13:50:16 -0800 (PST)
Date:   Sat, 07 Jan 2023 13:50:16 -0800
In-Reply-To: <20230107132243.5042-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fda2c405f1b38462@google.com>
Subject: Re: [syzbot] KASAN: wild-memory-access Read in io_wq_worker_running
From:   syzbot <syzbot+d56ec896af3637bdb7e4@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5521 } 2676 jiffies s: 2809 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         9b43a525 Merge tag 'nfs-for-6.2-2' of git://git.linux-..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13fe4f24480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff5cf657dd0e7643
dashboard link: https://syzkaller.appspot.com/bug?extid=d56ec896af3637bdb7e4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1249e6d6480000

