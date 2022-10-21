Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D3607107
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJUH3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUH3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:29:30 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA97109D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:29:22 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h10-20020a056e021d8a00b002f99580de6cso2673806ila.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLA+3r1xvit5y4rTCYybHB9QAIyOJ+gwRMGprsn2C5E=;
        b=ug1FOwGn+u5gJT+hB7LqRxEMVJNRMnQMzkNz3TaTjTOjSTHGrme7pbDG8YlC12sGIq
         oc0FAdj0ivEqXSDdy0j7qKP+jGByPPbleTCG72x8j7QXodXE4ChOq/gOl15nLkDsxLUi
         rped+PUE8fbyRqLTCmZxCcRegA6LOHPItacA3XAfl74ATcAPuGsvFlowxuSoN19i3dCx
         qPGldmwLVyXNxv5dUtgVvtRN/2nEIsQiEyg6dGpLoY91MaDy0MeR8tmtTTPIyLsBiFwq
         TjGUizxa9rqsoffhIv28IkDXbSoW6X9hURfDY1JPhIX84PYvtzp4Dv4DMTkU7IlElqFV
         u9FQ==
X-Gm-Message-State: ACrzQf1d8xOzI8Qtv/4dMDr4T9y09KQpJqmWWz3uxKindxcV3aZ8XPSK
        c4IGBcmJzH/s879aqNINlUfwyEK7iBlzoF1QsIAxjgYY55OM
X-Google-Smtp-Source: AMsMyM6ivYKPBMcMEjqUIvx4HsIOvlIl8UZbuuO9s8ADyQdCJ1GS2A/VUyLYAIDvnbl0pe9J/jXdI3/IAZUyEUy4mk6QG+nHzlnv
MIME-Version: 1.0
X-Received: by 2002:a02:cf33:0:b0:363:ed19:3a27 with SMTP id
 s19-20020a02cf33000000b00363ed193a27mr14384907jar.179.1666337361921; Fri, 21
 Oct 2022 00:29:21 -0700 (PDT)
Date:   Fri, 21 Oct 2022 00:29:21 -0700
In-Reply-To: <20221021071306.1535-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000888afd05eb86663d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
 (2)
From:   syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in firmware_fallback_sysfs

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'ueagle-atm!eagleI.fw'
WARNING: CPU: 1 PID: 4102 at fs/sysfs/group.c:278 sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:278
Modules linked in:

CPU: 1 PID: 4102 Comm: kworker/1:5 Not tainted 6.1.0-rc1-syzkaller-00025-gaae703b02f92-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Workqueue: events request_firmware_work_func

RIP: 0010:sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:278
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 37 48 8b 33 48 c7 c7 80 bb ff 89 e8 86 43 4a 07 <0f> 0b eb 98 e8 61 b7 c9 ff e9 01 ff ff ff 48 89 df e8 54 b7 c9 ff
RSP: 0018:ffffc90009d479b8 EFLAGS: 00010282

RAX: 0000000000000000 RBX: ffffffff8a62c000 RCX: 0000000000000000
RDX: ffff888024043a80 RSI: ffffffff81620a28 RDI: fffff520013a8f29
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 63656a626f6b2072 R12: ffff88823bdf8808
R13: ffffffff8a62c5a0 R14: 0000000000000000 R15: ffff88823bdf8808
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc1febad0b0 CR3: 00000000747ce000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:837
 device_del+0x20b/0xc80 drivers/base/core.c:3681
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:120 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0x5b7/0xba0 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xbca/0x1190 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


Tested on:

commit:         aae703b0 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f4dd0c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136e3036880000

