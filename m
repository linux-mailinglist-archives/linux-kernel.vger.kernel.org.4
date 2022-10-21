Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81760745F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJUJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJUJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:27 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246805F8D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:44:22 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id u2-20020a056e021a4200b002f9ecfa353cso3080796ilv.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5C40danUNo+7aNgIAz6Hosjtwc2W348gvO5srm6Pqs=;
        b=KDchzuwmrFn44zHb0HFwqm2hlJbOxcNT5hrUQZFSqNut46zalX5QEuhe274MQ/BD+f
         d3fmN4TMXnPmWF//lGLcnUW8ULSqxdDZrPz6scS79ET5k2p4J8U7vDU9tCsu+zdax2/y
         vO3MZBalecFmXGShDymXXSeTjKVFlWPL/YZQ5EZvmusgkFJqgzEUhxF1hYrB7PcOSrih
         2nH4WWzOdvT2gmKxD1T1w/EcC3Wi2idXmGxc/+mc6djkYyz30fz+3zFTM2HFDyl0bKEi
         bsQ+94U+qSLR5nrUTy9TsjuE2/RFv7W1Jhnpx6vVH2rP11fO1w0Hr5mIdcrxPlPuV8dn
         Scsg==
X-Gm-Message-State: ACrzQf1KS7Pa0msxE9ryArABFPNKRCUedBewnFWrt6f6JHTu995Hpvxz
        FeL6+noW68PYxf5ByKwBQlCGJtKbWojj089aN3WadlcfPgge
X-Google-Smtp-Source: AMsMyM68D2ADq/uxHYPRGMWyD/0fEZiRgj2j2mgYEw93KfaOmQ4oqSdW9Kyqb3yVvO/ldjAJ3UlcmVvJpJK8OrgLRX/M8eVE7S6s
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:2fc:6aa7:edda with SMTP id
 m7-20020a056e021c2700b002fc6aa7eddamr12520425ilh.177.1666345461388; Fri, 21
 Oct 2022 02:44:21 -0700 (PDT)
Date:   Fri, 21 Oct 2022 02:44:21 -0700
In-Reply-To: <20221021092625.1602-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c9cf805eb88494c@google.com>
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
WARNING: CPU: 1 PID: 144 at fs/sysfs/group.c:278 sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:278
Modules linked in:

CPU: 1 PID: 144 Comm: kworker/1:2 Not tainted 6.1.0-rc1-syzkaller-00025-gaae703b02f92-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Workqueue: events request_firmware_work_func

RIP: 0010:sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:278
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 37 48 8b 33 48 c7 c7 80 bb ff 89 e8 86 43 4a 07 <0f> 0b eb 98 e8 61 b7 c9 ff e9 01 ff ff ff 48 89 df e8 54 b7 c9 ff
RSP: 0018:ffffc90002d8f9b8 EFLAGS: 00010282

RAX: 0000000000000000 RBX: ffffffff8a62c000 RCX: 0000000000000000
RDX: ffff88801b998000 RSI: ffffffff81620a28 RDI: fffff520005b1f29
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 63656a626f6b2072 R12: ffff88801bbc3008
R13: ffffffff8a62c5a0 R14: 0000000000000000 R15: ffff88801bbc3008
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f475bfad0b0 CR3: 000000007340b000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:837
 device_del+0x223/0xcb0 drivers/base/core.c:3684
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
console output: https://syzkaller.appspot.com/x/log.txt?x=145588b4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157a759a880000

