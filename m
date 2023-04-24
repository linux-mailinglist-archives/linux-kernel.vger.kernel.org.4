Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235DF6ED45E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjDXS2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjDXS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:28:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF96618B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:28:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682360908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1/m2RzaE7vpUopc2wBHSmygU8a6nk7f+ku68jshDtM=;
        b=Vawy5gDQAGxstGSK6suLuM4B33hm2Uy2f7C3YYAS3ci84Et+Fdk3je9ndKsIP1vA/4w72g
        ASZ7C1YM3KAmhrE+zr2rQmv7elOpM/J2PqngTuf1BwxsVh6JgIdkq/O2/16S6enhMT1/aJ
        2fIxdPwuJjgbO5wBuanPzOSHIy4eGLHmNJi1MZPGif4is8zQB/YrMAUDjZfnWcQ2EfFuVZ
        56rTaSFtgXmNV6qQKgBEBtvmEhYx5e+Xx7N8+D8fi267Wr78L+7Flx4J5ix2meqoxe1P/+
        Anl+hM50pe/bb167nNhKkYeAURG1t5RYFgRx6hGRmjXv52hVsVySfLCjvk3PgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682360908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1/m2RzaE7vpUopc2wBHSmygU8a6nk7f+ku68jshDtM=;
        b=J7TV5u91KfTVGr+XILLkynVT+4N4IHPcpqnzu/YSJ9iN0p6XzanmtgrVDOSPArUPbKhv7y
        zg0lD47xsvNQzIBQ==
To:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <e4d1f832-d95e-02c9-ae7d-2aca48a45fb1@allwinnertech.com>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
 <e4d1f832-d95e-02c9-ae7d-2aca48a45fb1@allwinnertech.com>
Date:   Mon, 24 Apr 2023 20:28:27 +0200
Message-ID: <875y9l16es.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23 2023 at 22:16, Victor Hassan wrote:
> On 4/16/2023 5:01 AM, Thomas Gleixner wrote:
>> After more analysis of that code it turns out that this is even more
>> broken because of this:
>>=20
>> CPU0                       CPU1
>>=20
>>                             idle()
>>                               tick_broadcast_enter()
>>                                   test_and_set_cpu(cpu, oneshot_mask);
>>                                   shutdown_cpu_local_device();
>>                                   tick_broadcast_set_event();
>>                               sleep_deep();
>>=20
>>                             // All good. Broadcast will wake the CPU up
>>=20
>> install_new_broadcast_device(newdev)
>>    tick_broadcast_setup_oneshot(newdev)
>>      if (was_periodic)  <- Path not taken because device is in shutdown =
state
>
> Are you saying that the "tick_broadcast_enter->broadcast_shutdown_local"=
=20
> path will turn off the cpu1 tick device=EF=BC=88as the broadcast)?

No. On CPU1 the idle path does:

    - Mark the CPU in the broadcast oneshot mask
    - Conditionally shut down the CPU local clock event device
    - Set the broadcast event

> I think this only happens when CPU1's tick device is used as the=20
> broadcast device. However, the "broadcast_needs_cpu" path prevents this=20
> from happening, right?

No. broadcast_shutdown_local() checks first whether

    - the broadcast device is hrtimer based, i.e. a software emulation
    - the broadcast device is armed
    - the CPU handling the hrtimer is the current CPU

If all apply then the CPU local device cannot be shut down.

Then it checks whether:

    - the broadcast device is hrtimer based, i.e. a software emulation
    - the CPU local event is before the broadcast event, as it cannot
      reprogram the remote CPUs clockevent device

If all apply then the CPU local device cannot be shut down.

> Nevertheless, there is still an issue here. At this point, the broadcast=
=20
> will be in oneshot state (was_periodic is still false). The reason why=20
> this has not caused any serious problems may be because other CPUs will=20
> quickly enter idle to help refresh the broadcast.

The installation of a new broadcast device is a rare event and yes, if
the CPU which installed it or come other CPU goes idle shortly after it
will arm the broadcast event and stuff keeps moving, but that's far from
correct.

Thanks,

        tglx
