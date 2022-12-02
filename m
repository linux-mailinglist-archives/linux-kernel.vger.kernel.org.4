Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15CD6402E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiLBJEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiLBJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:04:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C872BA632;
        Fri,  2 Dec 2022 01:04:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669971853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MckjuAgrX9lPRRxAXgnWKVuqqFRTRL6g7Q93m+oxRpw=;
        b=zm9bAyKz9vWaZbKqWxM2FlRGsBKSUCB+fz3hebT+5HdIbA2ov/u5M1rmdOmRJ8xGtK++8s
        YfybLezzeXk3FvqzMOeEJ1zJnQSvdH5IvfSvum1gRGPkEnauyZJeKxwg1r8STWcwFqDxzk
        dd84kLqb9t8NYTV9haq10aBOHxu3cgnOWEs4TgR++hdbC+3og6jnqluG2Nn9pHQ5C3auIE
        UvbVr9hcopOIHfJSxrYfDfrdQFl1Cd3vxNkFHYpeCDO7aA5hRWPr8NnQWPlg7J4MX/nGKP
        Nm6y6Eu3LJmK5ywjoTWFXqIBQ3BOuL3N2/5Xo2nagc7iVyXZ1K7n53Cfk0EelA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669971853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MckjuAgrX9lPRRxAXgnWKVuqqFRTRL6g7Q93m+oxRpw=;
        b=3T1FVTK1GegP2cFse6RkU9JjMvJHY94AqQTDeH2joWNRB/quwq2MG0RhxW5q6BeesKfias
        6WWT9gXfkMWcQsAw==
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, zhuyinbo@loongson.cn
Subject: Re: [PATCH v11 1/3] clocksource: loongson2_hpet: add hpet driver
 support
In-Reply-To: <c46e5ebf-5293-5123-52d3-b3594c6e9244@loongson.cn>
References: <20221129030925.14074-1-zhuyinbo@loongson.cn>
 <87k03bs6pj.ffs@tglx> <c46e5ebf-5293-5123-52d3-b3594c6e9244@loongson.cn>
Date:   Fri, 02 Dec 2022 10:04:12 +0100
Message-ID: <87bkomqir7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02 2022 at 12:36, Yinbo Zhu wrote:
> =E5=9C=A8 2022/12/1 19:29, Thomas Gleixner =E5=86=99=E9=81=93:
>>
>>> +static DEFINE_SPINLOCK(hpet_lock);
>> This wants to be a raw spinlock if at all. But first you have to explain
>> the purpose of this lock.
>>
>>> +DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device);
>> Why needs this to be global and why is it needed at all?
>>
>> This code does support exactly _ONE_ clock event device.
>
> This is consider that the one hardware clock_event_device is used for=20
> multiple cpu cores,
>
> and earch cpu cores has a device from its perspective, so add=20
> DEFINE_SPINLOCK(hpet_lock)
>
> and DEFINE_PER_CPU(struct clock_event_device, hpet_clockevent_device),
>
> the use of locks described below is also this reason .

You cannot use _ONE_ clock event device as per CPU clock event device
for multiple CPUs. That simply cannot work ever.

There are two types of clockevent devices:

      1) strictly per CPU, i.e. one distinct device per CPU

      2) global broadcast device

The global broadcast device is used if there are less physical devices
than CPUs or to handle the cases where the per CPU device stops in
deep idle states.

For the case that there are less physical devices than CPUs, you have to
install dummy per CPU devices. Grep for CLOCK_EVT_FEAT_DUMMY.

The core code will use the broadcast device to provide timer interrupts
and it propagates them to the CPUs which are backed by a dummy per CPU
device via IPIs.

None of this needs a lock in the driver code unless the hardware is
really dumb designed and has a register shared with something else.

The serialization for all clockevent devices is completely provided by
the core code.

>> Seriously, this is not how it works. Instead of copy & paste, we create
>> shared infrastructure and just keep the real architecture specific
>> pieces separate.
>
> I don't find the shared infrastructure in LoongArch, I want to support=C2=
=A0=20
> hpet for LoongArch

Of course you can't find shared infrastructure because there is none.

That's the whole point. Instead of creating copies of code, you rework
the code so that the common parts can be shared between x86, longson and
loongarch. Then you have the architecture/platform specific pieces which
deal with the specific enumeration/initialization and use the shared
infrastructure.

Thanks,

        tglx




