Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6674BB47
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjGHCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGHCIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:08:23 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E01FD7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:08:21 -0700 (PDT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-66870a96b89so3222061b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 19:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688782101; x=1691374101;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRBoWvpxhXAi0Qo88lNcuZSLNUPMf0crD4g2r6lXdXA=;
        b=d/Ud2xgFZLK38fdbvQIC+IM7gYrfuHrTQOJaLeAa99Odi40hKjweXTsF/5SftEzIJK
         Q1098NWsSV02GgBa8IlTwl7DKYCN9ZL6fu9kJUEKnN9rxA7qiKxtyk30c53mgB6sdm2X
         VL4sibNJ2JUqi0l0JQnYIAY1CHQbOYQjepLJDcQzPOgeaxOgaxTKKjN1hQwRcRq3p9W5
         r4hT+oyULVwSuFy+8u/bJ71EHlcnJL3QovBPKnc8Dx5sSbJWKMzyxPt/GGBbpn8tuwYv
         nuaNbon/5VyN9ZbpJTbDaeKMpCJ/6kBTLtuM8OgzbC4TxkO9r7zK/MuBhuHh3iRa4iD0
         sWJw==
X-Gm-Message-State: ABy/qLZIRmGWa3Z4RLFQBCPIfpYf5Q3UuYv3Q/yzaTrqy3NlFQYDgR2V
        bMUSOvSIspyqS3/Qs+qYRATBOTX6hViH2wQ3WS1VEdkMyll4
X-Google-Smtp-Source: APBJJlFBCW/mmRlrFZdex3D/lxUEoJrrFD/yiLhce6sDC2W058BtJKbtH7A/4fmFbUa626lAyJE0pTUBGtDPcvUp4tUQCE3FlCwd
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:39a5:b0:67e:86c0:6bd3 with SMTP id
 fi37-20020a056a0039a500b0067e86c06bd3mr9555888pfb.1.1688782100770; Fri, 07
 Jul 2023 19:08:20 -0700 (PDT)
Date:   Fri, 07 Jul 2023 19:08:20 -0700
In-Reply-To: <20230708015442.1300-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038353d05fff0390d@google.com>
Subject: Re: [syzbot] [media?] [usb?] WARNING in smsusb_start_streaming
From:   syzbot <syzbot+a7c205f9c1168e2f1dcc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in smsusb_term_device

smsusb:smsusb_probe: board id=7, interface number 55
smsusb:smsusb_probe: board id=7, interface number 147
smsusb:smsusb_probe: board id=7, interface number 0
smsusb:siano_media_device_register: media controller created
smsusb:smsusb_start_streaming: smsusb_submit_urb(...) failed
smsusb:smsusb_init_device: smsusb_start_streaming(...) failed
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2029 at kernel/workqueue.c:3379 __flush_work+0x946/0xb60 kernel/workqueue.c:3379
Modules linked in:
CPU: 0 PID: 2029 Comm: kworker/0:3 Not tainted 6.4.0-syzkaller-11478-gd528014517f2-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:__flush_work+0x946/0xb60 kernel/workqueue.c:3379
Code: 00 48 c7 c6 2b 36 54 81 48 c7 c7 00 27 9a 8c e8 c0 09 12 00 e9 6f fc ff ff e8 16 a9 30 00 0f 0b e9 63 fc ff ff e8 0a a9 30 00 <0f> 0b 45 31 ed e9 54 fc ff ff e8 6b d8 83 00 e9 3e fb ff ff e8 f1
RSP: 0018:ffffc9000797ec08 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801b5d20e8 RCX: 0000000000000000
RDX: ffff888024503b80 RSI: ffffffff81543666 RDI: 0000000000000001
RBP: ffffc9000797eda0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000005 R12: ffff88801b5d20e8
R13: 0000000000000001 R14: 0000000000000001 R15: ffff88801b5d2100
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff765634a8 CR3: 0000000018f20000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3473
 __smsusb_stop_streaming drivers/media/usb/siano/smsusb.c:182 [inline]
 smsusb_stop_streaming drivers/media/usb/siano/smsusb.c:193 [inline]
 smsusb_term_device+0xee/0x300 drivers/media/usb/siano/smsusb.c:349
 smsusb_init_device+0xadc/0xd20 drivers/media/usb/siano/smsusb.c:484
 smsusb_probe+0x5b9/0x10b0 drivers/media/usb/siano/smsusb.c:572
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:956
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_set_configuration+0x1196/0x1bc0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:956
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2590
 hub_port_connect drivers/usb/core/hub.c:5422 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 port_event drivers/usb/core/hub.c:5726 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5808
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


Tested on:

commit:         d5280145 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1769c3aca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=a7c205f9c1168e2f1dcc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169e9ca8a80000

