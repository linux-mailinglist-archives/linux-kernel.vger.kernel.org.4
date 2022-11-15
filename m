Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6696362AF62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKOXYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiKOXY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:24:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFADA27921
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:24:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668554665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBbRZQXDdMBaAi+vrNqmlxDlwawbSjED4t0F+9t4J90=;
        b=h/hHLLaSC4VUq7AzPOGBrFQhlr1/t6zcW5MlnS0mJ8bRz+WaJa4rf88kDr2P/GIUTxXEi8
        VbsvyG4avktUNFWdCsliN6BICmNDgVIQMpu1gVFnLjGy7Pw1valyUgqBZIZuvxNXyBj+yd
        r6Q8wsBw0S9s4+vIE40Y7USO9l1/xJ9vnz7tJiLF2MsAVzpnfB0hfOYd5G1IZnr/YdqKPD
        4sL5jM55mlFbaEUjFINCtbAK0G6rdwlb4DdDgCDU/bHGY6iqKR96BQMzwRp91tAw8gZyMS
        8IDX0wHior9wtFTG/2aTzge1EKquRXgePi4sHme3wD3jD24v1/1WW5WVvjLsUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668554665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBbRZQXDdMBaAi+vrNqmlxDlwawbSjED4t0F+9t4J90=;
        b=z3WFkdXGuDHmXZew5FKjZiCUAMLOCELlIm/5tsEzDEyKThhu009QtV/DBBB5VE9NKOrnnO
        Dpv66sS+/iwqbQAQ==
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
In-Reply-To: <87sfijrf9o.ffs@tglx>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx>
Date:   Wed, 16 Nov 2022 00:24:24 +0100
Message-ID: <87o7t7rec7.ffs@tglx>
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

On Wed, Nov 16 2022 at 00:04, Thomas Gleixner wrote:

> On Tue, Nov 15 2022 at 17:44, Michael S. Tsirkin wrote:
>> On Tue, Nov 15, 2022 at 11:19:47PM +0100, Thomas Gleixner wrote:
>>> > We can see global_available drop from 15354 to 15273, is 81.
>>> > And the total_allocated increase from 411 to 413. One config irq,and
>>> > one vq irq.
>>> 
>>> Right. That's perfectly fine. At the point where you looking at it, the
>>> matrix allocator has given out 2 vectors as can be seen via
>>> total_allocated.
>>> 
>>> But then it also has another 79 vectors put aside for the other queues,
>>
>> What makes it put these vectors aside? pci_alloc_irq_vectors_affinity ?
>
> init_vq() -> virtio_find_vqs() -> vp_find_vqs() ->
> vp_request_msix_vectors() -> pci_alloc_irq_vectors_affinity()
>
> init_vq() hands in a struct irq_affinity which means that
> pci_alloc_irq_vectors_affinity() will spread out interrupts and have one
> for config and one per queue if vp_request_msix_vectors() is invoked
> with per_vq_vectors == true, which is what the first invocation in
> vp_find_vqs() does.

I just checked on a random VM. The PCI device as advertised to the guest
does not expose that many vectors. One has 2 and the other 4.

But as the interrupts are requested 'managed' the core ends up setting
the vectors aside. That's a fundamental property of managed interrupts.

Assume you have less queues than CPUs, which is the case with 2 vectors
and tons of CPUs, i.e. one ends up for config and the other for the
actual queue. So the affinity spreading code will end up having the full
cpumask for the queue vector, which is marked managed. And managed means
that it's guaranteed e.g. in the CPU hotplug case that the interrupt can
be migrated to a still online CPU.

So we end up setting 79 vectors aside (one per CPU) in the case that the
virtio device only provides two vectors.

But that's not the end of the world as you really would need ~200 such
devices to exhaust the vector space...

Thanks,

        tglx


