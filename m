Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD956F3838
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjEATi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjEAThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:37:54 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B2F30D1
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:37:24 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32948b8cb25so45535735ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969844; x=1685561844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lL9+eqzTbFpszMPAGwdcjGQPxkrmAwjR3imb9BQU1Bw=;
        b=lDdmsUegX31BeF9qgdxQp+miD87e0bxwKqL4p4AelhC3x35r5EvwYr9CaAouRSPHW7
         H8wip4/vR2vavPO+vULzW8cLLGPj7KDKoR+Jr77SlY3KRMY2oY+4o826o94Uw+eUa8BY
         6wtGSbFcTCGVIiTf1U7aYa9/cgFL7YZEC5ilD/unnejLVbrOZ88suPde1vkTI4cX+GNi
         uOMaowWJcGzelDc2v9Vlyz4by5q6K9TFSUzHtaiUwaVqAk5ZT2godfNTMRXfSohC//h9
         pOvRYQWc5kCCr9NBrJMMZe7qWfTul5nONWV5xx05yr5n+BKaTYgK+Jj103fhgckJFrAj
         p9xQ==
X-Gm-Message-State: AC+VfDysv/UQdh3lZMUoTrIXtkz5mxBWbEt2qDg9wnRsyj8cHlr+J9yj
        VdMu1PEgOlKw4Mtp3SWqI0hw2zNoduSBwZqle2UEk5ZVfUn3
X-Google-Smtp-Source: ACHHUZ4NBYTE8DBwA4VTr98R6VfDE0D0c+ThHQpBTEHd9wAKkzWpbjKXrNp1F+aBCSrkvxfFNE01C+4tYUJkYCQsymPazlo6gNRb
MIME-Version: 1.0
X-Received: by 2002:a92:cf42:0:b0:32b:7087:5bc1 with SMTP id
 c2-20020a92cf42000000b0032b70875bc1mr7937628ilr.2.1682969844210; Mon, 01 May
 2023 12:37:24 -0700 (PDT)
Date:   Mon, 01 May 2023 12:37:24 -0700
In-Reply-To: <ba18f241-72ef-4d10-acaf-5fc34edbd695@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb868005faa6f31a@google.com>
Subject: Re: [syzbot] [usb?] memory leak in class_create
From:   syzbot <syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in class_create

BUG: memory leak
unreferenced object 0xffff88810a6af480 (size 96):
  comm "kworker/0:2", pid 1755, jiffies 4294944661 (age 9.520s)
  hex dump (first 32 bytes):
    c7 03 9b 85 ff ff ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81544e14>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff82b65445>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b65445>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff82b65445>] class_create+0x25/0x90 drivers/base/class.c:261
    [<ffffffff831f7a9b>] init_usb_class drivers/usb/core/file.c:91 [inline]
    [<ffffffff831f7a9b>] usb_register_dev+0x2ab/0x3e0 drivers/usb/core/file.c:179
    [<ffffffff832cfff4>] usblp_probe+0x4e4/0x750 drivers/usb/class/usblp.c:1208
    [<ffffffff831f39a9>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82b62d7d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82b62d7d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82b63141>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:800
    [<ffffffff82b6324a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82b6343b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:958
    [<ffffffff82b60191>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82b63962>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1030
    [<ffffffff82b618fa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b5def3>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff831f0a89>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff832033d1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238
    [<ffffffff831f3080>] usb_probe_device+0x60/0x140 drivers/usb/core/driver.c:293

BUG: memory leak
unreferenced object 0xffff888114088c00 (size 512):
  comm "kworker/0:2", pid 1755, jiffies 4294944661 (age 9.520s)
  hex dump (first 32 bytes):
    00 8c 08 14 81 88 ff ff 00 8c 08 14 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 c7 03 9b 85 ff ff ff ff  ................
  backtrace:
    [<ffffffff81544e14>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff82b65308>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b65308>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff82b65308>] class_register+0x28/0x140 drivers/base/class.c:186
    [<ffffffff82b65467>] class_create+0x47/0x90 drivers/base/class.c:270
    [<ffffffff831f7a9b>] init_usb_class drivers/usb/core/file.c:91 [inline]
    [<ffffffff831f7a9b>] usb_register_dev+0x2ab/0x3e0 drivers/usb/core/file.c:179
    [<ffffffff832cfff4>] usblp_probe+0x4e4/0x750 drivers/usb/class/usblp.c:1208
    [<ffffffff831f39a9>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82b62d7d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82b62d7d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82b63141>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:800
    [<ffffffff82b6324a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82b6343b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:958
    [<ffffffff82b60191>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82b63962>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1030
    [<ffffffff82b618fa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b5def3>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff831f0a89>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff832033d1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238



Tested on:

commit:         22b8cc3e Merge tag 'x86_mm_for_6.4' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=14569d94280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5046ebeca744dd40
dashboard link: https://syzkaller.appspot.com/bug?extid=e7afd76ad060fa0d2605
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138259d7c80000

