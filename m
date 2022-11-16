Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4963C62BF60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKPN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKPN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:27:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EC6557
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:27:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668605232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oqse9AhE1qRO5EB7HsRQ/6UJ6Dpn3zw/H6qOOCfa4TE=;
        b=saLJcqdkQOORlxgyIVRcJxIF/3S8rD4X4MTd/ygybHEOyDfsJZla+tY+NICLc9qTOVmmKO
        CmhRbfUDPUZuuvcaLmcS0U03FnQYGFbtel1l7CK8NMCgaurPhl9r7A9FLxQt1+1XzSRuEy
        PFTOasr/K57zt2UxW7jS7x/rLX/kmzNwLohDknLZaO9COASULhrPvIUSyJvLULIRi4w260
        UDjYU8jG3bhYxeEQUDL7zFQukHsQBDyOVE5rKU0hKJx/8aCS6a7yloReLQwNriaBY/TkE3
        Kdr2HYi6KI013mMUO94kN6BDR56VUFmXAyK0LZVJrRY1cFOub8BMT06r7ORGzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668605232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oqse9AhE1qRO5EB7HsRQ/6UJ6Dpn3zw/H6qOOCfa4TE=;
        b=Dv5FqVTQ6pmVxm+BCOZNNcfKYx8ogCR1bEKqn8JAvCQ/RhvOsasbXA1peGz1lRKVb46RZD
        q3kLz4eUjxB4AdAA==
To:     Angus Chen <angus.chen@jaguarmicro.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: RE: IRQ affinity problem from virtio_blk
In-Reply-To: <TY2PR06MB3424E673A1374CAC37E647CA85079@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx> <87o7t7rec7.ffs@tglx>
 <20221115183339-mutt-send-email-mst@kernel.org>
 <TY2PR06MB34241333364AA5843CD4BAA885079@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87fsejqicd.ffs@tglx>
 <TY2PR06MB3424E673A1374CAC37E647CA85079@TY2PR06MB3424.apcprd06.prod.outlook.com>
Date:   Wed, 16 Nov 2022 14:27:11 +0100
Message-ID: <877czvqbbk.ffs@tglx>
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

On Wed, Nov 16 2022 at 11:24, Angus Chen wrote:
>> >> On Wed, Nov 16, 2022 at 12:24:24AM +0100, Thomas Gleixner wrote:
>> > Any other information I need to provide,pls tell me.
>> 
>> A sensible use case for 180+ virtio block devices in a single guest.
>> 
> Our card can provide more than 512 virtio_blk devices .
> one virtio_blk passthrough to one container,like docker.

I'm not sure whether that's sensible, but that's how your hardware is
designed. You could have provided this information upfront instead of
random memory dumps of the irq matrix internals.

> So we need so much devices.
> In the first patch ,I del the IRQD_AFFINITY_MANAGED in virtio_blk .

There is no IRQD_AFFINITY_MANAGED in virtio_blk. That flag is internal
to the interrupt core code and you can neither delete it nor fiddle with
it from inside virtio_blk.

You can do that in your private kernel, but that's not an option for
mainline as it will break existing setups and it's fundamentally wrong.

The block-mq code has assumptions about the semantics of managed
interrupts. It happens to work for the single queue case because that
always ends up with queue affinity == cpu_possible_mask.

For anything else which assigns the queues to partitions of the CPU
space it definitely expects the semantics of managed interrupts.

> As you know, if we just use small queues number ,like 1or 2,we Still
> occupy 80 vector ,that is kind of waste,and it is easy to eahausted
> the Irq resource.

We know that by now. No point in repeating this over and over. Aside of
that it's not that easy because this is the first time within 5 years
that someone ran into this problem.

The real question is how to solve this proper without creating problems
for other scenarios. That needs involvment of the blk-mq people.

Thanks,

        tglx
