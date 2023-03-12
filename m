Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E151A6B6B22
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCLUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCLUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:41:25 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3277D36444
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:41:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id t2-20020a922c02000000b003230219cf1eso1069201ile.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e16q7Pec4NoczsUqyQiywgB/gDgFOxGt1xv1NL41NUU=;
        b=0Q2mgWXwm69jvx7cMbvXfNCaJ+BxOyzYo6/Yg3+vIvg90Voh16gTYMw8Q8KgR1UtY3
         zwTnvMebCA0ZcdxkJUk+YBflu9zl+eB0uYGTS9pRSU3b0Z6Vld9rjYSTLXsCx93keRpz
         zKA2ija5kMMiSLLxMgmNRZgkj5ml4ZodcxpT2Zn93fgSICf+vNaC8b000XgizcLf0yiy
         aLYY1w7ELG5IqyAxMnV48FrV0WR10tDyPEhVpp50i5DBp4K9aMNh03AcByRmLDgS9nLb
         xQkrHJucKlAk8MS+sgUa05zcdNKdy6LmDSLg9Xhh/dpE1XeAQhdVQIreLGr2ZGjFUaXc
         4dEw==
X-Gm-Message-State: AO0yUKXBHi7MKwkRWS+is8xlhwlb7/MN/+tvNLgc998DXxQJ2FdJxKth
        QAvxl5cxRmlC7ptkeVIxSjyn9iW/ZnjNT+URUECPqwhqRRct
X-Google-Smtp-Source: AK7set9d8h5mRbFqs99i//BjL+cfQofE16ThAde+4LfLDIw8AJO53VqKI87+NtQtTYIAWbnOrtCEIOqtWvQaXwuqkbtGYIp29mhP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10e5:b0:402:aa02:6a6b with SMTP id
 g5-20020a05663810e500b00402aa026a6bmr976633jae.6.1678653683487; Sun, 12 Mar
 2023 13:41:23 -0700 (PDT)
Date:   Sun, 12 Mar 2023 13:41:23 -0700
In-Reply-To: <20230312202027.46brae36wrbypwge@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081589c05f6ba0468@google.com>
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

ath9k_htc 3-1:1.0: ath9k_htc: HTC initialized with 33 credits
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

CPU: 0 PID: 5569 Comm: kworker/0:4 Not tainted 6.3.0-rc1-syzkaller-00010-ge61893130d87-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: events request_firmware_work_func
=====================================================


Tested on:

commit:         e6189313 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1508f12ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef8f90a9dd9b8eae
dashboard link: https://syzkaller.appspot.com/bug?extid=df61b36319e045c00a08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10cabf24c80000

