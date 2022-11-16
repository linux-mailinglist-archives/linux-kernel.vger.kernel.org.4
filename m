Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738DF62CF14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKPXsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiKPXsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:48:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F586C60
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:48:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668642486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xg0hDSqtEw8J2eI5+nleZ6Zt6UOU2aYCgIJUROS4AcY=;
        b=jSTQgzJc0OonCSH3pyL48eXHQ/qI7Pwp0eIMSlvWd8TNgzQOchVpuZCrNaDWLg6u37OzoN
        JRlrssDFMOZiUg1WUShADMmlzfZHh11UtcMrXrE0psCg6DqE1/VdqcMt3fDBOZmk/49Zfm
        /yZ9ZhZH3oU9AHSWqrVFI1tV8fNM9LTL6hkO33TZvyNMX/1IV77nKNGs05DDRDtmGJonOR
        xjHegykTRruplFrNLt9691TAz7iP6an+EWedR2k8QXLigLp15xLp5z1Vdpzae9otPd72DA
        334KF2G8jt4y1Cakw7baH4QMKv5YuEILwneiAGAFd3zBfLlsSAsSEd58QnkArg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668642486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xg0hDSqtEw8J2eI5+nleZ6Zt6UOU2aYCgIJUROS4AcY=;
        b=mAdkuYGutvulBNUqtXkMNNY8QvTT8yV+iPC1IaiPuk/clfnA8P0RB8Tv3cXA3ZHMkRs7Xw
        9LjP4B3BNMIvcuCw==
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Zhou, Yun" <Yun.Zhou@windriver.com>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers: fix LVL_START macro
In-Reply-To: <20221115224042.GA722789@lothringen>
References: <20221115025614.79537-1-yun.zhou@windriver.com>
 <20221115120239.GA721394@lothringen>
 <SN6PR11MB300812CA336B497C40E93CA19F049@SN6PR11MB3008.namprd11.prod.outlook.com>
 <20221115224042.GA722789@lothringen>
Date:   Thu, 17 Nov 2022 00:48:05 +0100
Message-ID: <877czuo40a.ffs@tglx>
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

On Tue, Nov 15 2022 at 23:40, Frederic Weisbecker wrote:
> On Tue, Nov 15, 2022 at 01:15:11PM +0000, Zhou, Yun wrote:
>> Hi Frederic,
>> 
>> The issue now is that a timer may be thrown into the upper level bucket. For example, expires 4090 and 1000 HZ, it should be in level 2, but now it will be placed in the level 3. Is this expected?
>> 
>>  * HZ 1000 steps
>>  * Level Offset  Granularity            Range
>>  *  0      0         1 ms                0 ms -         63 ms
>>  *  1     64         8 ms               64 ms -        511 ms
>>  *  2    128        64 ms              512 ms -       4095 ms (512ms - ~4s)
>>  *  3    192       512 ms             4096 ms -      32767 ms (~4s - ~32s)
>>  *  4    256      4096 ms (~4s)      32768 ms -     262143 ms (~32s - ~4m)
>
> The rule is that a timer is not allowed to expire too early. But it can expire
> a bit late. Hence why it is always rounded up. So in the case of 4090, we have
> the choice between:
>
> 1) expiring at bucket 2 after 4096 - 64 = 4032 ms
> 2) expiring at bucket 3 after 4096 ms
>
> The 1) rounds down and expires too early. The 2) rounds up and expires a bit
> late. So the second solution is preferred.

It's not only preferred, it's required simply because the timer wheel
has only one guarantee: Not to expire early.

Timer wheel based timers are fundamentaly not precise unless the timeout
is short and hits the first level.

But even hrtimers which are designed to be precise have only one real
guarantee: Not to expire early.

hrtimers do not have the side effect of batching on long timeouts like
timer wheel based timer have, but that's it.

Timers in the kernel come with a choice:

  -  Imprecise and inexpensive to arm and cancel (timer_list)
  -  Precise and expensive to arm and cancel (hrtimer)

You can't have both. That's well documented.

Thanks,

        tglx
