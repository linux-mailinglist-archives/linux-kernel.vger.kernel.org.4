Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9568A65CD0E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjADG1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjADG1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:27:14 -0500
Received: from mail-il1-x145.google.com (mail-il1-x145.google.com [IPv6:2607:f8b0:4864:20::145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B71519C3D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:26:24 -0800 (PST)
Received: by mail-il1-x145.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so20581722ili.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 22:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPXQ+JT8y7Oy9kiSQ2Hk6loKbj3gnxbxJCYs2Zsnc/Q=;
        b=7vyFHEL1weG7RRScbyGVd9tjjTYysVKDF+tN3fWxsfRuU7vxhEDdNrx9uLhHdYXyDy
         5AWP/Ce78i+U3wXxyLZ/sbPWMC/XJcnNbHMr2zXYjkbL5McSvR6pvxBWtaW0/SW/IOnd
         0c+AOgvY6LI9ssEUqxqBqRRmqmnZF7Ky70Z1NnGBdhgQrAzG2KddAtGL+A+E17A//j/+
         qYtTqQSHtZXIivtEFYcSqwfrw78PbWvCYGXZdUX4xo7LS9TmZPHA3ss5zY1YktFwb4Ck
         vvc6CxuwGlSThBCAMZOBKenj1awPsCHiCG108rqERlq+KJgEGgpF5OPyOWXEJhINnVP9
         W4tg==
X-Gm-Message-State: AFqh2kqCbA8XBpQNuDI4DK5666XGlYKvj59Jk0MybQZB1CZgXLTzWJ5b
        nhpy5LRsTpZnEcMIcE5RpqOv+pq/3IxpX0hkPSek9W0gZGBN
X-Google-Smtp-Source: AMrXdXt3nPyc+EJ2585XP9CQHqISVPTiI/GmusdOlsK95rKhemXncIf1Gk6Bp9qJ3nqHvYyXP1DRKkFCEhl8PskhLU8CFd4FLE4p
MIME-Version: 1.0
X-Received: by 2002:a02:8788:0:b0:38a:49b8:bc49 with SMTP id
 t8-20020a028788000000b0038a49b8bc49mr3734672jai.66.1672813521702; Tue, 03 Jan
 2023 22:25:21 -0800 (PST)
Date:   Tue, 03 Jan 2023 22:25:21 -0800
In-Reply-To: <20230104003141.3986-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc96d105f16a3fdc@google.com>
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in reiserfs_sync_fs
From:   syzbot <syzbot+4dadbee41d087d9c6234@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5544 } 2644 jiffies s: 2781 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         69b41ac8 Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=178087b2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=4dadbee41d087d9c6234
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fd1f84480000

