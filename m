Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07DF6E59AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDRGv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjDRGvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:51:24 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E3D2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:51:23 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5068e99960fso2435551a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681800682; x=1684392682;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSTYXI3t9JX4Qoli8RnsylrJAGPSMn1Q41HaZfIKE+E=;
        b=UjNbg4y+T7yl5qT05d2ogA6kpVH4g/HLGdFEzuM1fpS3gW6C8gJD2HnJuceRtWKs97
         lsE8RNy0PYoKL6njOTQmeBWIgPBEnRvqXfKMWOfBmzRZq+rnQbnDL4fPFI1j6uH3e5sV
         ZgKvi91ACYRE2uv9w4a1VRoT1CPssZbc8X4x/Z08I8lkrilibVB/7kfl3cnE8ejuy0BC
         ad7rg243YCWtK2GcfDB3P33eJVrqhIZsUsOvxTCLvoKT4BDvblMt2TpTfkCpzG2kjZ2H
         /Bd4FGDRh7tHLKWnZ2NCV7whk4MMy2CdZgxxq1Hyuq4hXFgNzZRPWr+tg6J+cEqo9OXT
         Yy/w==
X-Gm-Message-State: AAQBX9c2kWbfa5YSOI9qwaWZbwKWCRvbL+dBjXRFA41dIW0FYko8g8CZ
        iFiyPHpqHX823bMXYilAMtw=
X-Google-Smtp-Source: AKy350aIOU1T2vCBxAMwLV+QGwS2doDCxDwbHw5ykZ1wST/HhZ7U57lKZ6GaActsHfzo+1mIq2m5lw==
X-Received: by 2002:aa7:dad8:0:b0:506:905b:816d with SMTP id x24-20020aa7dad8000000b00506905b816dmr1520663eds.6.1681800681711;
        Mon, 17 Apr 2023 23:51:21 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id js6-20020a17090797c600b0094f1fe1696bsm4535657ejc.216.2023.04.17.23.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 23:51:21 -0700 (PDT)
Message-ID: <5a994a13-d1f2-87a8-09e4-a877e65ed166@kernel.org>
Date:   Tue, 18 Apr 2023 08:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: BUG: sleeping function called from invalid context in
 __might_resched
Content-Language: en-US
To:     Yu Hao <yhao016@ucr.edu>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <CA+UBctCZok5FSQ=LPRA+A-jocW=L8FuMVZ_7MNqhh483P5yN8A@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CA+UBctCZok5FSQ=LPRA+A-jocW=L8FuMVZ_7MNqhh483P5yN8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 04. 23, 5:44, Yu Hao wrote:
> Hello,
> 
> We found the following issue using syzkaller on Linux v6.2.0.
> A similar bug was found in function `n_hdlc_tty_wakeup` before.
> (https://groups.google.com/g/syzkaller-bugs/c/XAyZCUO-eAY/m/Lpj5SzDNAwAJ)
> Now it is found in a different caller `gsmld_write`.
> It needs to fix the bug in `gsmld_write` again.
> 
> The full report including the C reproducer:
> https://gist.github.com/ZHYfeng/eb410de5d7aec253d8c83cf34e628d6a
> 
> The brief report is below:
> 
> Syzkaller hit 'BUG: sleeping function called from invalid context in
> __might_resched' bug.
> 
> BUG: sleeping function called from invalid context at
> kernel/printk/printk.c:2656
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 9817, name: (agetty)
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by (agetty)/9817:
>   #0: ffff888017797098 (&tty->ldisc_sem){++++}-{0:0}, at:
> tty_ldisc_ref_wait+0x27/0x80 drivers/tty/tty_ldisc.c:244
>   #1: ffff888017797130 (&tty->atomic_write_lock){+.+.}-{3:3}, at:
> tty_write_lock+0x23/0x90 drivers/tty/tty_io.c:944
>   #2: ffff888046ee93e0 (&gsm->tx_lock){....}-{2:2}, at:
> gsmld_write+0x63/0x150 drivers/tty/n_gsm.c:3410
> irq event stamp: 3146
> hardirqs last  enabled at (3145): [<ffffffff8a0f3a32>]
> syscall_enter_from_user_mode+0x22/0xb0 kernel/entry/common.c:111
> hardirqs last disabled at (3146): [<ffffffff8a12e6b3>]
> __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
> hardirqs last disabled at (3146): [<ffffffff8a12e6b3>]
> _raw_spin_lock_irqsave+0x53/0x60 kernel/locking/spinlock.c:162
> softirqs last  enabled at (0): [<ffffffff814b301d>]
> copy_process+0x1a8d/0x7490 kernel/fork.c:2211
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 9817 Comm: (agetty) Not tainted 6.2.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   __might_resched.cold+0x222/0x26b kernel/sched/core.c:10045
>   console_lock+0x1c/0x80 kernel/printk/printk.c:2656
>   do_con_write+0x114/0x1e40 drivers/tty/vt/vt.c:2908
>   con_write+0x26/0x40 drivers/tty/vt/vt.c:3295

Hmm, tty_operations::write() is documented as "not allowed to sleep". 
But vt's write was always sleeping :D. I wonder:
1) can gsmld be switched to a mutex?
2) what do other ldiscs do? FWIW n_tty does mutex, so allows ::write() 
to sleep.

>   gsmld_write+0xd0/0x150 drivers/tty/n_gsm.c:3413
>   do_tty_write drivers/tty/tty_io.c:1018 [inline]
>   file_tty_write.isra.0+0x48f/0x820 drivers/tty/tty_io.c:1089
>   call_write_iter include/linux/fs.h:2189 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x9cf/0xd90 fs/read_write.c:584
>   ksys_write+0x12c/0x250 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f5538c101b0
> Code: 2e 0f 1f 84 00 00 00 00 00 90 48 8b 05 19 7e 20 00 c3 0f 1f 84
> 00 00 00 00 00 83 3d 19 c2 20 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24
> RSP: 002b:00007ffdb4aadbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007f5538c101b0
> RDX: 000000000000000a RSI: 00007f553b13ccbe RDI: 0000000000000003
> RBP: 00007f553b13ccbe R08: 00007ffdb4aadba0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000000 R14: ffffffffffffffff R15: 00007ffdb4aadea0
>   </TASK>

-- 
js
suse labs

