Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF869D281
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjBTSED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjBTSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:04:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBF1BE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:03:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eg37so4051328edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A6D0LDt5tOZpJuOjBEExW7WXP/fQt80zWM8U7ozVGKY=;
        b=J+BefhrSZAVrhQrTx474ZlE6ZYO1CqSsZoKgn+OBFZjvHO15QVaOCnNCR9L59DqFTR
         h9msqBhlEtFVFdXB6Tqvddobh+ws7R1VOmF7JN1J0s0hW1P33sqrV6qDBWs4oUsyaobX
         r+P4Jsay/hi6G98U4pthAFK1kU7ZoQESzw0P38WF8NuZSIvdA6Oxp6fXLEUNvGnoIP3B
         Cn5dXp3fI98uUeRBVnhHT9oH9A6+ChxJgBKKYOPXGYiJfvTc84X6TZM0uudxudsZL7OH
         PUWwbRijzbtOMOPenHvFke4kmXDW1h7eTNzFyRPWXL5vt39I82EovnwB13wHUBQycnCB
         epxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6D0LDt5tOZpJuOjBEExW7WXP/fQt80zWM8U7ozVGKY=;
        b=NSgmNIbbSqGmnfw0NBV4O1LJCiBrHw36pHMHRdX95s/wSKqkQoQD9LLd1wkuktgVx9
         /pDP+fni7BxBxJo4fTEiuoojRzGoJgsXFlBNlsUxxrjgZNaUWWsVTNXyVkvkSSKTpivm
         rHt8qykiN8KBFc3whjuZpNEDLp0v5JpcFHQVN046cvrh0TpQn80QIVW/TaTigaQl/bZO
         hRQjx42KPbkgS3hMLazfjxaXu+wDa8h2eXtsuX/0Mb1kygupC5ExOExJ6Sj+ELGd1Ju+
         eSLbW/vjgHs351SkyYWH+hXTPUSGKEWZH1oRbg3yLng122eE2PHinxFY+ELMdjcCAiAE
         GWfA==
X-Gm-Message-State: AO0yUKUZ0xRzM29xYHrZS61f25ZKcS7FoER2M6j7Tn1Eq8+h0Nt/jgsp
        Ji1cltulAn1vxz1jw0e9nf8yG8ZjmpOtCnYGlBw=
X-Google-Smtp-Source: AK7set/F7AmbmO+7Raxe54NXRABadQSL0C2q0GLFiBydRAav0Bs+FawkHoqI2NOzaAP9ZSU6WNmv2MUPxHQ80tiqz1o=
X-Received: by 2002:a17:906:b746:b0:88d:64e7:a2be with SMTP id
 fx6-20020a170906b74600b0088d64e7a2bemr4747888ejb.15.1676916238232; Mon, 20
 Feb 2023 10:03:58 -0800 (PST)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Mon, 20 Feb 2023 10:03:46 -0800
Message-ID: <CAGyP=7cYsboh5JSczkZR31_+dPh=XRq4TBF63u8jQcX3h3biLw@mail.gmail.com>
Subject: KASAN: null-ptr-deref Write in f2fs_stop_discard_thread
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found the following issue using syzkaller on:
HEAD commit : e60276b8c11ab4a8be23807bc67b04
8cfb937dfa (v6.0.8)
git tree: stable

C Reproducer : https://gist.github.com/oswalpalash/eb758955c10d951eae2b5995ffe11d8c
Kernel .config :
https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb

Console log :

==================================================================
BUG: KASAN: null-ptr-deref in kthread_stop+0x8b/0x710
Write of size 4 at addr 000000000000001c by task syz-executor.0/6491

CPU: 1 PID: 6491 Comm: syz-executor.0 Not tainted 6.0.8-pasta #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xcd/0x134
 print_report.cold+0x36/0x63a
 kasan_report+0x8a/0x1b0
 kasan_check_range+0x13b/0x190
 kthread_stop+0x8b/0x710
 f2fs_stop_discard_thread+0x91/0xb0
 kill_f2fs_super+0xde/0x3e0
 deactivate_locked_super+0x8c/0xf0
 deactivate_super+0xad/0xd0
 cleanup_mnt+0x347/0x4b0
 task_work_run+0xe0/0x1a0
 exit_to_user_mode_prepare+0x25d/0x270
 syscall_exit_to_user_mode+0x19/0x50
 do_syscall_64+0x42/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb3a5c9143b
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6
e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe801d8e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb3a5c9143b
RDX: 00007fb3a5c28a90 RSI: 000000000000000a RDI: 00007ffe801d8f30
RBP: 00007ffe801d8f30 R08: 00007fb3a5cfba1f R09: 00007ffe801d8cf0
R10: 00000000fffffffb R11: 0000000000000246 R12: 00007fb3a5cfb9f8
R13: 00007ffe801d9fd0 R14: 0000555557244d90 R15: 0000000000000032
 </TASK>
==================================================================
