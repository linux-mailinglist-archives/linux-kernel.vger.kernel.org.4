Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7D62BF01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiKPNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiKPNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:06:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95745A23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:06:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668603961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yuj07RczzG7QB9VwgLNXWU6NASJPemhchSVaX9pL9zk=;
        b=QRzUgmIUBv4/dhqf+vV3QIVA6GbgIi6k3sP+l6USQfwhs8sVzvHkRmrEMscg0K4SgbtOPn
        or/lPoDyOHyIS2ZtxaCZa4srk3MbRRWPMJemkdtaTe2qhfpA9wR7sDWTcekEaXOcZ2yu/y
        FPCs/cQgluL1oips5tIynyQ3L7I7sHgCp6wT5IjBhY8xEhYK8nwnfR9dwdHziDNT+59PT/
        sxads0ueVBcesdqQo1QVb9/hqQqM9zqOfrYkpO99fdxOlQZBXDKt3KwdVD85qlz3qYfWnh
        blweuP8ejKfd+cXz/2E+MVbF4LNSN8znzF5T4YsZXLsZCjb20b+p2KqIs7tVgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668603961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yuj07RczzG7QB9VwgLNXWU6NASJPemhchSVaX9pL9zk=;
        b=wAi2mHmvYoWxFFQ/mGxAmx6IJbpwzWgowHW3Gq52kgfGJslO9KBHK0fV6EMh0aORevOCe6
        OLYfg+kZ4kH9p2CQ==
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
In-Reply-To: <Y3TK+0m6kJjiyrao@T590>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx> <87o7t7rec7.ffs@tglx>
 <20221115183339-mutt-send-email-mst@kernel.org> <87leobqiwj.ffs@tglx>
 <Y3TK+0m6kJjiyrao@T590>
Date:   Wed, 16 Nov 2022 14:06:00 +0100
Message-ID: <87a64rqcav.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2022 at 19:35, Ming Lei wrote:
> On Wed, Nov 16, 2022 at 11:43:24AM +0100, Thomas Gleixner wrote:
>> > Let's say we have 20 queues - then just 10 devices will exhaust the
>> > vector space right?
>> 
>> No.
>> 
>> If you have 20 queues then the queues are spread out over the
>> CPUs. Assume 80 CPUs:
>> 
>> Then each queue is associated to 80/20 = 4 CPUs and the resulting
>> affinity mask of each queue contains exactly 4 CPUs:
>> 
>> q0:      0 -  3
>> q1:      4 -  7
>> ...
>> q19:    76 - 79
>> 
>> So this puts exactly 80 vectors aside, one per CPU.
>> 
>> As long as at least one CPU of a queue mask is online the queue is
>> enabled. If the last CPU of a queue mask goes offline then the queue is
>> shutdown which means the interrupt associated to the queue is shut down
>> too. That's all handled by the block MQ and the interrupt core. If a CPU
>> of a queue mask comes back online then the guaranteed vector is
>> allocated again.
>> 
>> So it does not matter how many queues per device you have it will
>> reserve exactly ONE interrupt per CPU.
>> 
>> Ergo you need 200 devices to exhaust the vector space.
>
> I am wondering why one interrupt needs to be reserved for each CPU, in
> theory one queue needs one irq, I understand, so would you mind
> explaining the story a bit?

It's only one interrupt per queue. Interrupt != vector.

The guarantee of managed interrupts always was that if there are less
queues than CPUs that CPU hotunplug cannot result in vector exhaustion.

Therefore we differentiate between managed and non-managed
interrupts. Managed have a guaranteed reservation, non-managed do not.

That's been a very deliberate design decision from the very beginning.

Thanks,

        tglx






