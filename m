Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61E682565
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjAaHM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAaHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:12:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE4302AF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D43D61384
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319BEC433EF;
        Tue, 31 Jan 2023 07:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675149144;
        bh=GLgjuhuoJia1KAR/5UGex45CJbUQqaV06MfhGq/cpgg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LG9+Z6uP0o6BTNazjYmtFoa+ZhTZHaq7InRd4D32TMcfZFvPAu/GFZXkeGKQpNfrh
         JnaiZsV6aEjsA1Y8PC4X61ZWGSBNdBXI1TN6GgTmX1KlLV8ibKByby1zXWkICShRWi
         qlOBtz4PQMbqWk8aTVDoFz+9X8NW1D0xCQc/tutAZK3KGnNIhcoJaPg9WB51YuYssi
         FDkNyDBfzlEuNMMXR1mTwc22cEbGezu+inYjgeQydjFYzn5kEW47Ec8U1fuODBL+xp
         6Iy99il2z6Fkw1tzbs+DLo5k6o2AZL05J9wFElZNHTmDH4JrFL2MCXOvlPwd4J17tf
         URwpmqI2ACtSA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Guo Ren <guoren@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
In-Reply-To: <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
References: <20230126161559.1467374-1-guoren@kernel.org>
 <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
 <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
 <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
Date:   Tue, 31 Jan 2023 08:12:22 +0100
Message-ID: <87a61z2n55.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> writes:

> On Mon, Jan 30, 2023 at 11:49 PM Mark Rutland <mark.rutland@arm.com> wrot=
e:
>>
>> Hi Bjorn,
>>
>> On Mon, Jan 30, 2023 at 04:28:15PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> > Guo Ren <guoren@kernel.org> writes:
>> >
>> > >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instruc=
tions pair
>> > >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does no=
t execute
>> > >> in the instructions that will be modified, it is still need to stop=
 other CPUs
>> > >> via patch_text API, or you have any better solution to achieve the =
purpose?
>> > >  - The stop_machine is an expensive way all architectures should
>> > > avoid, and you could keep that in your OPTPROBES implementation files
>> > > with static functions.
>> > >  - The stop_machine couldn't work with PREEMPTION, so your
>> > > implementation needs to work with !PREEMPTION.
>> >
>> > ...and stop_machine() with !PREEMPTION is broken as well, when you're
>> > replacing multiple instructions (see Mark's post at [1]). The
>> > stop_machine() dance might work when you're replacing *one* instructio=
n,
>> > not multiple as in the RISC-V case. I'll expand on this in a comment in
>> > the OPTPROBES v6 series.
>>
>> Just to clarify, my comments in [1] were assuming that stop_machine() wa=
s not
>> used, in which case there is a problem with or without PREEMPTION.
>>
>> I believe that when using stop_machine(), the !PREEMPTION case is fine, =
since
>> stop_machine() schedules work rather than running work in IRQ context on=
 the
>> back of an IPI, so no CPUs should be mid-sequnce during the patching, an=
d it's
>> not possible for there to be threads which are preempted mid-sequence.
>>
>> That all said, IIUC optprobes is going to disappear once fprobe is ready
>> everywhere, so that might be moot.
> The optprobes could be in the middle of a function, but fprobe must be
> the entry of a function, right?
>
> Does your fprobe here mean: ?
>
> The Linux kernel configuration item CONFIG_FPROBE:
>
> prompt: Kernel Function Probe (fprobe)
> type: bool
> depends on: ( CONFIG_FUNCTION_TRACER ) && (
> CONFIG_DYNAMIC_FTRACE_WITH_REGS ) && ( CONFIG_HAVE_RETHOOK )
> defined in kernel/trace/Kconfig

See the cover of [1]. It's about direct calls for BPF tracing (and more)
on Arm, and you're completly right, that it's *not* related to optprobes
at all.

[1] https://lore.kernel.org/all/20221108220651.24492-1-revest@chromium.org/
