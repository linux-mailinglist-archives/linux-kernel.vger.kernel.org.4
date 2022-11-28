Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7A63A282
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiK1IMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiK1IMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:12:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0085C5E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:12:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669623148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VptkHmPTPSs5eOtCUMB4/TKM/fssvk4H/apqtf0JHkw=;
        b=RVM1J6xmynemcQ48SmviPVnGKjkS+iQ7y+Dybo1n8DoWIBaaWEuXyAytD5l2OzjuGo+XFS
        Vk7ZKnYbH9kZZHEqug/eGckC2Pv+UOu8Nc49FWtne4+UPkyRZFdp5R50cRKgl5Yje2cxQo
        jAFdjHPp2hCdTAwi0J07qx20DkIEXxjb2mxvrN8i+p33hWoydbH9RsGFmRn8K7id0rHBBe
        LZbAIf2A/fEmq1cQEdvprJhMCpT2iyaxrvhrj2HHZg32ZEt0Di+ZMNxPiznaaJMaopGPIM
        7VoGy40TdxuFU0Tj0dEQKOTf1dvvoc9WqzkxraB5SxTENJJk8X3lsAcRA8L7sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669623148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VptkHmPTPSs5eOtCUMB4/TKM/fssvk4H/apqtf0JHkw=;
        b=N+FP099LREZdAsl3iwZTUkFtZExrnpVx38wkGZq8p/XNiiqKi2AVZkLug7YXt+xE9Tn1yG
        OP1gD3qu12stZLBw==
To:     paulmck@kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, fweisbec@gmail.com,
        mingo@kernel.org, dave@stgolabs.net, josh@joshtriplett.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
In-Reply-To: <20221127175317.GF4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221121035140.118651-1-zhouzhouyi@gmail.com>
 <87y1rxwsse.ffs@tglx>
 <CAABZP2xNTbrx9iV+KH3VZx1c9Yi97+izNA=XSJQBuOJ4WENFZg@mail.gmail.com>
 <87v8n0woxv.ffs@tglx> <20221127175317.GF4001@paulmck-ThinkPad-P17-Gen-1>
Date:   Mon, 28 Nov 2022 09:12:28 +0100
Message-ID: <87sfi3wl8z.ffs@tglx>
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

On Sun, Nov 27 2022 at 09:53, Paul E. McKenney wrote:
> On Sun, Nov 27, 2022 at 01:40:28PM +0100, Thomas Gleixner wrote:
>> There are quite some reasons why a CPU-hotplug or a hot-unplug operation
>> can fail, which is not a fatal problem, really.
>> 
>> So if a CPU hotplug operation fails, then why can't the torture test
>> just move on and validate that the system still behaves correctly?
>> 
>> That gives us more coverage than just testing the good case and giving
>> up when something unexpected happens.
>
> Agreed, with access to a function like the tick_nohz_full_timekeeper()
> suggested earlier in this email thread, then yes, it would make sense to
> try to offline the CPU anyway, then forgive the failure in cases where
> the CPU matches that indicated by tick_nohz_full_timekeeper().

Why special casing this? There are other valid reasons why offlining can
fail. So we special case timekeeper today and then next week we special
case something else just because. That does not make sense. If it fails
there is a reason and you can log it. The important part is that the
system is functional and stable after the fail and the rollback.

>> I even argue that the torture test should inject random failures into
>> the hotplug state machine to achieve extended code coverage.
>
> I could imagine torture_onoff() telling various CPU-hotplug notifiers
> to refuse the transition using some TBD interface.

There is already an interface which is exposed to sysfs which allows you
to enforce a "fail" at a defined hotplug state.

> That would better test the CPU-hotplug common code's ability to deal
> with failures.

Correct.

> Or did you have something else/additional in mind?

No.

Thanks,

        tglx
