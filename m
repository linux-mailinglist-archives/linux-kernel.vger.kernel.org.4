Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1AB5B8897
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiINMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiINMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:50:03 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339A30F52;
        Wed, 14 Sep 2022 05:50:01 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id j7so10359040vsr.13;
        Wed, 14 Sep 2022 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=bpJxOTCh6oYyCQQdF2icsufM9QvXroCcz9Xfpd1L57M=;
        b=T+cbO+tKigJbRIFUktlNyjC9bQ6dwfZycN3vkq2FujQcVT0kTBUweNIpGKF3JIdgjd
         d0vctLHtEFIpRpKqkXBnu6UYeiM1IqTp4PaP8emL7uC7bAH+xtRlPv1pm//qIVD0rShq
         tlAmveKDrkGKUOy5u77oQX1KUnjauWbA6y/3e+WN2V4pZtFfufHctIXFeyTZ1bjMx7IB
         4uY+AY0N6iBxSWwBNLtpXJoSghxJX06S4IcoYqT9aJWhVHl1EtvlwpL3gYW8R9ipz9pI
         +C2uTuWERokOv0Q4uyXmLoIp8R98DLtCgB37+ZYsx4ssKMr2eQTul2nOgmyc7+uNY8zL
         aLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=bpJxOTCh6oYyCQQdF2icsufM9QvXroCcz9Xfpd1L57M=;
        b=EeO/mzxGuBvHLemkg1NJV3SnPBCYZ1BQSI+qI2VqYaSMVtkoV9G8HdLQ6a5Al4+NB3
         TuBmWoFs2y2EaiNNSFXu/LzZQnTqwB60V4y9tNnCEhNOKdS6VnVqafjWFRk3eyzHrjJM
         /00EQ49oWXxTTQoxpIXLHC+lftrg3Au1ydXu4x/2T545K3tPXzckhHi9doWu0VkZDpWl
         4ia66R4GbUiXiYAe5RcbxxRgaswD05gN87qOnfgBgspKZzAxDtvCbRmGpQE2Eheo0s2C
         8YjJM2YUZhj9BUDa2kIZtuhHVBbTBe7wqWcP9v1TGK/lMusSz9nA+YIZdQJEJ6rvobgp
         Dcdw==
X-Gm-Message-State: ACgBeo10iKW8d0mzFU3+JdUS0agjlp3Nmbf3YKJYTrlqV0HW9uU2QNU2
        9kL8/z7OMMQUrjm1PXtGVASLxmg97k1i6tYT19GptKrnFAIogg==
X-Google-Smtp-Source: AA6agR7r6FnnOyXSDr5DZY1ea/fXvRtR1nGgWvjMzf6vZVvsLjDq+I/FQpHLTsiUnDYQWPc9MTY8I2aPl4PvhmKAGr4=
X-Received: by 2002:a67:be16:0:b0:398:c2e4:e01f with SMTP id
 x22-20020a67be16000000b00398c2e4e01fmr807424vsq.33.1663159800573; Wed, 14 Sep
 2022 05:50:00 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Wed, 14 Sep 2022 20:49:49 +0800
Message-ID: <CAB7eexKfentLRraPRR8kwqY3NRN9WTTijLW8SrKwAPzOzouxDg@mail.gmail.com>
Subject: possible deadlock in f_midi_transmit
To:     balbi@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        john@metanate.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
triggered.

HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
git tree: upstream

kernel config: https://pastebin.com/raw/xtrgsXP3
C reproducer: https://pastebin.com/raw/C1xYEf7Q
console output: https://pastebin.com/raw/3RLhvQHE

Basically, in the c reproducer, we use the gadget module to emulate
attaching a USB device(vendor id: 0x403, product id: 0xff3d, with the
midi function) and executing some simple sequence of system calls.
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
the trick.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:


============================================
WARNING: possible recursive locking detected
6.0.0-rc4+ #20 Not tainted
--------------------------------------------
kworker/0:1H/9 is trying to acquire lock:
ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683

but task is already holding lock:
ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&midi->transmit_lock);
  lock(&midi->transmit_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/0:1H/9:
 #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1280
[inline]
 #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011c65138 ((wq_completion)events_highpri){+.+.}-{0:0}, at:
process_one_work+0x8b0/0x1650 kernel/workqueue.c:2260
 #1: ffffc900003afdb0 ((work_completion)(&midi->work)){+.+.}-{0:0},
at: process_one_work+0x8e4/0x1650 kernel/workqueue.c:2264
 #2: ffff888057ed9228 (&midi->transmit_lock){....}-{2:2}, at:
f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683

stack backtrace:
CPU: 0 PID: 9 Comm: kworker/0:1H Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_highpri f_midi_in_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2988 [inline]
 check_deadlock kernel/locking/lockdep.c:3031 [inline]
 validate_chain kernel/locking/lockdep.c:3816 [inline]
 __lock_acquire.cold+0x152/0x3c3 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x580 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 f_midi_transmit+0x18c/0x1460 drivers/usb/gadget/function/f_midi.c:683
 f_midi_complete+0x1bb/0x480 drivers/usb/gadget/function/f_midi.c:285
 dummy_queue+0x84a/0xb20 drivers/usb/gadget/udc/dummy_hcd.c:736
 usb_ep_queue+0xe8/0x3b0 drivers/usb/gadget/udc/core.c:288
 f_midi_do_transmit drivers/usb/gadget/function/f_midi.c:658 [inline]
 f_midi_transmit+0x7e4/0x1460 drivers/usb/gadget/function/f_midi.c:686
 process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
 worker_thread+0x623/0x1070 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
