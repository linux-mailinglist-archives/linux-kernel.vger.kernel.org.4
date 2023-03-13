Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332756B83B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCMVIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCMVIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:08:22 -0400
Received: from mail-il1-x146.google.com (mail-il1-x146.google.com [IPv6:2607:f8b0:4864:20::146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2783E8E3CF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:07:33 -0700 (PDT)
Received: by mail-il1-x146.google.com with SMTP id k13-20020a056e021a8d00b0031bae68b383so7223060ilv.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYS6Iu4hHFrTUlHj/j1E//vcMrDFbW8TckKBUMoFx8k=;
        b=1SN4HttJzIgHAKYGYOgjCddNsK3sG/KYCdtqehVifvw6LJgUvjcVvfPKd0gJjbu2X5
         ij/m+yxuWc/4zEBQAqGQ5IwTAHESVVcUXMcCvn6ioRjM+o0B0WEuvHsSViY00Yl0QTq/
         sN60tNSlV3BdcUOqSdsx5I7gBKJvfKUWsFgEWGXwyYoF86kDUl71Bw8WvvsNHVFplqHw
         ZbEqrILESRbF646Y6t6Bsd2XpkEo6QlXPAg19RU42z///PlZUpeKxHnrHw7na+OyeCod
         WMfGrzFpohtT/hwaGNw8IOXHskgjOxOPAESd7Fw0oIs0R6WnNwD864DORaPOFBt/ZzQf
         2IdA==
X-Gm-Message-State: AO0yUKU71Ef8XOFgVeicP37uINuVrSzKc8vMBisQGYFmHfXN/pHGXg5p
        LnE6QGeeiWUoDAtX47JG7IyEbtcYEiuCsILcBWA5h0zyJEAe
X-Google-Smtp-Source: AK7set9K6KIJTDvUPF8mXjQ8G/iflr0t2FEkcMa2ufvRIaaa7/BRgaAsfIi0BFQO/kVVDuMuxY5GMHH2m8HsxlUHCUNNRVYcGURu
MIME-Version: 1.0
X-Received: by 2002:a92:c14b:0:b0:316:f0d7:8db with SMTP id
 b11-20020a92c14b000000b00316f0d708dbmr502554ilh.5.1678741522792; Mon, 13 Mar
 2023 14:05:22 -0700 (PDT)
Date:   Mon, 13 Mar 2023 14:05:22 -0700
In-Reply-To: <20230313204732.zjcmd3ruvzw3bljo@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022c8b705f6ce78a3@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
From:   syzbot <syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        pchelkin@ispras.ru, syzkaller-bugs@googlegroups.com
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

CPU: 1 PID: 5549 Comm: kworker/1:5 Not tainted 6.3.0-rc2-syzkaller-00010-g34add094f9de-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: events request_firmware_work_func
=====================================================


Tested on:

commit:         34add094 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13196aecc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76a9330669c37355
dashboard link: https://syzkaller.appspot.com/bug?extid=df61b36319e045c00a08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a0437cc80000

