Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F862AE1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKOWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKOWT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:19:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8B2A24A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:19:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668550788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHwYQqfoOwKcMgyEe73TdbeHd2/6ZKMXhdeVBBQPHNg=;
        b=MmAV1YcKMD0BzxpDIvUnmA4Ef+S3Y0U3aWeFJ5tVBA8Ka67XcTdATiUhZMJT7W1skHdK/y
        mvuzwAHSbfXRb9SPd2cyjKyflWwc8iDxD749PSqM1hrkE5LP/YzobmSbtckoiZTbrCYItt
        LSXSKmAGtgBVxLVOrEyjJ/57di1/WL/4uXTDi7CyOW4oAD3ZT2J9rq4v0rbZKVt7bi8w3b
        nut7VMFcKmBMRhXLU7MV59RaZniZbcby4H5S903g06GTVD5Cn8T01aeeqD8EPwS4lkY54G
        gKTFj38VeQku9R29qfWf/qzpHIz4qzUvpAV+lu2M9zsD9ZpTMUaAdblP1Na3dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668550788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHwYQqfoOwKcMgyEe73TdbeHd2/6ZKMXhdeVBBQPHNg=;
        b=y4SneHOqzIKoHWTzbJON3lgOJWeFJQhN3JBulvmGwF1i7t7Bx7xNHa5x58I8JLEpEWaDIR
        7nX6CQX4/NdsSADw==
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
In-Reply-To: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
Date:   Tue, 15 Nov 2022 23:19:47 +0100
Message-ID: <87v8nfrhbw.ffs@tglx>
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

On Tue, Nov 15 2022 at 03:40, Angus Chen wrote:
> Before probe one virtio_blk.
> crash_cts> p *vector_matrix
> $44 = {
>   matrix_bits = 256,
>   alloc_start = 32,
>   alloc_end = 236,
>   alloc_size = 204,
>   global_available = 15354,
>   global_reserved = 154,
>   systembits_inalloc = 3,
>   total_allocated = 411,
>   online_maps = 80,
>   maps = 0x46100,
>   scratch_map = {1160908723191807, 0, 1, 18435222497520517120},
>   system_map = {1125904739729407, 0, 1, 18435221191850459136}
> }
> After probe one virtio_blk.
> crash_cts> p *vector_matrix
> $45 = {
>   matrix_bits = 256,
>   alloc_start = 32,
>   alloc_end = 236,
>   alloc_size = 204,
>   global_available = 15273,
>   global_reserved = 154,
>   systembits_inalloc = 3,
>   total_allocated = 413,
>   online_maps = 80,
>   maps = 0x46100,
>   scratch_map = {25769803776, 0, 0, 14680064},
>   system_map = {1125904739729407, 0, 1, 18435221191850459136}
> }
>
> We can see global_available drop from 15354 to 15273, is 81.
> And the total_allocated increase from 411 to 413. One config irq,and
> one vq irq.

Right. That's perfectly fine. At the point where you looking at it, the
matrix allocator has given out 2 vectors as can be seen via
total_allocated.

But then it also has another 79 vectors put aside for the other queues,
but those queues have not yet requested the interrupts so there is no
allocation yet. But the vectors are guaranteed to be available when
request_irq() for those queues runs, which does the actual allocation.

Btw, you can enable CONFIG_GENERIC_IRQ_DEBUGFS and then look at the
content of /sys/kernel/debug/irq/domain/VECTOR which gives you a very
clear picture of what's going on. No need for gdb.

> It is easy to expend the irq resource ,because virtio_blk device could
> be more than 512.

How so? virtio_blk allocates a config interrupt and one queue interrupt
per CPU. So in your case a total of 81.

How would you exhaust the vector space? Each CPU has about ~200 (in your
case exactly 204) vectors which can be handed out to devices. You'd need
to instantiate about 200 virtio_blk devices to get to the point of
vector exhaustion.

So what are you actually worried about and which problem are you trying
to solve?

Thanks,

        tglx


