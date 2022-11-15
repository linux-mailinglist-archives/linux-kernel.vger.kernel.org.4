Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BFE62AF11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiKOXE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiKOXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:04:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9E1BEAE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:04:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668553459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyLOjll9PSFTh2089EjVD8JZTparrCm5C62nsd9MCGA=;
        b=ihqlrFO1XG48hTyhT9ZexveVtp4JZkVopSVAlGE0hG326C0xwaNRTbwBp6VQIegjBlrh2g
        2/vu/arckFlJB9HpLXUUFR07+57XPUzrBKThd60G1mJzTpytqTDFcNxYIZuVYJmHXxpFne
        xEMx0eVTxD4K2CSokmkx4SZyYEvr43eyrgyms1UWNvrCqkeCFbzqZeYP74c3VvvsQE5Xwa
        kVvKOnPJiZl6vKveozNELzVJOy1OC8SMejc4yvJihF4/vGxQkfiMmqHOjGkolgjPmFJPop
        0SZIMiS2o5gOthwiyqIsyrMcjDa1jIG3Yk6wh1idbd7423RcYxalM/sMipGqkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668553459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyLOjll9PSFTh2089EjVD8JZTparrCm5C62nsd9MCGA=;
        b=LXdvJKrEt1FmFfN8uhiLD/25lOHUbuAP0Ldb0LW0lJ6a6Iz2gIGgMt3M7ikGkvonPatz7S
        pQRbe9SHwo8cfnCQ==
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
In-Reply-To: <20221115174152-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
Date:   Wed, 16 Nov 2022 00:04:19 +0100
Message-ID: <87sfijrf9o.ffs@tglx>
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

On Tue, Nov 15 2022 at 17:44, Michael S. Tsirkin wrote:
> On Tue, Nov 15, 2022 at 11:19:47PM +0100, Thomas Gleixner wrote:
>> > We can see global_available drop from 15354 to 15273, is 81.
>> > And the total_allocated increase from 411 to 413. One config irq,and
>> > one vq irq.
>> 
>> Right. That's perfectly fine. At the point where you looking at it, the
>> matrix allocator has given out 2 vectors as can be seen via
>> total_allocated.
>> 
>> But then it also has another 79 vectors put aside for the other queues,
>
> What makes it put these vectors aside? pci_alloc_irq_vectors_affinity ?

init_vq() -> virtio_find_vqs() -> vp_find_vqs() ->
vp_request_msix_vectors() -> pci_alloc_irq_vectors_affinity()

init_vq() hands in a struct irq_affinity which means that
pci_alloc_irq_vectors_affinity() will spread out interrupts and have one
for config and one per queue if vp_request_msix_vectors() is invoked
with per_vq_vectors == true, which is what the first invocation in
vp_find_vqs() does.

Thanks,

        tglx





