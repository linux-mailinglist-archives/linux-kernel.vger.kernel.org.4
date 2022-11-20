Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48E263121B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 02:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKTB1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 20:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKTB1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 20:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF46FB4F27
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 17:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668907566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylAqpC5kv5aEVbxMgjbbroXXaw7zQcXy0g3qEylcKPU=;
        b=c8OIAAWD+ayKgTnoRLU5lOrcqMhwj16reGH9hDBmkUWU1Xh1de9v3y+HuwvTjFUXhiDvrB
        oPxaieVS/3kHQH/swDYQHvqqw7/VHnJ1+muqA6R1GmeEllVOHZFJsSPKaRmA54ChF/35CC
        IPKeFBDTc1PFgqFJHiLMCZy/v8Jzqzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-e4iXALF8MBKlPRqVSrNXfA-1; Sat, 19 Nov 2022 20:26:05 -0500
X-MC-Unique: e4iXALF8MBKlPRqVSrNXfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D65F7802314;
        Sun, 20 Nov 2022 01:26:04 +0000 (UTC)
Received: from [10.22.32.7] (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968771415117;
        Sun, 20 Nov 2022 01:26:04 +0000 (UTC)
Message-ID: <a40e4347-8497-48cc-f2ee-73072b2ab79c@redhat.com>
Date:   Sat, 19 Nov 2022 20:26:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Nested calls to spin_lock_irq with different locks
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20221119151737.GA702470@roeck-us.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221119151737.GA702470@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/22 10:17, Guenter Roeck wrote:
> Hi,
>
> recently I have seen various syzbot reports reporting inconsistent lock
> states. One example is
>
> ================================
> WARNING: inconsistent lock state
> 5.16.0-syzkaller #0 Not tainted
> --------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> syz-executor.2/18360 [HC0[0]:SC0[0]:HE0:SE1] takes:
> ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
> ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: sync_info_debugfs_show+0x2d/0x200 drivers/dma-buf/sync_debug.c:147
> {IN-HARDIRQ-W} state was registered at:
>    lock_acquire kernel/locking/lockdep.c:5639 [inline]
>    lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
>    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>    _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
>    sync_timeline_debug_remove+0x25/0x190 drivers/dma-buf/sync_debug.c:31
>
> ================================
> WARNING: inconsistent lock state
> 5.16.0-syzkaller #0 Not tainted
> --------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> syz-executor.2/18360 [HC0[0]:SC0[0]:HE0:SE1] takes:
> ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
> ffffffff8c712cf8 (sync_timeline_list_lock){?...}-{2:2}, at: sync_info_debugfs_show+0x2d/0x200 drivers/dma-buf/sync_debug.c:147
>
> The log is from
> https://lore.kernel.org/lkml/000000000000d5b3af05edc9d445@google.com/T/.
>
> sync_info_debugfs_show() calls spin_lock_irq(&sync_timeline_list_lock).
> With the lock active, it calls sync_print_obj(), which calls
> spin_lock_irq(&obj->lock) and spin_unlock_irq(&obj->lock).
>
> spin_unlock_irq(), via __raw_spin_unlock_irq(), calls local_irq_enable(),
> presumably enabling hardware interrupts. If such a hardware interrupt
> calls sync_timeline_debug_remove(), the problem would be seen.
>
> Can this happen in practice ? In other words, does that mean that nested
> calls to spin_lock_irq() (with different locks) are not supported ?
> If that is indeed the case, is there a suggested remedy ?

That is what spin_lock_irqsave() and spin_unlock_irqrestore() are for. 
If you are not certain if a function will be called with interrupt 
enabled or disabled, you should always use the irqsave/irqrestore 
variant to make sure the function will work in both cases.

Cheers,
Longman

