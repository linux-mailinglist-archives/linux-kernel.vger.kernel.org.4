Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00046B7C50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCMPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:46:31 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F335254
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:46:30 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id z128-20020a6bc986000000b0074d32ddcce7so6445902iof.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678722389;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgoMhRyS4hyS64tey/KhVVb7fuEqh7f4Mb+2Jzq1dUc=;
        b=FVqo10NiHbK2gYGV270NX8kc6LY69ihR8ilrHTtogbPZqeeOkD4sl1dkDEi65GsSUP
         +K3eSD9Sv2iytXoQD3drOR2UW8d0PAEqOQPbWCxnPDDU4NvHVQUVm9CsD/j3kyIr2cAI
         m7sjotXGCfdYUOXNDXZ3utLZGyDgbkfvF76NPcIzAV+s6Kdh3jgWOUphx6ZR9ixcr4u9
         r3Xnpy71z1BE21nxKWfXSZtgE+t8fZy4RqGC/GoqOO49txTKoONZijbEmQeq6K28Lsf1
         Ayy9EistYrP2l454znBtz+Vz3ej+CskzJGQbcPMgqIDVtcOtuQJCLW4pTQIeKKSc0ZLm
         0rQQ==
X-Gm-Message-State: AO0yUKWUSqZ6TG4T2jztoGqA4D7qiqyD421DgaIZCsywHCbI8po1+T7l
        mYUsHbaPUVewfh6MiLXXchqHyPOYWca3lRJopLPQ9ejGmbCW
X-Google-Smtp-Source: AK7set+k4OunDSeNLiPyZEP0lEmmuaLW/Yz3UNXT5kTDUNS6G5VJfGY0g1jZF7m7CEmt48VC4XB89prpXEUMeVPncNlgPF1B8Yga
MIME-Version: 1.0
X-Received: by 2002:a92:d384:0:b0:313:b6ee:2037 with SMTP id
 o4-20020a92d384000000b00313b6ee2037mr76188ilo.3.1678722389631; Mon, 13 Mar
 2023 08:46:29 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:46:29 -0700
In-Reply-To: <20230313143619.ljca56xjl4nsrm3b@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5ec8105f6ca0390@google.com>
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
 ath9k_regread+0x62/0x1c0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:239
 ath9k_hw_read_revisions drivers/net/wireless/ath/ath9k/hw.c:287 [inline]
 __ath9k_hw_init drivers/net/wireless/ath/ath9k/hw.c:572 [inline]
 ath9k_hw_init+0x5c4/0x2ba0 drivers/net/wireless/ath/ath9k/hw.c:700

CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 6.3.0-rc2-syzkaller-00010-g34add094f9de-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: events request_firmware_work_func
=====================================================


Tested on:

commit:         34add094 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1352768ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76a9330669c37355
dashboard link: https://syzkaller.appspot.com/bug?extid=df61b36319e045c00a08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f40c3ac80000

