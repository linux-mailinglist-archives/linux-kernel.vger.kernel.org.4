Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728562BA53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiKPKzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiKPKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:54:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069DCDA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:43:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668595405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX2SKCrid73QyxVgZp3pXrhrbHc1mgUmMeIiTTjDIJ8=;
        b=Lhlt6L0xF38lo/Id90Tb6KyW2KU0rhGNz7/AFj/bhP6vIB4tWw+GgjHaijmqEXtLJEnGSg
        wxNKyc8vzxmn4KmezESnUk8vYrGQDJ9rd01W2U1fXJ1EINL75wEXtxMpDi4t5hPjrwXWdY
        D+NIx5LS+1K+nNNkM5CLQWy47gbypYptGF4RGW39g+ZuIBzKA9MR2qPRyOY8ufajzPEDHd
        3vd+AbR7EpjIZK4bWd/aOfC6vWwiIaY9l4HXoSkU5CR+sgomimoU7T6EwYfg27uAHgf6aU
        VhMZ5mE4hd0AXg32zbq3LDgQyzgZkbReHEXKAeKYrrjBTtXvpEHWs/13byeQIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668595405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX2SKCrid73QyxVgZp3pXrhrbHc1mgUmMeIiTTjDIJ8=;
        b=YMNl0EUQ4vnNNkN/qmrs64zL+FbqgwsjdyiNF7NJ+oRf/5XOqxVL3RM+Hgd8eqh+r4nvYN
        wC3etXsLenLQosAQ==
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Angus Chen <angus.chen@jaguarmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: IRQ affinity problem from virtio_blk
In-Reply-To: <20221115183339-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx> <87o7t7rec7.ffs@tglx>
 <20221115183339-mutt-send-email-mst@kernel.org>
Date:   Wed, 16 Nov 2022 11:43:24 +0100
Message-ID: <87leobqiwj.ffs@tglx>
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

On Tue, Nov 15 2022 at 18:36, Michael S. Tsirkin wrote:
> On Wed, Nov 16, 2022 at 12:24:24AM +0100, Thomas Gleixner wrote:
>> I just checked on a random VM. The PCI device as advertised to the guest
>> does not expose that many vectors. One has 2 and the other 4.
>> 
>> But as the interrupts are requested 'managed' the core ends up setting
>> the vectors aside. That's a fundamental property of managed interrupts.
>> 
>> Assume you have less queues than CPUs, which is the case with 2 vectors
>> and tons of CPUs, i.e. one ends up for config and the other for the
>> actual queue. So the affinity spreading code will end up having the full
>> cpumask for the queue vector, which is marked managed. And managed means
>> that it's guaranteed e.g. in the CPU hotplug case that the interrupt can
>> be migrated to a still online CPU.
>> 
>> So we end up setting 79 vectors aside (one per CPU) in the case that the
>> virtio device only provides two vectors.
>> 
>> But that's not the end of the world as you really would need ~200 such
>> devices to exhaust the vector space...
>
> Let's say we have 20 queues - then just 10 devices will exhaust the
> vector space right?

No.

If you have 20 queues then the queues are spread out over the
CPUs. Assume 80 CPUs:

Then each queue is associated to 80/20 = 4 CPUs and the resulting
affinity mask of each queue contains exactly 4 CPUs:

q0:      0 -  3
q1:      4 -  7
...
q19:    76 - 79

So this puts exactly 80 vectors aside, one per CPU.

As long as at least one CPU of a queue mask is online the queue is
enabled. If the last CPU of a queue mask goes offline then the queue is
shutdown which means the interrupt associated to the queue is shut down
too. That's all handled by the block MQ and the interrupt core. If a CPU
of a queue mask comes back online then the guaranteed vector is
allocated again.

So it does not matter how many queues per device you have it will
reserve exactly ONE interrupt per CPU.

Ergo you need 200 devices to exhaust the vector space.

Thanks,

        tglx







