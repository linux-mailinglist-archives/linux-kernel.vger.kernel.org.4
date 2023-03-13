Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF076B75DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCMLWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMLWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:22:33 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E03BD81
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:22:31 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b3-20020a056e02048300b003230de63373so982280ils.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706551;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXxKUFHOABMwg/pm9bVq4/AD5g/Yv6jSaASzzcsUeCA=;
        b=x+bJCKnTNt+GbCuPGJibgr+MJUFnde8QCyVBM569lgDtQYXJ25G07OvKLx1ddNMD8o
         rPCiYvqEL3s1dJaEvthZNFYZnP/VTRxyMxk3z28WUM6/9QEqKVGTalaZ19EA1sJdM6NQ
         pgErvphikuVjHi1pEVvCsR1nBlL4d2KS3I3xfwSUWzY8Xp+Kz8syQYrxHrXUFZ3NYPKs
         0sNGjEhR0G6d87W0dyp8nDfB7ddJcWMCjNOyE20sswjKWt6Zig2jW70BR5EpM5uob1ak
         mp9EHJAVJ3XEiVPjd4u3T9RfBKw3+1LsU/nGzZ5l1i3JGnD/nEd9vkEXLMhx6saxjk4O
         J+4w==
X-Gm-Message-State: AO0yUKX2zFJBItE0Hmk/Urs0raXCZ7A0HmX+g+57PcFsmYOsVgwV6n7b
        LZPPgQCUNqUEVhlq3IqnKGb4PTm68NQ/KgjSRt/717jKcymM
X-Google-Smtp-Source: AK7set9fspho1dI9dmruwQcHMyeQn1ibTqF+dWZ0xHVXN9rJPFyOW8ytPt8Baob1vJWhuFArFtyWod8Zkx0LVJ9jojhYASQzlSit
MIME-Version: 1.0
X-Received: by 2002:a02:7315:0:b0:3c5:15ee:9eca with SMTP id
 y21-20020a027315000000b003c515ee9ecamr16743917jab.4.1678706551257; Mon, 13
 Mar 2023 04:22:31 -0700 (PDT)
Date:   Mon, 13 Mar 2023 04:22:31 -0700
In-Reply-To: <20230313110256.driiufx5edha7xhh@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab850605f6c65394@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
From:   syzbot <syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        pchelkin@ispras.ru, syzkaller-bugs@googlegroups.com
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
KMSAN: uninit-value in ath9k_hw_init

ath9k_htc 2-1:1.0: ath9k_htc: HTC initialized with 33 credits
=====================================================
BUG: KMSAN: uninit-value in ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:289 [inline]
BUG: KMSAN: uninit-value in __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
BUG: KMSAN: uninit-value in ath9k_hw_init+0x119e/0x2ba0 drivers/net/wireless/ath/ath9k/hw.c:700
 ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:289 [inline]
 __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
 ath9k_hw_init+0x119e/0x2ba0 drivers/net/wireless/ath/ath9k/hw.c:700
 ath9k_init_priv drivers/net/wireless/ath/ath9k/htc_drv_init.c:662 [inline]
 ath9k_init_device drivers/net/wireless/ath/ath9k/htc_drv_init.c:839 [inline]
 ath9k_htc_probe_device+0xf48/0x3b60 drivers/net/wireless/ath/ath9k/htc_drv_init.c:963
 ath9k_htc_hw_init+0x4f/0x100 drivers/net/wireless/ath/ath9k/htc_hst.c:523
 ath9k_hif_usb_firmware_cb+0x2eb/0x800 drivers/net/wireless/ath/ath9k/hif_usb.c:1256
 request_firmware_work_func+0x130/0x240 drivers/base/firmware_loader/main.c:1107
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2390
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2537
 kthread+0x31f/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Local variable val created at:
 ath9k_regread+0x62/0x1b0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:239
 ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:287 [inline]
 __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
 ath9k_hw_init+0x5c4/0x2ba0 drivers/net/wireless/ath/ath9k/hw.c:700

CPU: 1 PID: 5056 Comm: kworker/1:3 Not tainted 6.3.0-rc1-syzkaller-00010-ge61893130d87-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: events request_firmware_work_func
=====================================================


Tested on:

commit:         e6189313 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17107072c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef8f90a9dd9b8eae
dashboard link: https://syzkaller.appspot.com/bug?extid=df61b36319e045c00a08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16cb811ac80000

